<!-- #include file = "../../../Include/Comment.Remove.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/comment.remove.js"></script>
<div class="box" style="width:400px; margin:0 auto; margin-top:100px;">
	<span class="rc-tp"><span></span></span>
	<div class="bd bd_white">
		<form id="theForm">
		<div class="message_box">
			<div class="titleBar"><%=objXmlLang("comment_delete")%></div>
			<div class="content"><%=objXmlLang("confirm_comment_delete")%></div>
			<div class="buttonArea">
				<span class="button icon"><span class="delete"></span><input type="button" id="btn_remove" value="<%=objXmlLang("cmd_delete")%>" /></span>
				<span class="button icon"><span class="cancel"></span><a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq & ",comment_page=" & intCommentPage)%>"><%=objXmlLang("cmd_cancel")%></a></span>
			</div>
		</div>
		</form>
	</div>
	<div class="ft"></div>
	<span class="rc-bt"><span></span></span>
</div>
<!-- #include file = "common.footer.asp" -->