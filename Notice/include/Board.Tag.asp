<!-- #include file = "Board.Default.asp" -->
<%
	DIM AdRs_List_Count, AdRs_List

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_TAG_LIST] '" & CONF_intSrl & "', 'N', '1' ")

	IF NOT(RS.EOF) THEN
		AdRs_List       = RS.GetRows()
		AdRs_List_Count = UBOUND(AdRs_List, 2)
	ELSE
		AdRs_List       = ""
		AdRs_List_Count = -1
	END IF

	DIM LIST_strTag, LIST_intCount
%>