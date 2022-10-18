<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM intSrl, intBoardSeq, listtype, bitImage

	intSrl        = GetInputReplce(REQUEST.FORM("board_srl"), "")
	intBoardSeq   = GetInputReplce(REQUEST.FORM("board_seq"), "")
	intCommentSeq = GetInputReplce(REQUEST.FORM("comment_seq"), "")
	listtype      = GetInputReplce(REQUEST.FORM("list_type"), "")
	bitImage      = GetInputReplce(REQUEST.FORM("image"), "")

	DIM CONF_bitBoardAdmin, CONF_bitUseConsult, CONF_strDownLevel

	CONF_bitBoardAdmin = GetBoardAdminCheck(intSrl, SESSION("memberSeq"), SESSION("staff"))	

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '" & intSrl & "' ")

	CONF_bitUseConsult = RS("bitUseConsult")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LEVEL_POINT_READ] '" & intSrl & "' ")

	CONF_strDownLevel = GetBoardLevelCheck(RS("strDownLevel"), SESSION("memberSeq"), SESSION("memberGroup"), RS("strDownGroup"), CONF_bitBoardAdmin, CONF_bitUseConsult)
	
	SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_LIST] '" & intSrl & "', '" & intBoardSeq & "', '" & intCommentSeq & "', '" & listtype & "', '" & bitImage & "' ")

	RESPONSE.WRITE "["

	DIM iCount, tmpFor
	iCount = 0

	WHILE NOT(RS.EOF)

		iCount = iCount + 1
		IF iCount > 1 THEN RESPONSE.WRITE ","

		RESPONSE.WRITE "{""seq"":""" & RS("intSeq") & """, ""filename"":""" & RS("strFileName") & """, ""fileext"":""" & GetFileExt(RS("strFileName")) & """, ""filesize1"":""" & GetFilesize(RS("intSize")) & """, ""filesize2"":""" & RS("intSize") & """, ""filedown"":""" & RS("intDown") & """, ""downlevel"":""" & GetBitTypeNumberChg(CONF_strDownLevel) & ""
		RESPONSE.WRITE """}" & CHR(10)

	RS.MOVENEXT
	WEND

	RESPONSE.WRITE "]"

	SET RS = NOTHING : DBCON.CLOSE
%>