<!-- #include file = "../../../Include/Member.Friend.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.friend.js"></script>
<form id="theForm">
<div id="bodyWrap" class="friend">
	<div class="page_navi">
		<h4><%=objXmlLang("friend")%></h4>
	</div>
	<dl class="list_info">
		<dt class="fl" style="margin-top:5px;"><b><%=objXmlLang("total")%></b>&nbsp;&nbsp;<b class="point u"><%=CONF_intTotalCount%></b></dt>
		<dt class="fr">
		<select id="group_name" name="group_name">
		<option value=""><%=objXmlLang("group")%></option>
		</select>
		<span class="button medium"><input type="button" class="btn_group_select" value="<%=objXmlLang("cmd_move")%>" /></span>
		<span class="button medium"><input type="button" class="btn_friend_move" value="<%=objXmlLang("cmd_group_move")%>" /></span>
		</dt>
	</dl>
	<table>
		<colgroup>
			<col width="30" /><col width="120" /><col width="100" /><col /><col width="80" /><col width="50" />
		</colgroup>
		<tr>
			<th><input type="checkbox" id="chkAll" /></th>
			<th><%=objXmlLang("group")%></th>
			<th><%=objXmlLang("nick_name")%></th>
			<th><%=objXmlLang("memo")%></th>
			<th><%=objXmlLang("registration_date")%></th>
			<th><%=objXmlLang("modify")%></th>
		</tr>
<%
	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Member.Friend.Disp.asp" -->
		<tr>
			<td><input name="seq" type="checkbox" id="seq" value="<%=LIST_intSeq%>"><input type="hidden" id="member_srl" value="<%=LIST_intFriendSrl%>" /></td>
			<td><%=LIST_strGroipName%></td>
			<td><a href="#" name="popup_menu_area" class="member_<%=LIST_intFriendSrl%>" onclick="return false;"><%=LIST_strNickName%></a></td>
			<td class="lfpd"><%=LIST_strMemo%></td>
			<td class="num"><%=LEFT(LIST_strRegDate,10)%></td>
			<td><span class="button small"><a href="#" name="btn_modify" id="friend_<%=LIST_intSeq%>" onclick="return false;"><%=objXmlLang("cmd_modify")%></a></span></td>
		</tr>
<% NEXT %>
	</table>
	<div class="btn_area">
		<span class="button eLarge icon"><span class="add"></span><input type="button" id="btn_friend_add" value="<%=objXmlLang("cmd_friend_add")%>"></span>
		<span class="button eLarge icon"><span class="delete"></span><input type="button" id="btn_friend_remove" value="<%=objXmlLang("cmd_friend_delete")%>"></span>
		<span class="button eLarge icon"><span class="message"></span><input type="button" id="btn_message" value="<%=objXmlLang("cmd_message_send")%>"></span>
		<span class="button eLarge icon"><span class="group"></span><input type="button" id="btn_group_maneger" value="<%=objXmlLang("cmd_group_manager")%>"></span>
	</div>
	<div class="pagingArea">
		<% IF CONF_intBlockPage = 1 THEN %><a class="prev_page_disabled"><%=objXmlLang("cmd_prev")%></a><% ELSE %><a name="link_page" id="page_<%=CONF_intBlockPage - 10%>" class="prev_page"><%=objXmlLang("cmd_prev")%></a><% END IF %>
		<span>
<%
	tmpFor = 1
	DO UNTIL tmpFor > 10 OR CONF_intBlockPage > CONF_intPageCount
%>
		<% IF INT(CONF_intBlockPage) = INT(intPage) THEN %><a class="current_page"><%=CONF_intBlockPage%></a><% ELSE %><a name="link_page" id="page_<%=CONF_intBlockPage%>"><%=CONF_intBlockPage%></a><% END IF %>
<%
		CONF_intBlockPage = CONF_intBlockPage + 1
		tmpFor = tmpFor + 1
	LOOP
%>
		</span>
		<% IF CONF_intBlockPage > CONF_intPageCount THEN %><a class="next_page_disabled"><%=objXmlLang("cmd_next")%></a><% ELSE %><a name="link_page" id="page_<%=CONF_intBlockPage%>" class="next_page"><%=objXmlLang("cmd_next")%></a><% END IF %>

	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->