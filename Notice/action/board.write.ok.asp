<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	IF INSTR(CONF_strSiteUrl, "http://" & REQUEST.ServerVariables("HTTP_HOST")) = 0 THEN

		RESPONSE.WRITE "ERROR"
		RESPONSE.End()

	ELSE

		WITH REQUEST
	
			writeAct        = GetInputReplce(.FORM("writeAct"), "")
			intSrl          = GetInputReplce(.FORM("intSrl"), "")
			intSeq          = GetInputReplce(.FORM("intSeq"), "")
			intCategory     = GetInputReplce(.FORM("intCategory"), "")
			intMemberSrl    = GetInputReplce(.FORM("intMemberSrl"), "")
			strUserID       = GetInputReplce(.FORM("strUserID"), "")
			strPassword     = GetInputReplce(.FORM("strPassword"), "")
			strUserName     = GetInputReplce(.FORM("strUserName"), "")
			strNickName     = GetInputReplce(.FORM("strNickName"), "")
			strEmail        = GetInputReplce(.FORM("strEmail"), "")
			strHomepage     = GetInputReplce(.FORM("strHomepage"), "")
			strTitle        = GetInputReplce(.FORM("strTitle"), "")
			strTitleSize    = GetInputReplce(.FORM("strTitleSize"), "")
			strTitleColor   = GetInputReplce(.FORM("strTitleColor"), "")
			bitTitleBold    = GetInputReplce(.FORM("bitTitleBold"), "")
			strContent      = GetInputReplce(.FORM("strContent"), "")
			strIpAddr       = REQUEST.SERVERVARIABLES("REMOTE_ADDR")
			strTag          = GetInputReplce(.FORM("strTag"), "")
			strUploadFile   = .FORM("strUploadFile")
			strUploadImg    = .FORM("strUploadImg")
			bitNotice       = GetInputReplce(.FORM("bitNotice"), "")
			bitSecret       = GetInputReplce(.FORM("bitSecret"), "")
			bitMessage      = GetInputReplce(.FORM("bitMessage"), "")
			bitAllowComment = GetInputReplce(.FORM("bitAllowComment"), "")
			bitAllowScrap   = GetInputReplce(.FORM("bitAllowScrap"), "")
			strAddData1     = GetInputReplce(.FORM("strAddData1_"), "")
			strAddData2     = GetInputReplce(.FORM("strAddData2_"), "")
			strAddData3     = GetInputReplce(.FORM("strAddData3_"), "")
			strAddData4     = GetInputReplce(.FORM("strAddData4_"), "")
			strAddData5     = GetInputReplce(.FORM("strAddData5_"), "")
			strAddData6     = GetInputReplce(.FORM("strAddData6_"), "")
			strAddData7     = GetInputReplce(.FORM("strAddData7_"), "")
			strAddData8     = GetInputReplce(.FORM("strAddData8_"), "")
			strAddData9     = GetInputReplce(.FORM("strAddData9_"), "")
			strAddData10    = GetInputReplce(.FORM("strAddData10_"), "")
			strAddData11    = GetInputReplce(.FORM("strAddData11_"), "")
			strAddData12    = GetInputReplce(.FORM("strAddData12_"), "")
			strAddData13    = GetInputReplce(.FORM("strAddData13_"), "")
			strAddData14    = GetInputReplce(.FORM("strAddData14_"), "")
			strAddData15    = GetInputReplce(.FORM("strAddData15_"), "")
			strCaptcha      = GetInputReplce(.FORM("strCaptcha"), "")
	
		END WITH
	
		IF intMemberSrl    = "" THEN intMemberSrl    = "0"
		IF bitTitleBold   <> "" THEN bitTitleBold    = "1"
		IF bitAllowComment = "" THEN bitAllowComment = "1"
		IF bitAllowScrap   = "" THEN bitAllowScrap   = "1"
	
		DIM bitUseConsult, bitBoardAdmin, strWriteNotName, bitUseWriteEmail, strWriteEmailList
	
		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '" & intSrl & "' ")
	
		bitUseConsult     = RS("bitUseConsult")
		strWriteNotName   = RS("strWriteNotName")
		bitUseWriteEmail  = RS("bitUseWriteEmail")
		strWriteEmailList = RS("strWriteEmailList")
		bitBoardAdmin     = GetBoardAdminCheck(intSrl, SESSION("memberSeq"), SESSION("staff"))

		IF intMemberSrl = "0" AND bitBoardAdmin = False AND writeAct <> "modify" THEN
			IF ActCaptchaCheck("ASPCAPTCHA", strCaptcha) = False THEN
				RESPONSE.WRITE "ERROR01"
				RESPONSE.End()
			END IF
		END IF

		IF bitBoardAdmin = False THEN
	
			IF strWriteNotName <> "" AND ISNULL(strWriteNotName) = False THEN
		
				IF INSTR(strWriteNotName, strUserName) > 0 THEN
					RESPONSE.WRITE "ERROR02"
					RESPONSE.End()
				END IF
		
				IF INSTR(strWriteNotName, strNickName) > 0 THEN
					RESPONSE.WRITE "ERROR02"
					RESPONSE.End()
				END IF
		
			END IF
	
		END IF
	
		IF GetTrimSpaceCheck(strUserName) = False OR GetTrimSpaceCheck(strNickName) = False OR GetTrimSpaceCheck(strTitle) = False OR GetTrimSpaceCheck(strContent) = False THEN
			RESPONSE.WRITE "ERROR02"
			RESPONSE.End()
		END IF
	
		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LEVEL_POINT_READ] '" & intSrl & "' ")
	
		IF GetBoardLevelCheck(RS("strWriteLevel"), SESSION("memberSeq"), SESSION("memberGroup"), RS("strWriteGroup"), bitBoardAdmin, bitUseConsult) = False THEN
			RESPONSE.WRITE "ERROR03"
			RESPONSE.End()
		END IF

		IF bitBoardAdmin = False THEN
			IF intMemberSrl <> "0" THEN
				IF SESSION("memberSeq") = "" THEN
					RESPONSE.WRITE "ERROR03"
					RESPONSE.End()
				ELSE
					IF INT(intMemberSrl) <> INT(SESSION("memberSeq")) THEN
						RESPONSE.WRITE "ERROR03"
						RESPONSE.End()
					END IF
				END IF
			END IF
		END IF
	
		DIM bitUsePoint, intWritePoint, strWritePoint, intUploadPoint, strUploadPoint
	
		bitUsePoint    = RS("bitUsePoint")
		intWritePoint  = RS("intWritePoint")
		strWritePoint  = RS("strWritePoint")
		intUploadPoint = RS("intUploadPoint")
		strUploadPoint = RS("strUploadPoint")

		IF bitBoardAdmin = True THEN bitUsePoint = False

		DIM strTagTemp
	
		IF strTag <> "" AND ISNULL(strTag) = False THEN
			FOR EACH strTags IN SPLIT(strTag, ",")
				IF INSTR(strTagTemp, strTags) = 0 THEN
					IF strTagTemp <> "" THEN strTagTemp = strTagTemp & ","
					strTagTemp = strTagTemp & strTags
				END IF
			NEXT
		END IF

		DIM tmpFileCount
	
		IF strUploadFile <> "" AND ISNULL(strUploadFile) = False THEN
			tmpFileCount = UBOUND(SPLIT(strUploadFile, ","))
			strFile  = SPLIT(SPLIT(strUploadFile, ",")(tmpFileCount), "$")(0)
		END IF

		IF strUploadImg  <> "" AND ISNULL(strUploadImg)  = False THEN
			tmpFileCount = UBOUND(SPLIT(strUploadImg, ","))
			strImage = SPLIT(SPLIT(strUploadImg, ",")(tmpFileCount), "$")(0)
		END IF

		SELECT CASE writeAct
		CASE "write"
	
			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_ADD] 'W', '', '" & intSrl & "', '" & intCategory & "', '" & intMemberSrl & "', '" & strUserID & "', '" & strPassword & "', N'" & strUserName & "', N'" & strNickName & "', N'" & strEmail & "', N'" & strHomepage & "', N'" & strTitle & "', '" & strTitleSize & "', '" & strTitleColor & "', '" & bitTitleBold & "', N'" & strContent & "', '" & strIpAddr & "', N'" & strTagTemp & "', '" & bitNotice & "', '" & bitSecret & "', '" & bitMessage & "', '" & bitAllowComment & "', '" & bitAllowScrap & "', N'" & strFile & "', N'" & strImage & "', N'" & strAddData1 & "', N'" & strAddData2 & "', N'" & strAddData3 & "', N'" & strAddData4 & "', N'" & strAddData5 & "', N'" & strAddData6 & "', N'" & strAddData7 & "', N'" & strAddData8 & "', N'" & strAddData9 & "', N'" & strAddData10 & "', N'" & strAddData11 & "', N'" & strAddData12 & "', N'" & strAddData13 & "', N'" & strAddData14 & "', N'" & strAddData15 & "' ")
			
			intSeq = RS(0)
	
			IF bitUsePoint = True AND intMemberSrl <> "0" AND intWritePoint <> 0 THEN DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '" & intMemberSrl & "', '" & intMemberSrl & "', '" & intWritePoint & "', '" & strWritePoint & "', 'write', '0', '" & intSeq & "' ")
	
			IF bitUseWriteEmail = True AND strWriteEmailList <> "" AND ISNULL(strWriteEmailList) = False THEN
				FOR EACH strRecvMail IN SPLIT(strWriteEmailList, ",")
					CALL ActSendEmail(strUserName, strEmail, strRecvMail, strRecvMail, strTitle, strContent, "", "", "", "")
				NEXT
			END IF

			IF strUploadFile <> "" AND ISNULL(strUploadFile) = False THEN
				FOR EACH strFiles IN SPLIT(strUploadFile, ",")
					SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_ADD] '', '" & intSrl & "', '" & intSeq & "', '0', '" & intMemberSrl & "', '0', '" & SPLIT(strFiles, "$")(1) & "', N'" & SPLIT(strFiles, "$")(0) & "', '" & SPLIT(strFiles, "$")(2) & "', './" & CONF_strFilePath & "/board/" & intSrl & "/files/" & SPLIT(strFiles, "$")(1) & "' ")
					IF bitUsePoint = True AND intMemberSrl <> "0" AND intUploadPoint <> 0 AND strUploadFile <> "" THEN DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '" & intMemberSrl & "', '" & intMemberSrl & "', '" & intUploadPoint & "', '" & strUploadPoint & "', 'upload', '0', '" & intSeq & "', '', '" & RS("intSeq") & "' ")
				NEXT
			END IF
		
			IF strUploadImg <> "" AND ISNULL(strUploadImg) = False THEN
				FOR EACH strFiles IN SPLIT(strUploadImg, ",")
					DBCON.EXECUTE("[ARTY30_SP_FILES_ADD] '', '" & intSrl & "', '" & intSeq & "', '0', '" & intMemberSrl & "', '1', '', N'" & SPLIT(strFiles, "$")(0) & "', '" & SPLIT(strFiles, "$")(1) & "', './" & CONF_strFilePath & "/board/" & intSrl & "/images/" & SPLIT(strFiles, "$")(0) & "' ")
				NEXT
			END IF

			IF intMemberSrl = "0" THEN
				IF SESSION("boardSeq") = "" THEN SESSION("boardSeq") = intSeq ELSE SESSION("boardSeq") = SESSION("boardSeq") & "," & intSeq
			END IF

			RESPONSE.WRITE intSeq

		CASE "modify"

			IF strUploadFile <> "" AND ISNULL(strUploadFile) = False THEN
				FOR EACH strFiles IN SPLIT(strUploadFile, ",")
					SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_ADD] '', '" & intSrl & "', '" & intSeq & "', '0', '" & intMemberSrl & "', '0', '" & SPLIT(strFiles, "$")(1) & "', N'" & SPLIT(strFiles, "$")(0) & "', '" & SPLIT(strFiles, "$")(2) & "', './" & CONF_strFilePath & "/board/" & intSrl & "/files/" & SPLIT(strFiles, "$")(1) & "' ")
					IF bitUsePoint = True AND intMemberSrl <> "0" AND intUploadPoint <> 0 AND strUploadFile <> "" THEN DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '" & intMemberSrl & "', '" & intMemberSrl & "', '" & intUploadPoint & "', '" & strUploadPoint & "', 'upload', '0', '" & intSeq & "', '', '" & RS("intSeq") & "' ")
				NEXT
			END IF
		
			IF strUploadImg <> "" AND ISNULL(strUploadImg) = False THEN
				FOR EACH strFiles IN SPLIT(strUploadImg, ",")
					DBCON.EXECUTE("[ARTY30_SP_FILES_ADD] '', '" & intSrl & "', '" & intSeq & "', '0', '" & intMemberSrl & "', '1', '', N'" & SPLIT(strFiles, "$")(0) & "', '" & SPLIT(strFiles, "$")(1) & "', './" & CONF_strFilePath & "/board/" & intSrl & "/images/" & SPLIT(strFiles, "$")(0) & "' ")
				NEXT
			END IF

			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_ADD] 'E', '" & intSeq & "', '" & intSrl & "', '" & intCategory & "', '" & intMemberSrl & "', '" & strUserID & "', '" & strPassword & "', N'" & strUserName & "', N'" & strNickName & "', N'" & strEmail & "', N'" & strHomepage & "', N'" & strTitle & "', '" & strTitleSize & "', '" & strTitleColor & "', '" & bitTitleBold & "', N'" & strContent & "', '" & strIpAddr & "', N'" & strTagTemp & "', '" & bitNotice & "', '" & bitSecret & "', '" & bitMessage & "', '" & bitAllowComment & "', '" & bitAllowScrap & "', N'" & strFile & "', N'" & strImage & "', N'" & strAddData1 & "', N'" & strAddData2 & "', N'" & strAddData3 & "', N'" & strAddData4 & "', N'" & strAddData5 & "', N'" & strAddData6 & "', N'" & strAddData7 & "', N'" & strAddData8 & "', N'" & strAddData9 & "', N'" & strAddData10 & "', N'" & strAddData11 & "', N'" & strAddData12 & "', N'" & strAddData13 & "', N'" & strAddData14 & "', N'" & strAddData15 & "' ")
	
		END SELECT
	
		IF strTagTemp <> "" THEN DBCON.EXECUTE("[ARTY30_SP_BOARD_TAG_ADD] '" & intSrl & "', '" & intSeq & "', N'" & strTagTemp & "' ")
	
		RESPONSE.End()

	END IF
	
	SET RS = NOTHING : DBCON.CLOSE
%>