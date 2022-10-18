<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 6
	menuID      = "F01"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.stat.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intYear, intMonth, strDateType, strDate

	WITH REQUEST

		intYear     = GetInputReplce(.FORM("year"), "")
		intMonth    = GetInputReplce(.FORM("month"), "")
		strDateType = GetInputReplce(.FORM("dateType"), "")

	END WITH

	IF intYear  = "" THEN intYear  = YEAR(NOW)
	IF intMonth = "" THEN intMonth = MONTH(NOW)
	IF LEN(intMonth) = 1 THEN intMonth = "0" & intMonth
	IF strDateType = "" THEN strDateType = "1"

	strDate = intYear & "-" & intMonth & "-01"

	intPrevYear  =  YEAR(DATEADD("y", -1, strDate))
	intPrevMonth = MONTH(DATEADD("m", -1, strDate))
	intNextYear  =  YEAR(DATEADD("m",  1, strDate))
	intNextMonth = MONTH(DATEADD("m",  1, strDate))

	DIM intTotalCount, intMonthCount

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_DATE] 'T', '" & strDate & "' ")
	intTotalCount = RS(0)

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_DATE] 'M', '" & strDate & "' ")
	intMonthCount = RS(0)
%>
<script type="text/javascript" src="stat/js/stat.member.join.date.js"></script>
		<div id="content">
			<form id="theForm" method="post" action="?act=statmemberjoindate">
			<input type="hidden" id="intPrevYear" value="<%=intPrevYear%>">
			<input type="hidden" id="intPrevMonth" value="<%=intPrevMonth%>">
			<input type="hidden" id="intNextYear" value="<%=intNextYear%>">
			<input type="hidden" id="intNextMonth" value="<%=intNextMonth%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_join_date")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_join_date")%></p>
			<div class="deatil_search_area">
				<div class="detail_box2">
					<ul>
						<li><%=objXmlLang("text_search_type")%> : </li>
						<li>
							<select name="year" id="year">
							<%=GetMakeDateSelectForm("", intYear, YEAR(NOW), YEAR(NOW) - 5, "-1", objXmlLang("text_year"))%>
							</select>						
						</li>
						<li>
							<select name="month" id="month">
							<%=GetMakeDateSelectForm("", intMonth, 1, 12, "1", objXmlLang("text_month"))%>
							</select>						
						</li>
						<li>
							<select name="dateType" id="dateType">
							<%=GetMakeSelectForm(objXmlLang("option_date_type"), ",", strDateType, "")%>
							</select>
						</li>
						<li>
							<span class="button medium"><input type="button" id="btn_prev_month" value="<%=objXmlLang("btn_prev_month")%>"></span>
						</li>
						<li>
							<span class="button medium"><input type="button" id="btn_next_month" value="<%=objXmlLang("btn_next_month")%>"></span>
						</li>
						<li>
							<span class="button medium"><input type="button" id="btn_search" value="<%=objXmlLang("btn_search")%>"></span>
						</li>
					</ul>
				</div>
			</div>
			<div id="subBody">
				<div class="list_info">
					<div class="left">
						<%=objXmlLang("text_total_member")%> : <b class="point u"><%=GetMoneyComma(intTotalCount)%></b> / <%=intYear%><%=objXmlLang("text_year")%>&nbsp;<%=intMonth%><%=objXmlLang("text_month")%>&nbsp;<%=objXmlLang("text_join_member_count")%> : <b class="point u"><%=GetMoneyComma(intMonthCount)%>&nbsp;</b>
						</ul>
					</div>
				</div>
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="100" /><col width="100" /><col width="100" /><col />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th><%=objXmlLang("list_date")%></th>
							<th class="bar"><%=objXmlLang("list_join_count")%></th>
							<th class="bar"><%=objXmlLang("list_percent")%></th>
							<th class="lineR bar"><%=objXmlLang("list_graph")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_STAT_DATE] '" & strDateType & "', '" & strDate & "' ")

	DIM intPerc, intGrpWidth, strDispDate

	intMaxCount = RS(1)

	RS.MOVENEXT
	WHILE NOT(RS.EOF)

		IF RS(1) = 0 THEN intPerc = 0 ELSE intPerc = FormatPercent(RS(1)/intMonthCount)
		intGrpWidth = RS(1) / intMaxCount * 100

		IF strDateType = "1" THEN
			strDispDate = RS(0) & "&nbsp;" & objXmlLang("text_day")
		ELSEIF strDateType = "2" THEN
			SELECT CASE RS(0)
			CASE "1" : strDispDate = objXmlLang("text_day_1")
			CASE "2" : strDispDate = objXmlLang("text_day_2")
			CASE "3" : strDispDate = objXmlLang("text_day_3")
			CASE "4" : strDispDate = objXmlLang("text_day_4")
			CASE "5" : strDispDate = objXmlLang("text_day_5")
			CASE "6" : strDispDate = objXmlLang("text_day_6")
			CASE "7" : strDispDate = objXmlLang("text_day_7")
			END SELECT
		ELSE
			strDispDate = RS(0) & "&nbsp;" & objXmlLang("text_hour")
		END IF
%>
						<tr>
							<td class="detail"></td>
							<td class="detail"><%=strDispDate%></td>
							<td class="detail num"><%=GetMoneyComma(RS(1))%></td>
							<td class="detail num"><%=intPerc%></td>
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
				</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->