<!-- #include file = "Member.Default.asp" -->
<%
	DIM CONF_strMemberDocument1, CONF_strMemberDocument2

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_READ] 'R', '', 'D001' ")
	CONF_strMemberDocument1 = RS("strContent")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_READ] 'R', '', 'D002' ")
	CONF_strMemberDocument2 = RS("strContent")

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="extForm" name="extForm" method="post">
<input type="hidden" id="checkMemberType" name="checkMemberType" />
<input type="hidden" id="checkMemberAgree" name="checkMemberAgree" value="1" />
</form>