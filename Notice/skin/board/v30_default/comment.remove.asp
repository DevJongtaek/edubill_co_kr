<!-- #include file = "../../../Include/Comment.Remove.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.remove.js"></script>
<form id="theForm">
<div class="message_box">
	<div class="titleBar"><%=objXmlLang("comment_delete")%></div>
	<div class="content"><%=objXmlLang("confirm_comment_delete")%></div>
	<div class="buttonArea">
		<span class="button medium"><input type="button" id="btn_remove" value="<%=objXmlLang("cmd_delete")%>" /></span>
		<span class="button medium"><a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & intCommentPage)%>"><%=objXmlLang("cmd_cancel")%></a></span>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->