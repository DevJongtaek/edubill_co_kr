<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.list.js"></script>
<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.write.js"></script>
<div class="comment_header">
	<h4 class="comment_count"><a href="#link_comment_show" id="link_comment_show" onclick="return false;"><%=objXmlLang("comment")%> : <%=AdRs_List_Count+1%></a></h4>
</div>
<div class="comment_body">
<% FOR tmpFor = 0 TO AdRs_List_Count %>
<!-- #include file = "../../../Include/Comment.List.Disp.asp" -->
		<div class="item<% IF LIST_intDepth > 0 THEN %> itemReply<% END IF %>" comment_id="<%=LIST_intSeq%>">
			<div class="indent<% IF LIST_intDepth > 0 THEN %> indent<%=LIST_intDepth%><% END IF %>">
				<div class="itemAside">
					<%=LIST_strPhotoImg%>
					<h4 class="header"><%=LIST_strNickName%></h4>
					<p class="meta"><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%>&nbsp;<%=FORMATDATETIME(LIST_strRegDate, 4)%><br /><%=LIST_strIpAddr%>,<%=LIST_intVote%></p>
<% IF LIST_intVote OR LIST_intBlamed <> 0 THEN %>
					<dl class="vote">
						<dt class="love"><span><%=objXmlLang("voted_count")%></span></dt>
						<dd><%=LIST_intVote%></dd>
						<dt class="hate"><span><%=objXmlLang("blamed_count")%></span></dt>
						<dd><%=LIST_intBlamed%></dd>
					</dl>
<% END IF %>
				</div>
				<div class="itemContent">
<% IF LIST_bitSecret = True THEN %>
					<form action="./" method="get" onsubmit="return secretCommentCheck(this, <%=LIST_intSeq%>)" class="secretMessage">
						<p>&quot;<%=objXmlLang("secret_posts")%>&quot;</p>
						<dl>
							<dt><label for="cpw"><%=objXmlLang("password")%></label> :</dt>
							<dd><input type="password" id="password" class="inputText" title="password" /><span class="button	"><input type="submit" value="<%=objXmlLang("cmd_confirm")%>" /></span></dd>
						</dl>
					</form>
<% ELSE %>
					<div class="content"><%=LIST_strContent%></div>

<% IF LIST_intFileCount > 0 THEN %>
					<div class="attachedFile">
						<dt><a href="#link_comment_file" name="link_comment_file" id="<%=LIST_intSeq%>" onclick="return false;"><%=objXmlLang("cmd_attach_file")%> (<%=LIST_intFileCount%>)</a></dt>
						<dd>
							<ul id="comment_file_<%=LIST_intSeq%>" class="files"></ul>
						</dd>
					</div>
<% END IF %>
					<ul class="action">
<% IF CONF_intMemberSrl <> "" THEN %>
						<li class="no_line"><a href="#popup_menu_area" name="popup_menu_area" class="comment_<%=LIST_intSeq%>" onclick="return false;"><%=objXmlLang("cmd_comment_popup")%></a></li>
<% END IF %>
<% IF LIST_strModifyLevel = True THEN %>
						<li><a href="<%=GetBoardUrl("comment_modify", "seq=" & READ_intSeq & ",comment_seq=" & LIST_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_modify")%></a></li> 
						<li><a href="<%=GetBoardUrl("comment_remove", "seq=" & READ_intSeq & ",comment_seq=" & LIST_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_delete")%></a></li> 
<% END IF %>
<% IF CONF_bitUseComment = True AND CONF_bitUseCommentReply = True AND CONF_strCmtWriteLevel = True THEN %>
						<li><a href="<%=GetBoardUrl("comment_reply", "seq=" & READ_intSeq & ",comment_seq=" & LIST_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_comment")%></a></li> 
<% END IF %>
					</ul>
<% END IF %>
				</div>
			</div>
		</div>
<% NEXT %>
</div>
<div class="comment_footer">
	<div class="paginate">
	<% IF LIST_strPrevPage = False THEN %>
			<a class="pre disabled"><%=objXmlLang("cmd_prev")%></a>
	<% ELSE %>
			<a href="<%=GetBoardUrl("view","seq=" & REQ_intSeq & ",comment_page=" & LIST_strPrevPage)%>" class="pre"><%=objXmlLang("cmd_prev")%></a>
	<% END IF %>
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
	<% IF LIST_strNextPage = False THEN %>
			<a class="next disabled"><%=objXmlLang("cmd_next")%></a>
	<% ELSE %>
			<a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & LIST_strNextPage)%>" class="next_page"><%=objXmlLang("next_page")%></a>
	<% END IF %>
	</div>
<% IF CONF_bitUseComment = True AND CONF_strCmtWriteLevel = True THEN %>
<form id="theForm" method="post">
	<div class="write">
		<!-- #include file = "../../../daum/editor_inc.asp" -->
		<div class="write_author">
		<span id="comment_write_member">
		<input type="text" id="nickname" class="inputText userName" title="usename" />
		<input type="password" id="password" class="inputText password" title="password" />
		<input type="text" id="email" class="inputText email" title="email" />
		<input type="text" id="homepage" class="inputText homepage" title="homepage" />
		</span>
		<span class="message_form"><input type="checkbox" id="message" value="1" /><label for="message" class="hand"><%=objXmlLang("cmd_message")%></label></span>
		<span><input type="checkbox" id="secret" value="1" /><label for="secret" class="hand"><%=objXmlLang("cmd_secret")%></label></span>
		</div>
		<div class="btn_area">
			<span class="button icon"><span class="add"></span><input type="submit" value="<%=objXmlLang("cmd_comment_add")%>" /></span>
		</div>
	</div>
</form>
<% END IF %>
</div>