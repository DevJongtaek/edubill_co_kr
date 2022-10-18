<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 6
	menuID      = "F09"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.stat.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM strSearchType, strStartDate, strEndDate, intYear, intMonth, intDay, strNowDate

	WITH REQUEST

		strSearchType = GetInputReplce(.FORM("strSearchType"), "")
		strStartDate  = GetInputReplce(.FORM("strStartDate"), "")
		strEndDate    = GetInputReplce(.FORM("strEndDate"), "")
		intYear       = GetInputReplce(.FORM("intYear"), "")
		intMonth      = GetInputReplce(.FORM("intMonth"), "")
		intDay        = DAY(NOW)

	END WITH

	IF strStartDate = "" THEN strStartDate = REPLACE(LEFT(DATEADD("m", -1, NOW()), 10), "-", ".")
	IF strEndDate   = "" THEN strEndDate   = REPLACE(LEFT(NOW(), 10), "-", ".")

	IF intYear  = "" THEN intYear  = YEAR(NOW)
	IF intMonth = "" THEN intMonth = MONTH(NOW)

	IF LEN(intMonth) = 1 THEN intMonth = "0" & intMonth
	IF LEN(intDay)   = 1 THEN intDay   = "0" & intDay

	strNowDate = REPLACE(LEFT(NOW(), 10), "-", ".")

	DIM intPage, intPageSize, intTotalCount, intPageCount, intSearchCount

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""
	IF intPage = "" THEN intPage = 1

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""
	IF intPageSize = "" THEN intPageSize = 10

	SELECT CASE strSearchType
	CASE "1"
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_STAT] '1', '" & strSearchType & "', '" & REPLACE(strStartDate, ".", "-") & "', '" & REPLACE(strEndDate, ".", "-") & "', '" & intPage & "', '" & intPageSize & "' ")
	CASE "2"
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_STAT] '1', '" & strSearchType & "', '" & intYear & "-01-01" & "', '', '" & intPage & "', '" & intPageSize & "' ")
	CASE "3"
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_STAT] '1', '" & strSearchType & "', '" & YEAR(NOW) & "-" & intMonth & "-01" & "', '', '" & intPage & "', '" & intPageSize & "' ")
	CASE "4", ""
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_STAT] '1', '" & strSearchType & "', '', '', '" & intPage & "', '" & intPageSize & "' ")
	END SELECT

	intTotalCount  = RS(0)
	intSearchCount = RS(1)
	intPageCount   = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="../js/Calendar.js"></script>
<script type="text/javascript" src="stat/js/stat.search.js"></script>
		<div id="content">
			<form id="theForm" method="post" action="?act=statsearch">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_search")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_search")%></p>
			<div id="detailSearchDiv" class="deatil_search_area">
				<dl id="detailSearcForm" class="radio_form">
					<%=GetMakeRadioForm(objXmlLang("option_search_type"), ",", strSearchType, "strSearchType", "<dd><b>", "</b></dd>")%>
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
				<div id="yearSearch" class="detail_box">
					<span class="fl mr5">
						<select name="intYear" id="intYear">
						<%=GetMakeDateSelectForm("", intYear, YEAR(NOW), YEAR(NOW) - 5, "-1", objXmlLang("text_year"))%>
						</select>
					</span>
					<span class="fl">
						<span class="button medium"><a name="btn_search"><%=objXmlLang("btn_search")%></a></span>
					</span>
				</div>
				<div id="monthSearch" class="detail_box">
					<span class="fl mr5">
						<select name="intMonth" id="intMonth">
						<%=GetMakeDateSelectForm("", intMonth, 1, 12, "1", objXmlLang("text_month"))%>
						</select>
					</span>
					<span class="fl">
						<span class="button medium"><a name="btn_search"><%=objXmlLang("btn_search")%></a></span>
					</span>
				</div>
				<div id="daySearch" class="detail_box">
					<span class="fl mr5">
						<input name="strNowDate" type="text" id="startTermDate" style="color:#666; background:#fff;" value="<%=strNowDate%>" size="10" readonly="readonly" />
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
						<p><%=objXmlLang("text_total")%> <span id="totalNum"><%=GetMoneyComma(intTotalCount)%></span></p>
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
					<col width="1" /><col width="50" /><col width="150" /><col width="60" /><col width="60" /><col width="100" /><col />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th><%=objXmlLang("list_rank")%></th>
							<th class="bar"><%=objXmlLang("list_keyword")%></th>
							<th class="bar"><%=objXmlLang("list_count")%></th>
							<th class="bar"><%=objXmlLang("list_percent")%></th>
							<th class="bar"><%=objXmlLang("list_search_date")%></th>
							<th class="lineR bar"><%=objXmlLang("list_graph")%></th>
						</tr>
					</thead>
<%
	SELECT CASE strSearchType
	CASE "1"
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_STAT] '2', '" & strSearchType & "', '" & REPLACE(strStartDate, ".", "-") & "', '" & REPLACE(strEndDate, ".", "-") & "', '" & intPage & "', '" & intPageSize & "' ")
	CASE "2"
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_STAT] '2', '" & strSearchType & "', '" & intYear & "-01-01" & "', '', '" & intPage & "', '" & intPageSize & "' ")
	CASE "3"
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_STAT] '2', '" & strSearchType & "', '" & YEAR(NOW) & "-" & intMonth & "-01" & "', '', '" & intPage & "', '" & intPageSize & "' ")
	CASE "4", ""
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_STAT] '2', '" & strSearchType & "', '', '', '" & intPage & "', '" & intPageSize & "' ")
	END SELECT

	DIM intPerc, intGrpWidth

	WHILE NOT(RS.EOF)

		IF RS("intCount") = 0 THEN intPerc = 0 ELSE intPerc = FormatPercent(RS("intCount") / intSearchCount)
		intGrpWidth = INT(369 * REPLACE(intPerc, "%", "") / 100)
%>
						<tr>
							<td class="detail"></td>
							<td class="detail num"><%=RS("intRank")%></td>
							<td class="lfpd"><%=RS("strKeyword")%></td>
							<td class="rfpd num"><%=GetMoneyComma(RS("intCount"))%></td>
							<td class="rfpd num"><%=intPerc%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%>&nbsp;(<%=FORMATDATETIME(RS("strRegDate"),4)%>)</td>
							<td class="lfpd">
								<div style="border:1px solid #CCC; height:12px;">
									<div style="width:<%=intGrpWidth%>px; height:12px; background-color:#E9E9E9;"></div>
								</div>
							</td>
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