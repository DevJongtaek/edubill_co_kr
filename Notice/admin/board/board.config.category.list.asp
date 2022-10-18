<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM intSrl
	intSrl = GetInputReplce(REQUEST.FORM("intSrl"), False)

	RESPONSE.WRITE "["

	DIM iCount
	iCount = 0

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_LIST] '" & intSrl & "' ")

	WHILE NOT(RS.EOF)

		iCount = iCount + 1
		IF iCount > 1 THEN RESPONSE.WRITE ","

			RESPONSE.WRITE "{""code"":""" & RS("intCode") & """, ""parentcode"":""" & RS("intParentCode") & """, ""title"":""" & RS("strTitle") & """, ""color"":""" & RS("strFontColor") & """, ""document_count"":""" & RS("intBoardCount") & """}" & CHR(10)

	RS.MOVENEXT
	WEND

	RESPONSE.WRITE "]"


	SET RS = NOTHING : DBCON.CLOSE
%>
