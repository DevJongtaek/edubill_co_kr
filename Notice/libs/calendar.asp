<html>
</head>
<style type="text/css"> 
* { margin:0; padding:0;}
h1, hr {display:none;}
h1 {font:normal 26px "바탕", Batang, "명조", Myeongjo, AppleMyeongjo, serif;}
hr {margin:20px 0;}
img {border:none;}
a:link, a:visited, a:hover, a:active{text-decoration:none;}
.layerpopup {position:absolute; z-index:100; }
.layerpopup .shadow1 {width:100%; background:url(../images/calendar/shadow.png);}
*:first-child+html .layerpopup .shadow1 {background:none; filter:progid:dximagetransform.microsoft.alphaimageloader(src='../images/calendar/shadow.png', sizingmethod='scale');}
* html .layerpopup .shadow1 {background:none; filter:progid:dximagetransform.microsoft.alphaimageloader(src='../images/calendar/shadow.png', sizingmethod='scale');}
.layerpopup .shadow1_side {position:relative; left:-3px; top:-3px}
.layerpopup .shadow2 {width:100%; background: url(../images/calendar/shadow02.png);}
*:first-child+html .layerpopup .shadow2 {background:none; filter:progid:dximagetransform.microsoft.alphaimageloader(src='../images/calendar/shadow02.png', sizingmethod='scale');}
* html .layerpopup .shadow2 {background:none; filter:progid:dximagetransform.microsoft.alphaimageloader(src='../images/calendar/shadow02.png', sizingmethod='scale');}
.layerpopup .shadow2_side {position:relative; left:-1px; top:-1px}
.layerpopup .border_type {padding:9px 0 5px 0;border:2px solid #777777; background-color:#ffffff; text-align:center;}
.layerpopup .closelayer {position:absolute; right:9px; top:9px;}

.calendar_simple {margin:0 auto; border:0px;}
.calendar_simple caption {margin:0 auto; padding:0 0 8px 3px; color:#000000; font:bold 11px 돋움,dotum; text-align:left;}
.calendar_simple caption strong {margin:0 5px;}
*:first-child+html .calendar_simple caption strong {margin:0;}
* html .calendar_simple caption strong {margin:0;}
.calendar_simple tr {border:none;}
.calendar_simple th {width:21px; height:19px; border:none; color:#000000; font:normal 11px 돋움,dotum;}
.calendar_simple td {width:21px; height:19px; border:none; font:11px tahoma; text-align:center;}
.calendar_simple td a {color:#c30;}
.calendar_simple td a em {color:#000000; font-style:normal;}
.calendar_simple td a strong {color:#ED432A; font-weight:bold; text-decoration:underline;}
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--
	function doOver() {
		var el = event.srcElement;
		cal_Day = el.title;

		if (cal_Day.length > 7) {
			el.style.borderTopColor = el.style.borderLeftColor = "buttonhighlight";
			el.style.borderRightColor = el.style.borderBottomColor = "buttonshadow";
		}
	}

	function doOut() {
		var el = event.srcElement;
		cal_Day = el.title;

		if (cal_Day.length > 7) {
			el.style.borderColor = "white";
		}
	}

	function day2(d) {																// 2자리 숫자료 변경
		var str = new String();
		
		if (parseInt(d) < 10) {
			str = "0" + parseInt(d);
		} else {
			str = "" + parseInt(d);
		}
		return str;
	}

	function Show_cal(sYear, sMonth, sDay) {
		var Months_day = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31)
		//var Weekday_name = new Array("일", "월", "화", "수", "목", "금", "토");
		var intThisYear = new Number(), intThisMonth = new Number(), intThisDay = new Number();
		document.all.cal.innerHTML = "";
		datToday = new Date();													// 현재 날자 설정
		
		intThisYear = parseInt(sYear);
		intThisMonth = parseInt(sMonth);
		intThisDay = parseInt(sDay);
		
		if (intThisYear == 0) intThisYear = datToday.getFullYear();				// 값이 없을 경우
		if (intThisMonth == 0) intThisMonth = parseInt(datToday.getMonth())+1;	// 월 값은 실제값 보다 -1 한 값이 돼돌려 진다.
		if (intThisDay == 0) intThisDay = datToday.getDate();
		
		switch(intThisMonth) {
			case 1:
					intPrevYear = intThisYear -1;
					intPrevMonth = 12;
					intNextYear = intThisYear;
					intNextMonth = 2;
					break;
			case 12:
					intPrevYear = intThisYear;
					intPrevMonth = 11;
					intNextYear = intThisYear + 1;
					intNextMonth = 1;
					break;
			default:
					intPrevYear = intThisYear;
					intPrevMonth = parseInt(intThisMonth) - 1;
					intNextYear = intThisYear;
					intNextMonth = parseInt(intThisMonth) + 1;
					break;
		}

		intPPyear = intThisYear-1
		intNNyear = intThisYear+1

		NowThisYear = datToday.getFullYear();										// 현재 년
		NowThisMonth = datToday.getMonth()+1;										// 현재 월
		NowThisDay = datToday.getDate();											// 현재 일
		
		datFirstDay = new Date(intThisYear, intThisMonth-1, 1);						// 현재 달의 1일로 날자 객체 생성(월은 0부터 11까지의 정수(1월부터 12월))
		intFirstWeekday = datFirstDay.getDay();										// 현재 달 1일의 요일을 구함 (0:일요일, 1:월요일)
		
		intSecondWeekday = intFirstWeekday;
		intThirdWeekday = intFirstWeekday;
		
		datThisDay = new Date(intThisYear, intThisMonth, intThisDay);				// 넘어온 값의 날자 생성
		intThisWeekday = datThisDay.getDay();										// 넘어온 날자의 주 요일

		//varThisWeekday = Weekday_name[intThisWeekday];								// 현재 요일 저장
		
		intPrintDay = 1;																// 달의 시작 일자
		secondPrintDay = 1;
		thirdPrintDay = 1;

		Stop_Flag = 0
		
		if ((intThisYear % 4)==0) {													// 4년마다 1번이면 (사로나누어 떨어지면)
			if ((intThisYear % 100) == 0) {
				if ((intThisYear % 400) == 0) {
					Months_day[2] = 29;
				}
			} else {
				Months_day[2] = 29;
			}
		}
		intLastDay = Months_day[intThisMonth];										// 마지막 일자 구함

		Cal_HTML = "<div class=\"layerpopup\" style=\"width:175px; left:10px; top:10px;\">";
		Cal_HTML += "<div class=\"shadow1\">";
		Cal_HTML += "<div class=\"shadow1_side\">";
		Cal_HTML += "<div class=\"shadow2\">";
		Cal_HTML += "<div class=\"shadow2_side\">";
		Cal_HTML += "	<div class=\"border_type\">";
		Cal_HTML += "		<a class=\"closelayer\" onclick=\"parent.Calendar_Out();\" style=\"cursor:hand\"><img src=\"../images/calendar/btn_close.gif\" width=\"15\" height=\"14\"></a>";
		Cal_HTML += "		<table id=\"Cal_Table\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" class=\"calendar_simple\">";
		Cal_HTML += "		<caption>";
		Cal_HTML += "			<a style='cursor:hand;' OnClick='Show_cal("+intPrevYear+","+intPrevMonth+","+intThisDay+");'><img src=\"../images/calendar/ico_prev_ca.gif\" width=\"6\" height=\"7\" alt=\"prev Month\"></a>";
		Cal_HTML += "			<strong>" + intThisYear +". "+ intThisMonth +".</strong>";
		Cal_HTML += "			<a style='cursor:hand;' OnClick='Show_cal("+intNextYear+","+intNextMonth+","+intThisDay+");'><img src=\"../images/calendar/ico_next_ca.gif\" width=\"6\" height=\"7\" alt=\"next Month\"></a>";
		Cal_HTML += "&nbsp;<select name=\"select\" id=\"select\" style=\"font-size:11px;\" OnChange='Show_cal(this.value,"+intThisMonth+","+intThisDay+");'>";

		for(var i = 1900; i <= NowThisYear; i++){
			Cal_HTML += "<option value=\"" + i + "\"";
			if (i == intThisYear)
				Cal_HTML += " selected";
			Cal_HTML += ">" + i + "</option>";
		}

		Cal_HTML += "</select>";
		Cal_HTML += "		</caption>";
		Cal_HTML += "		<thead>";
		Cal_HTML += "		<tr>";
		Cal_HTML += "		<th scope=\"col\">Su</th>";
		Cal_HTML += "		<th scope=\"col\">Mo</th>";
		Cal_HTML += "		<th scope=\"col\">Tu</th>";
		Cal_HTML += "		<th scope=\"col\">We</th>";
		Cal_HTML += "		<th scope=\"col\">Th</th>";
		Cal_HTML += "		<th scope=\"col\">Fr</th>";
		Cal_HTML += "		<th scope=\"col\">Sa</th>";
		Cal_HTML += "		</tr>";
		Cal_HTML += "		</thead>";
		Cal_HTML += "		<tbody>";

		for (intLoopWeek=1; intLoopWeek < 7; intLoopWeek++) {						// 주단위 루프 시작, 최대 6주
			Cal_HTML += "<tr>"
			for (intLoopDay=1; intLoopDay <= 7; intLoopDay++) {						// 요일단위 루프 시작, 일요일 부터
				if (intThirdWeekday > 0) {											// 첫주 시작일이 1보다 크면
					Cal_HTML += "<td>";
					intThirdWeekday--;
				} else {
					if (thirdPrintDay > intLastDay) {								// 입력 날짝 월말보다 크다면
						Cal_HTML += "<td>";
					} else {														// 입력날짜가 현재월에 해당 되면
						Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"."+day2(intThisMonth).toString()+"."+day2(thirdPrintDay).toString()+" style=\"cursor:Hand;border:1px solid white;\"><a href=\"#\">";

						if (intThisYear == NowThisYear && intThisMonth==NowThisMonth && thirdPrintDay==intThisDay) {
							Cal_HTML += "<strong>";
						}else{
							switch(intLoopDay) {
								case 1:													// 일요일이면 빨간 색으로
	//								Cal_HTML += "color:red;"
									break;
								//case 7:
								//	Cal_HTML += "color:blue;"
								//	break;
								default:
									Cal_HTML += "<em>";
									break;
							}
						}
					
						Cal_HTML += thirdPrintDay;
						if (intThisYear == NowThisYear && intThisMonth==NowThisMonth && thirdPrintDay==intThisDay) {
							Cal_HTML += "</strong>";
						}else{
							switch(intLoopDay) {
								case 1:													// 일요일이면 빨간 색으로
	//								Cal_HTML += "color:red;"
									break;
								//case 7:
								//	Cal_HTML += "color:blue;"
								//	break;
								default:
									Cal_HTML += "</em>";
									break;
							}
						}
						
					}
					thirdPrintDay++;
					
					if (thirdPrintDay > intLastDay) {								// 만약 날짜 값이 월말 값보다 크면 루프문 탈출
						Stop_Flag = 1;
					}
				}
				Cal_HTML += "</a></td>";
			}
			Cal_HTML += "</tr>";
			if (Stop_Flag==1) break;
		}
		Cal_HTML += "</table>";
		Cal_HTML += "		</tbody>";
		Cal_HTML += "		</table>";
		Cal_HTML += "	</div>";
		Cal_HTML += "</div>";
		Cal_HTML += "</div>";
		Cal_HTML += "</div>";
		Cal_HTML += "</div>";
		Cal_HTML += "</div>";

		document.all.cal.innerHTML = Cal_HTML;


		// 달력 출력이 완료되면 iframe의 크기를 재조정한다.
		var Cal_Table = document.all.Cal_Table;
		window.resizeTo(185, Cal_Table.offsetHeight + 28);
	}

	function Show_cal_M(sYear, sMonth) {
		//var Weekday_name = new Array("일", "월", "화", "수", "목", "금", "토");
		var intThisYear = new Number(), intThisMonth = new Number()
		document.all.cal.innerHTML = "";
		
		intThisYear = parseInt(sYear);
		intThisMonth = parseInt(sMonth);
		
		if (intThisYear == 0) intThisYear = datToday.getFullYear();				// 값이 없을 경우
		if (intThisMonth == 0) intThisMonth = parseInt(datToday.getMonth())+1;	// 월 값은 실제값 보다 -1 한 값이 돼돌려 진다.
				
		switch(intThisMonth) {
			case 1:
					intPrevYear = intThisYear -1;
					intNextYear = intThisYear;
					break;
			case 12:
					intPrevYear = intThisYear;
					intNextYear = intThisYear + 1;
					break;
			default:
					intPrevYear = intThisYear;
					intNextYear = intThisYear;
					break;
		}
		intPPyear = intThisYear-1
		intNNyear = intThisYear+1

		Stop_Flag = 0

		Cal_HTML = "<table id=Cal_Table border=0 bgcolor='#f4f4f4' cellpadding=1 cellspacing=1 width=100% onmouseover='doOver()' onmouseout='doOut()' style='font-size : 12;font-family:굴림;'>";
		Cal_HTML += "<tr align=center bgcolor='#f4f4f4'>";
		Cal_HTML += "<td colspan=4 align=center>";
		Cal_HTML += "<a style='cursor:hand;' OnClick='Show_cal_M("+intPPyear+","+intThisMonth+");'>◀</a>&nbsp;&nbsp;";
		Cal_HTML += intThisYear +"년";
		Cal_HTML += "&nbsp;&nbsp;<a style='cursor:hand;' OnClick='Show_cal_M("+intNNyear+","+intThisMonth+");'>▶</a>";
		Cal_HTML += "</td></tr>";
		Cal_HTML += "<tr align=center bgcolor=white>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-01"+" style=\"cursor:Hand;\">1월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-02"+" style=\"cursor:Hand;\">2월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-03"+" style=\"cursor:Hand;\">3월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-04"+" style=\"cursor:Hand;\">4월</td>";
		Cal_HTML += "</tr>";
		Cal_HTML += "<tr align=center bgcolor=white>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-05"+" style=\"cursor:Hand;\">5월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-06"+" style=\"cursor:Hand;\">6월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-07"+" style=\"cursor:Hand;\">7월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-08"+" style=\"cursor:Hand;\">8월</td>";
		Cal_HTML += "</tr>";
		Cal_HTML += "<tr align=center bgcolor=white>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-09"+" style=\"cursor:Hand;\">9월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-10"+" style=\"cursor:Hand;\">10월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-11"+" style=\"cursor:Hand;\">11월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-12"+" style=\"cursor:Hand;\">12월</td>";
		Cal_HTML += "</tr>";
		Cal_HTML += "</table>";

		document.all.cal.innerHTML = Cal_HTML;

		// 달력 출력이 완료되면 iframe의 크기를 재조정한다.
		var Cal_Table = document.all.Cal_Table;
		window.resizeTo(158, Cal_Table.offsetHeight);
	}
//-->
</SCRIPT>
</head>
<body style="margin:2">
	<div id="cal"></div>		
</body>
</html>