<!-- #include file = "../../../Include/Board.Remove.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/board.remove.js"></script>
<div class="message">
	<div class="sForm mBody">
    <h1><%=objXmlLang("posts_delete")%></h1>
    <form id="theForm">
		<p class="msg"><%=objXmlLang("confirm_posts_delete")%></p>
		<p class="help">
			<span class="button btn04 strong"><input type="button" id="btn_remove" value="<%=objXmlLang("cmd_delete")%>" /></span>
			<span class="button btn03"><a href="<%=GetBoardUrl("view", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_cancel")%></a></span>
		</p>
    </form>
	</div>
</div>
<!-- #include file = "common.footer.asp" -->