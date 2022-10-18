<!-- #include file = "../../../Include/Board.Password.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/password.js"></script>
<form id="theForm" name="theForm">
<div class="message_box">
	<div class="titleBar"><%=objXmlLang("password_input")%></div>
	<div class="content">
		<input type="password" id="password" name="password" class="inputText password" title="password" />
		<span class="button medium"><input type="submit" id="btn_submit" value="<%=objXmlLang("cmd_confirm")%>" /></span>
	</div>
	<div class="buttonArea">
		<span class="button medium"><a href="<%=GetBoardUrl(strPrevAct, "seq=" & REQ_intSeq & ",comment_page=" & intCommentPage)%>"><%=objXmlLang("cmd_back")%></a></span>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->