<% 
	searcha = request("searcha")
	If searcha = "" Then 
		searcha = 0
	End If 

	today = FormatDateTime(Now(), 2)
	tommorow = FormatDateTime(DateAdd("d", 1, Now()), 2)

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>edubill.co.kr</title>

</head>
<script language="javascript">
function submit()
{
	form.submit();
}
</script>
<body leftmargin="0" topmargin="0" style="SCROLLBAR-ARROW-COLOR: #ffffff; FILTER: chroma(color=#ffffff); SCROLLBAR-FACE-COLOR: #ffffff; SCROLLBAR-DARKSHADOW-COLOR: #ffffff;">
<!-- 박은호 2013-03-22 사장님 요청으로 날씨 표시안함.
<table cellspacing=0 cellpadding=0>
<tr>
<td valign=top>
<!--
<form name=form action=weather2.asp>
			<select name="searcha" size="1" class="box_work" onchange="submit()">
	          			<option value="0" <%if searcha="0" then%>selected<%end if%>>전체</option>
        	  			<option value="1" <%if searcha="1" then%>selected<%end if%>>서울경기</option>
        	  			<option value="2" <%if searcha="2" then%>selected<%end if%>>강원도</option>
        	  			<option value="3" <%if searcha="3" then%>selected<%end if%>>충청북도</option>
						<option value="4" <%if searcha="4" then%>selected<%end if%>>충청남도</option>
						<option value="5" <%if searcha="5" then%>selected<%end if%>>전라북도</option>
						<option value="6" <%if searcha="6" then%>selected<%end if%>>전라남도</option>
						<option value="7" <%if searcha="7" then%>selected<%end if%>>경상북도</option>
						<option value="8" <%if searcha="8" then%>selected<%end if%>>경상남도</option>
						<option value="9" <%if searcha="9" then%>selected<%end if%>>제주</option>
			</select>
</form>-->
</td>
<td>
</td>
<!--

	targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=108"
	Dim subtargetURL(20)
	Dim weatherdata(40)
	For Each tempdata In weatherdata
		tempdata = ""
	Next 
	Select Case searcha
	Case "0"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=108"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=125"  '서울
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=51&gridy=131"  '인천
		subtargetURL(2) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=120"  '수원
		subtargetURL(3) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=56&gridy=133"  '문산
		subtargetURL(4) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=73&gridy=134"  '춘천
		subtargetURL(5) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=93&gridy=132"  '강릉
		subtargetURL(6) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=69&gridy=106"  '청주
		subtargetURL(7) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=68&gridy=100"  '대전
		subtargetURL(8) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=51&gridy=110"  '서산
		subtargetURL(9) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=63&gridy=89"   '전주
		subtargetURL(10) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=57&gridy=74"  '광주
		subtargetURL(11) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=50&gridy=66"  '목포
		subtargetURL(12) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=74&gridy=65"  '여수
		subtargetURL(13) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=89&gridy=90"  '대구
		subtargetURL(14) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=91&gridy=105" '안동
		subtargetURL(15) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=97&gridy=74"  '부산
		subtargetURL(16) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=101&gridy=84" '울산
		subtargetURL(17) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=91&gridy=75"  '창원
		subtargetURL(18) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=53&gridy=38"  '제주
		subtargetURL(19) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=56&gridy=33"  '서귀포
	Case "1"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=109"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=125" '서울
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=51&gridy=131" '인천
		subtargetURL(2) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=120" '수원
		subtargetURL(3) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=56&gridy=133" '문산
	Case "2"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=105"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=73&gridy=134" '춘천
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=93&gridy=132" '강릉
	Case "3"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=131"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=69&gridy=106" '청주
	Case "4"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=133"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=68&gridy=100" '대전
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=51&gridy=110" '서산
	Case "5"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=146"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=63&gridy=89" '전주
	Case "6"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=156"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=57&gridy=74" '광주
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=50&gridy=66" '목포
		subtargetURL(2) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=74&gridy=65" '여수
	Case "7"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=143"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=89&gridy=90" '대구
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=91&gridy=105" '안동
	Case "8"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=159"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=97&gridy=74" '부산
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=101&gridy=84" '울산
		subtargetURL(2) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=91&gridy=75" '창원
	Case "9"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=184"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=53&gridy=38" '제주
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=56&gridy=33" '서귀포
	End Select 

Set xmlHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
xmlHttp.Open "GET", targetURL, False
xmlHttp.Send 

Set xmlDOM = server.CreateObject("MSXML2.DOMDOCUMENT.4.0")
xmlDOM.async = False
xmlDOM.LoadXML xmlHttp.responseText

Set xmlHttp = Nothing
Set forecast_information_Node = xmlDOM.selectNodes("/wid/body")

count = 0
se = 0
'테이블 시작
response.write "<table  border=1 bordercolorlight=""#999966"" bordercolordark=""#FFFFFF"" width=""100%"">" 
'테이블 헤더 시작(일자)
	response.write "<tr>"
	response.write "<td width=40 align=center>&nbsp;</td>"
	response.write "<td width=65 align=center><font style=""font-size:12;"">" & today & "</td>"
	response.write "<td width=65 align=center><font style=""font-size:12;"">" & tommorow & "</td>"

	For j = 2 To forecast_information_Node(0).childNodes(i).childNodes(3).childNodes.length - 2
		response.write "<td width=65 align=center>"
			response.write "<font style=""font-size:12;"">" & forecast_information_Node(0).childNodes(0).childNodes(j).childNodes(1).nodeTypedValue& "<br>"
		response.write "</td>"
	Next
	response.write "</tr>"
	'response.write "<main>" & targetURL & "<br>"
'테이블 데이터 시작
For Each tempURL In subtargetURL
	If tempURL <> "" Then		
		response.write "<tr>"
		'날씨 위치
		response.write "<td align=center><font style=""font-size:12;"">" & forecast_information_Node(0).childNodes(se).Childnodes(1).nodetypedValue & "</td>"
		count = count + 1
		'response.write count
		'response.write "<sub>" & tempURL & "<br>"
		Set subxmlHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
		subxmlHttp.Open "GET", tempURL, False
		subxmlHttp.Send 

		Set subxmlDOM = server.CreateObject("MSXML2.DOMDOCUMENT.4.0")
		subxmlDOM.async = False
		subxmlDOM.LoadXML subxmlHttp.responseText
	
		Set subxmlHttp = Nothing
		Set forecast = subxmlDOM.selectNodes("/wid/body")
		'오늘, 내일 날짜 출력
		'response.write forecast(0).ChildNodes.Length & "<br>"
		For i = 0 To  forecast(0).ChildNodes.Length - 1  
			If forecast(0).ChildNodes(i).attributes(0).Nodetypedvalue = "0" Then 
				response.write "<td align=center><font style=""font-size:12;"">" 
				Select Case replace(forecast(0).ChildNodes(i).ChildNodes(7).NodeTypedValue, " ", "")
				Case "구름많음"
					response.write "<img src=images/구름많음.png alt=구름많음><br>"
				Case "구름조금"
					response.write "<img src=images/구름조금.png alt=구름조금><br>"
				Case "흐림"
					response.write "<img src=images/흐림.png alt=흐림><br>"
				Case "비"
					response.write "<img src=images/비.png alt=비><br>"
				Case "맑음"
					response.write "<img src=images/맑음.png alt=맑음><br>"
				Case "구름많고비"
					response.write "<img src=images/구름많고비.png alt=구름많고비><br>"
				Case "흐리고비"
					response.write "<img src=images/흐리고비.png alt=흐리고비><br>"
				End Select 
				'response.write replace(forecast(0).ChildNodes(i).ChildNodes(7).NodeTypedValue, " ", "") & "<br>"
				response.write forecast(0).ChildNodes(i).ChildNodes(2).NodeTypedValue
				response.write "</td>"
			End If 
			If forecast(0).ChildNodes(i).ChildNodes(1).Nodetypedvalue = "1" And forecast(0).ChildNodes(i).childNodes(0).Nodetypedvalue = "12" Then 
				response.write "<td align=center><font style=""font-size:12;"">" 
				Select Case replace(forecast(0).ChildNodes(i).ChildNodes(7).NodeTypedValue, " ", "")
					Case "구름많음"
						response.write "<img src=images/구름많음.png alt=구름많음><br>"
					Case "구름조금"
						response.write "<img src=images/구름조금.png alt=구름조금><br>"
					Case "흐림"
						response.write "<img src=images/흐림.png alt=흐림><br>"
					Case "비"
						response.write "<img src=images/비.png alt=비><br>"
					Case "맑음"
						response.write "<img src=images/맑음.png alt=맑음><br>"
					Case "구름많고비"
						response.write "<img src=images/구름많고비.png alt=구름많고비><br>"
					Case "흐리고비"
						response.write "<img src=images/흐리고비.png alt=흐리고비><br>"
				End Select 
				'response.write  replace(forecast(0).ChildNodes(i).ChildNodes(7).NodeTypedValue, " ", "") & "<br>"				
				response.write forecast(0).ChildNodes(i).ChildNodes(2).NodeTypedValue
				response.write "</td>"
			End If 
		Next 
		response.write	"</td>"
		'나머지 3일출력
		For q = 2 To forecast_information_Node(0).childNodes(se).childnodes.Length - 4
			response.write "<td align=center><font style=""font-size:12;"">" 
			Select Case replace(forecast_information_Node(0).childNodes(se).Childnodes(q).Childnodes(2).nodetypedValue, " ", "")
				Case "구름많음"
					response.write "<img src=images/구름많음.png alt=구름많음><br>"
				Case "구름조금"
					response.write "<img src=images/구름조금.png alt=구름조금><br>"
				Case "흐림"
					response.write "<img src=images/흐림.png alt=흐림><br>"
				Case "비"
					response.write "<img src=images/비.png alt=비><br>"
				Case "맑음"
					response.write "<img src=images/맑음.png alt=맑음><br>"
				Case "구름많고비"
					response.write "<img src=images/구름많고비.png alt=구름많고비><br>"
				Case "흐리고비"
					response.write "<img src=images/흐리고비.png alt=흐리고비><br>"
			End Select 
			'response.write replace(forecast_information_Node(0).childNodes(se).Childnodes(q).Childnodes(2).nodetypedValue, " ", "") & "<br>"
			response.write forecast_information_Node(0).childNodes(se).Childnodes(q).Childnodes(3).NodeTypedValue & "℃~" & forecast_information_Node(0).childNodes(se).Childnodes(q).Childnodes(3).NodeTypedValue & "℃"
			response.write "</td>"
		Next 
 
	End If 
	se = se + 1 
Next 
'				Case "맑음"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB01.png alt=맑음><br>"
'				Case "구름조금"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB02.png alt=구름조금><br>"
'				Case "구름많음"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB03.png alt=구름많음><br>"
'				Case "흐림"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB04.png alt=흐림><br>"
'				Case "비"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB08.png alt=비><br>"
'				Case "눈"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB11.png alt=눈><br>"
'				Case "비또는눈"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB12.png alt=비또는눈><br>"
'				Case "눈또는비"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB13.png alt=눈또는비><br>"
'				Case "천둥번개"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB14.png alt=천둥번개><br>"
'				Case "안개"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB15.png alt=안개><br>"
'				Case "황사"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB16.png alt=황사><br>"
'				Case "소나기"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB07.png alt=소나기><br>"
'				Case "가끔비,한때비"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB20.png alt=가끔비,한때비><br>"
'				Case "가끔눈,한때눈"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB21.png alt=가끔눈,한때눈><br>"
'				Case "가끔비또는눈,한때비또는눈"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB22.png alt=가끔비또는눈,한때비또는눈><br>"
'				Case "가끔눈또는비,한때눈또는비"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB23.png alt=가끔눈또는비,한때눈또는비><br>"
'				Case "연무"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB18.png alt=연무><br>"
'				Case "박무"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB17.png alt=박무><br>"

-->
</tr>
</table>

</body>