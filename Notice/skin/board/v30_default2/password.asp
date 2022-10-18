<!-- #include file = "../../../Include/Board.Password.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/password.js"></script>
<div class="box" style="width:400px; margin:0 auto; margin-top:100px;">
	<span class="rc-tp"><span></span></span>
	<div class="bd bd_white">
		<form id="theForm" name="theForm">
		<div class="message_box">
			<div class="titleBar"><%=objXmlLang("password_input")%></div>
			<div class="content form">
				<input type="password" id="password" class="inputText password" title="password" />
				<span class="button medium"><input type="submit" id="btn_submit" value="<%=objXmlLang("cmd_confirm")%>" /></span>
			</div>
			<div class="buttonArea">
				<span class="button icon"><span class="back"></span><a href="<%=GetBoardUrl(strPrevAct, "seq=" & REQ_intSeq & ",comment_page=" & intCommentPage)%>"><%=objXmlLang("cmd_back")%></a></span>
			</div>
		</div>
		</form>
	</div>
	<div class="ft"></div>
	<span class="rc-bt"><span></span></span>
</div>
<!-- #include file = "common.footer.asp" -->