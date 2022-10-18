<%
'타겟 URL을 설정한다
targetURL = "http://www.google.com/ig/api?hl=ko&weather=seoul"

'외부 XML을 가져오기위한 HTTP객체 생성
Set xmlHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")

'XMLHTTP 객체의 OPEN 메소드 파라메터 설정
'xmlHttp.Open 전송방식, URL, 동기화옵션 (true:비동기화, false:동기화)
xmlHttp.Open "GET", targetURL, False

'XMLHTTP 객체를 이용하여 외부 URL의 XML을 받아온다
xmlHttp.Send 

'받아온 외부XML을 담을 DOM 객체 생성
Set xmlDOM = server.CreateObject("MSXML2.DOMDOCUMENT.4.0")
'동기화 옵션 : false로 설정
xmlDOM.async = False

'DOM  객체에 받아온 XML을 담는다
'XML을 파일로 사용할 경우에는 LOAD 메소드를 사용한다
'responseText 로 받아오는 데이터의 한글이 깨질경우 
'responseBody로 받아서 스트림객체를 이용해 다시 읽어 들이는 방식을 취하면 
'한글이 깨지는 증상을 피할수 있다
'COM+을 만들어 사용하는게 속도나 부하면에 최적화 된다
xmlDOM.LoadXML xmlHttp.responseText

'xmlHTTP 객체 사용이 끝났으므로 해제를 해준다
Set xmlHttp = Nothing


'DOM 객체에 담겨진 XML을 핸들링한다
'날씨 정보를 담은 info 객체노드
Set forecast_information_Node = xmlDOM.selectNodes("/xml_api_reply/weather/forecast_information")

If forecast_information_Node.length > 0 Then
   city = forecast_information_Node(0).childNodes(0).attributes.getNamedItem("data").nodeTypedValue
   postal_code =  forecast_information_Node(0).childNodes(1).attributes.getNamedItem("data").nodeTypedValue
   latitude_e6 =  forecast_information_Node(0).childNodes(2).attributes.getNamedItem("data").nodeTypedValue
   longitude_e6 =  forecast_information_Node(0).childNodes(3).attributes.getNamedItem("data").nodeTypedValue
   forecast_date =  forecast_information_Node(0).childNodes(4).attributes.getNamedItem("data").nodeTypedValue
   current_date_time =  forecast_information_Node(0).childNodes(5).attributes.getNamedItem("data").nodeTypedValue
   unit_system =  forecast_information_Node(0).childNodes(6).attributes.getNamedItem("data").nodeTypedValue
End If 

'온도 및 습도를 담은 노드
Set current_conditions_Node = xmlDOM.selectNodes("/xml_api_reply/weather/current_conditions")

If current_conditions_Node.length > 0 Then
   info_condition = current_conditions_Node(0).childNodes(0).attributes.getNamedItem("data").nodeTypedValue
   temp_f =  current_conditions_Node(0).childNodes(1).attributes.getNamedItem("data").nodeTypedValue
   temp_c =  current_conditions_Node(0).childNodes(2).attributes.getNamedItem("data").nodeTypedValue
   humidity =  current_conditions_Node(0).childNodes(3).attributes.getNamedItem("data").nodeTypedValue
   info_icon =  current_conditions_Node(0).childNodes(4).attributes.getNamedItem("data").nodeTypedValue
   wind_condition =  current_conditions_Node(0).childNodes(5).attributes.getNamedItem("data").nodeTypedValue
End If 

'날짜별 날씨정보를 담은 노드
Set forecast_conditions_Node = xmlDOM.selectNodes("/xml_api_reply/weather/forecast_conditions")

forecast_conditions_Node_CNT = forecast_conditions_Node.length

If forecast_conditions_Node_CNT > 0 Then
   '노드의 값을 담을 배열변수 셋팅
   ReDim day_of_week(forecast_conditions_Node_CNT-1)
   ReDim low(forecast_conditions_Node_CNT-1)
   ReDim high(forecast_conditions_Node_CNT-1)
   ReDim icon(forecast_conditions_Node_CNT-1)
   ReDim condition(forecast_conditions_Node_CNT-1)

   For i=0 To forecast_conditions_Node_CNT-1
      day_of_week(i) = forecast_conditions_Node(i).childNodes(0).attributes.getNamedItem("data").nodeTypedValue
      low(i) =  forecast_conditions_Node(i).childNodes(1).attributes.getNamedItem("data").nodeTypedValue
      high(i) =  forecast_conditions_Node(i).childNodes(2).attributes.getNamedItem("data").nodeTypedValue
      icon(i) =  forecast_conditions_Node(i).childNodes(3).attributes.getNamedItem("data").nodeTypedValue
      condition(i) =  forecast_conditions_Node(i).childNodes(4).attributes.getNamedItem("data").nodeTypedValue
   Next 
End If 

Set forecast_information_Node = Nothing 
Set current_conditions_Node = Nothing 
Set forecast_conditions_Node = Nothing 
Set xmlDOM = Nothing 

'밑에 출력부분의 데코레이션은 마음대로 한다
%>
<style>
    table,td {
        font-family: verdana;
        font-size: 12px;
    }
</style>
<table border="0" cellspacing="1" cellpadding="3" bgcolor="#DFDFDF">
   <col bgcolor="#EFEFEF"></col>
   <col bgcolor="#FFFFFF"></col>
   <tr>
      <td>city</td>
      <td><%=city%></td>
   </tr>
   <tr>
      <td>postal_code</td>
      <td><%=postal_code%></td>
   </tr>
   <tr>
      <td>latitude_e6</td>
      <td><%=latitude_e6%></td>
   </tr>
   <tr>
      <td>longitude_e6</td>
      <td><%=longitude_e6%></td>
   </tr>
   <tr>
      <td>forecast_date</td>
      <td><%=forecast_date%></td>
   </tr>
   <tr>
      <td>current_date_time</td>
      <td><%=current_date_time%></td>
   </tr>
   <tr>
      <td>unit_system</td>
      <td><%=unit_system%></td>
   </tr>
   <tr>
      <td>condition</td>
      <td><%=info_condition%></td>
   </tr>
   <tr>
      <td>temp_f</td>
      <td><%=temp_f%></td>
   </tr>
   <tr>
      <td>temp_c</td>
      <td><%=temp_c%></td>
   </tr>
   <tr>
      <td>humidity</td>
      <td><%=humidity%></td>
   </tr>
   <tr>
      <td>icon</td>
      <td><%=info_icon%></td>
   </tr>
   <tr>
      <td>wind_condition</td>
      <td><%=wind_condition%></td>
   </tr>
   <tr>
      <td colspan="2" height="1"></td>
   </tr>
   <%For j = 0 To forecast_conditions_Node_CNT-1%>
   <tr>
      <td>day_of_week(<%=j%>)</td>
      <td><%=day_of_week(j)%></td>
   </tr>
   <tr>
      <td>low(<%=j%>)</td>
      <td><%=low(j)%></td>
   </tr>
   <tr>
      <td>high(<%=j%>)</td>
      <td><%=high(j)%></td>
   </tr>
   <tr>
      <td>icon(<%=j%>)</td>
      <td><%=icon(j)%></td>
   </tr>
   <tr>
      <td>condition(<%=j%>)</td>
      <td><%=condition(j)%></td>
   </tr>
   <tr>
      <td colspan="2" height="1"></td>
   </tr>
   <%Next %>
<table>