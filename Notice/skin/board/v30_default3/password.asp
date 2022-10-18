<!-- #include file = "../../../Include/Board.Password.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/password.js"></script>
<div class="message">
	<div class="sForm mBody">
    <h1><%=objXmlLang("password_input")%></h1>
    <form id="theForm">
		<dl>
			<dt><label><%=objXmlLang("password_input")%></label></dt>
			<dd><input type="password" name="password" id="password" class="iText" title="password" /></dd>
		</dl>
		<span class="button btn03 strong btn_submit "><input type="submit" value="<%=objXmlLang("cmd_confirm")%>" /></span>
		<p class="help">
			<span class="button btn03"><a href="<%=GetBoardUrl(strPrevAct, "seq=" & REQ_intSeq & ",comment_page=" & intCommentPage)%>"><%=objXmlLang("cmd_back")%></a></span>
		</p>
    </form>
	</div>
</div>
<!-- #include file = "common.footer.asp" -->