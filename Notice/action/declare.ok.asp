<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	IF SESSION("memberSeq") = "" THEN

		RESPONSE.WRITE "ERROR01"
		RESPONSE.End()

	ELSE

		DIM Act, intBoardSrl, intBoardSeq, intCommentSeq
	
		WITH REQUEST
	
			Act           = GetInputReplce(.QueryString("Act"), "")
			intBoardSrl   = GetInputReplce(.FORM("board_srl"), "")
			intBoardSeq   = GetInputReplce(.FORM("board_seq"), "")
			intCommentSeq = GetInputReplce(.FORM("comment_seq"), "")
	
		END WITH

		SELECT CASE Act
		CASE "boarddeclare", "commentdeclare"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_DECLARED_ADD] '" & intBoardSrl & "', '" & intBoardSeq & "', '" & intCommentSeq & "', '" & SESSION("memberSeq") & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "' ")

			IF RS(0) = "0" THEN

				RESPONSE.WRITE "ERROR02"
				RESPONSE.End()

			END IF

		END SELECT

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>