<!-- #include file = "../../../Include/Board.List.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/list.js"></script>



<div class="faqTab"></div>



<div class="list_body">
	<ul>
<%
	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Board.List.Disp.asp" -->
		<li id="hList_<%=LIST_intSeq%>"><h5><% IF CONF_bitBoardAdmin = True THEN %><input type="checkbox" id="bbs_seq" value="<%=LIST_intSeq%>" /><% END IF %><a href="#hList_<%=LIST_intSeq%>" onclick="return false;" class="document_read"><% IF objSkinConfig("list_category") = "Y" THEN %>[<%=LIST_strCategory%>] <% END IF %><%=LIST_strTitle%></a></h5>
			<div id="hDesc_<%=LIST_intSeq%>" style="display:none;" class="on">
				<%=LIST_strContent%>
				<% FOR EACH extraData IN LIST_ExtraDataField %>
				<% IF extraData <> "" AND objExtraVar(extraData) <> "" THEN %>
				<p><%=objXmlLang(extraData)%> : <%=objExtraVar(extraData)%></p>
				<% END IF %>
				<% NEXT %>
 				<p class="document_menu">
					<a href="#<%=LIST_intSeq%>" id="document_print" onclick="return false;" class="document_print"><%=objXmlLang("cmd_document_print")%></a><% IF LIST_strModifyLevel = True THEN %> | ><a href="<%=GetBoardUrl("modify", "seq=" & LIST_intSeq)%>" id="document_modify"><%=objXmlLang("cmd_document_modify")%></a> | <a href="<%=GetBoardUrl("remove", "seq=" & LIST_intSeq)%>" id="document_delete"><%=objXmlLang("cmd_document_delete")%></a><% END IF %>
				</p>
			</div>
		</li>
<%
	NEXT
%>
	</ul>
</div>
<div class="list_footer">
<% IF CONF_bitBoardAdmin = True THEN %>
		<span class="button medium"><a href="#" id="btn_select_all"><%=objXmlLang("cmd_select_all")%></a><input type="checkbox" id="chkAll" class="none" /></span>
		<span class="button medium"><a href="#" id="btn_board_manage" onclick="return false;"><%=objXmlLang("cmd_manage")%></a></span>
<% END IF %>
		<span class="button medium strong icon"><span class="write"></span><a href="<%=GetBoardUrl("write", "")%>"><%=objXmlLang("cmd_regist")%></a></span>
	<table class="pageNav">
		<tr>
			<th><% IF LIST_strFirstPage = False THEN %><a class="btn_page_first disabled"><%=objXmlLang("cmd_first_page")%></a><% ELSE %><a href="<%=GetBoardUrl("","page=" & LIST_strFirstPage)%>" class="btn_page_first"><%=objXmlLang("cmd_first_page")%></a><% END IF %></th>
			<th class="pgL"><% IF LIST_strPrevPage = False THEN %><a class="btn_page_prev disabled"><%=objXmlLang("cmd_prev_page")%></a><% ELSE %><a href="<%=GetBoardUrl("","page=" & LIST_strPrevPage)%>" class="btn_page_prev"><%=objXmlLang("cmd_prev_page")%></a><% END IF %></th>
<%
	FOR EACH pageNavi IN LIST_strPageNavi
%>
<% IF INT(pageNavi) = REQ_intPage THEN %>
			<td class="on first"><%=pageNavi%></td>
<% ELSE %>
			<td><a href="<%=GetBoardUrl("","page=" & pageNavi)%>"><%=pageNavi%></a></td>
<% END IF %>
<%
	NEXT
%>
			<th class="pgR"><% IF LIST_strNextPage = False THEN %><a class="btn_page_next disabled"><%=objXmlLang("cmd_next_page")%></a><% ELSE %><a href="<%=GetBoardUrl("", "page=" & LIST_strNextPage)%>" class="btn_page_next"><%=objXmlLang("cmd_next_page")%></a><% END IF %></th>
			<th><% IF LIST_strEndPage = False THEN %><a class="btn_page_last disabled"><%=objXmlLang("cmd_last_page")%></a><% ELSE %><a href="<%=GetBoardUrl("","page=" & LIST_strEndPage)%>" class="btn_page_last"><%=objXmlLang("cmd_last_page")%></a><% END IF %></th>
		</tr>
	</table>
	<div class="search_form">
		<form id="searchForm" name="searchForm" method="get" class="search">
		<input type="hidden" id="target" name="target" value="title">
		<input type="text" id="keyword" name="keyword" class="inputText"/>
		<span class="button small"><input type="submit" value="<%=objXmlLang("cmd_search")%>" /></span>
		<span class="button small"><a href="<%=GetBoardUrl("",  "search_keyword=,search_target=")%>"><%=objXmlLang("cmd_cancel")%></a></span>
		</form>
	</div>
</div>
<!-- #include file = "common.footer.asp" -->