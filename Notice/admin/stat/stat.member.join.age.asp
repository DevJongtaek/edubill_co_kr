<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 6
	menuID      = "F02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.stat.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM strSearchType, strStartDate, strEndDate, intYear, intMonth, intDay, strNowDate, strSearchAge

	WITH REQUEST

		strSearchType = GetInputReplce(.FORM("strSearchType"), "")
		strStartDate  = GetInputReplce(.FORM("strStartDate"), "")
		strEndDate    = GetInputReplce(.FORM("strEndDate"), "")
		intYear       = GetInputReplce(.FORM("intYear"), "")
		intMonth      = GetInputReplce(.FORM("intMonth"), "")
		intDay        = DAY(NOW)
		strSearchAge  = GetInputReplce(.FORM("strSearchAge"), "")

	END WITH

	IF strStartDate = "" THEN strStartDate = REPLACE(LEFT(DATEADD("m", -1, NOW()), 10), "-", ".")
	IF strEndDate   = "" THEN strEndDate   = REPLACE(LEFT(NOW(), 10), "-", ".")

	IF intYear  = "" THEN intYear  = YEAR(NOW)
	IF intMonth = "" THEN intMonth = MONTH(NOW)

	IF LEN(intMonth) = 1 THEN intMonth = "0" & intMonth
	IF LEN(intDay)   = 1 THEN intDay   = "0" & intDay

	strNowDate = REPLACE(LEFT(NOW(), 10), "-", ".")

	DIM intTotalCount

	SELECT CASE strSearchType
	CASE "1"
		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '1', '" & strSearchType & "', '" & REPLACE(strStartDate, ".", "-") & "', '" & REPLACE(strEndDate, ".", "-") & "', '' ")
	CASE "2"
		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '1', '" & strSearchType & "', '" & intYear & "-01-01" & "', '', '' ")
	CASE "3"
		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '1', '" & strSearchType & "', '" & YEAR(NOW) & "-" & intMonth & "-01" & "', '', '' ")
	CASE "4", ""
		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '1', '" & strSearchType & "', '', '', '' ")
	END SELECT

	intTotalCount = RS(0)
%>
<script type="text/javascript" src="../js/Calendar.js"></script>
<script type="text/javascript" src="stat/js/stat.member.join.age.js"></script>
		<div id="content">
			<form id="theForm" method="post" action="?act=statmemberjoinage">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_join_age")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_join_age")%></p>
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
				<div class="detail_box">
					<ul class="radio_form">
						<%=GetMakeCheckForm(objXmlLang("option_age"), ",", strSearchAge, "strSearchAge", "<li class='fl'>", "</li>")%>
					</ul>
				</div>
			</div>
			<div class="textC">
				<span class="button medium"><a name="btn_search"><%=objXmlLang("btn_search")%></a></span>
			</div>
			<div id="subBody">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total_member")%> <span id="totalNum"><%=GetMoneyComma(intTotalCount)%></span></p>
					</div>
					<div class="right">
						(<%=objXmlLang("text_man")%>/<%=objXmlLang("text_woman")%>)
					</div>
				</div>
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="100" /><col width="100" /><col width="100" /><col />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th><%=objXmlLang("list_gubun")%></th>
							<th class="bar"><%=objXmlLang("list_join_count")%></th>
							<th class="bar"><%=objXmlLang("list_percent")%></th>
							<th class="lineR bar"><%=objXmlLang("list_graph")%></th>
						</tr>
					</thead>
<%
	DIM totalCount, DIM_intCount(15), intPerc1, intPerc2, intGrpWidth1, intGrpWidth2

	totalCount      = RS(0)
	DIM_intCount(0) = RS(1)
	DIM_intCount(1) = RS(2)
	DIM_intCount(2) = RS(3)
	DIM_intCount(3) = RS(4)
	DIM_intCount(4) = RS(5)
	DIM_intCount(5) = RS(6)
	DIM_intCount(6) = RS(7)
	DIM_intCount(7) = RS(8)
	DIM_intCount(8) = RS(9)
	DIM_intCount(9) = RS(10)
	DIM_intCount(10) = RS(11)
	DIM_intCount(11) = RS(12)
	DIM_intCount(12) = RS(13)
	DIM_intCount(13) = RS(14)
	DIM_intCount(14) = RS(15)
	DIM_intCount(15) = RS(16)

	FOR tmpFor = 0 TO UBOUND(DIM_intCount) STEP 2

		IF DIM_intCount(tmpFor) = 0 THEN intPerc1 = 0 ELSE intPerc1 = FormatPercent(DIM_intCount(tmpFor) / totalCount)
		IF DIM_intCount(tmpFor+1) = 0 THEN intPerc2 = 0 ELSE intPerc2 = FormatPercent(DIM_intCount(tmpFor+1) / totalCount)
		
		intGrpWidth1 = INT(490 * REPLACE(intPerc1, "%", "") / 100)
		intGrpWidth2 = INT(490 * REPLACE(intPerc2, "%", "") / 100)
%>
						<tr>
							<td class="detail"></td>
							<td class="detail">
<%
	SELECT CASE tmpFor
	CASE "0"  : RESPONSE.WRITE objXmlLang("text_age_1")
	CASE "2"  : RESPONSE.WRITE objXmlLang("text_age_2")
	CASE "4"  : RESPONSE.WRITE objXmlLang("text_age_3")
	CASE "6"  : RESPONSE.WRITE objXmlLang("text_age_4")
	CASE "8"  : RESPONSE.WRITE objXmlLang("text_age_5")
	CASE "10" : RESPONSE.WRITE objXmlLang("text_age_6")
	CASE "12" : RESPONSE.WRITE objXmlLang("text_age_7")
	CASE "14" : RESPONSE.WRITE objXmlLang("text_age_8")
	END SELECT
%>
							</td>
							<td class="rfpd num"><%=GetMoneyComma(DIM_intCount(tmpFor))%><br><%=GetMoneyComma(DIM_intCount(tmpFor+1))%></td>
							<td class="rfpd num"><%=intPerc1%><br><%=intPerc2%></td>
							<td class="lfpd">
								<div style="border:1px solid #CCC; height:12px;">
									<div style="width:<%=intGrpWidth1%>px; height:12px; background-color:#E9E9E9;"></div>
								</div>
								<div style="border:1px solid #CCC; height:12px; margin-top:3px;">
									<div style="width:<%=intGrpWidth2%>px; height:12px; background-color:#E9E9E9;"></div>
								</div>
							</td>
						</tr>
<%
	NEXT
%>
				</table>
<%
	DIM strTitleAge

	IF strSearchAge <> "" THEN
		FOR EACH intAge IN SPLIT(strSearchAge, ",")

		SELECT CASE strSearchType
		CASE "1"
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '2', '" & strSearchType & "', '" & REPLACE(strStartDate, ".", "-") & "', '" & REPLACE(strEndDate, ".", "-") & "', '" & TRIM(intAge) & "' ")
		CASE "2"
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '2', '" & strSearchType & "', '" & intYear & "-01-01" & "', '', '" & TRIM(intAge) & "' ")
		CASE "3"
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '2', '" & strSearchType & "', '" & YEAR(NOW) & "-" & intMonth & "-01" & "', '', '" & TRIM(intAge) & "' ")
		CASE "4", ""
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '2', '" & strSearchType & "', '', '', '" & TRIM(intAge) & "' ")
		END SELECT

		totalCount = RS(0)

		SELECT CASE TRIM(intAge)
		CASE "0"  : strTitleAge = objXmlLang("text_age_1") & " " & objXmlLang("text_member_count")
		CASE "10" : strTitleAge = objXmlLang("text_age_2") & " " & objXmlLang("text_member_count")
		CASE "20" : strTitleAge = objXmlLang("text_age_3") & " " & objXmlLang("text_member_count")
		CASE "30" : strTitleAge = objXmlLang("text_age_4") & " " & objXmlLang("text_member_count")
		CASE "40" : strTitleAge = objXmlLang("text_age_5") & " " & objXmlLang("text_member_count")
		CASE "50" : strTitleAge = objXmlLang("text_age_6") & " " & objXmlLang("text_member_count")
		CASE "60" : strTitleAge = objXmlLang("text_age_7") & " " & objXmlLang("text_member_count")
		CASE "70" : strTitleAge = objXmlLang("text_age_8") & " " & objXmlLang("text_member_count")
		END SELECT
%>
				<div class="mt10">
					<dl class="list_info">
						<dt class="fl mr5"><%=strTitleAge%> : <b class="point u"><%=totalCount%></b>&nbsp;</dt>
						<dt class="fr mr5">(<%=objXmlLang("text_man")%>/<%=objXmlLang("text_woman")%>)</dt>
					</dl>
					<table class="tableType3">
					<colgroup>
						<col width="1" /><col width="100" /><col width="100" /><col width="100" /><col />
					</colgroup>
						<thead>
							<tr>
								<th class="lineL"></th>
								<th><%=objXmlLang("list_gubun")%></th>
								<th class="bar"><%=objXmlLang("list_join_count")%></th>
								<th class="bar"><%=objXmlLang("list_percent")%></th>
								<th class="lineR bar"><%=objXmlLang("list_graph")%></th>
							</tr>
						</thead>
<%
		SELECT CASE strSearchType
		CASE "1"
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '3', '" & strSearchType & "', '" & REPLACE(strStartDate, ".", "-") & "', '" & REPLACE(strEndDate, ".", "-") & "', '" & TRIM(intAge) & "' ")
		CASE "2"
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '3', '" & strSearchType & "', '" & intYear & "-01-01" & "', '', '" & TRIM(intAge) & "' ")
		CASE "3"
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '3', '" & strSearchType & "', '" & YEAR(NOW) & "-" & intMonth & "-01" & "', '', '" & TRIM(intAge) & "' ")
		CASE "4", ""
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_AGE] '3', '" & strSearchType & "', '', '', '" & TRIM(intAge) & "' ")
		END SELECT

		WHILE NOT(RS.EOF)

		IF RS("intCountM") = 0 THEN intPerc1 = 0 ELSE intPerc1 = FormatPercent(RS("intCountM") / totalCount)
		IF RS("intCountW") = 0 THEN intPerc2 = 0 ELSE intPerc2 = FormatPercent(RS("intCountW") / totalCount)
		
		intGrpWidth1 = INT(490 * REPLACE(intPerc1, "%", "") / 100)
		intGrpWidth2 = INT(490 * REPLACE(intPerc2, "%", "") / 100)
%>
						<tr>
							<td class="detail"></td>
							<td class="detail"><%=RS("intAge")%><%=objXmlLang("text_age")%></td>
							<td class="rfpd num"><%=RS("intCountM")%><br><%=RS("intCountW")%></td>
							<td class="rfpd num"><%=intPerc1%><br><%=intPerc2%></td>
							<td class="lfpd">
								<div style="border:1px solid #CCC; height:12px;">
									<div style="width:<%=intGrpWidth1%>px; height:12px; background-color:#E9E9E9;"></div>
								</div>
								<div style="border:1px solid #CCC; height:12px; margin-top:3px;">
									<div style="width:<%=intGrpWidth2%>px; height:12px; background-color:#E9E9E9;"></div>
								</div>
							</td>
						</tr>
<%
		RS.MOVENEXT
		WEND
%>
						</thead>
					</table>
				</div>
<%
		NEXT
	END IF
%>	
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->