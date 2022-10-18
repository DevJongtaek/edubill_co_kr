<!-- #include file = "Member.Default.asp" -->
<%
	DIM strUserID, strUserPwd

	strUserID  = GetInputReplce(REQUEST.FORM("userid"), "")
	strUserPwd = GetInputReplce(REQUEST.FORM("userpwd"), "")

	IF strUserID = "" THEN
		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_access_page"), "url", "/")
		RESPONSE.End()
	END IF

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>