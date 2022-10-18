<!-- #include file = "../../../Include/Member.Scrap.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.scrap.js"></script>
<form id="theForm" name="theForm">
<div id="bodyWrap" class="scrap">
	<div class="page_navi">
		<h4><%=objXmlLang("scrap")%></h4>
	</div>
	<dl class="list_info">
		<dt class="fl"><b><%=objXmlLang("total")%></b>&nbsp;&nbsp;<b class="point u"><%=CONF_intTotalCount%></b></dt>
		<dt class="fr">
			<select id="page_size">
			<%=GetMakeSelectForm(objXmlLang("option_pagelist"), ",", intPageSize, "int")%>
			</select>
		</dt>
	</dl>
	<table>
		<colgroup>
			<col width="30" /><col width="40" /><col /><col width="100" /><col width="100" />
		</colgroup>
		<tr>
			<th><input type="checkbox" id="chkAll" /></th>
			<th><%=objXmlLang("num")%></th>
			<th><%=objXmlLang("title")%></th>
			<th><%=objXmlLang("writer")%></th>
			<th><%=objXmlLang("date")%></th>
		</tr>
<%
	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Member.Scrap.Disp.asp" -->
		<tr>
			<td><input name="seq" type="checkbox" id="seq" value="<%=LIST_intSeq%>"></td>
			<td><%=LIST_intNumber%></td>
			<td class="lfpd"><a href="?act=bbs&subAct=view&bid=<%=LIST_strBoardID%>&seq=<%=LIST_intSeq%>" target="_blank"><%=GetCutDispData(LIST_strTitle,40,"..")%></a></td>
			<td><a href="#" name="popup_menu_area" class="member_<%=LIST_intMemberSrl%>" onclick="return false;"><%=LIST_strNickName%></a></td>
			<td class="num"><%=LEFT(LIST_strRegDate,10)%>&nbsp;(<%=FORMATDATETIME(LIST_strRegDate, 4)%>)</td>
		</tr>
<% NEXT %>
	</table>
	<div class="btn_area">
		<span class="button eLarge icon"><span class="delete"></span><input type="button" id="btn_remove" value="<%=objXmlLang("cmd_delete")%>"></span>
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