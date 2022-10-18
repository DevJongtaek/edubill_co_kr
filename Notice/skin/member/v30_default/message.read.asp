<!-- #include file = "../../../Include/Member.Message.Read.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.message.read.js"></script>
<div id="popupWrap" class="message_read">
<form id="theForm">
	<div class="header"></div>
	<table>
		<tr id="sender">
			<th><%=objXmlLang("sender")%></th>
			<td><%=READ_strSenderNick%>&nbsp;(<%=READ_strSenderID%>)</td>
		</tr>
		<tr id="receiver">
			<th><%=objXmlLang("receiver")%></th>
			<td><%=READ_strReceiverNick%>&nbsp;(<%=READ_strReceiverID%>)</td>
		</tr>
		<tr>
			<th><%=objXmlLang("send_date")%></th>
			<td><%=READ_strRegDate%></td>
		</tr>
		<tr>
			<th><%=objXmlLang("receive_date")%></th>
			<td><%=READ_strReadedDate%></td>
		</tr>
		<tr>
			<th><%=objXmlLang("title")%></th>
			<td><%=READ_strTitle%></td>
		</tr>
	</table>
	<div class="content"><%=READ_strContent%></div>
	<div class="btn_area">
		<span id="button_reply" class="button eLarge strong"><input type="button" id="btn_reply" value="<%=objXmlLang("cmd_reply")%>" /></span>
		<span id="button_save" class="button eLarge"><input type="button" id="btn_save" value="<%=objXmlLang("cmd_keep")%>" /></span>
		<span class="button eLarge icon"><span class="delete"></span><input type="button" id="btn_remove" value="<%=objXmlLang("cmd_delete")%>" /></span>
		<span class="button eLarge"><input type="button" id="btn_close" value="<%=objXmlLang("cmd_close")%>" /></span>
	</div>
</form>
</div>
<!-- #include file = "common.footer.asp" -->