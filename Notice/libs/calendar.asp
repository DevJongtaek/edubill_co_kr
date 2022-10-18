<html>
</head>
<style type="text/css"> 
* { margin:0; padding:0;}
h1, hr {display:none;}
h1 {font:normal 26px "����", Batang, "����", Myeongjo, AppleMyeongjo, serif;}
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
.calendar_simple caption {margin:0 auto; padding:0 0 8px 3px; color:#000000; font:bold 11px ����,dotum; text-align:left;}
.calendar_simple caption strong {margin:0 5px;}
*:first-child+html .calendar_simple caption strong {margin:0;}
* html .calendar_simple caption strong {margin:0;}
.calendar_simple tr {border:none;}
.calendar_simple th {width:21px; height:19px; border:none; color:#000000; font:normal 11px ����,dotum;}
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

	function day2(d) {																// 2�ڸ� ���ڷ� ����
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
		//var Weekday_name = new Array("��", "��", "ȭ", "��", "��", "��", "��");
		var intThisYear = new Number(), intThisMonth = new Number(), intThisDay = new Number();
		document.all.cal.innerHTML = "";
		datToday = new Date();													// ���� ���� ����
		
		intThisYear = parseInt(sYear);
		intThisMonth = parseInt(sMonth);
		intThisDay = parseInt(sDay);
		
		if (intThisYear == 0) intThisYear = datToday.getFullYear();				// ���� ���� ���
		if (intThisMonth == 0) intThisMonth = parseInt(datToday.getMonth())+1;	// �� ���� ������ ���� -1 �� ���� �ŵ��� ����.
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

		NowThisYear = datToday.getFullYear();										// ���� ��
		NowThisMonth = datToday.getMonth()+1;										// ���� ��
		NowThisDay = datToday.getDate();											// ���� ��
		
		datFirstDay = new Date(intThisYear, intThisMonth-1, 1);						// ���� ���� 1�Ϸ� ���� ��ü ����(���� 0���� 11������ ����(1������ 12��))
		intFirstWeekday = datFirstDay.getDay();										// ���� �� 1���� ������ ���� (0:�Ͽ���, 1:������)
		
		intSecondWeekday = intFirstWeekday;
		intThirdWeekday = intFirstWeekday;
		
		datThisDay = new Date(intThisYear, intThisMonth, intThisDay);				// �Ѿ�� ���� ���� ����
		intThisWeekday = datThisDay.getDay();										// �Ѿ�� ������ �� ����

		//varThisWeekday = Weekday_name[intThisWeekday];								// ���� ���� ����
		
		intPrintDay = 1;																// ���� ���� ����
		secondPrintDay = 1;
		thirdPrintDay = 1;

		Stop_Flag = 0
		
		if ((intThisYear % 4)==0) {													// 4�⸶�� 1���̸� (��γ����� ��������)
			if ((intThisYear % 100) == 0) {
				if ((intThisYear % 400) == 0) {
					Months_day[2] = 29;
				}
			} else {
				Months_day[2] = 29;
			}
		}
		intLastDay = Months_day[intThisMonth];										// ������ ���� ����

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

		for (intLoopWeek=1; intLoopWeek < 7; intLoopWeek++) {						// �ִ��� ���� ����, �ִ� 6��
			Cal_HTML += "<tr>"
			for (intLoopDay=1; intLoopDay <= 7; intLoopDay++) {						// ���ϴ��� ���� ����, �Ͽ��� ����
				if (intThirdWeekday > 0) {											// ù�� �������� 1���� ũ��
					Cal_HTML += "<td>";
					intThirdWeekday--;
				} else {
					if (thirdPrintDay > intLastDay) {								// �Է� ��¦ �������� ũ�ٸ�
						Cal_HTML += "<td>";
					} else {														// �Է³�¥�� ������� �ش� �Ǹ�
						Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"."+day2(intThisMonth).toString()+"."+day2(thirdPrintDay).toString()+" style=\"cursor:Hand;border:1px solid white;\"><a href=\"#\">";

						if (intThisYear == NowThisYear && intThisMonth==NowThisMonth && thirdPrintDay==intThisDay) {
							Cal_HTML += "<strong>";
						}else{
							switch(intLoopDay) {
								case 1:													// �Ͽ����̸� ���� ������
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
								case 1:													// �Ͽ����̸� ���� ������
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
					
					if (thirdPrintDay > intLastDay) {								// ���� ��¥ ���� ���� ������ ũ�� ������ Ż��
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


		// �޷� ����� �Ϸ�Ǹ� iframe�� ũ�⸦ �������Ѵ�.
		var Cal_Table = document.all.Cal_Table;
		window.resizeTo(185, Cal_Table.offsetHeight + 28);
	}

	function Show_cal_M(sYear, sMonth) {
		//var Weekday_name = new Array("��", "��", "ȭ", "��", "��", "��", "��");
		var intThisYear = new Number(), intThisMonth = new Number()
		document.all.cal.innerHTML = "";
		
		intThisYear = parseInt(sYear);
		intThisMonth = parseInt(sMonth);
		
		if (intThisYear == 0) intThisYear = datToday.getFullYear();				// ���� ���� ���
		if (intThisMonth == 0) intThisMonth = parseInt(datToday.getMonth())+1;	// �� ���� ������ ���� -1 �� ���� �ŵ��� ����.
				
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

		Cal_HTML = "<table id=Cal_Table border=0 bgcolor='#f4f4f4' cellpadding=1 cellspacing=1 width=100% onmouseover='doOver()' onmouseout='doOut()' style='font-size : 12;font-family:����;'>";
		Cal_HTML += "<tr align=center bgcolor='#f4f4f4'>";
		Cal_HTML += "<td colspan=4 align=center>";
		Cal_HTML += "<a style='cursor:hand;' OnClick='Show_cal_M("+intPPyear+","+intThisMonth+");'>��</a>&nbsp;&nbsp;";
		Cal_HTML += intThisYear +"��";
		Cal_HTML += "&nbsp;&nbsp;<a style='cursor:hand;' OnClick='Show_cal_M("+intNNyear+","+intThisMonth+");'>��</a>";
		Cal_HTML += "</td></tr>";
		Cal_HTML += "<tr align=center bgcolor=white>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-01"+" style=\"cursor:Hand;\">1��</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-02"+" style=\"cursor:Hand;\">2��</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-03"+" style=\"cursor:Hand;\">3��</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-04"+" style=\"cursor:Hand;\">4��</td>";
		Cal_HTML += "</tr>";
		Cal_HTML += "<tr align=center bgcolor=white>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-05"+" style=\"cursor:Hand;\">5��</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-06"+" style=\"cursor:Hand;\">6��</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-07"+" style=\"cursor:Hand;\">7��</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-08"+" style=\"cursor:Hand;\">8��</td>";
		Cal_HTML += "</tr>";
		Cal_HTML += "<tr align=center bgcolor=white>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-09"+" style=\"cursor:Hand;\">9��</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-10"+" style=\"cursor:Hand;\">10��</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-11"+" style=\"cursor:Hand;\">11��</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-12"+" style=\"cursor:Hand;\">12��</td>";
		Cal_HTML += "</tr>";
		Cal_HTML += "</table>";

		document.all.cal.innerHTML = Cal_HTML;

		// �޷� ����� �Ϸ�Ǹ� iframe�� ũ�⸦ �������Ѵ�.
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