<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 1
	menuID      = "A02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.default.staff.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<script type="text/javascript" src="default/js/staff.list.js"></script>
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""
	IF intPage = "" THEN intPage = 1

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""
	IF intPageSize = "" THEN intPageSize = 10

	SET RS = DBCON.EXECUTE("[ARTY30_SP_STAFF_LIST] ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
				<div class="right_area">
					<span class="button medium icon"><span class="add"></span><button id="btn_staff_add" type="button"><%=objXmlLang("btn_staff_add")%></button></span>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description")%></p>
			<div id="subBody">
			<form id="theForm" method="post" action="?act=stafflist">
			<input type="hidden" id="intPage" value="<%=intPage%>">
			<input type="hidden" id="Act" name="Act">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalNum"><%=intTotalCount%></span></p>
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
					<col width="1" /><col width="22" /><col width="45" /><col width="80"><col /><col width="80" /><col width="120" /><col width="100" /><col width="50" />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_user_id")%></th>
							<th class="bar"><%=objXmlLang("list_user_name")%></th>
							<th class="bar"><%=objXmlLang("list_menu_count")%></th>
							<th class="bar"><%=objXmlLang("list_sign_date")%></th>
							<th class="bar"><%=objXmlLang("list_end_date")%></th>
							<th class="lineR bar"><%=objXmlLang("list_authority")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_STAFF_LIST] 'L', '" & intPage & "', '" & intPageSize & "' ")

	DIM iCount, intNumber
	WHILE NOT(RS.EOF)
	
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input name="memberSrl" type="checkbox" id="memberSrl" value="<%=RS("intSeq")%>"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="detail"><%=RS("strLoginID")%></td>
							<td class="detail"><%=RS("strUserName")%>&nbsp;(<%=RS("strNickName")%>)</td>
							<td class="detail"><%=RS("intMenuCount")%></td>
							<td class="detail num"><% IF RS("strVisitDate") <> "" AND ISNULL(RS("strVisitDate")) = False THEN %><%=REPLACE(LEFT(RS("strVisitDate"),10),"-",".")%>&nbsp;(<%=HOUR(RS("strVisitDate"))%>:<%=MINUTE(RS("strVisitDate"))%>)<% ELSE %>-<% END IF %></td>
							<td class="detail num"><% IF RS("strEndDate") <> "" AND ISNULL(RS("strEndDate")) = False THEN %><%=REPLACE(LEFT(RS("strEndDate"),10),"-",".")%><% ELSE %>-<% END IF %></td>
							<td class="detail"><span class="button small"><a href="#" name="btn_modify" id="<%=RS("intSeq")%>"><%=objXmlLang("btn_config")%></a></span></td>
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