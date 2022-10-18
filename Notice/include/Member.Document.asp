<!-- #include file = "Member.Default.asp" -->
<%
	IF SESSION("memberSeq") = "" THEN
		RESPONSE.WRITE ActFormSubmit(objXmlLang("msg_session_error"), "?act=login", "post", "strPrevUrl", "/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & "?act=member&subAct=document")
		RESPONSE.End()
	END IF

	DIM intPage, intPageSize

	intPage     = GetInputReplce(REQUEST.QueryString("page"), "")
	intPageSize = GetInputReplce(REQUEST.QueryString("page_size"), "")

	IF intPage = "" THEN
		intPage = 1
	ELSE
		IF GetNumericCheck(intPage, "i") = False THEN intPage = 1
	END IF

	IF intPageSize = "" THEN
		intPageSize = 20
	ELSE
		IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = 20
	END IF

	DIM CONF_intTotalCount, CONF_intPageCount, CONF_intBlockPage

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_OWN_DOCUMENT] 'C', '" & SESSION("memberSeq") & "' ")

	CONF_intTotalCount = RS(0)
	CONF_intPageCount = INT((CONF_intTotalCount - 1) / intPageSize) + 1
	CONF_intBlockPage = INT((intPage - 1) / 10) * 10 + 1

	DIM AdRs_List, AdRs_List_Count, AdRs_List_Temp

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_OWN_DOCUMENT] 'L', '" & SESSION("memberSeq") & "', '" & intPage & "', '" & intPageSize & "' ")

	IF NOT(RS.EOF) THEN
		AdRs_List       = RS.GetRows()
		AdRs_List_Count = UBOUND(AdRs_List, 2)
	ELSE
		AdRs_List       = ""
		AdRs_List_Count = -1
	END IF

	DIM LIST_iCount, LIST_intNumber, LIST_intSeq, LIST_strBoardID, LIST_strTitle, LIST_intComment, LIST_intRead
	DIM LIST_intVote, LIST_strRegDate
%>
<form id="extForm">
	<input type="hidden" id="intPageSize" name="intPageSize" value="<%=intPageSize%>" />
</form>