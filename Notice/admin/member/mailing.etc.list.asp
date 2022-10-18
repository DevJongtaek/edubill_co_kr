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

	DIM searchMode, searchText
	searchMode = GetInputReplce(REQUEST.FORM("searchMode"), "")
	searchText = GetInputReplce(REQUEST.FORM("searchText"), "")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_ETC_LIST] 'Y', '', '', '" & searchMode & "', '" & searchText & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="member/js/mailing.etc.list.js"></script>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_etc_list")%></h3>
				<div class="right_area">
					<ul>
						<li>
							<select name="searchMode" class="wd100" id="searchMode">
							<%=GetMakeSelectForm(objXmlLang("option_search_etc"), ",", searchMode, "")%>
							</select>
						</li>
						<li>
							<input name="searchText" type="text" id="searchText" value="<%=searchText%>" size="25" maxlength="20" />
							<span class="button medium"><input type="button" id="btn_search" value="<%=objXmlLang("btn_search")%>" /></span>
							<span class="button medium"><input type="button" id="btn_cancel" value="<%=objXmlLang("btn_cancel")%>" /></span>
						</li>
						<li><span class="button medium icon"><span class="add"></span><button id="btn_mailinfo_add" type="button"><%=objXmlLang("btn_mailinfo_add")%></button></span></li>
					</ul>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_etc")%></p>
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
					<td class="tabL2"/>
					<th><a href="?act=mailingsendlist"><%=objXmlLang("tab_menu1")%></a></th>
					<td class="tabR2"/>
					<td class="tabL2"/>
					<th><a href="?act=mailinggrouplist"><%=objXmlLang("tab_menu2")%></a></th>
					<td class="tabR2"/>
					<td class="tabL1"/>
					<th class="over"><%=objXmlLang("tab_menu3")%></th>
					<td class="tabR1"/>
					<td class="tar"/>
				</tr>
				</tbody>
				</table>
				</div>
			<form id="theForm" method="post" action="?act=mailingetclist">
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
					<col width="1" /><col width="22" /><col width="45" /><col width="100" /><col width="150" /><col /><col width="70" /><col width="90" /><col width="45" />
				</colgroup>
					<thead id="pointListHead">
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_name")%></th>
							<th class="bar"><%=objXmlLang("list_position")%></th>
							<th class="bar"><%=objXmlLang("list_email")%></th>
							<th class="bar"><%=objXmlLang("list_mailing")%></th>
							<th class="bar"><%=objXmlLang("list_regdate")%></th>
							<th class="lineR bar"><%=objXmlLang("list_modify")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_ETC_LIST] 'N', '" & intPage & "', '" & intPageSize & "', '" & searchMode & "', '" & searchText & "' ")

	DIM iCount, intNumber
	WHILE NOT(RS.EOF)
	
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input name="intSeq" type="checkbox" id="intSeq" value="<%=RS("intSeq")%>"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="lfpd"><%=RS("strName")%></td>
							<td class="detail"><%=RS("strCompany")%></td>
							<td class="detail"><%=RS("strEmail")%></td>
							<td class="detail"><%=GetOptionArrText(objXmlLang("option_use"), GetBitTypeNumberChg(RS("bitSend")))%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%></td>
							<td class="detail"><span class="button small"><a name="btn_modify" id="<%=RS("intSeq")%>"><%=objXmlLang("btn_modify")%></a></span></td>
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
				<%=GetPageHTML(intPage, intPageCount, objXmlLang("prevpage"), objXmlLang("nextpage"), "goPage") %>
				</div>
			</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->