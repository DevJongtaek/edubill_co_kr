<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM Act, strLoginID, strLoginPwd

	Act         = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	strLoginID  = GetInputReplce(REQUEST.FORM("strLoginID"), "")
	strLoginPwd = GetInputReplce(REQUEST.FORM("strPassword"), "")

	RESPONSE.WRITE ActMemberLogin(strLoginID, strLoginPwd, False)
	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>