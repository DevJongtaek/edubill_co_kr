<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 6
	menuID      = "F06"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.stat.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM strSearchType, strStartDate, strEndDate

	WITH REQUEST

		strSearchType = GetInputReplce(.FORM("strSearchType"), "")
		strStartDate  = GetInputReplce(.FORM("strStartDate"), "")
		strEndDate    = GetInputReplce(.FORM("strEndDate"), "")

	END WITH

	IF strSearchType = "" THEN strSearchType = "1"

	IF strStartDate = "" THEN strStartDate = REPLACE(LEFT(DATEADD("m", -1, NOW()), 10), "-", ".")
	IF strEndDate   = "" THEN strEndDate   = REPLACE(LEFT(NOW(), 10), "-", ".")

	DIM intPage, intPageSize, intTotalCount, intPageCount

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""
	IF intPage = "" THEN intPage = 1

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""
	IF intPageSize = "" THEN intPageSize = 15

	SET RS = DBCON.EXECUTE("[ARTY30_SP_SITE_STAT_LOG] '" & strSearchType & "', 'Y', '" & strStartDate & "', '" & strEndDate & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="../js/Calendar.js"></script>
<script type="text/javascript" src="stat/js/stat.site.log.js"></script>
		<div id="content">
			<form id="theForm" method="post" action="?act=statsitelog">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_site_log")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_site_log")%></p>
			<div id="detailSearchDiv" class="deatil_search_area">
				<dl id="detailSearcForm" class="radio_form">
					<%=GetMakeRadioForm(objXmlLang("option_log_search_type"), ",", strSearchType, "strSearchType", "<dd><b>", "</b></dd>")%>
				</dl>
				<div id="termSearch" class="detail_box">
					<span class="fl mr5">
					<input name="strStartDate" type="text" id="strStartDate" style="color:#666; background:#fff;" value="<%=strStartDate%>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, 'strStartDate')" /> ~
						<input name="strEndDate" type="text" id="strEndDate" style="color:#666; background:#fff;" value="<%=strEndDate%>" size="10" readonly="readonly" /><input type="button" id="btnEndCal" class="btn_calendar" onClick="calendar(event, 'strEndDate')" />
					</span>
					<span class="fl">
						<span class="button medium"><a name="btn_search"><%=objXmlLang("btn_search")%></a></span>
					</span>
				</div>
			</div>
			<div class="textC">
				<span class="button medium"><a name="btn_search"><%=objXmlLang("btn_search")%></a></span>
			</div>
			<div id="subBody">
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
					<col width="1" /><col width="80" /><col width="110" /><col width="100" /><col />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_date")%></th>
							<th class="bar"><%=objXmlLang("list_ip")%></th>
							<th class="lineR bar"><%=objXmlLang("list_path")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_SITE_STAT_LOG] '" & strSearchType & "', 'N', '" & strStartDate & "', '" & strEndDate & "', '" & intPage & "', '" & intPageSize & "' ")

	DIM iCount, intNumber
	
	WHILE NOT(RS.EOF)
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="detail num"><%=GetMoneyComma(intNumber)%></td>
							<td class="rfpd num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%>&nbsp;(<%=FORMATDATETIME(RS("strRegDate"),4)%>)</td>
							<td class="rfpd num"><%=RS("strIpAddr")%></td>
							<td class="lfpd"><a href="<%=RS("strReferer")%>" target="_blank"><%=RS("strReferer")%></a></td>
						</tr>
<%
	RS.MOVENEXT
	WEND
%>
				</table>
				<div id="pagingArea">
				<%=GetPageHTML(intPage, intPageCount, objXmlLang("btn_prev_page"), objXmlLang("btn_next_page"), "goPage") %>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->