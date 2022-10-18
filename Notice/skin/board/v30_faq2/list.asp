<!-- #include file = "../../../Include/Board.List.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/list.js"></script>

<div id="boardModule">

	<div class="best_faq">
		<div class="box">
			<form id="searchForm" name="searchForm" method="get" class="search">
			<input type="hidden" id="target" name="target" value="title">
			<div class="search_area">
				<ul>
					<li class="icon">질문검색</li>
					<li><input type="text" id="keyword" name="keyword" class="input_search" /></li>
					<li>
						<span class="button medium"><input type="button" id="btn_search" value="<%=objXmlLang("cmd_search")%>" /></span>
						<span class="button medium"><a href="<%=GetBoardUrl("",  "search_keyword=,search_target=")%>"><%=objXmlLang("cmd_cancel")%></a></span>
					</li>
				</ul>
			</div>
			</form>
			<table id="bestFaq"></table>
		</div>
	</div>
	
	<div class="category_area">
		<ul id="category_list">
		</ul>
	</div>

	<table class="bbsList">
		<tr>
<% IF CONF_bitBoardAdmin = True THEN %>
			<th class="check"><input type="checkbox" id="chkAll" /></th>
<% END IF %>
			<th></th>
			<th class="title">제목</th>
		</tr>
<%
	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Board.List.Disp.asp" -->
		<tr>
<% IF CONF_bitBoardAdmin = True THEN %>
			<td class="check"><input name="bbs_seq" type="checkbox" id="bbs_seq" value="<%=LIST_intSeq%>" /></td>
<% END IF %>
			<td class="icon"><img src="images/etc/blank.gif" class="icon_q" /></td>
			<td class="title"><% IF objSkinConfig("list_category") = "Y" THEN %><span class="category">[<%=LIST_strCategory%>]</span> <% END IF %> <a name="faq_read" id="bbs_<%=LIST_intSeq%>" href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>" onclick="return false;"><%=LIST_strTitle%></a></td>
		</tr>
<%
	IF REQ_intSeq <> "" THEN
		IF CDBL(LIST_intSeq) = CDBL(REQ_intSeq) THEN LIST_strContentView = True ELSE LIST_strContentView = False
	ELSE
		LIST_strContentView = False
	END IF
%>
		<tr id="hDesc_<%=LIST_intSeq%>"<% IF LIST_strContentView = True THEN %> class="on"<% END IF %> style="display:<% IF LIST_strContentView = True THEN %>block<% ELSE %>none<% END IF %>;">
<% IF CONF_bitBoardAdmin = True THEN %>
			<td></td>
<% END IF %>
			<td class="icon"><img src="images/etc/blank.gif" class="icon_a" /></td>
			<td class="content"><%=LIST_strContent%></td>
		</tr>
<%
	NEXT
%>
	</table>
	<div style="float:left; padding:10px 0 10px 0;">
<% IF CONF_bitBoardAdmin = True THEN %>
		<span class="button medium"><a href="#" id="btn_board_manage" onclick="return false;"><%=objXmlLang("cmd_manage")%></a></span>
<% END IF %>
	</div>
	<div style="float:right; padding:10px 0 10px 0;"">
		<span class="button medium"><a href="<%=GetBoardUrl("write", "")%>"><%=objXmlLang("cmd_regist")%></a></span>
	</div>
	<table class="pagingArea">
		<tr>
			<td><a<% IF CONF_intBlockPage <> 1 THEN %> href="<%=GetBoardUrl("","page=1")%>"<% END IF %> class="page_fist<% IF CONF_intBlockPage = 1 THEN %>_disabled<% END IF %>"><%=objXmlLang("cmd_first_page")%></a></td>
			<td><a<% IF CONF_intBlockPage <> 1 THEN %> href="<%=GetBoardUrl("","page=" & CONF_intBlockPage - 10)%>"<% END IF %> class="page_before<% IF CONF_intBlockPage = 1 THEN %>_disabled<% END IF %>"><%=objXmlLang("cmd_prev_page")%></a></td>
			<td>
			<span>
<%
	tmpFor = 1
	DO UNTIL tmpFor > 10 OR CONF_intBlockPage > CONF_intPageCount
%>
					<% IF INT(CONF_intBlockPage) = INT(REQ_intPage) THEN %><a class="current_page"><%=CONF_intBlockPage%></a><% ELSE %><a href="<%=GetBoardUrl("", "page=" & CONF_intBlockPage)%>"><%=CONF_intBlockPage%></a><% END IF %>
<%
		CONF_intBlockPage = CONF_intBlockPage + 1
		tmpFor = tmpFor + 1
	LOOP
%>
			</span>
			</td>
			<td><a<% IF CONF_intBlockPage < CONF_intPageCount THEN %> href="<%=GetBoardUrl("", "page=" & CONF_intBlockPage)%>"<% END IF %> class="page_next<% IF CONF_intBlockPage > CONF_intPageCount THEN %>_disabled<% END IF %>"><%=objXmlLang("cmd_next_page")%></a></td>
			<td><a<% IF CONF_intBlockPage < CONF_intPageCount THEN %> href="<%=GetBoardUrl("","page=" & CONF_intPageCount)%>"<% END IF %> class="page_end<% IF CONF_intBlockPage > CONF_intPageCount THEN %>_disabled<% END IF %>">처음..</a></td>
		</tr>
	</table>
</div>
<iframe id="blankFrame" style="display:none;"></iframe>
<!-- #include file = "common.footer.asp" -->