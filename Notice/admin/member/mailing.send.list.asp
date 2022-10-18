<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C10"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.mailing.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""
	IF intPage = "" THEN intPage = 1

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""
	IF intPageSize = "" THEN intPageSize = 10

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_LIST] ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="member/js/mailing.send.list.js"></script>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_list")%></h3>
				<div class="right_area">
					<span class="button medium icon"><span class="add"></span><button id="btn_mailing_add" type="button"><%=objXmlLang("btn_mailing_add")%></button></span>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_list")%></p>
			<div id="subBody">
				<div style="border-bottom: 1px solid #DADADA; margin-bottom:20px;">
				<table class="admin_tab">
					<colgroup>
					<col width="5"/><col /><col width="9"/>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col/>
					</colgroup>
				<tbody>
				<tr>
					<td class="tabL1"/>
					<th class="over"><%=objXmlLang("tab_menu1")%></th>
					<td class="tabR1"/>
					<td class="tabL2"/>
					<th><a href="?act=mailinggrouplist"><%=objXmlLang("tab_menu2")%></a></th>
					<td class="tabR2"/>
					<td class="tabL2"/>
					<th><a href="?act=mailingetclist"><%=objXmlLang("tab_menu3")%></a></th>
					<td class="tabR2"/>
					<td class="tar"/>
				</tr>
				</tbody>
				</table>
				</div>
			<form id="theForm" method="post" action="?act=mailingsendlist">
			<input type="hidden" id="intPage" value="<%=intPage%>">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalCnt"><%=intTotalCount%></span></p>
					</div>
					<div class="right">
						<ul>
							<li>
								<select name="intPageSize" id="intPageSize" onChange="javascript:$('#theForm').submit();">
								<%=GetMakeSelectForm(objXmlLang("option_page_list"), ",", intPageSize, "int")%>
								</select>
							</li>
						</ul>
					</div>
				</div>
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="22" /><col width="45" /><col /><col width="70" /><col width="120" /><col width="80" /><col width="90" /><col width="90" /><col width="45" />
				</colgroup>
					<thead id="pointListHead">
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_subject")%></th>
							<th class="bar"><%=objXmlLang("list_user")%></th>
							<th class="bar"><%=objXmlLang("list_senddate")%></th>
							<th class="bar"><%=objXmlLang("list_regdate")%></th>
							<th class="bar"><%=objXmlLang("list_user_set")%></th>
							<th class="bar"><%=objXmlLang("list_send")%></th>
							<th class="lineR bar"><%=objXmlLang("list_modify")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_LIST] 'N', '" & intPage & "', '" & intPageSize & "' ")

	DIM iCount, intNumber
	WHILE NOT(RS.EOF)
	
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input name="strCode" type="checkbox" id="strCode" value="<%=RS("strCode")%>"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="lfpd"><%=RS("strTitle")%></td>
							<td class="detail num"><%=RS("intMemberCount")%></td>
							<td class="detail num"><% IF RS("strLastDate") <> "" AND ISNULL(RS("strLastDate")) = False THEN %><%=REPLACE(LEFT(RS("strLastDate"),10),"-",".")%>&nbsp;<%=FORMATDATETIME(RS("strLastDate"), 4)%><% END IF %></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%></td>
							<td class="detail"><span class="button small"><a name="btn_member_set" id="<%=RS("strCode")%>"><%=objXmlLang("btn_config")%></a></span></td>
							<td class="detail"><span class="button small"><a name="btn_send_mail" id="<%=RS("strCode")%>"><%=objXmlLang("btn_send_mail")%></a></span></td>
							<td class="detail"><span class="button small"><a name="btn_modify" id="<%=RS("strCode")%>"><%=objXmlLang("btn_modify")%></a></span></td>
						</tr>
<%
	RS.MOVENEXT
	WEND
%>
				</table>
				<div id="noDataDiv" class="lineB" style="display:<% IF intTotalCount = 0 THEN %>block<% ELSE %>none<% END IF %>;"><%=objXmlLang("text_nodata")%></div>
				<div class="list_control">
					<ul>
						<li class="chk"><input type="checkbox" id="checkall" cid="n" /></li>
						<li class="lbl"><%=objXmlLang("text_select")%></li>
						<li><span class="button small btn"><a id="btn_remove"><%=objXmlLang("btn_remove")%></a></span></li>
					</ul>
				</div>
				<div id="pagingArea">
				<%=GetPageHTML(intPage, intPageCount, objXmlLang("btn_prev_page"), objXmlLang("btn_next_page"), "goPage") %>
				</div>
			</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->