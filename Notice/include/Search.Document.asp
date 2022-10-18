<%
	DIM CONF_intDocumentCount

	SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_ALL] 'D', 'Y', '" & CONF_strSearchBoard & "', '', '', '', '" & CONF_strSearchTarget & "', '" & strKeyword & "' ")
	
	CONF_intDocumentCount = RS(0)

	IF subAct = "" THEN
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_ALL] 'D', 'N', '" & CONF_strSearchBoard & "', '" & CONF_intDefaultListCount & "', '', '', '" & CONF_strSearchTarget & "', '" & strKeyword & "' ")
	ELSE
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_ALL] 'D', 'N', '" & CONF_strSearchBoard & "', '" & CONF_intDefaultListCount & "', '" & intPage & "', '" & CONF_intListCount & "', '" & CONF_strSearchTarget & "', '" & strKeyword & "' ")
	END IF

	IF NOT(RS.EOF) THEN
		AdRs_List       = RS.GetRows()
		AdRs_List_Count = UBOUND(AdRs_List, 2)
	ELSE
		AdRs_List       = ""
		AdRs_List_Count = -1
	END IF

	CONF_intPageCount = INT((CONF_intDocumentCount - 1) / CONF_intListCount) + 1
	CONF_intBlockPage = INT((intPage - 1) / 10) * 10 + 1
%>