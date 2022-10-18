<!-- #include file = "../../../Include/Board.List.asp" -->
<% IF subAct = "view" THEN %>
<div class="boardModule">
<% ELSE %>
<!-- #include file = "common.header.asp" -->
<% END IF %>
<script type="text/javascript" src="<%=CONF_skinPath%>js/list.js"></script>
<script type="text/javascript">

	var last_page_count = <%=CONF_intPageCount%>;

</script>
<div class="list_header">
	<div class="left"><%=objXmlLang("total_article")%> : <span><%=CONF_intTotalCount%></span></div>
	<div class="right">
		<form id="searchForm" method="get">
		<ul>
			<li>
				<select id="target" name="target" class="inputSelect" title="<%=objXmlLang("search_field")%>">
				<option value="title"><%=objXmlLang("title")%></option>
				<option value="content"><%=objXmlLang("content")%></option>
				<option value="title_content"><%=objXmlLang("title")%>+<%=objXmlLang("content")%></option>
				<option value="user_name"><%=objXmlLang("user_name")%></option>
				<option value="nick_name"><%=objXmlLang("nick_name")%></option>
				<option value="user_id"><%=objXmlLang("user_id")%></option>
				<option value="tag"><%=objXmlLang("tag")%></option>
				</select>
			</li>
			<li><input type="text" name="keyword" id="keyword" class="inputSearch" title="<%=objXmlLang("search_keyword")%>"></li>
			<li><span class="button btn02"><input type="submit" id="btn_search" value="<%=objXmlLang("cmd_search")%>" /></span></li>
			<li><span class="button btn01"><a href="<%=GetBoardUrl("",  "search_keyword=,search_target=")%>"><%=objXmlLang("cmd_cancel")%></a></span></li>
<% IF SESSION("memberSeq") <> "" THEN %>
			<li><span class="button btn01"><a href="<%=GetBoardUrl("", "search_target=user_id,search_keyword=" & SESSION("userID"))%>" id="my_article"><%=objXmlLang("cmd_my_posts")%></a></span></li>
<% END IF %>
			<li><span class="button btn01"><a href="<%=GetBoardUrl("tag", "")%>" title="<%=objXmlLang("tag")%>"><%=objXmlLang("tag")%></a></span></li>
		</ul>
		</form>
	</div>
</div>
<% iCount = 0 %>
<table class="board_list" summary="List of Articles">
	<thead>
	<tr>
<% IF CONF_bitBoardAdmin = True THEN %>
<% iCount = iCount + 1 %>
		<th scope="col" class="check"><input type="checkbox" id="check_all" /></th>
<% END IF %>
<% FOR EACH dispField IN CONF_strDispListField %>
<% IF dispField = "no" THEN %>
		<th scope="col"><%=objXmlLang("num")%></th>
<% ELSEIF dispField = "title" THEN %>
		<th scope="col" class="title order_title"><a href="<%=GetBoardUrl("", "order_index=title,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("title")%><img src="images/etc/blank.gif" alt="order" /></a></th>
<% ELSEIF dispField = "nick_name" THEN %>
		<th scope="col"><%=objXmlLang("nick_name")%></th>
<% ELSEIF dispField = "user_id" THEN %>
		<th scope="col"><%=objXmlLang("user_id")%></th>
<% ELSEIF dispField = "user_name" THEN %>
		<th scope="col"><%=objXmlLang("user_name")%></th>
<% ELSEIF dispField = "regdate" THEN %>
		<th scope="col" class="order_regdate"><a href="<%=GetBoardUrl("", "order_index=regdate,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("regdate")%><img src="images/etc/blank.gif" alt="order" /></a></th>
<% ELSEIF dispField = "last_update" THEN %>
		<th scope="col" class="order_update"><a href="<%=GetBoardUrl("", "order_index=update,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("last_update")%><img src="images/etc/blank.gif" alt="order" /></a></th>
<% ELSEIF dispField = "readed_count" THEN %>
		<th scope="col" class="order_readed_count"><a href="<%=GetBoardUrl("", "order_index=readed_count,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("readed_count")%><img src="images/etc/blank.gif" alt="order" /></a></th>
<% ELSEIF dispField = "voted_count" THEN %>
		<th scope="col" class="order_voted_count"><a href="<%=GetBoardUrl("", "order_index=voted_count,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("voted_count")%><img src="images/etc/blank.gif" alt="order" /></a></th>
<% ELSEIF dispField = "blamed_count" THEN %>
		<th scope="col" class="order_blamed_count"><a href="<%=GetBoardUrl("", "order_index=blamed_count,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("blamed_count")%><img src="images/etc/blank.gif" alt="order" /></a></th>
<% ELSE %>
		<th scope="col"><%=objXmlLang(dispField)%></th>
<% END IF %>
<% NEXT %>
	</tr>
	</thead>
<%
	FOR tmpFor = 0 TO AdRs_Notice_List_Count
		AdRs_List_Temp = AdRs_Notice_List
%>
<!-- #include file = "../../../Include/Board.List.Disp.asp" -->
	<tr class="notice">
<% IF CONF_bitBoardAdmin = True THEN %>
		<td><input name="bbs_seq" type="checkbox" id="bbs_seq" value="<%=LIST_intSeq%>" /></td>
<% END IF %>
<%
		FOR EACH dispField IN CONF_strDispListField
%>
<% IF dispField = "no" THEN %>
		<td class="tac"><%=objXmlLang("notice")%></td>
<% ELSEIF dispField = "title" THEN %>
		<td class="title">
		<span class="tx">
		<a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>" class="hx"><%=LIST_strTitle%></a>
		<% IF LIST_intComment > 0 THEN %><span class="comment">[<%=LIST_intComment%>]</span><% END IF %>
		<% IF DATEDIFF("h", LIST_strRegDate, NOW) < INT(objSkinConfig("duration_new")) THEN %><img src="images/etc/blank.gif" class="icon_new" /><% END IF %>
		<% IF LIST_strFile <> "" THEN %><img src="images/etc/blank.gif" class="icon_file" alt="<%=objXmlLang("attached_file")%>" /><% END IF %>
		<% IF LIST_strImage <> "" THEN %><img src="images/etc/blank.gif" class="icon_image" alt="<%=objXmlLang("attached_image")%>" /><% END IF %>
		<% IF LIST_bitSecret = True THEN %><img src="images/etc/blank.gif" class="icon_secret" alt="<%=objXmlLang("secret_document")%>" /><% END IF %>
		</span>
		</td>
<% ELSEIF dispField = "nick_name" THEN %>
		<td class="nickname">
		<%=LIST_strNickName%>
		</td>
<% ELSEIF dispField = "user_id" THEN %>
		<td class="userid"><%=LIST_strUserID%></td>
<% ELSEIF dispField = "user_name" THEN %>
		<td class="username"><%=LIST_strUserName%></td>
<% ELSEIF dispField = "regdate" THEN %>
		<td class="date"><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%></td>
<% ELSEIF dispField = "last_update" THEN %>
		<td class="date"><% IF LIST_strModifyDate = "" OR ISNULL(LIST_strModifyDate) = True THEN %>-<% ELSE %><%=REPLACE(LEFT(LIST_strModifyDate,10),"-",".")%><% END IF %></td>
<% ELSEIF dispField = "readed_count" THEN %>
		<td class="count"><%=LIST_intRead%></td>
<% ELSEIF dispField = "voted_count" THEN %>
		<td class="count"><%=LIST_intVote%></td>
<% ELSEIF dispField = "blamed_count" THEN %>
		<td class="count"><%=LIST_intBlamed%></td>
<% ELSE %>
		<td><%=objExtraVar(dispField)%></td>
<% END IF %>
<%
		NEXT
%>
	</tr>
<% NEXT %>
<%
	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Board.List.Disp.asp" -->
	<tr>
<% IF CONF_bitBoardAdmin = True THEN %>
		<td><input name="bbs_seq" type="checkbox" id="bbs_seq" value="<%=LIST_intSeq%>" /></td>
<% END IF %>
<%
		FOR EACH dispField IN CONF_strDispListField
%>
<% IF dispField = "no" THEN %>
		<td class="num"><%=LIST_intNumber%></td>
<% ELSEIF dispField = "title" THEN %>
		<td class="title">
		<span class="tx">
		<a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>" class="hx"><%=LIST_strTitle%></a>
		<% IF LIST_intComment > 0 THEN %><span class="comment">[<%=LIST_intComment%>]</span><% END IF %>
		<% IF DATEDIFF("h", LIST_strRegDate, NOW) < INT(objSkinConfig("duration_new")) THEN %><img src="images/etc/blank.gif" class="icon_new" /><% END IF %>
		<% IF LIST_strFile <> "" THEN %><img src="images/etc/blank.gif" class="icon_file" alt="<%=objXmlLang("attached_file")%>" /><% END IF %>
		<% IF LIST_strImage <> "" THEN %><img src="images/etc/blank.gif" class="icon_image" alt="<%=objXmlLang("attached_image")%>" /><% END IF %>
		<% IF LIST_bitSecret = True THEN %><img src="images/etc/blank.gif" class="icon_secret" alt="<%=objXmlLang("secret_document")%>" /><% END IF %>
		</span>
		</td>
<% ELSEIF dispField = "nick_name" THEN %>
		<td class="nickname">
		<%=LIST_strNickName%>
		</td>
<% ELSEIF dispField = "user_id" THEN %>
		<td class="userid"><%=LIST_strUserID%></td>
<% ELSEIF dispField = "user_name" THEN %>
		<td class="username"><%=LIST_strUserName%></td>
<% ELSEIF dispField = "regdate" THEN %>
		<td class="date"><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%></td>
<% ELSEIF dispField = "last_update" THEN %>
		<td class="date"><% IF LIST_strModifyDate = "" OR ISNULL(LIST_strModifyDate) = True THEN %>-<% ELSE %><%=REPLACE(LEFT(LIST_strModifyDate,10),"-",".")%><% END IF %></td>
<% ELSEIF dispField = "readed_count" THEN %>
		<td class="count"><%=LIST_intRead%></td>
<% ELSEIF dispField = "voted_count" THEN %>
		<td class="count"><%=LIST_intVote%></td>
<% ELSEIF dispField = "blamed_count" THEN %>
		<td class="count"><%=LIST_intBlamed%></td>
<% ELSE %>
		<td><%=objExtraVar(dispField)%></td>
<% END IF %>
<%
		NEXT
%>
	</tr>
<% NEXT %>
</table>
<div class="paging">
	<ul>
		<li><% IF LIST_strFirstPage <> False THEN %><a href="<%=GetBoardUrl("","page=" & LIST_strFirstPage)%>"><img src="images/etc/blank.gif" class="first" alt="<%=objXmlLang("first_page")%>" /></a><% ELSE %><img src="images/etc/blank.gif" class="first_disabled" alt="<%=objXmlLang("first_page")%>" /><% END IF %></li>
		<li><% IF LIST_strPrevPage <> False THEN %><a href="<%=GetBoardUrl("","page=" & LIST_strPrevPage)%>"><img src="images/etc/blank.gif" class="prev" alt="<%=objXmlLang("prev_page")%>" /></a><% ELSE %><img src="images/etc/blank.gif" class="prev_disabled" alt="<%=objXmlLang("prev_page")%>" /><% END IF %></li>
		<li><img src="images/etc/blank.gif" class="bar" alt="<%=objXmlLang("division_line")%>" /></li>
		<li>Page</li>
		<li><input type="text" class="move_page integer ime_mode" value="<%=REQ_intPage%>" title="<%=objXmlLang("page_move")%>" /></li>
		<li>of <%=CONF_intPageCount%></li>
		<li><img src="images/etc/blank.gif" class="bar" alt="<%=objXmlLang("division_line")%>" /></li>
		<li><% IF LIST_strNextPage <> False THEN %><a href="<%=GetBoardUrl("", "page=" & LIST_strNextPage)%>"><img src="images/etc/blank.gif" class="next" alt="<%=objXmlLang("next_page")%>" /></a><% ELSE %><img src="images/etc/blank.gif" class="next_disabled" alt="<%=objXmlLang("next_page")%>" /><% END IF %></li>
		<li><% IF LIST_strEndPage <> False THEN %><a href="<%=GetBoardUrl("","page=" & LIST_strEndPage)%>"><img src="images/etc/blank.gif" class="last" alt="<%=objXmlLang("last_page")%>" /></a><% ELSE %><img src="images/etc/blank.gif" class="last_disabled" alt="<%=objXmlLang("last_page")%>" /><% END IF %></li>
	</ul>
	<div class="list_btn_area">
		<% IF CONF_bitBoardAdmin = True THEN %><span class="button btn01"><a href="#btn_board_manage" id="btn_board_manage" onclick="return false;"><%=objXmlLang("cmd_manage")%></a></span><% END IF %>
		<span class="button btn01"><a href="<%=GetBoardUrl("write", "")%>"><%=objXmlLang("cmd_write")%></a></span>
	</div>
</div>
<% IF REQ_intSeq = "" THEN %>
<!-- #include file = "common.footer.asp" -->
<% ELSE %>
</div>
<% END IF %>