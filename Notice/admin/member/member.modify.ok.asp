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

		DIM intSeq
		intSeq = GetInputReplce(REQUEST.FORM("intSeq"), "")

		SELECT CASE Act
		CASE "modify"

			DIM strMemberType, strGroupCode, intLevel, strLoginID, strPassword, strEmail, strUserName, strNickName, strSex
			DIM strBirthday, strHomePage, strHomeTel, strMobile, strHomeAddr, strJob, strMarry, strMyMemo, strUserSign
			DIM bitMailing, bitMemo, bitAuth, bitOpenInfo, strSido, bitStop, strLoginNoDate, strCorpNum, strCorpName
			DIM strCorpJob1, strCorpJob2, strAddData1, strAddData2, strAddData3, strAddData4, strAddData5, strAddData6
			DIM strAddData7, strAddData8, strAddData9, strAddData10, strAdminMemo

			WITH REQUEST

				strMemberType  = GetInputReplce(.FORM("strMemberType"), "")
				strGroupCode   = GetInputReplce(.FORM("strGroupCode"), "")
				intLevel       = GetInputReplce(.FORM("intLevel"), "")
				strLoginID     = .FORM("strLoginID")
				strPassword    = GetInputReplce(.FORM("strPassword"), "")
				strEmail       = GetInputReplce(.FORM("strEmail")(1) & "@" & .FORM("strEmail")(2), "")
				strUserName    = GetInputReplce(.FORM("strUserName"), "")
				strNickName    = GetInputReplce(.FORM("strNickName"), "")
				strSex         = GetInputReplce(.FORM("strSex"), "")
				strHomePage    = GetInputReplce(.FORM("strHomePage"), "")
				strJob         = GetInputReplce(.FORM("strJob"), "")
				strMyMemo      = GetInputReplce(.FORM("strMyMemo"), "")
				strUserSign    = GetInputReplce(.FORM("strUserSign"), "")
				bitMailing     = GetInputReplce(.FORM("bitMailing"), "")
				bitMemo        = GetInputReplce(.FORM("bitMemo"), "")
				bitAuth        = GetInputReplce(.FORM("bitAuth"), "")
				bitOpenInfo    = GetInputReplce(.FORM("bitOpenInfo"), "")
				bitStop        = GetInputReplce(.FORM("bitStop"), "")
				strLoginNoDate = GetInputReplce(.FORM("strLoginNoDate"), "")
				strAddData1   = GetInputReplce(.FORM("strAddData1_"), "")
				strAddData2   = GetInputReplce(.FORM("strAddData2_"), "")
				strAddData3   = GetInputReplce(.FORM("strAddData3_"), "")
				strAddData4   = GetInputReplce(.FORM("strAddData4_"), "")
				strAddData5   = GetInputReplce(.FORM("strAddData5_"), "")
				strAddData6   = GetInputReplce(.FORM("strAddData6_"), "")
				strAddData7   = GetInputReplce(.FORM("strAddData7_"), "")
				strAddData8   = GetInputReplce(.FORM("strAddData8_"), "")
				strAddData9   = GetInputReplce(.FORM("strAddData9_"), "")
				strAddData10  = GetInputReplce(.FORM("strAddData10_"), "")
				strAdminMemo  = GetInputReplce(.FORM("strAdminMemo"), "")

				IF strSex = "0" THEN strSex = "2"

				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_LIST] 'R' ")
		
				WHILE NOT(RS.EOF)
			
					SELECT CASE LCASE(RS("strFieldName"))
					CASE "strbirthday"
						IF RS("bitUse") = True THEN strBirthday = GetInputReplce(REPLACE(.FORM("strBirthday")(1) & .FORM("strBirthday")(2), ".", ""), "")
					CASE "strhometel"
						IF RS("bitUse") = True THEN strHomeTel  = GetInputReplce(.FORM("strHomeTel")(1) & "-" & .FORM("strHomeTel")(2) & "-" & .FORM("strHomeTel")(3), "")
					CASE "strmobile"
						IF RS("bitUse") = True THEN strMobile   = GetInputReplce(.FORM("strMobile")(1) & "-" & .FORM("strMobile")(2) & "-" & .FORM("strMobile")(3), "")
					CASE "strhomeaddr"
						IF RS("bitUse") = True THEN strHomeAddr = GetInputReplce(GetInputReplce(REPLACE(.FORM("strHomeAddr3"), "-", "") & "$$$" & .FORM("strHomeAddr4") & "$$$" & .FORM("strHomeAddr5"), ""), "")
					CASE "strmarry"
						IF RS("bitUse") = True THEN
							IF .FORM("strMarry")(1) = "1" THEN strMarry = .FORM("strMarry")(1) & GetInputReplce(REPLACE(.FORM("strMarry")(2), ".", ""), "") ELSE strMarry = "000000000"
						END IF
					CASE "strcorpnum", "strcorpname", "strcorpjob1", "strcorpjob2", "strcorpaddr"
						IF strMemberType = "C" THEN
							SELECT CASE LCASE(RS("strFieldName"))
							CASE "strcorpnum"  : strCorpNum  = GetInputReplce(.FORM("strCorpNum")(1) & .FORM("strCorpNum")(2) & .FORM("strCorpNum")(3), "")
							CASE "strcorpname" : strCorpName = GetInputReplce(.FORM("strCorpName"), "")
							CASE "strcorpjob1" : strCorpJob1 = GetInputReplce(.FORM("strCorpJob1"), "")
							CASE "strcorpjob2" : strCorpJob2 = GetInputReplce(.FORM("strCorpJob2"), "")
							CASE "strcorpaddr" : strCorpAddr = GetInputReplce(REPLACE(.FORM("strCorpAddr3"), "-", "") & "$$$" & .FORM("strCorpAddr4") & "$$$" & .FORM("strCorpAddr5"), "")
							END SELECT
						END IF
					END SELECT
			
				RS.MOVENEXT
				WEND

			END WITH

			IF strHomeAddr <> "" THEN
				SET RS = DBCON.EXECUTE("[ARTY30_SP_ZIPCODE_LIST] '" & LEFT(strHomeAddr, 6) & "', 'S' ")
				IF NOT(RS.EOF) THEN strSido = RS(0)
			END IF

			IF REQUEST.FORM("change_email") = "1" THEN
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'EMAIL', '" & strEmail & "', '" & intSeq & "' ")
		
				IF RS(0) > 0 THEN
					RESPONSE.WRITE "ERROR02"
					RESPONSE.End()
				END IF
	
			END IF
	
			IF REQUEST.FORM("change_nick") = "1" THEN
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'NICKNAME', '" & strNickName & "', '" & intSeq & "' ")
		
				IF RS(0) > 0 THEN
					RESPONSE.WRITE "ERROR03"
					RESPONSE.End()
				END IF
	
			END IF
	
			DBCON.EXECUTE("[ARTY30_SP_MEMBER_ADD] 'E', '" & intSeq & "', '" & strMemberType & "', '" & strGroupCode & "', '" & intLevel & "', N'" & strLoginID & "', N'" & strPassword & "', N'" & strEmail & "', N'" & strUserName & "', N'" & strNickName & "', '" & strSex & "', '" & strSSN & "', '" & strBirthday & "', N'" & strHomePage & "', '" & strHomeTel & "', '" & strMobile & "', N'" & strHomeAddr & "', N'" & strJob & "', '" & strMarry & "', N'" & strMyMemo & "', N'" & strUserSign & "', '" & bitMailing & "', '" & bitMemo & "', '1', '" & bitOpenInfo & "', N'" & strSido & "', '', '', '" & strCorpNum & "', N'" & strCorpName & "', N'" & strCorpJob1 & "', N'" & strCorpJob2 & "', N'" & strCorpAddr & "', N'" & strAddData1 & "', N'" & strAddData2 & "', N'" & strAddData3 & "', N'" & strAddData4 & "', N'" & strAddData5 & "', N'" & strAddData6 & "', N'" & strAddData7 & "', N'" & strAddData8 & "', N'" & strAddData9 & "', N'" & strAddData10 & "', '' ")

		CASE "fileremove"

			CALL ActFileDelete(GetNowFolderPath("../../") & "\" & CONF_strFilePath & "\member\" & GetInputReplce(REQUEST.FORM("filetype"), "") & "\" & GetInputReplce(REQUEST.FORM("intSeq"), "") & "\" & GetFolderFileList(GetNowFolderPath("../../") & "\" & CONF_strFilePath & "\member\" & GetInputReplce(REQUEST.FORM("filetype"), "") & "\" & GetInputReplce(REQUEST.FORM("intSeq"), "")  & "\"))

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>