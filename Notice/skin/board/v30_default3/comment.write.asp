<!-- #include file = "../../../Include/Comment.Write.Form.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.write.js"></script>
<div class="comments">
<% IF subAct = "comment_reply" THEN %>
	<ul class="cmtList">
		<li class="cmtItem" comment_id="<%=LIST_intSeq%>">
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
			<div class="content"><%=LIST_strContent%></div>
		</li>
	</ul>
<% END IF %>
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
		<span class="button btn03"><a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_cancel")%></a></span>
	</div>
	</form>
</div>
<!-- #include file = "common.footer.asp" -->