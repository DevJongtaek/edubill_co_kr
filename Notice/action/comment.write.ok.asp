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
			intCommentSeq   = GetInputReplce(.FORM("intCommentSeq"), "")
			intSrl          = GetInputReplce(.FORM("intSrl"), "")
			intBoardSeq     = GetInputReplce(.FORM("intBoardSeq"), "")
			intThread       = GetInputReplce(.FORM("intThread"), "")
			intMemberSrl    = GetInputReplce(.FORM("intMemberSrl"), "")
			strUserID       = GetInputReplce(.FORM("strUserID"), "")
			strUserName     = GetInputReplce(.FORM("strUserName"), "")
			strNickName     = GetInputReplce(.FORM("strNickName"), "")
			strPassword     = GetInputReplce(.FORM("strPassword"), "")
			strEmail        = GetInputReplce(.FORM("strEmail"), "")
			strHomepage     = GetInputReplce(.FORM("strHomepage"), "")
			strContent      = GetInputReplce(.FORM("strContent"), "")
			strIpAddr       = REQUEST.SERVERVARIABLES("REMOTE_ADDR")
			strUploadFile   = GetInputReplce(.FORM("strUploadFile"), "")
			strUploadImg    = GetInputReplce(.FORM("strUploadImg"), "")
			bitSecret       = GetInputReplce(.FORM("bitSecret"), "")
			bitMessage      = GetInputReplce(.FORM("bitMessage"), "")
	
			IF strUploadFile <> "" AND ISNULL(strUploadFile) = False THEN intFileCount = UBOUND(SPLIT(strUploadFile, ",")) + 1 ELSE intFileCount = 0
	
		END WITH
	
		IF intMemberSrl    = "" THEN intMemberSrl    = "0"
	
		DIM bitBoardAdmin, bitUseConsult
		bitBoardAdmin     = GetBoardAdminCheck(intSrl, SESSION("memberSeq"), SESSION("staff"))
	
		IF GetTrimSpaceCheck(strUserName) = False OR GetTrimSpaceCheck(strNickName) = False THEN
			RESPONSE.WRITE "ERROR01"
			RESPONSE.End()
		END IF

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '" & intSrl & "' ")
	
		bitUseConsult = RS("bitUseConsult")

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LEVEL_POINT_READ] '" & intSrl & "' ")
	
		IF GetBoardLevelCheck(RS("strCmtWriteLevel"), SESSION("memberSeq"), SESSION("memberGroup"), RS("strCmtWriteGroup"), bitBoardAdmin, bitUseConsult) = False THEN
			RESPONSE.WRITE "ERROR02"
			RESPONSE.End()
		END IF
	
		IF bitBoardAdmin = False AND intMemberSrl <> "0" THEN
			IF SESSION("memberSeq") = "" THEN
				RESPONSE.WRITE "ERROR02"
				RESPONSE.End()
			ELSE
				IF INT(intMemberSrl) <> INT(SESSION("memberSeq")) THEN
					RESPONSE.WRITE "ERROR02"
					RESPONSE.End()
				END IF
			END IF
		END IF
	
		DIM bitUsePoint, intCmtWritePoint, strCmtWritePoint
	
		bitUsePoint      = RS("bitUsePoint")
		intCmtWritePoint = RS("intCmtWritePoint")
		strCmtWritePoint = RS("strCmtWritePoint")

		IF bitBoardAdmin = True THEN bitUsePoint = False

		IF writeAct = "view" OR writeAct = "comment_reply" THEN
			IF bitUsePoint = True AND intCmtWritePoint <> 0 THEN
				IF SESSION("memberSeq") = "" THEN
					IF intCmtWritePoint < 0 THEN
						RESPONSE.WRITE "ERROR03"
						RESPONSE.End()
					END IF
				ELSE
					IF intCmtWritePoint < 0 THEN
						SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & SESSION("memberSeq") & "' ")
						IF INT(RS("intPoint")) - (intCmtWritePoint * -1) < 0 THEN
							RESPONSE.WRITE "ERROR03"
							RESPONSE.End()
						END IF
					END IF
				END IF
			END IF
		END IF

		SELECT CASE writeAct
		CASE "view"
	
			SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_ADD] 'W', '" & intSrl & "', '', '" & intBoardSeq & "', '" & intThread & "', '" & intMemberSrl & "', '" & strUserID & "', N'" & struserName & "', N'" & strNickName & "', '" & strPassword & "', N'" & strEmail & "', N'" & strHomepage & "', N'" & strContent & "', '" & bitSecret & "', '" & bitMessage & "', '" & strIpAddr & "', '" & intFileCount & "' ")
	
			intCommentSeq = RS(0)
	
			IF bitUsePoint = True AND intMemberSrl <> "0" AND intCmtWritePoint <> 0 THEN DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '" & intMemberSrl & "', '" & intMemberSrl & "', '" & intCmtWritePoint & "', '" & strCmtWritePoint & "', 'comment', '0', '" & intBoardSeq & "', '" & intCommentSeq & "' ")

			IF SESSION("commentSeq") = "" THEN SESSION("commentSeq") = intCommentSeq ELSE SESSION("commentSeq") = SESSION("commentSeq") & "," & intCommentSeq
	
		CASE "comment_modify"
	
			DBCON.EXECUTE("[ARTY30_SP_COMMENTS_ADD] 'E', '" & intSrl & "', '" & intCommentSeq & "', '" & intBoardSeq & "', '" & intThread & "', '" & intMemberSrl & "', '" & strUserID & "', N'" & struserName & "', N'" & strNickName & "', '" & strPassword & "', N'" & strEmail & "', N'" & strHomepage & "', N'" & strContent & "', '" & bitSecret & "', '" & bitMessage & "', '" & strIpAddr & "', '" & intFileCount & "' ")

		CASE "comment_reply"
	
			SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_ADD] 'R', '" & intSrl & "', '" & intCommentSeq & "', '" & intBoardSeq & "', '" & intThread & "', '" & intMemberSrl & "', '" & strUserID & "', N'" & struserName & "', N'" & strNickName & "', '" & strPassword & "', N'" & strEmail & "', N'" & strHomepage & "', N'" & strContent & "', '" & bitSecret & "', '" & bitMessage & "', '" & strIpAddr & "', '" & intFileCount & "' ")

			intCommentSeq = RS(0)
	
			IF bitUsePoint = True AND intMemberSrl <> "0" AND intCmtWritePoint <> 0 THEN DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '" & intMemberSrl & "', '" & intMemberSrl & "', '" & intCmtWritePoint & "', '" & strCmtWritePoint & "', 'comment', '0', '" & intBoardSeq & "', '" & intCommentSeq & "' ")

			IF SESSION("commentSeq") = "" THEN SESSION("commentSeq") = intCommentSeq ELSE SESSION("commentSeq") = SESSION("commentSeq") & "," & intCommentSeq

		END SELECT
	
		IF writeAct = "view" OR writeAct = "comment_reply" THEN
			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_READ] '" & intSrl & "', '" & intBoardSeq & "', '" & intMemberSrl & "', '" & strIpAddr & "', '0' ")

			IF RS("bitMessage") = True AND RS("intMemberSrl") <> 0 THEN
				IF INT(intMemberSrl) <> INT(RS("intMemberSrl")) THEN
					DBCON.EXECUTE("[ARTY30_SP_MEMBER_MESSAGE_ADD] '" & intMemberSrl & "', '" & RS("intMemberSrl") & "', N'" & GetCutDispData(GetStripTags(strContent), 40, "..") & "', N'" & strContent & "', '1', '' ")
				END IF
			END IF

		END IF
	
		IF strUploadFile <> "" AND ISNULL(strUploadFile) = False THEN
			FOR EACH strFiles IN SPLIT(strUploadFile, ",")
				DBCON.EXECUTE("[ARTY30_SP_FILES_ADD] '', '" & intSrl & "', '" & intBoardSeq & "', '" & intCommentSeq & "', '" & intMemberSrl & "', '0', '" & SPLIT(strFiles, "$")(1) & "', '" & SPLIT(strFiles, "$")(0) & "', '" & SPLIT(strFiles, "$")(2) & "', './" & CONF_strFilePath & "/comment/" & intSrl & "/files/" & SPLIT(strFiles, "$")(1) & "' ")
			NEXT
		END IF
	
		IF strUploadImg <> "" AND ISNULL(strUploadImg) = False THEN
			FOR EACH strFiles IN SPLIT(strUploadImg, ",")
				DBCON.EXECUTE("[ARTY30_SP_FILES_ADD] '', '" & intSrl & "', '" & intBoardSeq & "', '" & intCommentSeq & "', '" & intMemberSrl & "', '1', '', '" & SPLIT(strFiles, "$")(0) & "', '" & SPLIT(strFiles, "$")(1) & "', './" & CONF_strFilePath & "/comment/" & intSrl & "/images/" & SPLIT(strFiles, "$")(0) & "' ")
			NEXT
		END IF
	
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>