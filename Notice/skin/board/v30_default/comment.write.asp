<!-- #include file = "../../../Include/Comment.Write.Form.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.write.js"></script>
<div class="comment_body">
<% IF subAct = "comment_reply" THEN %>
	<div class="item line">
		<div class="indent">
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
				<div class="content"><%=LIST_strContent%></div>
				<p class="action">
				<% IF LIST_intVote <> 0 THEN %><span class="vote"><%=objXmlLang("voted_count")%>:<%=LIST_intVote%></span><% END IF %>
				<% IF LIST_intBlamed <> 0 THEN %><span class="vote"><%=objXmlLang("blamed_count")%>:<%=LIST_intBlamed%></span><% END IF %>
				</p>
			</div>
		</div>
	</div>
<% END IF %>
	<form id="theForm" name="theForm" method="post" class="comment_write">
		<!-- #include file = "../../../daum/editor_inc.asp" -->
		<div class="write_author">
			<span id="comment_write_member">
				<ul>
					<li><input name="nickname" type="text" id="nickname" class="inputText comment_nickname" /></li>
					<li><input name="password" type="password" id="password" class="inputText comment_password" /></li>
					<li><input name="email" type="text" id="email" class="inputText comment_email" /></li>
					<li><input name="homepage" type="text" id="homepage" class="inputText comment_homepage" /></li>
				</ul>
			</span>
			<span class="comment_message"><input name="message" type="checkbox" id="message" value="1" /><label for="message" class="hand"><%=objXmlLang("cmd_message")%></label></span>
			<span class="comment_secret"><input name="secret" type="checkbox" id="secret" value="1" /><label for="secret" class="hand"><%=objXmlLang("cmd_secret")%></label></span>
		</div>
		<div class="button_area">
			<span class="button large strong"><input type="submit" value="<%=objXmlLang("cmd_comment_add")%>" /></span>
			<span class="button large"><a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_cancel")%></a></span>
		</div>
	</form>
</div>
<!-- #include file = "common.footer.asp" -->