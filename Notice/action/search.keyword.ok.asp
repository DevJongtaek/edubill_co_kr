<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	IF INSTR(CONF_strSiteUrl, "http://" & REQUEST.ServerVariables("HTTP_HOST")) = 0 THEN

		RESPONSE.WRITE "ERROR"
		RESPONSE.End()

	ELSE

		DIM intSrl, strKeyWord

		WITH REQUEST
	
			intSrl          = GetInputReplce(.FORM("intSrl"), "")
			strKeyWord      = GetInputReplce(.FORM("strKeyWord"), "")
	
		END WITH

		IF TRIM(strKeyWord) <> "" THEN
			response.write "[ARTY30_SP_SEARCH_KEYWORD_ADD] '" & intSrl & "', '" & strKeyWord & "' "
			DBCON.EXECUTE("[ARTY30_SP_SEARCH_KEYWORD_ADD] '" & intSrl & "', '" & strKeyWord & "' ")
		END IF
	
	END IF
	
	SET RS = NOTHING : DBCON.CLOSE
%>