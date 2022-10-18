<!-- #include file = "../../../Include/Member.Message.List.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.message.list.js"></script>
<form id="theForm" name="theForm">
<div id="bodyWrap" class="message_list">
	<div class="page_navi">
		<h4><% IF strMessageType = "R" THEN %><%=objXmlLang("message_receive_list")%><% ELSEIF strMessageType = "S" THEN %><%=objXmlLang("message_send_list")%><% ELSE %><%=objXmlLang("message_save_list")%><% END IF %></h4>
	</div>
	<dl class="list_info">
		<dt class="fl"><b><% IF strMessageType = "R" THEN %><%=objXmlLang("message_receive_list")%><% ELSEIF strMessageType = "S" THEN %><%=objXmlLang("message_send_list")%><% ELSE %><%=objXmlLang("message_save_list")%><% END IF %></b>&nbsp;&nbsp;<b class="point u"><%=CONF_intTotalCount%></b></dt>
		<dd class="fr">
			<select name="message_type" id="message_type">
				<option value="R"><%=objXmlLang("message_receive_list")%></option>
				<option value="S"><%=objXmlLang("message_send_list")%></option>
				<option value="T"><%=objXmlLang("message_save_list")%></option>
			</select>
			<span class="button medium"><input type="button" id="btn_move" value="<%=objXmlLang("cmd_move")%>"></span>
		</dd>
	</dl>
	<table>
		<colgroup>
			<col width="30" /><col width="40" /><col /><col width="100" /><col width="100" /><% IF strMessageType = "S" THEN %><col width="100" /><% END IF %>
		</colgroup>
		<tr>
			<th><input type="checkbox" id="chkAll" /></th>
			<th><%=objXmlLang("num")%></th>
			<th><%=objXmlLang("title")%></th>
			<th><% IF strMessageType = "S" THEN %><%=objXmlLang("receiver")%><% ELSE %><%=objXmlLang("sender")%><% END IF %></th>
<% IF strMessageType = "S" THEN %>
			<th><%=objXmlLang("receive_date")%></th>
<% END IF %>
			<th><% IF strMessageType = "S" THEN %><%=objXmlLang("send_date")%><% ELSE %><%=objXmlLang("date")%><% END IF %></th>
		</tr>
<%
	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Member.Message.List.Disp.asp" -->
		<tr>
			<td><input name="seq" type="checkbox" id="seq" value="<%=LIST_intSeq%>"></td>
			<td class="num"><%=LIST_intNumber%></td>
			<td class="lfpd"><a href="#" id="<%=LIST_intSeq%>" class="message_read"><%=LIST_strTitle%></a></td>
			<td><a href="#" name="popup_menu_area" class="member_<%=LIST_intMemberSrl%>" onclick="return false;"><%=LIST_strNickName%></a></td>
<% IF strMessageType = "S" THEN %>
			<td class="num"><% IF LIST_bitReaded = True THEN %><%=LEFT(LIST_strReadedDate,10)%>&nbsp;(<%=FORMATDATETIME(LIST_strReadedDate, 4)%>)<% ELSE %>-<% END IF %></td>
<% END IF %>
			<td class="num"><%=LEFT(LIST_strRegDate,10)%>&nbsp;(<%=FORMATDATETIME(LIST_strRegDate, 4)%>)</td>
		</tr>
<% NEXT %>
	</table>
	<div class="btn_area">
		<span class="button eLarge icon"><span class="message"></span><input type="button" id="btn_send" value="<%=objXmlLang("cmd_message_send")%>"></span>
		<span class="button eLarge icon"><span class="download"></span><input type="button" id="btn_save" value="<%=objXmlLang("cmd_keep")%>"></span>
		<span class="button eLarge icon"><span class="delete"></span><input type="button" id="btn_remove" value="<%=objXmlLang("cmd_delete")%>"></span>
	</div>
	<div id="pagingArea">
		<% IF CONF_intBlockPage = 1 THEN %><a class="prev_page_disabled"><%=objXmlLang("cmd_prev")%></a><% ELSE %><a href="?act=member&subAct=message&message_type=<%=strMessageType%>&page=<%=CONF_intBlockPage - 10%>" class="prev_page"><%=objXmlLang("cmd_prev")%></a><% END IF %>
		<span>
<%
	tmpFor = 1
	DO UNTIL tmpFor > 10 OR CONF_intBlockPage > CONF_intPageCount
%>
		<% IF INT(CONF_intBlockPage) = INT(intPage) THEN %><a class="current_page"><%=CONF_intBlockPage%></a><% ELSE %><a href="?act=member&subAct=message&message_type=<%=strMessageType%>&page=<%=CONF_intBlockPage%>"><%=CONF_intBlockPage%></a><% END IF %>
<%
		CONF_intBlockPage = CONF_intBlockPage + 1
		tmpFor = tmpFor + 1
	LOOP
%>
		</span>
		<% IF CONF_intBlockPage > CONF_intPageCount THEN %><a class="next_page_disabled"><%=objXmlLang("cmd_next")%></a><% ELSE %><a href="?act=member&subAct=message&message_type=<%=strMessageType%>&page=<%=CONF_intBlockPage%>" class="next_page"><%=objXmlLang("cmd_next")%></a><% END IF %>

	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->