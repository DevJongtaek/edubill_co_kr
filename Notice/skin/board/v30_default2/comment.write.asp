<!-- #include file = "../../../Include/Comment.Write.Form.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.write.js"></script>
	<div class="box">
		<span class="rc-tp"><span></span></span>
		<div class="bd bd_white">
<% IF subAct = "comment_reply" THEN %>
		<div class="comment_body">
			<div class="item no_line" comment_id="<%=LIST_intSeq%>">
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
					<div class="content"><%=LIST_strContent%></div>
				</div>
			</div>
		</div>
<% END IF %>
		<div class="comment_footer">
			<form id="theForm" method="post">
				<div class="write">
					<!-- #include file = "../../../daum/editor_inc.asp" -->
					<div class="write_author">
					<span id="comment_write_member">
					<input type="text" id="nickname" class="inputText userName" title="username" />
					<input type="password" id="password" class="inputText password" title="password" />
					<input type="text" id="email" class="inputText email" title="email" />
					<input type="text" id="homepage" class="inputText homepage" title="homepage" />
					</span>
					<span class="message_form"><input type="checkbox" id="message" value="1" /><label for="message" class="hand"><%=objXmlLang("cmd_message")%></label></span>
					<span><input type="checkbox" id="secret" value="1" /><label for="secret" class="hand"><%=objXmlLang("cmd_secret")%></label></span>
					</div>
					<div class="btn_area">
						<span class="button icon"><span class="add"></span><input type="submit" value="<%=objXmlLang("cmd_comment_add")%>" /></span>
						<span class="button icon"><span class="cancel"></span><a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_cancel")%></a></span>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="ft"></div>
	<span class="rc-bt"><span></span></span>
</div>
<!-- #include file = "common.footer.asp" -->