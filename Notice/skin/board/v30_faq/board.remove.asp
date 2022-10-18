<!-- #include file = "../../../Include/Board.Remove.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/board.remove.js"></script>
<form id="theForm">
<div class="messageForm">
	<h3><%=objXmlLang("posts_delete")%></h3>
	<div class="message"><%=objXmlLang("confirm_posts_delete")%></div>
	<div class="buttonArea">
		<span class="button medium"><input type="button" id="btn_remove" value="<%=objXmlLang("cmd_delete")%>" /></span>
		<span class="button medium"><a href="<%=GetBoardUrl("list", "")%>"><%=objXmlLang("cmd_cancel")%></a></span>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->