<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D03"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act, strSeq, intSrl, intCategory, strMemo, bitUseTrash, strMemoUserSrl
		Act    = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))

		WITH REQUEST

			strSeq      = GetInputReplce(.FORM("strSeq"), "")
			intSrl      = GetInputReplce(.FORM("intSrl"), "")
			intCategory = GetInputReplce(.FORM("intCategory"), "")
			strMemo     = GetInputReplce(.FORM("strMemo"), "")
			bitUseTrash = GetInputReplce(.FORM("bitTrash"), "")
			
		END WITH

		strSeq = SPLIT(strSeq, ",")

		DIM intMemberSrl

		SELECT CASE Act
		CASE "boardremove"

			FOR EACH intBoardSeq IN strSeq

				SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_READ] '', '" & intBoardSeq & "', '', '', '0' ")

				intMemberSrl = RS("intMemberSrl")
				intSrl       = RS("intSrl")

				IF RS("intMemberSrl") <> "0" THEN
					IF INSTR(strMemoUserSrl, RS("intMemberSrl") & ",") = 0 THEN strMemoUserSrl = strMemoUserSrl & RS("intMemberSrl") & ","
				END IF

				CALL ActBoardRemove(intSrl, intBoardSeq, intMemberSrl, bitUseTrash, GetNowFolderPath("../../" & CONF_strFilePath))

			NEXT

		CASE "move"

			DIM strSourcePath, strTargetPath

			FOR EACH intSeq IN strSeq

				SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_READ] '', '" & intSeq & "', '', '', '0' ")

				IF INT(RS("intSrl")) <> INT(intSrl) THEN

					IF RS("intMemberSrl") <> "0" THEN
						IF INSTR(strMemoUserSrl, RS("intMemberSrl") & ",") = 0 THEN strMemoUserSrl = strMemoUserSrl & RS("intMemberSrl") & ","
					END IF
						
					SET RS2 = DBCON.EXECUTE("[ARTY30_SP_FILES_LIST] '', '" & intSeq & "', '', 'A', '' ")
					
					WHILE NOT(RS2.EOF)

						strSourcePath = GetNowFolderPath("../../" & CONF_strFilePath)
						strTargetPath = GetNowFolderPath("../../" & CONF_strFilePath)

						IF RS2("intCommentSeq") = "0" THEN
							strSourcePath = strSourcePath & "\board\" & RS2("intSrl")
							strTargetPath = strTargetPath & "\board\" & intSrl
						ELSE
							strSourcePath = strSourcePath & "\comment\" & RS2("intSrl")
							strTargetPath = strTargetPath & "\comment\" & intSrl
						END IF

						IF RS2("bitImage") = True THEN
							strSourcePath = strSourcePath & "\images\"
							strTargetPath = strTargetPath & "\images\"
						ELSE
							strSourcePath = strSourcePath & "\files\"
							strTargetPath = strTargetPath & "\files\"
						END IF

						IF RS2("bitImage") = True THEN

							CALL ActDefaultFileCopy(strSourcePath & RS2("strFilename"), strTargetPath & RS2("strFilename"))
							CALL ActDefaultFileCopy(strSourcePath & "temp\" & RS2("strFilename"), strTargetPath & "temp\" & RS2("strFilename"))
							CALL ActDefaultFileCopy(strSourcePath & "thrum\" & RS2("strFilename"), strTargetPath & "thrum\" & RS2("strFilename"))

							CALL ActFileDelete(strSourcePath & RS2("strFilename"))
							CALL ActFileDelete(strSourcePath & "temp\" & RS2("strFilename"))
							CALL ActFileDelete(strSourcePath & "thrum\" & RS2("strFilename"))

						ELSE

							CALL ActDefaultFileCopy(strSourcePath & RS2("strSid"), strTargetPath & RS2("strSid"))
							CALL ActFileDelete(strSourcePath & RS2("strSid"))

						END IF

					RS2.MOVENEXT
					WEND

					SET RS2 = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_LIST] 'R', '" & RS("intSrl") & "', '" & intSeq & "' ")

					WHILE NOT(RS2.EOF)

						strContent = REPLACE(RS2("strContent"), "/comment/" & RS("intSrl") & "/images/", "/comment/" & intSrl & "/images/")
						DBCON.EXECUTE("[ARTY30_SP_CONTENT_MODIFY] '" & intSeq & "', '" & RS2("intSeq") & "', N'" & strContent & "' ")

					RS2.MOVENEXT
					WEND

					strContent = GetInputReplce(REPLACE(RS("strContent"), "/board/" & RS("intSrl") & "/images/", "/board/" & intSrl & "/images/"), "")
					DBCON.EXECUTE("[ARTY30_SP_BOARD_MANAGE_MOVE] '" & intSrl & "', '" & intSeq & "', '" & intCategory & "', N'" & strContent & "' ")

				END IF

			NEXT

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : SET RS2 = NOTHING : DBCON.CLOSE
%>