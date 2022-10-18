<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
'	IF INSTR(CONF_strSiteUrl, "http://" & REQUEST.ServerVariables("HTTP_HOST")) = 0 THEN

'		RESPONSE.WRITE "ERROR"
'		RESPONSE.End()

'	ELSE

		DIM filetype, filename, userpath, editorMode, boardSrl, boardSeq, commentSeq, fileseq, intMemberSrl
	
		WITH REQUEST
	
			filetype   = GetInputReplce(.FORM("filetype"), "")
			filename   = GetInputReplce(.FORM("filename"), "")
			userpath   = REPLACE(GetInputReplce(.FORM("userpath"), ""), "/", "\")
			editorMode = GetInputReplce(.FORM("editorMode"), "")
			boardSrl   = GetInputReplce(.FORM("board_srl"), "")
			boardSeq   = GetInputReplce(.FORM("board_seq"), "")
			commentSeq = GetInputReplce(.FORM("comment_seq"), "")
			fileseq    = GetInputReplce(.FORM("file_seq"), "")
	
		END WITH

		DIM strPath
	
		strPath = SERVER.MAPPATH("../" & CONF_strFilePath) & "\" & userpath

		SELECT CASE filetype
		CASE "image", "file"

			CALL ActFileDelete(strPath & filename)
			IF filetype = "image" THEN CALL ActFileDelete(strPath & "thrum\" & filename)

			IF fileseq <> "" THEN

				SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_READ] 'R', '" & fileSeq & "' ")

				IF NOT(RS.EOF) THEN

					intMemberSrl = RS("intmemberSrl")
	
					CALL ActFileDelete(strPath & RS("strSid"))
	
					SELECT CASE editorMode
					CASE "board"
	
						SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LEVEL_POINT_READ] '" & boardSrl & "' ")
	
						DIM bitUsePoint, intUploadPoint, strUploadPoint
	
						bitUsePoint    = RS("bitUsePoint")
						intUploadPoint = RS("intUploadPoint")
						strUploadPoint = RS("strUploadPoint")
	
						IF bitUsePoint = True AND intMemberSrl <> "0" AND intUploadPoint <> 0 THEN
	
							SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & intMemberSrl & "' ")
			
							IF GetBoardAdminCheck(boardSrl, intMemberSrl, RS("strAdmin")) = False THEN
	
								SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_READ] '', '" & intMemberSrl & "', '', '" & boardSeq & "', '', '" & fileseq & "', 'upload' ")
		
								IF NOT(RS.EOF) THEN DBCON.EXECUTE("[ARTY30_SP_POINT_REMOVE] '" & RS("intSeq") & "' ")
	
							END IF
	
						END IF
	
						DBCON.EXECUTE("[ARTY30_SP_FILES_REMOVE] '" & fileseq & "' ")
		
					CASE "comment"
		
						DBCON.EXECUTE("[ARTY30_SP_FILES_REMOVE] '" & fileseq & "' ")
		
					END SELECT

				END IF

			END IF

		CASE "images", "files"
	
			filename = SPLIT(filename, ",")
	
			FOR EACH files IN filename
	response.write strPath & files & "<br>"
				CALL ActFileDelete(strPath & files)
	
				IF filetype = "images" THEN
				 IF editorMode = "board" OR editorMode = "comment" THEN CALL ActFileDelete(strPath & "thrum\" & files)
				END IF
	
			NEXT
	
		END SELECT

'	END IF
	
	DBCON.CLOSE
%>