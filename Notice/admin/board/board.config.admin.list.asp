<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C04"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM intSrl, searchMode, searchText
	
		WITH REQUEST
	
			intSrl     = GetInputReplce(.FORM("intSrl"), "")
			searchMode = GetInputReplce(.FORM("searchMode"), "")
			searchText = GetInputReplce(.FORM("searchText"), "")
	
		END WITH

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_ADMIN_READ] '" & intSrl & "', '', '1', '" & searchMode & "', '" & searchText & "' ")

		DIM iCount, intNumber
		iCount = 0

		RESPONSE.WRITE "["
	
		WHILE NOT(RS.EOF)
	
			iCount = iCount + 1
			intNumber = INT(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
	
			IF iCount > 1 THEN RESPONSE.WRITE ","

			RESPONSE.WRITE "{""memberSrl"":""" & RS("intSeq") & """, ""userid"":""" & RS("strLoginID") & """, ""username"":""" & RS("strUserName") & """, ""nickname"":""" & RS("strNickName") & """, ""visitdate"":"""

			IF ISNULL(RS("strVisitDate")) = False THEN RESPONSE.WRITE REPLACE(LEFT(RS("strVisitDate"),10), "-", ".") ELSE RESPONSE.WRITE "-"
			RESPONSE.WRITE """, ""visit"":""" & RS("intVisit") & """, ""article"":""" & RS("intArticle") & """, ""comment"":""" &  RS("intComment") & """}" & CHR(10)

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "]"

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET objRoot = NOTHING : SET rootNode = NOTHING
%>