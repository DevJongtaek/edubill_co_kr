<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM langXmlPath, langXmlFile

	langXmlPath = Server.MapPath("../") & "\"
	langXmlFile = "lang.member.xml"

	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop

	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<%
	DIM pageMode, intPage, intPageSize, strMemberType, strGroupCode, intTotalCount, intPageCount, strSortID, strSordDsc
	DIM search_option, detail_search, searchMode, searchText, startTermDate, endTermDate, termType, etcAuth, etcSex
	DIM startPoint, endPoint, birthType

	WITH REQUEST

		pageMode      = LCASE(GetInputReplce(.FORM("pageMode"), ""))
		intPage       = GetInputReplce(.FORM("intPage"), False)
		intPageSize   = GetInputReplce(.FORM("intPageSize"), False)
		strMemberType = .FORM("memberType")
		strGroupCode  = .FORM("groupCode")
		intLevel      = .FORM("memberLevel")
		strSortID     = LCASE(GetInputReplce(.FORM("sortid"), ""))
		strSordDsc    = LCASE(GetInputReplce(.FORM("sortdsc"), ""))
		search_option = .FORM("searchOption")
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

	IF pageMode = "" THEN pageMode = "list"
	IF isNumeric(intPage) = False THEN intPage = ""
	IF intPage = "" THEN intPage = 1
	IF isNumeric(intPageSize) = False THEN intPageSize = ""
	IF intPageSize = "" THEN intPageSize = 15

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

	SELECT CASE pageMode
	CASE "list"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LIST] 'Y', '" & intPageSize & "', '" & intPage & "', '" & strSortID & "', '" & strSordDsc & "', '" & strMemberType & "', '" & strGroupCode & "', '" & intLevel & "', '" & search_option & "', '" & detail_search & "', '" & searchData1 & "', '" & searchData2 & "', '" & searchData3 & "', '" & searchData4 & "', '" & searchData5 & "' ")

		intTotalCount = RS(0)

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LIST] 'N', '" & intPageSize & "', '" & intPage & "', '" & strSortID & "', '" & strSordDsc & "', '" & strMemberType & "', '" & strGroupCode & "', '" & intLevel & "', '" & search_option & "', '" & detail_search & "', '" & searchData1 & "', '" & searchData2 & "', '" & searchData3 & "', '" & searchData4 & "', '" & searchData5 & "' ")

		DIM iCount, intNumber
		iCount = 0

		RESPONSE.WRITE "["
	
		WHILE NOT(RS.EOF)
	
			iCount = iCount + 1
			intNumber = INT(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
	
			IF iCount > 1 THEN RESPONSE.WRITE ","

			RESPONSE.WRITE "{""total"":""" & intTotalCount & """, ""seq"":""" & RS("intSeq") & """, ""number"":""" & intNumber & """, ""groupcode"":""" & RS("strGroupCode") & """, ""level"":""" & RS("intLevel") & """, ""userid"":""" & RS("strLoginID") & """, ""username"":""" & RS("strUserName") & """, ""nickname"":""" & RS("strNickName") & """, ""regdate"":""" & REPLACE(LEFT(RS("strRegDate"),10), "-", ".") & """, ""visitdate"":"""

			IF ISNULL(RS("strVisitDate")) = False THEN RESPONSE.WRITE REPLACE(LEFT(RS("strVisitDate"),10), "-", ".") ELSE RESPONSE.WRITE "-"
			RESPONSE.WRITE """, ""visit"":""" & RS("intVisit") & """, ""article"":""" & RS("intArticle") & """, ""comment"":""" &  RS("intComment") & """, ""sex"":""" & GetOptionArrText(objXmlLang("option_sex"), RS("strSex")) & """, ""birthday"":"""
			IF RS("strBirthday") <> "" AND ISNULL(RS("strBirthday")) = False THEN
				RESPONSE.WRITE LEFT(RS("strBirthday"),4) & "." & MID(RS("strBirthday"), 5, 2) & "." & MID(RS("strBirthday"), 7, 2)
				IF RIGHT(RS("strBirthday"), 1) = "0" THEN RESPONSE.WRITE " (-)" ELSE RESPONSE.WRITE " (+)"
			ELSE
				RESPONSE.WRITE "-"
			END IF
			RESPONSE.WRITE """, ""sido"":""" & RS("strSido") & """, ""mailing"":""" & GetOptionArrText(objXmlLang("option_mailing"), GetBitTypeNumberChg(RS("bitMailing"))) & """, ""auth"":""" & GetOptionArrText(objXmlLang("option_auth"), GetBitTypeNumberChg(RS("bitAuth"))) & """, ""point"":""" & RS("intPoint") & """, ""usestop"":"""
			IF RS("bitStop") = True THEN RESPONSE.WRITE "Y" ELSE RESPONSE.WRITE "N"
			RESPONSE.WRITE """, ""nologin"":"""
			IF RS("strLoginNoDate") <> "" AND ISNULL(RS("strLoginNoDate")) = False THEN
				IF DATEDIFF("d", NOW(), RS("strLoginNoDate")) > 0 THEN
					RESPONSE.WRITE REPLACE(LEFT(RS("strLoginNoDate"), 10), "-", ".")
				ELSE
					RESPONSE.WRITE "-"
				END IF
			ELSE
				RESPONSE.WRITE "-"
			END IF
			RESPONSE.WRITE """}" & CHR(10)

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "]"

	CASE "page"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LIST] 'Y', '" & intPageSize & "', '" & intPage & "', '" & strSortID & "', '" & strSordDsc & "', '" & strMemberType & "', '" & strGroupCode & "', '" & intLevel & "', '" & search_option & "', '" & detail_search & "', '" & searchData1 & "', '" & searchData2 & "', '" & searchData3 & "', '" & searchData4 & "', '" & searchData5 & "' ")
	
		intTotalCount = RS(0)
		intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

		RESPONSE.WRITE GetPageHTML(intPage, intPageCount, objXmlLang("text_prevpage"), objXmlLang("text_nextpage"), "goPage")

	CASE "excel"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LIST] 'Y', '" & intPageSize & "', '" & intPage & "', '" & strSortID & "', '" & strSordDsc & "', '" & strMemberType & "', '" & strGroupCode & "', '" & intLevel & "', '" & search_option & "', '" & detail_search & "', '" & searchData1 & "', '" & searchData2 & "', '" & searchData3 & "', '" & searchData4 & "', '" & searchData5 & "' ")

		intTotalCount = RS(0)
		intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

		RESPONSE.WRITE "["
		FOR tmpFor = 1 TO intPageCount

			IF tmpFor > 1 THEN RESPONSE.WRITE ", "

			RESPONSE.WRITE "{""excelpage"":""" & tmpFor & """, ""exceltitle"":"""
			IF tmpFor = 1 THEN RESPONSE.WRITE tmpFor ELSE RESPONSE.WRITE (tmpFor * 2000) + 1 - 2000
			RESPONSE.WRITE "~" & tmpFor * 2000 & """}"

		NEXT
		RESPONSE.WRITE "]"

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET objRoot = NOTHING : SET rootNode = NOTHING
%>
