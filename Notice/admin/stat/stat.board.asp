<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 6
	menuID      = "F07"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.stat.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intBoardSrl, strStatType, strDateType, intYear, intMonth, intDat

	WITH REQUEST

		intBoardSrl = GetInputReplce(.FORM("boardSrl"), "")
		strStatType = GetInputReplce(.FORM("statType"), "")
		strDateType = GetInputReplce(.FORM("dateType"), "")
		intYear     = GetInputReplce(.FORM("year"), "")
		intMonth    = GetInputReplce(.FORM("month"), "")
		intDay      = GetInputReplce(.FORM("day"), "")

	END WITH

	IF strStatType = "" THEN strStatType = "1"
	IF strDateType = "" THEN strDateType = "1"

	DIM intTotalCount

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_STAT] '" & intBoardSrl & "', '" & strStatType & "', '" & strDateType & "', 'Y', '" & intYear & "', '" & intMonth & "', '" & intDay & "' ")

	intTotalCount = RS(0)
%>
<script type="text/javascript" src="stat/js/stat.board.js"></script>
		<div id="content">
			<form id="theForm" method="post" action="?act=statboard">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_board")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_board")%></p>
			<div class="deatil_search_area">
				<div class="detail_box2">
					<ul>
						<li>
							<select name="boardSrl" id="boardSrl">
							<%=GetMakeSelectForm(objXmlLang("option_board"), ",", intBoardSrl, "")%>
<%
	SET RS = DBCON.EXECUTE("ARTY30_SP_BOARD_CONFIG_LIST 'L', '', '', '' ")

	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "<option value=""" & RS("intSrl") & """"
		IF intBoardSrl <> "" THEN
			IF INT(intBoardSrl) = RS("intSrl") THEN RESPONSE.WRITE " selected"
		END IF
		RESPONSE.WRITE ">" & RS("strTitle") & "</option>" & CHR(10)
	RS.MOVENEXT
	WEND
%>
							</select>
						</li>
						<li>
							<select name="statType" id="statType">
							<%=GetMakeSelectForm(objXmlLang("option_board_stat_type"), ",", strStatType, "")%>
							</select>
						</li>
						<li>
							<select name="dateType" id="dateType">
							<%=GetMakeSelectForm(objXmlLang("option_board_date_type"), ",", strDateType, "")%>
							</select>
						</li>
						<li>
						<select name="year" id="year">
						<%=GetMakeSelectForm(objXmlLang("option_year"), ",", "", "")%>
						<%=GetMakeDateSelectForm("", intYear, YEAR(NOW), YEAR(NOW) - 5, "-1", objXmlLang("text_year"))%>
						</select>
						</li>
						<li>
						<select name="month" id="month">
						<%=GetMakeSelectForm(objXmlLang("option_month"), ",", "", "")%>
						<%=GetMakeDateSelectForm("", intMonth, 1, 12, "1", objXmlLang("text_month"))%>
						</select>
						</li>
						<li>
						<select name="day" id="day">
						<%=GetMakeSelectForm(objXmlLang("option_day"), ",", "", "")%>
						<%=GetMakeDateSelectForm("", intDay, 1, 31, "1", objXmlLang("text_day"))%>
						</select>
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
						<p><%=objXmlLang("text_total")%> <span id="totalNum"><%=GetMoneyComma(intTotalCount)%></span></p>
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
							<th class="bar"><%=objXmlLang("list_count")%></th>
							<th class="bar"><%=objXmlLang("list_percent")%></th>
							<th class="lineR bar"><%=objXmlLang("list_graph")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_STAT] '" & intBoardSrl & "', '" & strStatType & "', '" & strDateType & "', 'N', '" & intYear & "', '" & intMonth & "', '" & intDay & "' ")
	
	DIM intPerc, intGrpWidth, strDispDate

	WHILE NOT(RS.EOF)

		SELECT CASE strDateType
		CASE "1" : strDispDate = RS(0) & objXmlLang("text_year")
		CASE "2" : strDispDate = RS(0) & objXmlLang("text_month")
		CASE "3" : strDispDate = RS(0) & objXmlLang("text_day")
		CASE "4"
			strDispDate = objXmlLang("text_day_" & RS(0))
		CASE "5" : strDispDate = RS(0) & objXmlLang("text_hour")
		END SELECT

		IF RS("intCount") = 0 THEN intPerc = 0 ELSE intPerc = FormatPercent(RS("intCount") / intTotalCount)
		intGrpWidth = INT(490 * REPLACE(intPerc, "%", "") / 100)
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