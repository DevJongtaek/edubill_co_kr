<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "dbconn.asp" -->
<!-- #include file = "function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM strBoardID, intBoardSrl, intBoardSeq, intCommentSeq, intFileSeq, bitUseConsult, CONF_strSkinLang

	WITH REQUEST

		strBoardID    = GetInputReplce(.QueryString("bid"), "")
		intBoardSeq   = GetInputReplce(.QueryString("seq"), "")
		intCommentSeq = GetInputReplce(.QueryString("comment_seq"), "")
		intFileSeq    = GetInputReplce(.QueryString("file_seq"), "")

	END WITH

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '', '" & strBoardID & "' ")

	intBoardSrl      = RS("intSrl")
	bitUseConsult    = RS("bitUseConsult")
	CONF_strSkinLang = RS("strSkinLang")

	DIM xmlPath
	xmlPath = Server.MapPath(".") & "\skin/board/" & RS("strSkinName") & "/lang/" & RS("strSkinLang") & "/lang.xml"
%>
<!--#include file="../include/Xml.Config.asp"-->
<%
	DIM bitBoardAdmin
	bitBoardAdmin = GetBoardAdminCheck(intBoardSrl, SESSION("memberSeq"), SESSION("staff"))

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LEVEL_POINT_READ] '" & intBoardSrl & "' ")

	IF GetBoardLevelCheck(RS("strDownLevel"), SESSION("memberSeq"), SESSION("memberGroup"), RS("strDownGroup"), bitBoardAdmin, bitUseConsult) = False THEN

		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_permitted"), "", "")
		RESPONSE.End()

	END IF

	DIM bitUsePoint, intDownPoint, strDownPoint

	bitUsePoint  = RS("bitUsePoint")
	intDownPoint = RS("intDownPoint")
	strDownPoint = RS("strDownPoint")

	DIM bitSecret, intMemberSrl, strFileSid, strFileName, intFileMemberSrl

	SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_READ] 'R', '" & intFileSeq & "' ")

	IF RS.EOF THEN

		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_find_file"), "", "")
		RESPONSE.End()

	END IF

	strFileSid       = RS("strSid")
	strFileName      = RS("strFilename")
	intFileMemberSrl = RS("intMemberSrl")

	IF intCommentSeq = "" THEN
		strDownFileName = GetNowFolderPath("") & "\" & CONF_strFilePath & "\board\" & intBoardSrl & "\files\" & strFileSid
	ELSE
		strDownFileName = GetNowFolderPath("") & "\" & CONF_strFilePath & "\comment\" & intBoardSrl & "\files\" & strFileSid
	END IF

	IF intCommentSeq = "" THEN

		IF bitBoardAdmin = False THEN

			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_READ] '" & intBoardSrl & "', '" & intBoardSeq & "', '', '', '0' ")

			IF RS.EOF THEN

				RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_invalid_request"), "", "")
				RESPONSE.End()

			END IF
			
			bitSecret    = RS("bitSecret")
			intMemberSrl = RS("intMemberSrl")

			IF bitSecret = True THEN
				IF SESSION("boardSeq") <> "" THEN
					FOR EACH intSecretSeq IN SPLIT(SESSION("boardSeq"), ",")
						IF CDbl(intSecretSeq) = CDbl(intBoardSeq) THEN
							bitSecret = False
							EXIT FOR
						END IF
					NEXT
				END IF
			END IF

			IF bitSecret = True THEN
				IF SESSION("memberSeq") <> "" THEN
					IF INT(intMemberSrl) = INT(SESSION("memberSeq")) THEN bitSecret = False
				END IF
			END IF

			IF bitSecret = True THEN
				RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_permitted"), "", "")
				RESPONSE.End()
			END IF

		END IF

		IF bitUsePoint = True AND bitBoardAdmin = False AND intDownPoint <> 0 THEN

			IF SESSION("memberSeq") = "" THEN
				IF intDownPoint < 0 THEN
					RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_disallow_by_point"), "", "")
					RESPONSE.End()
				END IF
			ELSE
				IF intFileMemberSrl <> SESSION("memberSeq") THEN
					IF intDownPoint < 0 THEN
						SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & SESSION("memberSeq") & "' ")
						IF INT(RS("intPoint")) - (intDownPoint * -1) < 0 THEN
							RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_disallow_by_point"), "", "")
							RESPONSE.End()
						END IF
					END IF
					DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '" & SESSION("memberSeq") & "', '" & SESSION("memberSeq") & "', " & intDownPoint & ", N'" & strDownPoint & "', 'down', '0', '" & intBoardSeq & "', '" & intCommentSeq & "', '" & intFileSeq & "' ")
				END IF
			END IF

		END IF

	ELSE

		IF bitBoardAdmin = False THEN

			SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_READ] '" & intCommentSeq & "' ")

			IF RS.EOF THEN
				RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_invalid_request"), "", "")
				RESPONSE.End()
			END IF
			
			bitSecret    = RS("bitSecret")
			intMemberSrl = RS("intMemberSrl")

			IF bitSecret = True THEN
				IF SESSION("commentSeq") <> "" THEN
					FOR EACH intSecretSeq IN SPLIT(SESSION("commentSeq"), ",")
						IF CDbl(intSecretSeq) = CDbl(intCommentSeq) THEN
							bitSecret = False
							EXIT FOR
						END IF
					NEXT
				END IF
			END IF

			IF bitSecret = True THEN
				IF SESSION("memberSeq") <> "" THEN
					IF INT(intMemberSrl) = INT(SESSION("memberSeq")) THEN
						bitSecret = False
					END IF
				END IF
			END IF

			IF bitSecret = True THEN
				RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_permitted"), "", "")
				RESPONSE.End()
			END IF

		END IF

	END IF

	DBCON.EXECUTE("[ARTY30_SP_FILES_UPDATE] '" & intFileSeq & "' ")

	DBCON.EXECUTE("[ARTY30_SP_FILES_DOWN_LOG_ADD] '" & intBoardSrl & "', '" & intBoardSeq & "', '" & intCommentSeq & "', '" & intFileSeq & "', '" &  SESSION("memberSeq") & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "' ")

	IF intCommentSeq = "" THEN
		RESPONSE.REDIRECT "libs/file.down.act.asp?intBoardSrl=" & intBoardSrl & "&strFileName=" & SERVER.URLPathEncode(strFileName) & "&strFileSid=" & strFileSid & "&strFileFolder=board"
	ELSE
		RESPONSE.REDIRECT "libs/file.down.act.asp?intBoardSrl=" & intBoardSrl & "&strFileName=" & strFileName & "&strFileSid=" & strFileSid & "&strFileFolder=comment"
	END IF

	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>