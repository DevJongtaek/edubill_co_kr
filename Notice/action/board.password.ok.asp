<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<!-- #include file = "../libs/md5.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM intSrl, intBoardSeq, intCommentSeq, strPassword

	WITH REQUEST

		intSrl         = GetInputReplce(.QueryString("board_srl"), "")
		intBoardSeq    = GetInputReplce(.QueryString("board_seq"), "")
		intCommentSeq  = GetInputReplce(.QueryString("comment_seq"), "")
		strPassword    = GetInputReplce(.FORM("password"), "")

	END WITH

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_COMMENT_PASSWORD] '" & intSrl & "', '" & intBoardSeq & "', '" & intCommentSeq & "', '" & strPassword & "' ")

	IF RS.EOF THEN

		RESPONSE.WRITE "ERROR"

	ELSE

		IF intCommentSeq = "" THEN

			IF SESSION("boardSeq") = "" THEN SESSION("boardSeq") = intBoardSeq ELSE SESSION("boardSeq") = SESSION("boardSeq") & "," & intBoardSeq

		ELSE

			IF SESSION("commentSeq") = "" THEN SESSION("commentSeq") = intCommentSeq ELSE SESSION("commentSeq") = SESSION("commentSeq") & "," & intCommentSeq

		END IF

		RESPONSE.WRITE "SUCCESS"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>