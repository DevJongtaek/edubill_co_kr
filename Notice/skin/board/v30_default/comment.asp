<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.list.js"></script>
<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.write.js"></script>
<% IF CONF_bitUseComment = True THEN %>
<div class="comment_header">
	<h4><%=objXmlLang("comment")%> <span><%=AdRs_List_Count+1%></span></h4>
</div>
<div class="comment_body">
<% FOR tmpFor = 0 TO AdRs_List_Count %>
<!-- #include file = "../../../Include/Comment.List.Disp.asp" -->
	<div class="item<% IF LIST_intDepth > 0 THEN %> itemReply<% END IF %>" comment_id="<%=LIST_intSeq%>">
			<div class="indent<% IF LIST_intDepth > 0 THEN %> indent<%=LIST_intDepth%><% END IF %>">
				<div class="item_aside">
					<ul>
<% IF LIST_strPhotoImg <> "" THEN %>
						<li class="profile"><%=LIST_strPhotoImg%></li>
<% END IF %>
						<li><%=LIST_strNickName%></li>
						<li class="meta"><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%>&nbsp;<%=FORMATDATETIME(LIST_strRegDate, 4)%></li>
<% IF objSkinConfig("display_ipaddr") = "Y" THEN %>
						<li class="meta"><%=LIST_strIpAddr%></li>
<% END IF %>
<% IF LIST_intVote OR LIST_intBlamed <> 0 THEN %>
						<li>
							<dl class="vote">
								<dt class="love"><span><%=objXmlLang("voted_count")%></span></dt>
								<dd><%=LIST_intVote%></dd>
								<dt class="hate"><span><%=objXmlLang("blamed_count")%></span></dt>
								<dd><%=LIST_intBlamed%></dd>
							</dl>
						</li>
<% END IF %>
					</ul>
				</div>
				<div class="item_content">
<% IF LIST_bitSecret = True THEN %>
					<form action="./" method="get" onsubmit="return secretCommentCheck(this, <%=LIST_intSeq%>)" class="secret_comment">
						<p>&quot;<%=objXmlLang("secret_posts")%>&quot;</p>
						<dl>
							<dt><label for="cpw"><%=objXmlLang("password")%></label> :</dt>
							<dd><input type="password" id="password" name="password" class="inputText" /><span class="button small"><input type="submit" value="<%=objXmlLang("cmd_confirm")%>" /></span></dd>
						</dl>
					</form>
<% ELSE %>
					<div class="content"><%=LIST_strContent%></div>
<% IF LIST_intFileCount > 0 THEN %>
					<div class="file_list">
						<a href="#toggle_file" name="comment_file" id="<%=LIST_intSeq%>" class="toggle_file" onclick="return false;"><%=objXmlLang("cmd_attach_file")%> <strong><%=LIST_intFileCount%></strong> <%=objXmlLang("count")%><span>▼</span></a>
						<ul id="comment_file_<%=LIST_intSeq%>" class="files"></ul>
					</div>
<% END IF %>
					<p class="action">
					<% IF LIST_intVote <> 0 THEN %><span class="vote"><%=objXmlLang("voted_count")%>:<%=LIST_intVote%></span><% END IF %>
					<% IF LIST_intBlamed <> 0 THEN %><span class="vote"><%=objXmlLang("blamed_count")%>:<%=LIST_intBlamed%></span><% END IF %>
					<% IF CONF_bitUseComment = True AND CONF_bitUseCommentReply = True AND CONF_strCmtWriteLevel = True THEN %><a href="<%=GetBoardUrl("comment_reply", "seq=" & READ_intSeq & ",comment_seq=" & LIST_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_comment")%></a><% END IF %>
					<% IF LIST_strModifyLevel = True THEN %>
					<a href="<%=GetBoardUrl("comment_modify", "seq=" & READ_intSeq & ",comment_seq=" & LIST_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_modify")%></a>
					<a href="<%=GetBoardUrl("comment_remove", "seq=" & READ_intSeq & ",comment_seq=" & LIST_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_delete")%></a>
					<% END IF %>
					<% IF CONF_intMemberSrl <> "" THEN %><a href="#popup_menu_area" name="popup_menu_area" class="comment_<%=LIST_intSeq%> this" onclick="return false;"><%=objXmlLang("cmd_comment_popup")%></a><% END IF %>
					</p>
<% END IF %>
				</div>
			</div>
		</div>
<% NEXT %>
		<div class="pagingArea">
			<% IF LIST_strPrevPage = False THEN %><a class="prev_page_disabled"><%=objXmlLang("cmd_prev")%></a><% ELSE %><a href="<%=GetBoardUrl("view","seq=" & REQ_intSeq & ",comment_page=" & CONF_intBlockPage - 10)%>" class="prev_page"><%=objXmlLang("cmd_prev")%></a><% END IF %>
			<span>
<%
	FOR EACH pageNavi IN LIST_strPageNavi
%>
			<% IF INT(pageNavi) = REQ_intCommentPage THEN %>
				<a class="current_page"><%=pageNavi%></a>
			<% ELSE %>
				<a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & pageNavi)%>"><%=pageNavi%></a>
			<% END IF %>
<%
	NEXT
%>
			</span>
			<% IF LIST_strNextPage = False THEN %><a class="next_page_disabled"><%=objXmlLang("cmd_next")%></a><% ELSE %><a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & CONF_intBlockPage)%>" class="next_page"><%=objXmlLang("cmd_next")%></a><% END IF %>
		</div>
<% IF CONF_bitUseComment = True AND CONF_strCmtWriteLevel = True THEN %>
		<form id="theForm" name="theForm" method="post" class="comment_write">
			<!-- #include file = "../../../daum/editor_inc.asp" -->
			<div class="write_author">
				<span id="comment_write_member">
					<ul>
						<li><input name="nickname" type="text" id="nickname" class="inputText comment_nickname" title="nickname" /></li>
						<li><input name="password" type="password" id="password" class="inputText comment_password" title="password" /></li>
						<li><input name="email" type="text" id="email" class="inputText comment_email" title="email" /></li>
						<li><input name="homepage" type="text" id="homepage" class="inputText comment_homepage" title="homepage" /></li>
					</ul>
				</span>
				<span class="comment_message"><input name="message" type="checkbox" id="message" value="1" /><label for="message" class="hand"><%=objXmlLang("cmd_message")%></label></span>
		<span class="comment_secret"><input name="secret" type="checkbox" id="secret" value="1" /><label for="secret" class="hand"><%=objXmlLang("cmd_secret")%></label></span>
			</div>
			<div class="button_area"><span class="button large"><input type="submit" value="<%=objXmlLang("cmd_comment_add")%>" /></span></div>
		</form>
<% END IF %>
</div>
<% END IF %>