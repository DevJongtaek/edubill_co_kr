<!-- #include file = "../../../Include/Board.Message.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/message.js"></script>
<div class="message_box">
	<div class="titleBar"><%=objXmlLang("message")%></div>
	<div class="content">
		<span id="message"><%=objXmlLang(msgCode)%></span>
	</div>
	<div class="buttonArea">
		<span class="button medium"><a href="<%=GetBoardUrl("login", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_login")%></a></span>
		<span class="button medium"><a href="<%=GetBoardUrl(REQ_prevAct, "seq=" & REQ_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_back")%></a></span>
	</div>
</div>
<!-- #include file = "common.footer.asp" -->