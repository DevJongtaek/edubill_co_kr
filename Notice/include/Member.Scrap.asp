<!-- #include file = "Member.Default.asp" -->
<%
	IF SESSION("memberSeq") = "" THEN
		RESPONSE.WRITE ActFormSubmit(objXmlLang("msg_session_error"), "?act=login", "post", "strPrevUrl", "/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & "?act=member&subAct=scrap")
		RESPONSE.End()
	END IF

	DIM intPage, intPageSize

	intPage        = GetInputReplce(REQUEST.QueryString("page"), "")
	intPageSize    = GetInputReplce(REQUEST.QueryString("page_size"), "")

	IF intPage = "" THEN
		intPage = 1
	ELSE
		IF GetNumericCheck(intPage, "i") = False THEN intPage = 1
	END IF

	IF intPageSize = "" THEN
		intPageSize = 10
	ELSE
		IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = 10
	END IF

	DIM CONF_intTotalCount, CONF_intPageCount, CONF_intBlockPage

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_SCRAP_LIST] 'C', '" & SESSION("memberSeq") & "' ")

	CONF_intTotalCount = RS(0)
	CONF_intPageCount = INT((CONF_intTotalCount - 1) / 10) + 1
	CONF_intBlockPage = INT((intPage - 1) / 10) * 10 + 1

	DIM AdRs_List, AdRs_List_Count, AdRs_List_Temp

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_SCRAP_LIST] 'L', '" & SESSION("memberSeq") & "', '" & intPage & "', '" & intPageSize & "' ")

	IF NOT(RS.EOF) THEN
		AdRs_List       = RS.GetRows()
		AdRs_List_Count = UBOUND(AdRs_List, 2)
	ELSE
		AdRs_List       = ""
		AdRs_List_Count = -1
	END IF

	DIM LIST_iCount, LIST_intNumber, LIST_intSeq, LIST_strBoardID, LIST_intBoardSeq, LIST_intMemberSrl, LIST_strTitle
	DIM LIST_strUserName, LIST_strNickName, LIST_strRegDate
%>
<form id="extForm" name="extForm" method="post">
<input type="hidden" id="strMessageType" value="<%=strMessageType%>" />
</form>