<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	IF INSTR(CONF_strSiteUrl, "http://" & REQUEST.ServerVariables("HTTP_HOST")) = 0 THEN

		RESPONSE.WRITE "ERROR"
		RESPONSE.End()

	ELSE

		DIM intMemberSrl
		intMemberSrl = GetInputReplce(REQUEST.FORM("memberSrl"), "")

		RESPONSE.WRITE "["
	
		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & intMemberSrl & "' ")

		RESPONSE.WRITE "{""userid"":""" & RS("strLoginID") & """, ""email"":""" & RS("strEmail") & """, ""homepage"":""" & RS("strHomePage") & """}" & CHR(10)
	
		RESPONSE.WRITE "]"

	END IF
	
	DBCON.CLOSE
%>