<!-- #include file = "../../../Include/Board.List.asp" -->
<% IF subAct = "view" THEN %>
<div class="boardModule">
<% ELSE %>
<!-- #include file = "common.header.asp" -->
<% END IF %>
<script type="text/javascript">

	var disp_notice = "<%=GetBitTypeNumberChg(CONF_bitDispNotice)%>";

	$(document).ready(function() {
<%
	IF REQ_strListType = "" THEN
		REQ_strListType = objSkinConfig("default_style")
%>
		$("#extForm #list_style").val('<%=REQ_strListType%>');
<%
	END IF
%>
	});
</script>
<script type="text/javascript" src="<%=CONF_skinPath%>js/list.js"></script>

<div class="box">
	<span class="rc-tp"><span></span></span>
	<div class="bd bd_gray">
		<div class="list_header">
			<div class="fl">
				<form id="searchForm" name="searchForm" method="get">
					<fieldset>
						<legend>SEARCH</legend>
						<select id="target" name="target" class="inputSelect" title="search target">
						<option value="title"><%=objXmlLang("title")%></option>
						<option value="content"><%=objXmlLang("content")%></option>
						<option value="title_content"><%=objXmlLang("title")%>+<%=objXmlLang("content")%></option>
						<option value="user_name"><%=objXmlLang("user_name")%></option>
						<option value="nick_name"><%=objXmlLang("nick_name")%></option>
						<option value="user_id"><%=objXmlLang("user_id")%></option>
						<option value="tag"><%=objXmlLang("tag")%></option>
						</select>
						<input type="text" name="keyword" id="keyword" class="inputText keyword" title="search keyword">
						<span class="button icon mt1"><span class="search"></span><input type="submit" value="<%=objXmlLang("cmd_search")%>" /></span>
						<% IF SESSION("memberSeq") <> "" THEN %><span class="button icon mt1"><span class="list"></span><a href="<%=GetBoardUrl("", "search_target=user_id,search_keyword=" & SESSION("userID"))%>" id="my_article"><%=objXmlLang("cmd_my_posts")%></a></span><% END IF %>
					</fieldset>
				</form>
			</div>
			<div class="fr">
				<span>
					<select id="bbsCategory" class="inputSelect" title="category">
					</select>
				</span>
				<span><span class="button icon mt1"><span class="tag"></span><a href="<%=GetBoardUrl("tag", "")%>" title="<%=objXmlLang("tag")%>"><%=objXmlLang("tag")%></a></span></span>
			</div>
		</div>
	</div>
	<div class="ft"></div>
	<span class="rc-bt"><span></span></span>
</div>
<div class="list_body">
	<div class="box">
		<span class="rc-tp"><span></span></span>
		<div class="bd bd_white">
<% IF CONF_bitDispNotice = True OR REQ_strListType = "list" THEN %>
			<table class="list_default">
				<tr>
<% IF CONF_bitBoardAdmin = True THEN %>
					<th class="select_all"><div><input type="checkbox" id="check_all" /></div></th>
<% END IF %>
<% FOR EACH dispField IN CONF_strDispListField %>
<% IF dispField = "no" THEN %>
						<th><div><a href="<%=GetBoardUrl("", "order_index=no,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("num")%></a></div></th>
<% ELSEIF dispField = "title" THEN %>
						<th id="th_title" class="title"><div><a href="<%=GetBoardUrl("", "order_index=title,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("title")%></a></div></th>
<% ELSEIF dispField = "nick_name" THEN %>
						<th><div><%=objXmlLang("nick_name")%></div></th>
<% ELSEIF dispField = "user_id" THEN %>
						<th><div><%=objXmlLang("user_id")%></div></th>
<% ELSEIF dispField = "user_name" THEN %>
						<th><div><%=objXmlLang("user_name")%></div></th>
<% ELSEIF dispField = "regdate" THEN %>
						<th id="th_regdate"><div><a href="<%=GetBoardUrl("", "order_index=regdate,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("regdate")%></a></div></th>
<% ELSEIF dispField = "last_update" THEN %>
						<th id="th_update"><div><a href="<%=GetBoardUrl("", "order_index=update,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("last_update")%></a></div></th>
<% ELSEIF dispField = "readed_count" THEN %>
						<th id="th_readed_count"><div><a href="<%=GetBoardUrl("", "order_index=readed_count,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("readed_count")%></a></div></th>
<% ELSEIF dispField = "voted_count" THEN %>
						<th id="th_voted_count"><div><a href="<%=GetBoardUrl("", "order_index=voted_count,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("voted_count")%></a></div></th>
<% ELSEIF dispField = "blamed_count" THEN %>
						<th id="th_blamed_count"><div><a href="<%=GetBoardUrl("", "order_index=blamed_count,order_type=" & GetListSortChange(REQ_strOrderType))%>"><%=objXmlLang("blamed_count")%></a></div></th>
<% ELSE %>
						<th><div><%=objXmlLang(dispField)%></div></th>
<% END IF %>
<% NEXT %>
				</tr>
<%
	FOR tmpFor = 0 TO AdRs_Notice_List_Count
		AdRs_List_Temp = AdRs_Notice_List
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
					<td class="notice"><%=objXmlLang("notice")%></td>
<% ELSEIF dispField = "title" THEN %>
					<td class="title">
					<a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>"><%=LIST_strTitle%></a>
					<% IF LIST_intComment > 0 THEN %><span class="comment">[<%=LIST_intComment%>]</span><% END IF %>
					<% IF DATEDIFF("h", LIST_strRegDate, NOW) < INT(objSkinConfig("duration_new")) THEN %><img src="images/etc/blank.gif" class="icon_new" alt="icon_new" /><% END IF %>
					<% IF LIST_strFile <> "" THEN %><img src="images/etc/blank.gif" class="icon_file" alt="icon_file" /><% END IF %>
					<% IF LIST_strImage <> "" THEN %><img src="images/etc/blank.gif" class="icon_image" alt="icon_image" /><% END IF %>
					<% IF LIST_bitSecret = True THEN %><img src="images/etc/blank.gif" class="icon_secret" alt="icon_image" /><% END IF %>
					</td>
<% ELSEIF dispField = "nick_name" THEN %>
					<td><%=LIST_strNickName%></td>
<% ELSEIF dispField = "user_id" THEN %>
					<td><%=LIST_strUserID%></td>
<% ELSEIF dispField = "user_name" THEN %>
					<td><%=LIST_strUserName%></td>
<% ELSEIF dispField = "regdate" THEN %>
					<td class="small"><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%></td>
<% ELSEIF dispField = "last_update" THEN %>
					<td class="small"><% IF LIST_strModifyDate = "" OR ISNULL(LIST_strModifyDate) = True THEN %>-<% ELSE %><%=REPLACE(LEFT(LIST_strModifyDate,10),"-",".")%><% END IF %></td>
<% ELSEIF dispField = "readed_count" THEN %>
					<td class="small"><%=LIST_intRead%></td>
<% ELSEIF dispField = "voted_count" THEN %>
					<td class="small"><%=LIST_intVote%></td>
<% ELSEIF dispField = "blamed_count" THEN %>
					<td class="small"><%=LIST_intBlamed%></td>
<% ELSE %>
					<td><%=objExtraVar(dispField)%></td>
<% END IF %>
<% NEXT %>
				</tr>
<% NEXT %>
<% IF REQ_strListType = "list" THEN %>
<!-- #include file = "list.style.asp" -->
<% END IF %>
			</table>
<% END IF %>
<% IF REQ_strListType = "webzine" THEN %>
<!-- #include file = "webzine.style.asp" -->
<% END IF %>
<% IF REQ_strListType = "gallery" THEN %>
<!-- #include file = "gallery.style.asp" -->
<% END IF %>


		</div>
		<div class="ft"></div>
		<span class="rc-bt"><span></span></span>
	</div>



</div>
<div class="list_footer">
	<div class="list_btn_area">
		<span class="fl">
	<% IF CONF_bitBoardAdmin = True THEN %>
				<span class="button icon"><span class="manage"></span><a href="#" id="btn_board_manage" onclick="return false;"><%=objXmlLang("cmd_manage")%></a></span>
	<% END IF %>
				<span class="button icon"><span class="write"></span><a href="<%=GetBoardUrl("write", "")%>"><%=objXmlLang("cmd_write")%></a></span>
		</span>
		<span class="fr">
			<span class="button icon"><span class="list"></span><a href="<%=GetBoardUrl("",  "search_keyword=,search_target=")%>"><%=objXmlLang("cmd_list")%></a></span>
		</span>
	</div>
	<div class="paginate">
<% IF LIST_strFirstPage = False THEN %>
		<a class="first disabled"><%=objXmlLang("first_page")%></a>
<% ELSE %>
		<a class="first" href="<%=GetBoardUrl("","page=" & LIST_strFirstPage)%>"><%=objXmlLang("first_page")%></a>
<% END IF %>
<% IF LIST_strPrevPage = False THEN %>
		<a class="pre disabled"><%=objXmlLang("prev_page")%></a>
<% ELSE %>
		<a class="pre" href="<%=GetBoardUrl("","page=" & LIST_strPrevPage)%>"><%=objXmlLang("prev_page")%></a>
<% END IF %>
<%
	FOR EACH pageNavi IN LIST_strPageNavi
%>
<% IF INT(pageNavi) = REQ_intPage THEN %>
	<strong><%=pageNavi%></strong>
<% ELSE %>
		<a href="<%=GetBoardUrl("", "page=" & pageNavi)%>"><%=pageNavi%></a>
<% END IF %>
<%
	NEXT
%>
<% IF LIST_strNextPage = False THEN %>
		<a class="next disabled"><%=objXmlLang("next_page")%></a>
<% ELSE %>
		<a href="<%=GetBoardUrl("", "page=" & LIST_strNextPage)%>" class="next"><%=objXmlLang("next_page")%></a>
<% END IF %>
<% IF LIST_strEndPage = False THEN %>
		<a class="end disabled"><%=objXmlLang("last_page")%></a>
<% ELSE %>
		<a href="<%=GetBoardUrl("","page=" & LIST_strEndPage)%>" class="end"><%=objXmlLang("last_page")%></a>
<% END IF %>
	</div>
</div>
<% IF REQ_intSeq = "" THEN %>
</div>
<% ELSE %>
<!-- #include file = "common.footer.asp" -->
<% END IF %>