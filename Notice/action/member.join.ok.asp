<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM Act
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))

	SELECT CASE Act
	CASE "memberjoin", "membermodify"

		DIM strMemberType, strGroupCode, intLevel, strLoginID, strPassword, strEmail, strUserName, strNickName, strSex
		DIM strSSN, strBirthday, strHomePage, strHomeTel, strMobile, strHomeAddr, strHomePost, strHomeAddr1, strHomeAddr2
		DIM strJob, strMarry, strMyMemo, strUserSign, bitMailing, bitMemo, bitAuth, bitOpenInfo, strAdmin, strSido, intArticle
		DIM intComment, intPoint, intVisit, strVisitIp, strVisitDate, bitStop, strLoginNoDate, bitLeave, strLeaveMemo, strLeaveDate
		DIM strRegDate, strAddData1, strAddData2, strAddData3, strAddData4, strAddData5, strAddData6, strAddData7, strAddData8
		DIM strAddData9, strAddData10, strAdminMemo, bitSendJoinEmail
	
		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")
	
		strGroupCode      = RS("strJoinGroup")
		intLevel          = RS("intJoinLevel")
		bitAuth           = GetBitTypeNumberChg(RS("bitAuth"))
		strJoinPointTitle = RS("strJoinPointTitle")
		intPoint          = RS("intJoinPoint")
		strMasterName     = RS("strMasterName")
		strMasterEmail    = RS("strMasterEmail")
		bitSendJoinEmail  = RS("bitSendJoinEmail")
	
		WITH REQUEST
	
			strMemberType = GetInputReplce(.FORM("strMemberType"), "")
			strLoginID    = .FORM("strLoginID")
			strPassword   = .FORM("strPassword")
			strEmail      = GetInputReplce(.FORM("strEmail")(1) & "@" & .FORM("strEmail")(2), "")
			strUserName   = GetInputReplce(.FORM("strUserName"), "")
			strNickName   = GetInputReplce(.FORM("strNickName"), "")
			strSex        = GetInputReplce(.FORM("strSex"), "")
			strSSN        = GetInputReplce(.FORM("strSSN"), "")
			strHomePage   = GetInputReplce(.FORM("strHomePage"), "")
			strJob        = GetInputReplce(.FORM("strJob"), "")
			strMyMemo     = GetInputReplce(.FORM("strMyMemo"), "")
			strUserSign   = GetInputReplce(.FORM("strUserSign"), "")
			bitMailing    = GetInputReplce(.FORM("bitMailing"), "")
			bitMemo       = GetInputReplce(.FORM("bitMemo"), "")
			bitOpenInfo   = GetInputReplce(.FORM("bitOpenInfo"), "")
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

			IF strSex = "0" THEN strSex = "2"

			IF GetNickNameCheck(strNickName, 1) = False THEN
				RESPONSE.WRITE "ERROR04"
				RESPONSE.End()
			END IF
	
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
					IF RS("bitUse") = True THEN strHomeAddr = GetInputReplce(.FORM("strHomeAddr"), "")
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
						CASE "strcorpaddr" : strCorpAddr = GetInputReplce(REPLACE(.FORM("address_list_strCorpAddr"), "-", "") & "$$$" & .FORM("krzip_address2_strCorpAddr") & "$$$" & .FORM("strCorpAddr5"), "")
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
	
		SELECT CASE Act
		CASE "memberjoin"	
	
			IF strSSN <> "" THEN
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'SSN', '" & strSSN & "' ")
		
				IF RS(0) > 0 THEN
					RESPONSE.WRITE "ERROR01"
					RESPONSE.End()
				END IF
	
			END IF
	
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'EMAIL', '" & strEmail & "' ")
	
			IF RS(0) > 0 THEN
				RESPONSE.WRITE "ERROR02"
				RESPONSE.End()
			END IF
	
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'NICKNAME', '" & strNickName & "' ")
	
			IF RS(0) > 0 THEN
				RESPONSE.WRITE "ERROR03"
				RESPONSE.End()
			END IF

			IF strMemberType = "K" THEN bitAuth = "0"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_ADD] 'A', '', '" & strMemberType & "', '" & strGroupCode & "', '" & intLevel & "', N'" & strLoginID & "', N'" & strPassword & "', N'" & strEmail & "', N'" & strUserName & "', N'" & strNickName & "', '" & strSex & "', '" & strSSN & "', '" & strBirthday & "', N'" & strHomePage & "', '" & strHomeTel & "', '" & strMobile & "', N'" & strHomeAddr & "', N'" & strJob & "', '" & strMarry & "', N'" & strMyMemo & "', N'" & strUserSign & "', '" & bitMailing & "', '" & bitMemo & "', '" & bitAuth & "', '" & bitOpenInfo & "', N'" & strSido & "', '', '" & strLoginNoDate & "', '" & strCorpNum & "', N'" & strCorpName & "', N'" & strCorpJob1 & "', N'" & strCorpJob2 & "', N'" & strCorpAddr & "', N'" & strAddData1 & "', N'" & strAddData2 & "', N'" & strAddData3 & "', N'" & strAddData4 & "', N'" & strAddData5 & "', N'" & strAddData6 & "', N'" & strAddData7 & "', N'" & strAddData8 & "', N'" & strAddData9 & "', N'" & strAddData10 & "', '' ")
	
			DIM intMemberSeq, strMailContent
	
			intMemberSeq = RS(0)

			SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_CONFIG] ")

			IF RS("bitPointUse") = True THEN
	
				IF intPoint > 0 THEN DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '" & intMemberSeq & "', '" & intMemberSeq & "', '" & intPoint & "', '" & strJoinPointTitle & "', 'join' ")
	
			END IF
	
			IF bitSendJoinEmail = True THEN
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_READ] 'R', '', 'D004' ")
	
				strMailContent = RS("strContent")
				strMailContent = REPLACE(strMailContent, "{{userid}}", strLoginID)
				strMailContent = REPLACE(strMailContent, "{{username}}", strUserName)
				strMailContent = REPLACE(strMailContent, "{{usernick}}", strNickName)
				strMailContent = REPLACE(strMailContent, "{{userpass}}", strPassword)
	
				CALL ActSendEmail(strMasterName, strMasterEmail, strUserName, strEmail, RS("strSubject"), strMailContent, "", "", "", "")
	
			END IF
	
			IF bitAuth = "1" THEN
	
				SESSION("memberSeq") = intMemberSeq
				SESSION("userID")    = strLoginID
				SESSION("userName")  = strUserName
				SESSION("nickName")  = strNickName
				SESSION("staff")     = "N"
	
			END IF
	
		CASE "membermodify"
	
			IF SESSION("memberSeq") = "" THEN
	
				RESPONSE.WRITE "ERROR01"
				RESPONSE.End()
	
			END IF
	
			IF GetInputReplce(REQUEST.FORM("change_email"), "") = "1" THEN
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'EMAIL', '" & strEmail & "', '" & intSeq & "' ")
		
				IF RS(0) > 0 THEN
					RESPONSE.WRITE "ERROR02"
					RESPONSE.End()
				END IF
	
			END IF
	
			IF GetInputReplce(REQUEST.FORM("change_nick"), "") = "1" THEN
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'NICKNAME', '" & strNickName & "', '" & intSeq & "' ")
		
				IF RS(0) > 0 THEN
					RESPONSE.WRITE "ERROR03"
					RESPONSE.End()
				END IF
	
			END IF
	
			DBCON.EXECUTE("[ARTY30_SP_MEMBER_ADD] 'U', '" & SESSION("memberSeq") & "', '" & strMemberType & "', '" & strGroupCode & "', '" & intLevel & "', N'" & strLoginID & "', N'" & strPassword & "', N'" & strEmail & "', N'" & strUserName & "', N'" & strNickName & "', '" & strSex & "', '" & strSSN & "', '" & strBirthday & "', N'" & strHomePage & "', '" & strHomeTel & "', '" & strMobile & "', N'" & strHomeAddr & "', N'" & strJob & "', '" & strMarry & "', N'" & strMyMemo & "', N'" & strUserSign & "', '" & bitMailing & "', '" & bitMemo & "', '1', '" & bitOpenInfo & "', N'" & strSido & "', '', '', '" & strCorpNum & "', N'" & strCorpName & "', N'" & strCorpJob1 & "', N'" & strCorpJob2 & "', N'" & strCorpAddr & "', N'" & strAddData1 & "', N'" & strAddData2 & "', N'" & strAddData3 & "', N'" & strAddData4 & "', N'" & strAddData5 & "', N'" & strAddData6 & "', N'" & strAddData7 & "', N'" & strAddData8 & "', N'" & strAddData9 & "', N'" & strAddData10 & "', '' ")
	
		END SELECT

	CASE "memberfileremove"

		DIM strUploadedFile

		strUploadedFile = GetFolderFileList(GetNowFolderPath("../") & "\" & CONF_strFilePath & "\member\" & GetInputReplce(REQUEST.FORM("subAct"), "") & "\" & GetInputReplce(REQUEST.FORM("intSeq"), ""))

		IF strUploadedFile <> "" THEN CALL ActFileDelete(GetNowFolderPath("../") & "\" & CONF_strFilePath & "\member\" & GetInputReplce(REQUEST.FORM("subAct"), "") & "\" & GetInputReplce(REQUEST.FORM("intSeq"), "") & "\" & strUploadedFile)

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>