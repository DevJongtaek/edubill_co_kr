<!-- #include file = "../../../Include/Member.Message.Send.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.message.send.js"></script>
<div id="popupWrap" class="message_send">
<form id="theForm">
	<div class="header">
		<span class="title"><%=objXmlLang("message_send")%></span><span class="title_info"> - <%=objXmlLang("about_message_member")%></span>
	</div>
	<table>
<% IF intMemberSrl = "" THEN %>
		<tr>
			<th><%=objXmlLang("receiver")%></th>
			<td>
				<input type="text" id="nick_name" class="input_text wd400" />
				<select id="friend">
				<option value=""><%=objXmlLang("friend")%></option>
				</select>
				<p><%=objXmlLang("about_message_memebr")%></p>
			</td>
		</tr>
<% ELSE %>
		<tr>
			<th><%=objXmlLang("receiver")%></th>
			<td><%=SEND_strNickName%></td>
		</tr>
<% END IF %>
		<tr>
			<th><%=objXmlLang("title")%></th>
			<td><input type="text" name="title" id="title" class="input_text wd500" /></td>
		</tr>
		<tr id="mail_send">
			<th><%=objXmlLang("option")%></th>
			<td><input type="checkbox" id="send_mail" name="send_mail" value="1" /><label for="send_mail" class="hand"><%=objXmlLang("cmd_mail")%></label></td>
		</tr>
	</table>
	<div class="content">
<!-- #include file = "../../../daum/editor_inc.asp" -->
	</div>
	<div class="btn_area">
		<span class="button large strong"><input type="submit" value="<%=objXmlLang("cmd_send")%>" /></span>
		<span class="button large"><input type="button" id="btn_close" value="<%=objXmlLang("cmd_cancel")%>" /></span>
	</div>
</form>
</div>
<!-- #include file = "common.footer.asp" -->