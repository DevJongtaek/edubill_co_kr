<!-- #include file = "../../../Include/Board.Message.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/message.js"></script>
<div class="messageForm">
	<h3><%=objXmlLang("message")%></h3>
	<div class="message"><%=objXmlLang(msgCode)%></div>
	<div class="buttonArea">
		<span class="button medium"><a href="<%=GetBoardUrl("login", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_login")%></a></span>
		<span class="button medium"><a href="<%=GetBoardUrl(REQ_prevAct, "seq=" & REQ_intSeq & ",comment_page=" & REQ_intCommentPage)%>"><%=objXmlLang("cmd_back")%></a></span>
	</div>
</div>
<!-- #include file = "common.footer.asp" -->