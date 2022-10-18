<%
	DIM CONF_intBlockPage, REQ_intCommentPage

	REQ_intCommentPage = GetInputReplce(REQUEST.QueryString("comment_page"), "")

	IF REQ_intCommentPage = "" THEN
		REQ_intCommentPage = 1
	ELSE
		IF GetNumericCheck(REQ_intCommentPage, "i") = False THEN REQ_intCommentPage = CONF_intPageCount
	END IF

	SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_LIST] 'C', '" & CONF_intSrl & "', '" & REQ_intSeq & "', '" & REQ_intCommentPage & "', '" & CONF_intCommentListCount & "' ")

	CONF_intTotalCount = RS(0)
	CONF_intPageCount = INT((CONF_intTotalCount - 1) / CONF_intCommentListCount) + 1
	CONF_intBlockPage = INT((REQ_intCommentPage - 1) / CONF_intCommentListCount) * CONF_intCommentListCount + 1

	DIM LIST_strPrevPage, LIST_strPageNavi, LIST_strNextPage

	IF REQ_intPage > 1 THEN LIST_strPrevPage  = CONF_intBlockPage - 1 ELSE LIST_strPrevPage  = False

	tmpFor = 1
	LIST_strPageNavi = ""

	DO UNTIL tmpFor > CONF_intPageSet OR CONF_intBlockPage > CONF_intPageCount

		IF LIST_strPageNavi <> "" THEN LIST_strPageNavi = LIST_strPageNavi & ","
		LIST_strPageNavi = LIST_strPageNavi & CONF_intBlockPage

		CONF_intBlockPage = CONF_intBlockPage + 1
		tmpFor = tmpFor + 1

	LOOP

	LIST_strPageNavi = SPLIT(LIST_strPageNavi, ",")

	IF CONF_intBlockPage < CONF_intPageCount THEN LIST_strNextPage = CONF_intBlockPage ELSE LIST_strNextPage = False

	DIM AdRs_List_Count

	SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_LIST] 'L', '" & CONF_intSrl & "', '" & REQ_intSeq & "', '" & REQ_intCommentPage & "', '" & CONF_intCommentListCount & "' ")

	IF NOT(RS.EOF) THEN
		AdRs_List       = RS.GetRows()
		AdRs_List_Count = UBOUND(AdRs_List, 2)
	ELSE
		AdRs_List       = ""
		AdRs_List_Count = -1
	END IF
%>
<script type="text/javascript">

	var set_comment_default = {
		page : "<%=REQ_intCommentPage%>"
	}

</script>