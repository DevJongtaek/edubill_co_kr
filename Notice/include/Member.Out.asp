<!-- #include file = "Member.Default.asp" -->
<%
	IF SESSION("memberSeq") = "" THEN
		RESPONSE.WRITE ActFormSubmit(objXmlLang("msg_session_error"), "?act=login", "post", "strPrevUrl", "/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & "?act=member&subAct=out")
		RESPONSE.End()
	END IF

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<script type="text/javascript">

	var strOutOption_ = "<%=CONF_strOutOption%>";
	var strOutAct_ = "<%=CONF_strOutAct%>";
	var strOutActMsg_ = "<%=CONF_strOutActMsg%>";
	var strOutActUrl_ = "<%=CONF_strOutActUrl%>";

	function outActScript(){
<%=CONF_strOutActScript%>
	}

</script>
<form id="extForm" name="extForm" method="post">
<input type="hidden" id="strLeaveMemo" name="strLeaveMemo" value="" />
<input type="hidden" id="strPassword" name="strPassword" value="" />
</form>