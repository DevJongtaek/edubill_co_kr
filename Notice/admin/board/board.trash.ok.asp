<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D07"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act, strPath, intSeq
		Act     = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
		strPath = GetNowFolderPath("../../") & "\" & CONF_strFilePath

		DIM resultFile

		SELECT CASE Act
		CASE "remove"

			DIM tmpCommentSeq

			FOR EACH intSeq IN REQUEST.FORM("intSeq")

				tmpCommentSeq = ""
		
				SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_TRASH_LIST] 'R', '', '', '" & SPLIT(intSeq, ",")(0) & "', '" & SPLIT(intSeq, ",")(1) & "' ")

				WHILE NOT(RS.EOF)

					IF tmpCommentSeq <> "" THEN tmpCommentSeq = tmpCommentSeq & ","
					tmpCommentSeq = tmpCommentSeq & RS("intSeq")

				RS.MOVENEXT
				WEND

				IF tmpCommentSeq <> "" THEN

					FOR EACH intCommentSeq IN SPLIT(tmpCommentSeq, ",")
					
						SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_LIST] '', '" & SPLIT(intSeq, ",")(1) & "', '" & intCommentSeq & "', 'C', '' ")

						WHILE NOT(RS.EOF)

							IF RS("bitImage") = True THEN
								CALL ActFileDelete(strPath & "\comment\" & SPLIT(intSeq, ",")(0) & "\images\" & RS("strFilename"))
								CALL ActFileDelete(strPath & "\comment\" & SPLIT(intSeq, ",")(0) & "\images\temp\" & RS("strFilename"))
								CALL ActFileDelete(strPath & "\comment\" & SPLIT(intSeq, ",")(0) & "\images\thrum\" & RS("strFilename"))
								resultFile = resultFile & "," & strPath & "\comment\" & SPLIT(intSeq, ",")(0) & "\images\" & RS("strFilename")
								resultFile = resultFile & "," & strPath & "\comment\temp\" & SPLIT(intSeq, ",")(0) & "\images\" & RS("strFilename")
								resultFile = resultFile & "," & strPath & "\comment\thrum\" & SPLIT(intSeq, ",")(0) & "\images\" & RS("strFilename")
							ELSE
								CALL ActFileDelete(strPath & "\comment\" & SPLIT(intSeq, ",")(0) & "\files\" & RS("strSid"))
								resultFile = resultFile & "," & strPath & "\comment\" & SPLIT(intSeq, ",")(0) & "\files\" & RS("strSid")
							END IF
			
							DBCON.EXECUTE("[ARTY30_SP_FILES_REMOVE] '" & RS("intSeq") & "' ")

						RS.MOVENEXT
						WEND

					NEXT

				END IF

				SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_LIST] '', '" & SPLIT(intSeq, ",")(1) & "', '', 'B', '' ")

				WHILE NOT(RS.EOF)

					IF RS("bitImage") = True THEN
						CALL ActFileDelete(strPath & "\board\" & SPLIT(intSeq, ",")(0) & "\images\" & RS("strFilename"))
						CALL ActFileDelete(strPath & "\board\" & SPLIT(intSeq, ",")(0) & "\images\temp\" & RS("strFilename"))
						CALL ActFileDelete(strPath & "\board\" & SPLIT(intSeq, ",")(0) & "\images\thrum\" & RS("strFilename"))
						resultFile = resultFile & "," & strPath & "\board\" & SPLIT(intSeq, ",")(0) & "\images\" & RS("strFilename")
						resultFile = resultFile & "," & strPath & "\board\temp\" & SPLIT(intSeq, ",")(0) & "\images\" & RS("strFilename")
						resultFile = resultFile & "," & strPath & "\board\thrum\" & SPLIT(intSeq, ",")(0) & "\images\" & RS("strFilename")
					ELSE
						CALL ActFileDelete(strPath & "\board\" & SPLIT(intSeq, ",")(0) & "\files\" & RS("strSid"))
						resultFile = resultFile & "," & strPath & "\board\" & SPLIT(intSeq, ",")(0) & "\files\" & RS("strSid")
					END IF
	
					DBCON.EXECUTE("[ARTY30_SP_FILES_REMOVE] '" & RS("intSeq") & "' ")

				RS.MOVENEXT
				WEND

				DBCON.EXECUTE("[ARTY30_SP_BOARD_TRASH_REMOVE] '" & SPLIT(intSeq, ",")(1) & "', '0' ")
	
			NEXT

		CASE "restore"

			FOR EACH intSeq IN REQUEST.FORM("intSeq")

				DBCON.EXECUTE("[ARTY30_SP_BOARD_TRASH_RESTORE] '" & SPLIT(intSeq, ",")(1) & "' ")
				DBCON.EXECUTE("[ARTY30_SP_BOARD_TRASH_REMOVE] '" & SPLIT(intSeq, ",")(1) & "', '1' ")

			NEXT

		END SELECT
		
	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>