<!-- #include file = "../../../Include/Member.Friend.Group.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.friend.group.js"></script>
<div id="popupWrap" class="friend_group">
<form id="theForm">
	<div class="header">
		<span class="title"><%=objXmlLang("friend_group")%></span>
	</div>
	<div class="content">
		<table>
			<tr>
				<th><%=objXmlLang("group_name")%></th>
				<td>
					<input type="text" id="group_name" class="input_text group_name" />
					<span class="button medium"><input type="button" id="btn_regist" value="<%=objXMlLang("cmd_regist")%>" /></span>
				</td>
			</tr>
			<tr id="mail_send">
				<th><%=objXmlLang("group")%></th>
				<td>
					<div class="group_list">
						<ul id="group_list">
						</ul>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div class="btn_area">
		<span class="button large"><input type="button" id="btn_close" value="<%=objXmlLang("cmd_close")%>" /></span>
	</div>
</form>
</div>
<!-- #include file = "common.footer.asp" -->