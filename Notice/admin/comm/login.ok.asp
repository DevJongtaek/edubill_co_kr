<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM strLoginID, strLoginPwd

	strLoginID  = GetInputReplce(REQUEST.FORM("id"), "")
	strLoginPwd = GetInputReplce(REQUEST.FORM("enpw"), "")

	RESPONSE.WRITE ActMemberLogin(strLoginID, strLoginPwd, True)
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>