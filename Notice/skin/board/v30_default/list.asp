<!-- #include file = "../../../Include/Board.List.asp" -->
<%
	IF REQ_strListType = "" THEN
		REQ_strListType = objSkinConfig("default_style")
%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#extForm #list_style").val('<%=REQ_strListType%>');
	});
</script>
<%
	END IF
%>
<% IF subAct = "view" THEN %>
<div id="boardModule">
<% ELSE %>
<!-- #include file = "common.header.asp" -->
<% END IF %>
<script type="text/javascript" src="<%=CONF_skinPath%>js/list.js"></script>
<% IF CONF_bitBoardAdmin = True THEN %>
<div class="list_header">
	<div class="line"></div>
	<div class="admin">
		<span class="button small"><a href="#" id="btn_select_all" onclick="return false;"><%=objXmlLang("cmd_select_all")%></a><input type="checkbox" id="chkAll" class="none" /></span>
		<span class="button small"><a href="#" id="btn_board_manage" onclick="return false;"><%=objXmlLang("cmd_manage")%></a></span>
	</div>
</div>
<% END IF %>
<div class="list_body">
	<table class="bbsList">
		<tr>
			<th></th>
<%
	FOR EACH dispField IN CONF_strDispListField
%>
<% IF dispField = "no" THEN %>
			<th><%=objXmlLang("num")%></th>
<% ELSEIF dispField = "title" THEN %>
			<th class="title" id="th_title"><a href="<%=GetBoardUrl("", "order_index=title,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("title")%></a></th>
<% ELSEIF dispField = "nick_name" THEN %>
			<th><%=objXmlLang("nick_name")%></th>
<% ELSEIF dispField = "user_id" THEN %>
			<th><%=objXmlLang("user_id")%></th>
<% ELSEIF dispField = "user_name" THEN %>
			<th><%=objXmlLang("user_name")%></th>
<% ELSEIF dispField = "regdate" THEN %>
			<th id="th_regdate"><a href="<%=GetBoardUrl("", "order_index=regdate,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("regdate")%></a></th>
<% ELSEIF dispField = "last_update" THEN %>
			<th id="th_update"><a href="<%=GetBoardUrl("", "order_index=update,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("last_update")%></a></th>
<% ELSEIF dispField = "readed_count" THEN %>
			<th id="th_readed_count"><a href="<%=GetBoardUrl("", "order_index=readed_count,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("readed_count")%></a></th>
<% ELSEIF dispField = "voted_count" THEN %>
			<th id="th_voted_count"><a href="<%=GetBoardUrl("", "order_index=voted_count,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("voted_count")%></a></th>
<% ELSEIF dispField = "blamed_count" THEN %>
			<th id="th_blamed_count"><a href="<%=GetBoardUrl("", "order_index=blamed_count,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("blamed_count")%></a></th>
<% ELSE %>
			<th><%=objXmlLang(dispField)%></th>
<% END IF %>
<%
	NEXT
%>
		</tr>
	<tbody>
<%
	FOR tmpFor = 0 TO AdRs_Notice_List_Count
		AdRs_List_Temp = AdRs_Notice_List
%>
<!-- #include file = "../../../Include/Board.List.Disp.asp" -->
		<tr>
			<td class="check"><% IF CONF_bitBoardAdmin = True THEN %><input name="bbs_seq" type="checkbox" id="bbs_seq" value="<%=LIST_intSeq%>" /><% END IF %></td>
<%
		FOR EACH dispField IN CONF_strDispListField
%>
<% IF dispField = "no" THEN %>
			<td class="notice"><%=objXmlLang("notice")%></td>
<% ELSEIF dispField = "title" THEN %>
			<td class="title">
			<a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>"><%=LIST_strTitle%></a>
<% IF LIST_intComment > 0 THEN %>
			<span class="comment">[<%=LIST_intComment%>]</span>
<% END IF %>
<% IF DATEDIFF("h", LIST_strRegDate, NOW) < INT(objSkinConfig("duration_new")) THEN %>
			<img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_new" alt="new" />
<% END IF %>
<% IF LIST_strFile <> "" THEN %>
			<img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_file" alt="file" />
<% END IF %>
<% IF LIST_strImage <> "" THEN %>
			<img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_image" alt="photo" />
<% END IF %>
<% IF LIST_bitSecret = True THEN %>
			<img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_secret" alt="secret" />
<% END IF %>
			</td>
<% ELSEIF dispField = "nick_name" THEN %>
			<td class="nick"><%=LIST_strNickName%></td>
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
			<td>
<%=objExtraVar(dispField)%>
			</td>
<% END IF %>
<% NEXT %>
		</tr>
<% NEXT %>
<% IF REQ_strListType = "list" THEN %>
<!-- #include file = "list.style.asp" -->
<% END IF %>
		</tbody>
	</table>
<% IF REQ_strListType = "webzine" THEN %>
<!-- #include file = "webzine.style.asp" -->
<% END IF %>
<% IF REQ_strListType = "gallery" THEN %>
<!-- #include file = "gallery.style.asp" -->
<% END IF %>
</div>
<div class="list_footer">
	<div class="button_area">
		<div class="fl">
			<span class="button medium strong icon"><span class="write"></span><a href="<%=GetBoardUrl("write", "")%>"><%=objXmlLang("cmd_write")%></a></span>
		</div>
		<div class="fr">
			<span class="button medium"><a href="<%=GetBoardUrl("",  "search_keyword=,search_target=")%>"><%=objXmlLang("cmd_list")%></a></span>
		</div>
	</div>
	<div class="pagingArea">
		<% IF LIST_strPrevPage = False THEN %><a class="prev_page_disabled"><%=objXmlLang("cmd_prev")%></a><% ELSE %><a href="<%=GetBoardUrl("","page=" & LIST_strPrevPage)%>" class="prev_page"><%=objXmlLang("cmd_prev")%></a><% END IF %>
		<span>
<%
	FOR EACH pageNavi IN LIST_strPageNavi
%>
<% IF INT(pageNavi) = REQ_intPage THEN %><a class="current_page"><%=pageNavi%></a><% ELSE %><a href="<%=GetBoardUrl("", "page=" & pageNavi)%>"><%=pageNavi%></a><% END IF %>
<%
	NEXT
%>
		</span>
		<% IF LIST_strNextPage = False THEN %><a class="next_page_disabled"><%=objXmlLang("cmd_next")%></a><% ELSE %><a href="<%=GetBoardUrl("", "page=" & LIST_strNextPage)%>" class="next_page"><%=objXmlLang("cmd_next")%></a><% END IF %>
	</div>
	<div class="searchForm">
		<form id="searchForm" name="searchForm" method="get">
			<fieldset>
				<legend>SEARCH</legend>
				<select id="target" name="target" class="inputSelect" title="search_target">
				<option value="title"><%=objXmlLang("title")%></option>
				<option value="content"><%=objXmlLang("content")%></option>
				<option value="title_content"><%=objXmlLang("title")%>+<%=objXmlLang("content")%></option>
				<option value="user_name"><%=objXmlLang("user_name")%></option>
				<option value="nick_name"><%=objXmlLang("nick_name")%></option>
				<option value="user_id"><%=objXmlLang("user_id")%></option>
				<option value="tag"><%=objXmlLang("tag")%></option>
				</select>
				<input type="text" name="keyword" id="keyword" class="inputText keyword" title="search_keyword">
				<span class="button medium"><input type="submit" value="<%=objXmlLang("cmd_search")%>" /></span>
				<% IF SESSION("memberSeq") <> "" THEN %><a href="<%=GetBoardUrl("", "search_target=user_id,search_keyword=" & SESSION("userID"))%>" id="my_article" class="my_post"><%=objXmlLang("cmd_my_posts")%></a><br /><% END IF %>
			</fieldset>
			<div class="view_tag"><a href="<%=GetBoardUrl("tag", "")%>" class="btn_tag_list" title="<%=objXmlLang("tag")%>"><%=objXmlLang("tag")%></a></div>
		</form>
	</div>
</div>
<% IF subAct = "view" THEN %>
</div>
<% ELSE %>
<!-- #include file = "common.footer.asp" -->
<% END IF %>