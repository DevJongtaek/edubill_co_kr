<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../libs/function.asp" -->
<%
	CALL ActMemberLogout()

	RESPONSE.REDIRECT "?act=login"
	RESPONSE.End()
%>