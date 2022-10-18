<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	RESPONSE.WRITE "["

	DIM iCount, tmpFor
	iCount = 0

	SET RS = DBCON.EXECUTE("[ARTY30_SP_POPUPS_READ] 'E', '' ")

	WHILE NOT(RS.EOF)

		iCount = iCount + 1
		IF iCount > 1 THEN RESPONSE.WRITE ","

		RESPONSE.WRITE "{""seq"":""" & RS("intSeq") & """, ""position"":""" & RS("strPosition") & """, ""width"":""" & RS("intWidth") & """, ""height"":""" & RS("intHeight") & """, ""scroll"":""" & GetBitTypeNumberChg(RS("bitScroll")) & """, ""popup_type"":""" & RS("strPopupType") & """}" & CHR(10)

	RS.MOVENEXT
	WEND

	RESPONSE.WRITE "]"

	SET RS = NOTHING : DBCON.CLOSE
%>