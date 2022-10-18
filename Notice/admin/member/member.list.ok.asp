<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C01"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act, tmpFor
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))

		DIM intAdminCount
		intAdminCount = 0
	
		SELECT CASE Act
		CASE "grouplevel"

			IF REQUEST.FORM("intSeq").COUNT = 0 THEN

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_UPDATE_GROUP_LEVEL] '" & GetInputReplce(REQUEST.FORM("gradeList"), "") & "', '" & GetInputReplce(REQUEST.FORM("levelList"), "") & "' ")

			ELSE

				FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT
					DBCON.EXECUTE("[ARTY30_SP_MEMBER_UPDATE_GROUP_LEVEL] '" & GetInputReplce(REQUEST.FORM("gradeList"), "") & "', '" & GetInputReplce(REQUEST.FORM("levelList"), "") & "', '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")
				NEXT

			END IF

		CASE "remove"

			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")
				
				IF RS("strAdmin") = "A" THEN intAdminCount = intAdminCount + 1 ELSE CALL ActMemberRemove(GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), ""), RS("strAdmin"), GetNowFolderPath("../../") & "\" & CONF_strFilePath)

			NEXT

			RESPONSE.WRITE intAdminCount

		CASE "leave"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

			DIM strOutOption
			
			strOutOption = RS("strOutOption")

			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")

				IF RS("strAdmin") = "A" THEN 
					intAdminCount = intAdminCount + 1
				ELSE
					IF strOutOption = "1" THEN
						CALL ActMemberRemove(GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), ""), RS("strAdmin"), GetNowFolderPath("../../") & "\" & CONF_strFilePath)
					ELSE
						DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEAVE] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "', N'" & GetInputReplce(REQUEST.FORM("strLeaveMemo"), "") & "' ")
					END IF
				END IF
				
			NEXT

			RESPONSE.WRITE intAdminCount

		CASE "point"

			DIM addminus, intPoint, strDescription

			addminus       = GetInputReplce(REQUEST.FORM("addminus"), "")
			intPoint       = GetInputReplce(REQUEST.FORM("addpoint"), "")
			strDescription = GetInputReplce(REQUEST.FORM("pointMemo"), "")

			IF addminus = "-" THEN intPoint = "-" & intPoint

			IF REQUEST.FORM("intSeq").COUNT = 0 THEN

				DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '', '', '" & intPoint & "', N'" & strDescription & "', '1' ")

			ELSE

				FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

					DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "', '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "', '" & intPoint & "', N'" & strDescription & "', '0' ")

				NEXT

			END IF

		CASE "excel"

			DIM excelKind, excelCount

			excelKind  = GetInputReplce(REQUEST.FORM("excelKind"), "")
'			excelCount = GetInputReplce(REQUEST.FORM("excelCount"), "")

	
			DIM intPage, intPageSize, strGroupCode, intLevel, strSortID, strSordDsc, search_option, detail_search, searchMode
			DIM searchText, startTermDate, endTermDate, termType, etcAuth, etcSex, startPoint, endPoint, birthType
		
			WITH REQUEST
		
				intPage       = .QueryString("intPage")
				intPageSize   = 2000
				strGroupCode  = .QueryString("viewGradeList")
				intLevel      = .QueryString("viewLevelList")
				strSortID     = LCASE(GetInputReplce(.QueryString("sortid"), ""))
				strSordDsc    = LCASE(GetInputReplce(.QueryString("sortdsc"), ""))
				search_option = .QueryString("searchOption")
				detail_search = .FORM("detail_search")
				searchMode    = .FORM("searchMode")
				searchText    = GetInputReplce(.FORM("searchText"), "")
				startTermDate = .FORM("startTermDate")
				endTermDate   = .FORM("endTermDate")
				termType      = .FORM("termType")
				etcAuth       = .FORM("etcAuth")
				etcSex        = .FORM("etcSex")
				startPoint    = .FORM("startPoint")
				endPoint      = .FORM("endPoint")
				birthType     = .FORM("birthType")
		
			END WITH
		
			SELECT CASE strSortID
			CASE "threg"     : strSortID = "strRegDate"
			CASE "thlast"    : strSortID = "strVisitDate"
			CASE "thvisit"   : strSortID = "intVisit"
			CASE "tharticle" : strSortID = "intArticle"
			CASE "thcomment" : strSortID = "intComment"
			CASE ELSE : strSortID = ""
			END SELECT
		
			SELECT CASE strSordDsc
			CASE "dsc" : strSordDsc = "DESC"
			CASE "asc" : strSordDsc = "ASC"
			CASE ELSE : strSordDsc = ""
			END SELECT
		
			DIM searchData1, searchData2, searchData3, searchData4, searchData5
		
			SELECT CASE search_option
			CASE "default"
		
				searchData1 = searchMode
				searchData2 = searchText
		
			CASE "detail"
				SELECT CASE detail_search
				CASE "0"
					searchData1 = REPLACE(startTermDate, ".", "-")
					searchData2 = REPLACE(endTermDate, ".", "-")
					searchData3 = termType
				CASE "1"
					searchData1 = etcAuth
					searchData2 = etcSex
				CASE "2"
					searchData1 = startPoint
					searchData2 = endPoint
				CASE "3"
		
					DIM nowYear, nowMonth, nowDay, umDate, umYear, umMonth, umDay, nowWeekDay, nowWeekStartDate, nowWeekEndDate
					DIM nowWeekStartMonth, nowWeekStartDay, nowWeekEndMonth, nowWeekEndDay, nowWeekUmStartDate, nowWeekUmEndDate
					DIM nowWeekUmStartMonth, nowWeekUmStartDay, nowWeekUmEndMonth, nowWeekUmEndDay
		
					nowYear  = YEAR(NOW)
					nowMonth = MONTH(NOW)   : IF LEN(nowMonth) = 1 THEN nowMonth = "0" & nowMonth
					nowDay   = DAY(NOW)     : IF LEN(nowDay)   = 1 THEN nowDay   = "0" & nowDay
			
					umDate  = GetLunar(nowYear, nowMonth, nowDay)
					umYear  = YEAR(umDate)
					umMonth = MONTH(umDate)   : IF LEN(umMonth) = 1 THEN umMonth = "0" & umMonth
					umDay   = DAY(umDate)     : IF LEN(umDay)   = 1 THEN umDay   = "0" & umDay
		
					searchData1 = birthType
		
					SELECT CASE birthType
					CASE "0"
		
						searchData2 = nowMonth & nowDay
						searchData3 = umMonth & umDay
		
					CASE "1"
		
						nowWeekDay = WEEKDAY(NOW)
						nowWeekStartDate = DATEADD("d", 1 - nowWeekDay, NOW)
						nowWeekEndDate   = DATEADD("d", 7 - nowWeekDay, NOW)
			
						nowWeekStartMonth = MONTH(nowWeekStartDate)
						nowWeekStartDay   = DAY(nowWeekStartDate)
						nowWeekEndMonth   = MONTH(nowWeekEndDate)
						nowWeekEndDay     = DAY(nowWeekEndDate)
			
						IF LEN(nowWeekStartMonth) = 1 THEN nowWeekStartMonth = "0" & nowWeekStartMonth
						IF LEN(nowWeekStartDay)   = 1 THEN nowWeekStartDay   = "0" & nowWeekStartDay
						IF LEN(nowWeekEndMonth)   = 1 THEN nowWeekEndMonth   = "0" & nowWeekEndMonth
						IF LEN(nowWeekEndDay)     = 1 THEN nowWeekEndDay     = "0" & nowWeekEndDay
			
						nowWeekUmStartDate = GetLunar(YEAR(nowWeekStartDate), nowWeekStartMonth, nowWeekStartDay)
						nowWeekUmEndDate   = GetLunar(YEAR(nowWeekEndDate), nowWeekEndMonth, nowWeekEndDay)
			
						nowWeekUmStartMonth = MONTH(nowWeekUmStartDate)
						nowWeekUmStartDay   = DAY(nowWeekUmStartDate)
						nowWeekUmEndMonth   = MONTH(nowWeekUmEndDate)
						nowWeekUmEndDay     = DAY(nowWeekUmEndDate)
			
						IF LEN(nowWeekUmStartMonth) = 1 THEN nowWeekUmStartMonth = "0" & nowWeekUmStartMonth
						IF LEN(nowWeekUmStartDay)   = 1 THEN nowWeekUmStartDay   = "0" & nowWeekUmStartDay
						IF LEN(nowWeekUmEndMonth)   = 1 THEN nowWeekUmEndMonth   = "0" & nowWeekUmEndMonth
						IF LEN(nowWeekUmEndDay)     = 1 THEN nowWeekUmEndDay     = "0" & nowWeekUmEndDay
		
						searchData2 = nowWeekStartMonth & nowWeekStartDay
						searchData3 = nowWeekEndMonth & nowWeekEndDay
						searchData4 = nowWeekUmStartMonth & nowWeekUmStartDay
						searchData5 = nowWeekUmEndMonth & nowWeekUmEndDay
		
					CASE "2"
		
						DIM nowStartDateMonth, nowStartDateDay, nowStartDate, nowEndDate, nowEndDateMonth, nowEndDateDay
						DIM nowStartUmDate, nowEndUmDate, nowStartDateUmMonth, nowStartDateUmDay, nowEndDateUmMonth, nowEndDateUmDay
				
						nowStartDateMonth = MONTH(NOW)   : IF LEN(nowStartDateMonth) = 1 THEN nowStartDateMonth = "0" & nowStartDateMonth
						nowStartDateDay   = "01"
						nowStartDate      = YEAR(NOW) & "-" & nowStartDateMonth & "-" & nowStartDateDay
						nowEndDate        = YEAR(NOW) & "-" & nowStartDateMonth & "-" & GetMonthCount(YEAR(NOW), nowStartDateMonth)
						nowEndDateMonth   = nowStartDateMonth
						nowEndDateDay     = GetMonthCount(YEAR(NOW), nowStartDateMonth)
				
						nowStartUmDate = GetLunar(YEAR(NOW), nowStartDateMonth, "01")
						nowEndUmDate   = GetLunar(YEAR(NOW), nowStartDateMonth, nowEndDateDay)
				
						nowStartDateUmMonth = MONTH(nowStartUmDate)
						nowStartDateUmDay   = DAY(nowStartUmDate)
						nowEndDateUmMonth   = MONTH(nowEndUmDate)
						nowEndDateUmDay     = DAY(nowEndUmDate)
			
						IF LEN(nowStartDateUmMonth) = 1 THEN nowStartDateUmMonth = "0" & nowStartDateUmMonth
						IF LEN(nowStartDateUmDay)   = 1 THEN nowStartDateUmDay   = "0" & nowStartDateUmDay
						IF LEN(nowEndDateUmMonth)   = 1 THEN nowEndDateUmMonth   = "0" & nowEndDateUmMonth
						IF LEN(nowEndDateUmDay)     = 1 THEN nowEndDateUmDay     = "0" & nowEndDateUmDay			
		
						searchData2 = nowStartDateMonth & nowStartDateDay
						searchData3 = nowEndDateMonth & nowEndDateDay
						searchData4 = nowStartDateUmMonth & nowStartDateUmDay
						searchData5 = nowEndDateUmMonth & nowEndDateUmDay
		
					END SELECT
		
				END SELECT
		
			END SELECT
		
			Response.ContentType = "application/vnd.ms-excel"
			Response.AddHeader "Content-Disposition","attachment;filename=MemberList" & YEAR(NOW) & MONTH(NOW) & DAY(NOW) & "_" & excelKind & excelCount & ".xls"
			RESPONSE.Buffer = True

			RESPONSE.WRITE "<html>" & vbcrlf
			RESPONSE.WRITE "<head>" & vbcrlf
			RESPONSE.WRITE "<meta http-equiv='content-type' content='text/html; charset=utf-8'>" & vbcrlf
			RESPONSE.WRITE "<title></title>" & vbcrlf
			RESPONSE.WRITE "</head>" & vbcrlf
			RESPONSE.WRITE "<body>" & vbcrlf

			RESPONSE.WRITE "<table border=1 cellspacing=0 cellpadding=0>" & vbcrlf

			IF excelKind = "all" THEN

				RESPONSE.WRITE "  <tr>" & vbcrlf
				RESPONSE.WRITE "    <td>intSeq</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strMemberType</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strGroupCode</td>" & vbcrlf
				RESPONSE.WRITE "    <td>intLevel</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strLoginID</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strPassword</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strEmail</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strUserName</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strNickName</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strSex</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strSSN</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strBirthday</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strHomePage</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strHomeTel</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strMobile</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strHomeAddr</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strJob</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strMarry</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strMyMemo</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strUserSign</td>" & vbcrlf
				RESPONSE.WRITE "    <td>bitMailing</td>" & vbcrlf
				RESPONSE.WRITE "    <td>bitMemo</td>" & vbcrlf
				RESPONSE.WRITE "    <td>bitAuth</td>" & vbcrlf
				RESPONSE.WRITE "    <td>bitOpenInfo</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strAdmin</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strSido</td>" & vbcrlf
				RESPONSE.WRITE "    <td>intArticle</td>" & vbcrlf
				RESPONSE.WRITE "    <td>intComment</td>" & vbcrlf
				RESPONSE.WRITE "    <td>intPoint</td>" & vbcrlf
				RESPONSE.WRITE "    <td>intVisit</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strVisitIp</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strVisitDate</td>" & vbcrlf
				RESPONSE.WRITE "    <td>bitStop</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strLoginNoDate</td>" & vbcrlf
				RESPONSE.WRITE "    <td>bitLeave</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strLeaveMemo</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strLeaveDate</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strRegDate</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strCorpNum</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strCorpName</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strCorpJob1</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strCorpJob2</td>" & vbcrlf
				RESPONSE.WRITE "    <td>strCorpAddr</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAddData1</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAddData2</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAddData3</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAddData4</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAddData5</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAddData6</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAddData7</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAddData8</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAddData9</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAddData10</td>" & vbcrlf
				RESPONSE.WRITE "		<td>strAdminMemo</td>" & vbcrlf				
				RESPONSE.WRITE "  </tr>" & vbcrlf

			END IF

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LIST] 'N', '" & intPageSize & "', '" & intPage & "', '" & strSortID & "', '" & strSordDsc & "', '" & strGroupCode & "', '" & intLevel & "', '" & search_option & "', '" & detail_search & "', '" & searchData1 & "', '" & searchData2 & "', '" & searchData3 & "', '" & searchData4 & "', '" & searchData5 & "' ")


			WHILE NOT(RS.EOF)

				RESPONSE.WRITE "  <tr>" & vbcrlf

			SELECT CASE excelKind
			CASE "all"
				RESPONSE.WRITE "    <td>" & RS("intSeq") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strMemberType") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strGroupCode") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("intLevel") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strLoginID") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strPassword") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strEmail") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strUserName") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strNickName") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strSex") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strSSN") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strBirthday") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strHomePage") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strHomeTel") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strMobile") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strHomeAddr") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strJob") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strMarry") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strMyMemo") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strUserSign") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("bitMailing") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("bitMemo") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("bitAuth") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("bitOpenInfo") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strAdmin") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strSido") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("intArticle") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("intComment") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("intPoint") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("intVisit") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strVisitIp") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strVisitDate") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("bitStop") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strLoginNoDate") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("bitLeave") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strLeaveMemo") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strLeaveDate") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strRegDate") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strCorpNum") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strCorpName") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strCorpJob1") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strCorpJob2") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strCorpAddr") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAddData1") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAddData2") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAddData3") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAddData4") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAddData5") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAddData6") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAddData7") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAddData8") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAddData9") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAddData10") & "</td>" & vbcrlf
				RESPONSE.WRITE "		<td>" & RS("strAdminMemo") & "</td>" & vbcrlf				
			CASE "mail"
				RESPONSE.WRITE "    <td>" & RS("strUserName") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strEmail") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>""" & RS("strUserName") & """ &lt;" & RS("strEmail") & "&gt;</td>" & vbcrlf
			CASE "tel"
				RESPONSE.WRITE "    <td>" & RS("strUserName") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strHomeTel") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strMobile") & "</td>" & vbcrlf
			CASE "dm"
				RESPONSE.WRITE "    <td>" & RS("strUserName") & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & LEFT(RS("strHomePost"),3) & "-" & RIGHT(RS("strHomePost"),3) & "</td>" & vbcrlf
				RESPONSE.WRITE "    <td>" & RS("strHomeAddr1") & " " & RS("strHomeAddr2") & "</td>" & vbcrlf
			END SELECT

			RESPONSE.WRITE "  </tr>" & vbcrlf
	
			RS.MOVENEXT
			WEND

			RESPONSE.WRITE "</table>" & vbcrlf
			RESPONSE.WRITE "</body>" & vbcrlf
			RESPONSE.WRITE "</html>" & vbcrlf

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>