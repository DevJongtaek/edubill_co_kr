<!-- #include file = "../../../Include/Comment.Remove.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.remove.js"></script>
<div class="message">
	<div class="sForm mBody">
    <h1><%=objXmlLang("comment_delete")%></h1>
    <form id="theForm">
		<p class="msg"><%=objXmlLang("confirm_comment_delete")%></p>
		<p class="help">
			<span class="button btn04 strong"><input type="button" id="btn_remove" value="<%=objXmlLang("cmd_delete")%>" /></span>
			<span class="button btn03"><a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & intCommentPage)%>"><%=objXmlLang("cmd_cancel")%></a></a></span>
		</p>
    </form>
	</div>
</div>
<!-- #include file = "common.footer.asp" -->