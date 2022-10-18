<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "A02"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		WITH REQUEST
	
			searchTarget = GetInputReplce(.FORM("searchTarget"), "")
			searchText   = .FORM("searchText")
	
		END WITH

		SET RS = DBCON.EXECUTE("[ARTY30_SP_STAFF_SEARCH] '" & searchTarget & "', '" & searchText & "' ")
	
		RESPONSE.WRITE "["

		DIM iCount
		iCount = 0

		WHILE NOT(RS.EOF)

			iCount = iCount + 1
			IF iCount > 1 THEN RESPONSE.WRITE ","

			RESPONSE.WRITE "{""seq"":""" & RS("intSeq") & """, ""userid"":""" & RS("strLoginID") & """, ""username"":""" & RS("strUserName") & """, ""nickname"":""" & RS("strNickName") & """, ""regdate"":""" & REPLACE(LEFT(RS("strRegDate"),10), "-", ".") & """}"

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "]"

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF
%>