<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 5
	menuID      = "E01"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.schedule.xml"
%>
<!-- #include file = "../../libs/function.schedule.asp" -->
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intYear, intMonth, intPrevYear, intPrevMonth, intNextYear, intNextMonth, strDate

	intYear  = GetInputReplce(REQUEST.FORM("nowYear"), "")
	intMonth = GetInputReplce(REQUEST.FORM("nowMonth"), "")

	IF intYear  = "" THEN intYear  = YEAR(NOW)
	IF intMonth = "" THEN intMonth = MONTH(NOW)

	intPrevYear  = YEAR(DATEADD("m", -1, intYear & "-" & intMonth & "-1"))
	intPrevMonth = MONTH(DATEADD("m", -1, intYear & "-" & intMonth & "-1"))

	intNextYear  = YEAR(DATEADD("m", 1, intYear & "-" & intMonth & "-1"))
	intNextMonth = MONTH(DATEADD("m", 1, intYear & "-" & intMonth & "-1"))

	strDate = intYear & "-"
	IF LEN(intMonth) = 1 THEN strDate = strDate & "0"
	strDate = strDate & intMonth & "-01"

	SET RS = DBCON.EXECUTE("[ARTY30_SP_SCHEDULE_LIST] '" & strDate & "' ")

	DIM strScheduleSeq(42), strScheduleTitle(42), strScheduleStartDate(42), strScheduleEndDate(42), strScheduleIcon(42)

	FOR tmpFor = 0 TO 42
		strScheduleIcon(tmpFor) = ""
	NEXT
	
	WHILE NOT(RS.EOF)

		IF strScheduleSeq(DAY(RS("strStartDate"))) <> "" THEN
			strScheduleSeq(DAY(RS("strStartDate")))       = strScheduleSeq(DAY(RS("strStartDate")))       & "$$$"
			strScheduleTitle(DAY(RS("strStartDate")))     = strScheduleTitle(DAY(RS("strStartDate")))     & "$$$"
			strScheduleStartDate(DAY(RS("strStartDate"))) = strScheduleStartDate(DAY(RS("strStartDate"))) & "$$$"
			strScheduleEndDate(DAY(RS("strStartDate")))   = strScheduleEndDate(DAY(RS("strStartDate")))   & "$$$"
			strScheduleIcon(DAY(RS("strStartDate")))      = strScheduleIcon(DAY(RS("strStartDate")))      & "$$$"
		END IF

		strScheduleSeq(DAY(RS("strStartDate")))       = strScheduleSeq(DAY(RS("strStartDate"))) & RS("intSeq")
		strScheduleTitle(DAY(RS("strStartDate")))     = strScheduleTitle(DAY(RS("strStartDate"))) & RS("strTitle")
		strScheduleStartDate(DAY(RS("strStartDate"))) = strScheduleStartDate(DAY(RS("strStartDate"))) & RS("strStartDate")
		strScheduleEndDate(DAY(RS("strStartDate")))   = strScheduleEndDate(DAY(RS("strStartDate"))) & RS("strEndDate")
		strScheduleIcon(DAY(RS("strStartDate")))      = strScheduleIcon(DAY(RS("strStartDate"))) & RS("strIcon")

	RS.MOVENEXT
	WEND
%>
<script type="text/javascript" src="../js/Calendar.js"></script>
<script type="text/javascript" src="other/js/schedule.js"></script>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
				<div class="right_area">
					<span class="button medium icon"><span class="add"></span><button id="btn_schedule_add" type="button"><%=objXmlLang("btn_schedule_add")%></button></span>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description")%></p>
			<form id="extForm" method="post">
			<input type="hidden" id="prevYear" value="<%=intPrevYear%>">
			<input type="hidden" id="prevMonth" value="<%=intPrevMonth%>">
			<input type="hidden" id="nextYear" value="<%=intNextYear%>">
			<input type="hidden" id="nextMonth" value="<%=intNextMonth%>">
			<input type="hidden" name="nowYear" id="nowYear" value="<%=intYear%>">
			<input type="hidden" name="nowMonth" id="nowMonth" value="<%=intMonth%>">
			</form>
			<div id="subBody">
				<div>
					<div class="schedule_date">
						<ul>
							<li><a href="#" id="btn_prev_month" class="btn_prev_month"><%=objXmlLang("text_prev_month")%></a></li>
							<li class="date"><%=intYear%><%=objXmlLang("text_year")%>&nbsp;<%=intMonth%><%=objXmlLang("text_month")%></li>
							<li><a href="#" id="btn_next_month" class="btn_next_month"><%=objXmlLang("text_next_month")%></a></li>
						</ul>
					</div>
					<div class="both pt10"></div>
					<div class="both">
						<table id="schedule" class="schedule">
							<tr>
								<th class="sun"><%=objXmlLang("list_sun")%></th>
								<th><%=objXmlLang("list_mon")%></th>
								<th><%=objXmlLang("list_tue")%></th>
								<th><%=objXmlLang("list_wed")%></th>
								<th><%=objXmlLang("list_thu")%></th>
								<th><%=objXmlLang("list_fri")%></th>
								<th class="sat"><%=objXmlLang("list_sat")%></th>
							</tr>
<%
	iNowYear  = intYear
	iNowMonth = intMonth

	aCal = fn_CalMain(iNowYear,iNowMonth)

	DIM bitHoliday

	FOR I = 1 TO UBOUND(aCal, 1)
%>
							<tr>
<%
		FOR J = 1 TO UBOUND(aCal, 2)

			IF aCal(i,j) <> "" THEN
				IF fn_HolidayPrint(iNowYear,iNowMonth, aCal(i,j)) = False THEN bitHoliday = False ELSE bitHoliday = True
			ELSE
				bitHoliday = False
			END IF
%>
								<td id="<%=iNowYear%><%=iNowMonth%><%=aCal(i,j)%>">
									<div class="date<% IF aCal(i,j) <> "" THEN %> schedule_day hand<% END IF %>" id="<%=iNowYear%>.<%=iNowMonth%>.<%=aCal(i,j)%>">
										<span id="schedule_day" class="fl num<% IF bitHoliday = True THEN %> sun<% END IF %>"><%=aCal(i,j)%></span>
										<span class="fr<% IF bitHoliday = True THEN %> holiday<% END IF %>" style="font-size:11px; line-height:18px;"><% IF bitHoliday = True THEN %><%=fn_HolidayPrint( iNowYear,iNowMonth, aCal(i,j)  )%><% END IF %></span>
<% IF aCal(i,j) = 5 OR aCal(i,j) = 15 OR aCal(i,j) = 25 THEN %>
										<span class="fr num mr5">-<%=INT(MID(getLunar(iNowYear, iNowMonth, aCal(i,j)), 6, 2))%>.<%=INT(RIGHT(getLunar(iNowYear, iNowMonth, aCal(i,j)), 2))%></span>
<% END IF %>
									</div>
<%
	IF aCal(i,j) <> "" THEN
		IF strScheduleTitle(aCal(i,j)) <> "" THEN
			FOR tmpFor = 0 TO UBOUND(SPLIT(strScheduleTitle(aCal(i,j)), "$$$"))
%>
									<div class="title">
									<% IF strScheduleIcon(aCal(i,j)) <> "" THEN %><% IF SPLIT(strScheduleIcon(aCal(i,j)), "$$$")(tmpFor) <> "" THEN %><span><img src="images/blank.gif" class="schedule_icon_blank schedule_<%=SPLIT(strScheduleIcon(aCal(i,j)), "$$$")(tmpFor)%>" style="width:11px; height:11px;"></span><% END IF %><% END IF %>
									<span><a href="#" name="schedule_user" id="<%=SPLIT(strScheduleSeq(aCal(i,j)), "$$$")(tmpFor)%>" onClick="return false;" title="<%=SPLIT(strScheduleTitle(aCal(i,j)), "$$$")(tmpFor)%> (<%=SPLIT(strScheduleStartDate(aCal(i,j)), "$$$")(tmpFor)%>~<%=SPLIT(strScheduleEndDate(aCal(i,j)), "$$$")(tmpFor)%>)"><%=SPLIT(strScheduleTitle(aCal(i,j)), "$$$")(tmpFor)%></a></span>
									</div>
<%
			NEXT
		END IF
	END IF
%>
								</td>
<%
		IF J = ubound(aCal,2) THEN
%>
							</tr>
<%
		END IF
%>
<%
		NEXT
	NEXT
%>
						</table>
					</div>
				</div>
			</div>
		</div>
		<form id="theForm" method="post">
		<input type="hidden" id="strAct" name="strAct">
		<input type="hidden" id="intSeq" name="intSeq">
		<input type="hidden" id="strIcon" name="strIcon">
		<div id="schedule_input">
			<div class="header">
				<div class="wrap">
					<h1>
						<label><%=objXmlLang("text_schedule_input")%></label>
						<a id="btn_close" href="javascript:;" class="btnClose"><%=objXmlLang("btn_close")%></a>
					</h1>
				</div>
			</div>
			<div class="popContent">
			<table class="dcalPopForm">
				<tbody>
				<tr>
					<th nowrap><label><%=objXmllang("text_date")%></label></th>
					<td>
						<ul>
							<li><input name="strStartDate" type="text" id="strStartDate" value="<%=strStartDate%>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, 'strStartDate')" /></li>
							<li>
							<select name="strStartHour" id="strStartHour">
								<option value=""><%=objXmlLang("text_hour")%></option>
<% FOR tmpFor = 0 TO 23 %>
								<option value="<%=tmpFor%>"><%=tmpFor%><%=objXmlLang("text_hour")%></option>
<% NEXT %>
							</select>
							</li>
							<li>
								<select name="strStartMinute" id="strStartMinute">
									<option value=""><%=objXmlLang("text_minute")%></option>
<% FOR tmpFor = 0 TO 59 %>
								<option value="<%=tmpFor%>"><%=tmpFor%><%=objXmlLang("text_minute")%></option>
<% NEXT %>
								</select>
							</li>
							<li>~</li>
							<li><input name="strEndDate" type="text" id="strEndDate" value="<%=strEndDate%>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, 'strEndDate')" /></li>
							<li>
								<select name="strEndHour" id="strEndHour">
									<option value=""><%=objXmlLang("text_hour")%></option>
<% FOR tmpFor = 0 TO 23 %>
								<option value="<%=tmpFor%>"><%=tmpFor%><%=objXmlLang("text_hour")%></option>
<% NEXT %>
								</select>
							</li>
							<li>
							<select name="strEndMinute" id="strEndMinute">
								<option value=""><%=objXmlLang("text_minute")%></option>
<% FOR tmpFor = 0 TO 59 %>
								<option value="<%=tmpFor%>"><%=tmpFor%><%=objXmlLang("text_minute")%></option>
<% NEXT %>
							</select>
							</li>
						</ul>
						<p id="repeat"><input type="checkbox" id="bitRepeat" name="bitRepeat" value="1"><label for="bitRepeat" class="hand"><%=objXmlLang("text_repeat")%></label></p>
					</td>
				</tr>
				<tr class="blank">
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<th nowrap><label><%=objXmllang("text_title")%></label></th>
					<td class="titleForm" nowrap>
						<div id="btn_icon_select" class="icon_select_off"><a id="set_icon">ICON</a></div>
						<div class="fl"><input type="text" name="strTitle" id="strTitle" maxlength="80" style="width:410px;" class="inputText" /></div>
						<div id="icon_list">
							<ul>
								<li><a href="#" class="schedule_icon schedule_icon01" onClick="icon_select('schedule_icon01');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon02" onClick="icon_select('schedule_icon02');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon03" onClick="icon_select('schedule_icon03');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon04" onClick="icon_select('schedule_icon04');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon05" onClick="icon_select('schedule_icon05');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon06" onClick="icon_select('schedule_icon06');return false;">icon</a></li>
								<li class="last"><a href="#" class="schedule_icon schedule_icon07" onClick="icon_select('schedule_icon07');return false;">icon</a></li>
							</ul>
							<ul>
								<li><a href="#" class="schedule_icon schedule_icon08" onClick="icon_select('schedule_icon08');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon09" onClick="icon_select('schedule_icon09');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon10" onClick="icon_select('schedule_icon10');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon11" onClick="icon_select('schedule_icon11');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon12" onClick="icon_select('schedule_icon12');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon13" onClick="icon_select('schedule_icon13');return false;">icon</a></li>
								<li class="last"><a href="#" class="schedule_icon schedule_icon14" onClick="icon_select('schedule_icon14');return false;">icon</a></li>
							</ul>
							<ul>
								<li><a href="#" class="schedule_icon schedule_icon15" onClick="icon_select('schedule_icon15');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon16" onClick="icon_select('schedule_icon16');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon17" onClick="icon_select('schedule_icon17');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon18" onClick="icon_select('schedule_icon18');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon19" onClick="icon_select('schedule_icon19');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon20" onClick="icon_select('schedule_icon20');return false;">icon</a></li>
								<li class="last"><a href="#" class="schedule_icon schedule_icon21" onClick="icon_select('schedule_icon21');return false;">icon</a></li>
							</ul>
							<ul>
								<li><a href="#" class="schedule_icon schedule_icon22" onClick="icon_select('schedule_icon22');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon23" onClick="icon_select('schedule_icon23');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon24" onClick="icon_select('schedule_icon24');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon25" onClick="icon_select('schedule_icon25');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon26" onClick="icon_select('schedule_icon26');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon27" onClick="icon_select('schedule_icon27');return false;">icon</a></li>
								<li class="last"><a href="#" class="schedule_icon schedule_icon28" onClick="icon_select('schedule_icon28');return false;">icon</a></li>
							</ul>
							<ul>
								<li><a href="#" class="schedule_icon schedule_icon29" onClick="icon_select('schedule_icon29');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon30" onClick="icon_select('schedule_icon30');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon31" onClick="icon_select('schedule_icon31');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon32" onClick="icon_select('schedule_icon32');return false;">icon</a></li>
								<li><a href="#" class="schedule_icon schedule_icon33" onClick="icon_select('schedule_icon33');return false;">icon</a></li>
							</ul>
						</div>
					</td>
				</tr>
				<tr class="blank">
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<th nowrap><label><%=objXmllang("text_content")%></label></th>
					<td class="titleForm" nowrap>
						<textarea name="strContent" id="strContent" cols="45" rows="5" style="width:460px;" class="textarea"></textarea></td>
				</tr>
				<tr class="blank">
					<td colspan="2">&nbsp;</td>
				</tr>
				</tbody>
				</table>
				<div class="buttonArea mt10">
					<span class="button medium strong"><input type="button" id="btn_save" value="<%=objXmlLang("btn_save")%>"></span>
					<span class="button medium" id="btn_remove_area"><input type="button" id="btn_remove" value="<%=objXmlLang("btn_remove")%>"></span>
					<span class="button medium"><input type="button" id="btn_cancel" value="<%=objXmlLang("btn_cancel")%>"></span>
				</div>
			</div>
			<div class="footer"><div class="wrap"><div class="back"></div></div></div>
		</div>
		</form>
<!-- #include file = "../comm/sub.foot.asp" -->