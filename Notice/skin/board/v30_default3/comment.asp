<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.list.js"></script>
<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.write.js"></script>
<div class="comments">
	<div class="header">
		<h2><%=objXmlLang("comment")%> <em><%=AdRs_List_Count+1%></em></h2>
	</div>
	<ul class="cmtList">
<% FOR tmpFor = 0 TO AdRs_List_Count %>
<!-- #include file = "../../../Include/Comment.List.Disp.asp" -->
		<li class="cmtItem<% IF LIST_intDepth > 0 THEN %> indent indent<%=LIST_intDepth%><% END IF %>" comment_id="<%=LIST_intSeq%>">
		<div class="cmtMeta">
			<% IF LIST_strPhotoImg <> "" AND ISNULL(LIST_strPhotoImg) = False THEN %>
			<%=LIST_strPhotoImg%>
			<% ELSE %>
			<span class="profile"></span>
			<% END IF %>
			<h3 class="author">
				<%=LIST_strNickName%>
			</h3>
			<p class="time"><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%>&nbsp;<%=FORMATDATETIME(LIST_strRegDate, 4)%></p>
		</div>
<% IF LIST_bitSecret = True THEN %>
<% IF LIST_intMemberSrl = "0" THEN %>
		<form action="./" method="get" onsubmit="return secretCommentCheck(this, <%=LIST_intSeq%>)">
			<p class="secret"><%=objXmlLang("secret_posts")%></p>
			<p class="secret_form">
				<b><%=objXmlLang("password")%> : </b>
				<input type="password" id="password" name="password" class="input_secret" />
				<span class="button	btn01"><input type="submit" value="<%=objXmlLang("cmd_confirm")%>" /></span>
			</p>
		</form>
<% ELSE %>
		<p class="secret"><%=objXmlLang("secret_posts")%></p>
<% END IF %>
<% ELSE %>
		<div class="content"><%=LIST_strContent%></div>
<% IF LIST_intFileCount > 0 THEN %>
		<div class="file_list">
			<a href="#toggle_file" name="comment_file" id="<%=LIST_intSeq%>" class="toggle_file"><%=objXmlLang("cmd_attach_file")%> [<span><%=LIST_intFileCount%></span>]</a>
			<ul id="files_<%=LIST_intSeq%>" class="files"></ul>
		</div>
<% END IF %>
<% END IF %>
		<p class="action">
			<% IF LIST_intVote <> 0 THEN %><span class="vote"><%=objXmlLang("voted_count")%>:<%=LIST_intVote%></span><% END IF %>
			<% IF LIST_intBlamed <> 0 THEN %><span class="vote"><%=objXmlLang("blamed_count")%>:<%=LIST_intBlamed%></span><% END IF %>
			<% IF CONF_bitUseComment = True AND CONF_bitUseCommentReply = True AND CONF_strCmtWriteLevel = True THEN %><a href="<%=GetBoardUrl("comment_reply", "seq=" & READ_intSeq & ",comment_seq=" & LIST_intSeq & ",comment_page=" & REQ_intCommentPage)%>" class="reply"><%=objXmlLang("cmd_comment")%></a><% END IF %>
<% IF LIST_strModifyLevel = True THEN %>
			<a href="<%=GetBoardUrl("comment_modify", "seq=" & READ_intSeq & ",comment_seq=" & LIST_intSeq & ",comment_page=" & REQ_intCommentPage)%>" class="modify"><%=objXmlLang("cmd_modify")%></a>
			<a href="<%=GetBoardUrl("comment_remove", "seq=" & READ_intSeq & ",comment_seq=" & LIST_intSeq & ",comment_page=" & REQ_intCommentPage)%>" class="delete"><%=objXmlLang("cmd_delete")%></a>
<% END IF %>
			<% IF CONF_intMemberSrl <> "" THEN %><a href="#popup_menu_area" name="popup_menu_area" class="comment_<%=LIST_intSeq%> this" onclick="return false;"><%=objXmlLang("cmd_comment_popup")%></a><% END IF %>
		</p>
		</li>
<% NEXT %>
	</ul>
	<div class="pagination">
		<% IF LIST_strPrevPage = False THEN %><a href="#prev_page" class="direction_disabled prev" onclick="return false;"><span></span><span></span> <%=objXmlLang("prev_page")%></a><% ELSE %><a href="<%=GetBoardUrl("view","seq=" & REQ_intSeq & ",comment_page=" & LIST_strPrevPage)%>" class="direction prev"><span></span><span></span> <%=objXmlLang("prev_page")%></a><% END IF %>
<%
	FOR EACH pageNavi IN LIST_strPageNavi
%>
			<% IF INT(pageNavi) = REQ_intCommentPage THEN %>
				<strong><%=pageNavi%></strong>
			<% ELSE %>
				<a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & pageNavi)%>"><%=pageNavi%></a>
			<% END IF %>
<%
	NEXT
%>
			<% IF LIST_strNextPage = False THEN %><a href="#next_page" onclick="return false;" class="direction_disabled next"><%=objXmlLang("next_page")%> <span></span><span></span></a><% ELSE %><a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & LIST_strNextPage)%>" class="direction next"><%=objXmlLang("next_page")%> <span></span><span></span></a><% END IF %>
	</div>
<% IF CONF_bitUseComment = True AND CONF_strCmtWriteLevel = True THEN %>
	<form id="theForm">
	<div class="write">
	<!-- #include file = "../../../daum/editor_inc.asp" -->
	<div class="write_author">
		<span id="comment_write_member">
			<ul>
				<li><input name="nickname" type="text" id="nickname" class="inputText nickname" title="nickname" /></li>
				<li><input name="password" type="password" id="password" class="inputText password" title="password" /></li>
				<li><input name="email" type="text" id="email" class="inputText email" title="email" /></li>
				<li><input name="homepage" type="text" id="homepage" class="inputText url" title="homepage" /></li>
			</ul>
		</span>
		<span class="comment_message"><input name="message" type="checkbox" id="message" value="1" /><label for="message" class="hand"><%=objXmlLang("cmd_message")%></label></span>
		<span class="comment_secret"><input name="secret" type="checkbox" id="secret" value="1" /><label for="secret" class="hand"><%=objXmlLang("cmd_secret")%></label></span>
	</div>
	<div class="btnArea">
		<span class="button btn04 strong"><input type="submit" value="<%=objXmlLang("cmd_comment_add")%>" /></span>
	</div>
	</form>
</div>
<% END IF %>