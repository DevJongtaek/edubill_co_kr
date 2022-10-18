<!-- #include file = "../../../Include/Member.Document.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.document.js"></script>
<div id="bodyWrap" class="document">
	<div class="page_navi">
		<h4><%=objXmlLang("my_document")%></h4>
	</div>
	<dl class="list_info">
		<dt class="fl"><b><%=objXmlLang("total")%></b>&nbsp;&nbsp;<b class="point u"><%=CONF_intTotalCount%></b></dt>
	</dl>
	<table>
		<colgroup>
			<col width="50" /><col /><col width="60" /><col width="60" /><col width="100" />
		</colgroup>
		<tr>
			<th><%=objXmlLang("num")%></th>
			<th><%=objXmlLang("title")%></th>
			<th><%=objXmlLang("readed_count")%></th>
			<th><%=objXmlLang("voted_count")%></th>
			<th><%=objXmlLang("date")%></th>
		</tr>
<%
	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Member.Document.Disp.asp" -->
		<tr>
			<td><%=LIST_intNumber%></td>
			<td class="lfpd"><a href="?act=bbs&subAct=view&bid=<%=LIST_strBoardID%>&seq=<%=LIST_intSeq%>" target="_blank"><%=GetCutDispData(LIST_strTitle,40,"..")%></a><% IF LIST_intComment > 0 THEN %>&nbsp;<span class="num">[<%=LIST_intComment%>]</span><% END IF %></td>
			<td><%=LIST_intRead%></td>
			<td><%=LIST_intVote%></td>
			<td class="num"><%=LEFT(LIST_strRegDate,10)%>&nbsp;(<%=FORMATDATETIME(LIST_strRegDate, 4)%>)</td>
		</tr>
<% NEXT %>
	</table>
	<div style="border-top:1px solid #D7D7D7;"></div>
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
<!-- #include file = "common.footer.asp" -->