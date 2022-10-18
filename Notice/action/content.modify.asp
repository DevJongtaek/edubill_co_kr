<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	DIM boardSrl, boardSeq, commentSeq, strContent, bitBoardAdmin

	WITH REQUEST

		boardSrl   = GetInputReplce(.QueryString("board_srl"), "")
		boardSeq   = GetInputReplce(.QueryString("board_seq"), "")
		commentSeq = GetInputReplce(.QueryString("comment_seq"), "")
		strContent = GetInputReplce(.FORM("strTempContent"), "")

	END WITH

	bitBoardAdmin = GetBoardAdminCheck(boardSrl, SESSION("memberSeq"), SESSION("staff"))

	IF bitBoardAdmin = False THEN
		IF commentSeq = "" THEN
			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_READ] '', '" & boardSeq & "', '', '', '0' ")
			IF RS("intMmeberSrl") = "0" THEN
				IF GetPasswordSessionCheck(boardSeq, SESSION("boardSeq")) = False THEN
					RESPONSE.WRITE "ERROR"
					RESPONSE.End()
				END IF
			ELSE
				IF SESSION("memberSeq") = "" THEN
					RESPONSE.WRITE "ERROR"
					RESPONSE.End()
				ELSE
					IF INT(RS("intMmeberSrl")) <> INT(SESSION("memberSeq")) THEN
						RESPONSE.WRITE "ERROR"
						RESPONSE.End()
					END IF
				END IF
			END IF
		ELSE
			SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_READ] '" & commentSeq & "' ")
			IF RS("intMmeberSrl") = "0" THEN
				IF GetPasswordSessionCheck(commentSeq, SESSION("commentSeq")) = False THEN
					RESPONSE.WRITE "ERROR"
					RESPONSE.End()
				END IF
			ELSE
				IF SESSION("memberSeq") = "" THEN
					RESPONSE.WRITE "ERROR"
					RESPONSE.End()
				ELSE
					IF INT(RS("intMmeberSrl")) <> INT(SESSION("memberSeq")) THEN
						RESPONSE.WRITE "ERROR"
						RESPONSE.End()
					END IF
				END IF
			END IF
		END IF
	END IF

	DBCON.EXECUTE("[ARTY30_SP_CONTENT_MODIFY] '" & boardSeq & "', '" & commentSeq & "', '" & strContent & "' ")

	DBCON.CLOSE
%>