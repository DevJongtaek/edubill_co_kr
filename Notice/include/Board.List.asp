<!-- #include file = "Board.Default.asp" -->
<script type="text/javascript">

	var set_extra_form = {
		config: [
<% FOR tmpFor = 0 TO AdRs_ExtraForm_Count %>
			{field : "<%=AdRs_ExtraForm(0, tmpFor)%>", title : "<%=AdRs_ExtraForm(1, tmpFor)%>", formType : "<%=AdRs_ExtraForm(2, tmpFor)%>", use : "<%=AdRs_ExtraForm(4, tmpFor)%>", rquired : "<%=AdRs_ExtraForm(5, tmpFor)%>", search : "<%=AdRs_ExtraForm(6, tmpFor)%>"}<% IF tmpFor <> AdRs_ExtraForm_Count THEN %>,<% END IF %>
<% NEXT %>
		]
	};

</script>
<%
	IF CONF_strListLevel = False THEN
		RESPONSE.REDIRECT GetBoardAuthScript(CONF_strListLevelUrl, CONF_strListLevelLogin, "", "", "", "list", "msg_not_permitted")
		RESPONSE.End()
	END IF

	DIM CONF_intBlockPage

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_LIST] '" & CONF_intSrl & "', 'C', '" & REQ_intCategory & "', '', '', '" & GetBoardSearchField(REQ_strSearchTarget) & "', '" & REQ_strSearchKeyword & "', '', '', '" & GetBitTypeNumberChg(CONF_bitUseConsult) & "', '" & CONF_intMemberSrl & "' ")

	CONF_intTotalCount = RS(0)
	CONF_intPageCount = INT((CONF_intTotalCount - 1) / CONF_intListCount) + 1
	CONF_intBlockPage = INT((REQ_intPage - 1) / CONF_intPageSet) * CONF_intPageSet + 1

	DIM LIST_strFirstPage, LIST_strPrevPage, LIST_strPageNavi, LIST_strNextPage, LIST_strEndPage

	IF REQ_intPage > 1 THEN
		LIST_strFirstPage = 1
		LIST_strPrevPage  = CONF_intBlockPage - 1
	ELSE
		LIST_strFirstPage = False
		LIST_strPrevPage  = False
	END IF

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

	IF REQ_intPage < CONF_intPageCount THEN LIST_strEndPage = CONF_intPageCount ELSE LIST_strEndPage = False

	DIM AdRs_Notice_List, AdRs_Notice_List_Count, AdRs_List, AdRs_List_Count, AdRs_List_Temp

	IF REQ_intPage > 1 THEN CONF_bitDispNotice = False

	IF CONF_bitDispNotice = True THEN
		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_LIST] '" & CONF_intSrl & "', 'N' ")
	
		IF NOT(RS.EOF) THEN
			AdRs_Notice_List       = RS.GetRows()
			AdRs_Notice_List_Count = UBOUND(AdRs_Notice_List, 2)
		ELSE
			AdRs_Notice_List       = ""
			AdRs_Notice_List_Count = -1
		END IF
	ELSE
		AdRs_Notice_List       = ""
		AdRs_Notice_List_Count = -1
	END IF

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_LIST] '" & CONF_intSrl & "', 'L', '" & REQ_intCategory & "', '" & REQ_intPage & "', '" & CONF_intListCount & "', '" & GetBoardSearchField(REQ_strSearchTarget) & "', '" & REQ_strSearchKeyword & "', '" & GetBoardOrderField(REQ_strOrderIndex) & "', '" & REQ_strOrderType & "', '" & GetBitTypeNumberChg(CONF_bitUseConsult) & "', '" & CONF_intMemberSrl & "' ")
	
	IF NOT(RS.EOF) THEN
		AdRs_List       = RS.GetRows()
		AdRs_List_Count = UBOUND(AdRs_List, 2)
	ELSE
		AdRs_List       = ""
		AdRs_List_Count = -1
	END IF

	IF AdRs_ExtraForm_Count > 0 THEN
		FOR tmpFor = 0 TO AdRs_ExtraForm_Count
			IF extraForm.use(tmpFor + 1) = True THEN
				IF extraForm.readdisp(tmpFor + 1) = True THEN
					LIST_ExtraDataField = LIST_ExtraDataField & ","
					LIST_ExtraDataField = LIST_ExtraDataField & extraForm.field(tmpFor + 1)
				END IF
			END IF
		NEXT
		LIST_ExtraDataField = SPLIT(LIST_ExtraDataField, ",")
	ELSE
		LIST_ExtraDataField = SPLIT("", ",")
	END IF

	DIM LIST_iCount, LIST_intSeq, LIST_intNumber, LIST_intCategory, LIST_strCategory, LIST_intMemberSrl, LIST_strGroupLevel
	DIM LIST_strUserID, LIST_strUserName, LIST_strNickName, LIST_strEmail, LIST_strHomepage, LIST_strTitle, LIST_strContent
	DIM LIST_strContentMemo, LIST_strIpAddr, LIST_strTag, LIST_bitNotice, LIST_bitDelete, LIST_bitBad, LIST_bitSecret
	DIM LIST_bitMessage, LIST_bitAllowComment, LIST_bitAllowScrap, LIST_strFile, LIST_strImage, LIST_intRead, LIST_intVote
	DIM LIST_intBlamed, LIST_intComment, LIST_strCommentDate, LIST_strModifyDate, LIST_strRegDate, LIST_strGroupLevelImg
	DIM LIST_strPhotoImg, LIST_strMarkImg, LIST_strNameImg, LIST_strModifyLevel

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>