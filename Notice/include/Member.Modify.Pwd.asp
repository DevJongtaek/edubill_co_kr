<!-- #include file = "Member.Default.asp" -->
<%
	IF SESSION("memberSeq") = "" THEN
		RESPONSE.WRITE ActFormSubmit(objXmlLang("msg_session_error"), "?act=login", "post", "strPrevUrl", "/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & "?act=member&subAct=modifypwd")
		RESPONSE.End()
	END IF

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="extForm" name="extForm" method="post">
<input type="hidden" id="strPassword" name="strPassword" />
<input type="hidden" id="strPassword2" name="strPassword2" />
<input type="hidden" id="strPrevUrl" name="strPrevUrl" value="<%="/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & "?act=member&subAct=modifypwd"%>" />
</form>