<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM strBoardSrl, intCategory, intCount, strDateType, strOrderField, strOrderDesc

	WITH REQUEST

		strBoardSrl   = .FORM("board_srl")
		intCategory   = .FORM("category_srl")
		intCount      = .FORM("count")
		strDateType   = .FORM("strDateType")
		strOrderField = .FORM("order_field")
		strOrderDesc  = .FORM("order_desc")

	END WITH

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_MAIN_LIST] '" & strBoardSrl & "', '" & intCategory & "', '" & strDateType & "', '" & intCount & "', '', '" & strOrderField & "', '" & strOrderDesc & "' ")

	RESPONSE.WRITE "["

	DIM iCount, tmpFor
	iCount = 0

	WHILE NOT(RS.EOF)

		iCount = iCount + 1
		IF iCount > 1 THEN RESPONSE.WRITE ","

		RESPONSE.WRITE "{""seq"":""" & RS("intSeq") & """, ""board_srl"":""" & RS("intSrl") & """, ""bid"":""" & RS("strBoardID") & """, ""category"":""" & RS("intCategory") & """, ""category_title"":""" & RS("strCategory") & """, ""member_srl"":""" & RS("intMemberSrl") & """, ""user_id"":""" & RS("strUserID") & """,""user_name"":""" & RS("strUserName") & """,""nick_name"":""" & RS("strNickName") & """,""title"":""" & RS("strTitle") & """,""reg_date"":""" & RS("strRegDate") & ""
		RESPONSE.WRITE """}" & CHR(10)

	RS.MOVENEXT
	WEND

	RESPONSE.WRITE "]"

	SET RS = NOTHING : DBCON.CLOSE
%>