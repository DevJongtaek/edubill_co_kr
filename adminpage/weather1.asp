<% 
	searcha = request("searcha")
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
<body leftmargin="0" topmargin="0">
<table cellspacing=0 cellpadding=0>
<tr>
<td valign=top>
<form name=form action=weather1.asp>
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
</form>
</td>
<td>
<%
	targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=108"
	Select Case searcha
	Case "0"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=108"
	Case "1"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=109"
	Case "2"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=105"
	Case "3"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=131"
	Case "4"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=133"
	Case "5"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=146"
	Case "6"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=156"
	Case "7"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=143"
	Case "8"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=159"
	Case "9"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=184"
	End Select 

Set xmlHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")

xmlHttp.Open "GET", targetURL, False

xmlHttp.Send 

Set xmlDOM = server.CreateObject("MSXML2.DOMDOCUMENT.4.0")

xmlDOM.async = False

xmlDOM.LoadXML xmlHttp.responseText

Set xmlHttp = Nothing

Set forecast_information_Node = xmlDOM.selectNodes("/wid/body")
'If forecast_information_Node.length > 0 Then
'	response.write "지역" & forecast_information_Node(0).childNodes(0).childNodes(1).nodeTypedValue & "<br>"
'	response.write "날자" & forecast_information_Node(0).childNodes(0).childNodes(2).childNodes(1).nodeTypedValue& "<br>"
'	response.write "날씨" & forecast_information_Node(0).childNodes(0).childNodes(2).childNodes(2).nodeTypedValue& "<br>"
'	response.write "최저온도" & forecast_information_Node(0).childNodes(0).childNodes(2).childNodes(3).nodeTypedValue& "<br>"
'    response.write "최고온도" & forecast_information_Node(0).childNodes(0).childNodes(2).childNodes(4).nodeTypedValue& "<br>"
'Else
'	reponse.write "bbbbbbbbbb"
'End If 

response.write "<table border=1 bordercolorlight=""#999966"" bordercolordark=""#FFFFFF"" width=""100%"">"
	response.write "<tr>"
		response.write "<td>&nbsp;</td>"
	For j = 2 To forecast_information_Node(0).childNodes(i).childNodes(3).childNodes.length 
		response.write "<td>"
			response.write "<font style=""font-size:12;"">" & forecast_information_Node(0).childNodes(0).childNodes(j).childNodes(1).nodeTypedValue& "<br>"
		response.write "</td>"
	Next
	response.write "</tr>"
For i = 0 To forecast_information_Node(0).childNodes.length - 1 Step 1
	response.write "<tr><td>"
	response.write "<font style=""font-size:12;"">" & forecast_information_Node(0).childNodes(i).childNodes(1).nodeTypedValue & "<br>"
	response.write "</td>"
	For j = 2 To forecast_information_Node(0).childNodes(i).childNodes(3).childNodes.length 
		response.write "<td align=center>"
	    Select Case forecast_information_Node(0).childNodes(i).childNodes(j).childNodes(2).nodeTypedValue
		Case "구름많음"
			response.write "<img src=img/구름많음.png /><br>"
		Case "구름조금"
			response.write "<img src=img/구름조금.png /><br>"
		Case "구름눈비"
			response.write "<img src=img/구름눈비.png /><br>"
		Case "구름많고 비"
			response.write "<img src=img/구름많고비.png /><br>"
		Case "맑음"
			response.write "<img src=img/맑음.png /><br>"
		Case "흐리고비"
			response.write "<img src=img/흐리고비.png /><br>"
		Case Else
			response.write "<img src=img/맑음.png /><br>"
		End Select 
		response.write "<font style=""font-size:12;"">" & forecast_information_Node(0).childNodes(i).childNodes(j).childNodes(3).nodeTypedValue& "℃~" &forecast_information_Node(0).childNodes(i).childNodes(j).childNodes(4).nodeTypedValue& "℃<br>"
		response.write "</td>"
	Next 		
	
Next 
response.write "<table border=1>"
%>
</td>
</tr>
</table>
</body>