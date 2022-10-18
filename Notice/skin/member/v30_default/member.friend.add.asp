<!-- #include file = "../../../Include/Member.Friend.Add.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.friend.add.js"></script>
<div id="popupWrap" class="friend_add">
<form id="theForm">
	<div class="header">
		<span class="title"><%=objXmlLang("friend")%></span>
	</div>
	<div class="content">
		<table>
			<tr>
				<th><%=objXmlLang("profile")%></th>
				<td>
					<select id="search_target">
					<option value="nick_name"><%=objXmlLang("nick_name")%></option>
					<option value="user_id"><%=objXmlLang("user_id")%></option>
					<option value="user_name"><%=objXmlLang("user_name")%></option>
					</select>
					<input type="text" id="search_keyword" class="input_text nick_name" value="<%=READ_strNickName%>" />
					<span class="button medium"><input type="button" id="btn_search" value="<%=objXmlLang("cmd_search")%>" /></span>
					<div id="search_result" class="search_result"></div>
				</td>
			</tr>
			<tr>
				<th><%=objXmlLang("group")%></th>
				<td>
					<select id="group_name">
					<%=GetMakeSelectForm(objXmlLang("option_select_group"), ",", "", "")%>
					</select>
				</td>
			</tr>
			<tr id="mail_send">
				<th><%=objXmlLang("memo")%></th>
				<td><input type="text" id="memo" class="input_text all" value="<%=READ_strMemo%>" /></td>
			</tr>
		</table>
	</div>
	<div class="btn_area">
		<span class="button large strong"><input type="submit" value="<%=objXmlLang("cmd_regist")%>" /></span>
		<span class="button large"><input type="button" id="btn_close" value="<%=objXmlLang("cmd_cancel")%>" /></span>
	</div>
</form>
</div>
<!-- #include file = "common.footer.asp" -->