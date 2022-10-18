<!-- #include file = "Member.Default.asp" -->
<%
	IF SESSION("memberSeq") = "" THEN

		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_session_error"), "close", "")
		RESPONSE.End()

	END IF
%>
<form id="extForm" name="extForm" method="post">
<input type="hidden" id="intMemberSrl" name="intMemberSrl" value="<%=SESSION("memberSeq")%>" />
</form>