<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = ""
	isStaffAddLog = False
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM strSearchTarget, strSearchKeyword
	
		WITH REQUEST
	
			strSearchTarget  = GetInputReplce(.FORM("searchTarget"), "")
			strSearchKeyword = GetInputReplce(.FORM("searchKeyword"), "")
	
		END WITH

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_SEARCH] '" & strSearchTarget & "', '" & strSearchKeyword & "' ")

		DIM iCount

		iCount = 0

		RESPONSE.WRITE "["
	
		WHILE NOT(RS.EOF)
	
			iCount = iCount + 1
	
			IF iCount > 1 THEN RESPONSE.WRITE ","

			RESPONSE.WRITE "{""member_srl"":""" & RS("intSeq") & """, ""userid"":""" & RS("strLoginID") & """, ""username"":""" & RS("strUserName") & """, ""nickname"":""" & RS("strNickName") & """, ""email"":""" & RS("strEmail") & """, ""visitdate"":"""

			IF ISNULL(RS("strVisitDate")) = False THEN RESPONSE.WRITE REPLACE(LEFT(RS("strVisitDate"),10), "-", ".") ELSE RESPONSE.WRITE "-"

			RESPONSE.WRITE """, ""regdate"":""" & REPLACE(LEFT(RS("strRegDate"), 10), "-", ".") & """}" & CHR(10)

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "]"

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET objRoot = NOTHING : SET rootNode = NOTHING
%>