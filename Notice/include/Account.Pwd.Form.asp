<!-- #include file = "Member.Default.asp" -->
<%
	DIM isCheckSSN

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_READ] 'strSSN' ")

	IF RS("bitUse") = True AND RS("bitRquired") = True THEN isCheckSSN = True ELSE isCheckSSN = False

	DIM strLoginID

	strLoginID = GetInputReplce(REQUEST.FORM("strUserID"), "")

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="extForm">
<input type="hidden" name="strLoginID" id="strLoginID" value="<%=strLoginID%>" />
<input type="hidden" name="strUserName" id="strUserName" value="" />
<input type="hidden" name="strEmail" id="strEmail" value="" />
<input type="hidden" name="strSSN" id="strSSN" value="" />
<input type="hidden" name="ssnCheck" id="ssnCheck" value="<%=GetBitTypeNumberChg(isCheckSSN)%>" />
</form>