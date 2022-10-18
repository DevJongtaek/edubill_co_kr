<!-- #include file = "../../../Include/Board.Password.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/password.js"></script>
<form id="theForm" name="theForm">
<div class="messageForm">
	<h3><%=objXmlLang("password_input")%></h3>
	<div class="message">
		<input type="password" id="password" name="password" class="password" />
		<span class="button medium"><input type="submit" id="btn_submit" value="<%=objXmlLang("cmd_confirm")%>" /></span>
	</div>
	<div class="buttonArea">
		<span class="button medium"><a href="#" onclick="history.back(-1);return false;"><%=objXmlLang("cmd_back")%></a></span>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->