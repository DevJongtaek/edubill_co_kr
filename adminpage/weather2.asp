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
<!-- ����ȣ 2013-03-22 ����� ��û���� ���� ǥ�þ���.
<table cellspacing=0 cellpadding=0>
<tr>
<td valign=top>
<!--
<form name=form action=weather2.asp>
			<select name="searcha" size="1" class="box_work" onchange="submit()">
	          			<option value="0" <%if searcha="0" then%>selected<%end if%>>��ü</option>
        	  			<option value="1" <%if searcha="1" then%>selected<%end if%>>������</option>
        	  			<option value="2" <%if searcha="2" then%>selected<%end if%>>������</option>
        	  			<option value="3" <%if searcha="3" then%>selected<%end if%>>��û�ϵ�</option>
						<option value="4" <%if searcha="4" then%>selected<%end if%>>��û����</option>
						<option value="5" <%if searcha="5" then%>selected<%end if%>>����ϵ�</option>
						<option value="6" <%if searcha="6" then%>selected<%end if%>>���󳲵�</option>
						<option value="7" <%if searcha="7" then%>selected<%end if%>>���ϵ�</option>
						<option value="8" <%if searcha="8" then%>selected<%end if%>>��󳲵�</option>
						<option value="9" <%if searcha="9" then%>selected<%end if%>>����</option>
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
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=125"  '����
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=51&gridy=131"  '��õ
		subtargetURL(2) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=120"  '����
		subtargetURL(3) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=56&gridy=133"  '����
		subtargetURL(4) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=73&gridy=134"  '��õ
		subtargetURL(5) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=93&gridy=132"  '����
		subtargetURL(6) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=69&gridy=106"  'û��
		subtargetURL(7) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=68&gridy=100"  '����
		subtargetURL(8) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=51&gridy=110"  '����
		subtargetURL(9) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=63&gridy=89"   '����
		subtargetURL(10) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=57&gridy=74"  '����
		subtargetURL(11) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=50&gridy=66"  '����
		subtargetURL(12) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=74&gridy=65"  '����
		subtargetURL(13) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=89&gridy=90"  '�뱸
		subtargetURL(14) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=91&gridy=105" '�ȵ�
		subtargetURL(15) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=97&gridy=74"  '�λ�
		subtargetURL(16) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=101&gridy=84" '���
		subtargetURL(17) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=91&gridy=75"  'â��
		subtargetURL(18) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=53&gridy=38"  '����
		subtargetURL(19) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=56&gridy=33"  '������
	Case "1"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=109"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=125" '����
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=51&gridy=131" '��õ
		subtargetURL(2) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=120" '����
		subtargetURL(3) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=56&gridy=133" '����
	Case "2"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=105"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=73&gridy=134" '��õ
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=93&gridy=132" '����
	Case "3"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=131"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=69&gridy=106" 'û��
	Case "4"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=133"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=68&gridy=100" '����
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=51&gridy=110" '����
	Case "5"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=146"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=63&gridy=89" '����
	Case "6"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=156"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=57&gridy=74" '����
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=50&gridy=66" '����
		subtargetURL(2) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=74&gridy=65" '����
	Case "7"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=143"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=89&gridy=90" '�뱸
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=91&gridy=105" '�ȵ�
	Case "8"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=159"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=97&gridy=74" '�λ�
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=101&gridy=84" '���
		subtargetURL(2) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=91&gridy=75" 'â��
	Case "9"
		targetURL = "http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=184"
		subtargetURL(0) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=53&gridy=38" '����
		subtargetURL(1) = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=56&gridy=33" '������
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
'���̺� ����
response.write "<table  border=1 bordercolorlight=""#999966"" bordercolordark=""#FFFFFF"" width=""100%"">" 
'���̺� ��� ����(����)
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
'���̺� ������ ����
For Each tempURL In subtargetURL
	If tempURL <> "" Then		
		response.write "<tr>"
		'���� ��ġ
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
		'����, ���� ��¥ ���
		'response.write forecast(0).ChildNodes.Length & "<br>"
		For i = 0 To  forecast(0).ChildNodes.Length - 1  
			If forecast(0).ChildNodes(i).attributes(0).Nodetypedvalue = "0" Then 
				response.write "<td align=center><font style=""font-size:12;"">" 
				Select Case replace(forecast(0).ChildNodes(i).ChildNodes(7).NodeTypedValue, " ", "")
				Case "��������"
					response.write "<img src=images/��������.png alt=��������><br>"
				Case "��������"
					response.write "<img src=images/��������.png alt=��������><br>"
				Case "�帲"
					response.write "<img src=images/�帲.png alt=�帲><br>"
				Case "��"
					response.write "<img src=images/��.png alt=��><br>"
				Case "����"
					response.write "<img src=images/����.png alt=����><br>"
				Case "����������"
					response.write "<img src=images/����������.png alt=����������><br>"
				Case "�帮����"
					response.write "<img src=images/�帮����.png alt=�帮����><br>"
				End Select 
				'response.write replace(forecast(0).ChildNodes(i).ChildNodes(7).NodeTypedValue, " ", "") & "<br>"
				response.write forecast(0).ChildNodes(i).ChildNodes(2).NodeTypedValue
				response.write "</td>"
			End If 
			If forecast(0).ChildNodes(i).ChildNodes(1).Nodetypedvalue = "1" And forecast(0).ChildNodes(i).childNodes(0).Nodetypedvalue = "12" Then 
				response.write "<td align=center><font style=""font-size:12;"">" 
				Select Case replace(forecast(0).ChildNodes(i).ChildNodes(7).NodeTypedValue, " ", "")
					Case "��������"
						response.write "<img src=images/��������.png alt=��������><br>"
					Case "��������"
						response.write "<img src=images/��������.png alt=��������><br>"
					Case "�帲"
						response.write "<img src=images/�帲.png alt=�帲><br>"
					Case "��"
						response.write "<img src=images/��.png alt=��><br>"
					Case "����"
						response.write "<img src=images/����.png alt=����><br>"
					Case "����������"
						response.write "<img src=images/����������.png alt=����������><br>"
					Case "�帮����"
						response.write "<img src=images/�帮����.png alt=�帮����><br>"
				End Select 
				'response.write  replace(forecast(0).ChildNodes(i).ChildNodes(7).NodeTypedValue, " ", "") & "<br>"				
				response.write forecast(0).ChildNodes(i).ChildNodes(2).NodeTypedValue
				response.write "</td>"
			End If 
		Next 
		response.write	"</td>"
		'������ 3�����
		For q = 2 To forecast_information_Node(0).childNodes(se).childnodes.Length - 4
			response.write "<td align=center><font style=""font-size:12;"">" 
			Select Case replace(forecast_information_Node(0).childNodes(se).Childnodes(q).Childnodes(2).nodetypedValue, " ", "")
				Case "��������"
					response.write "<img src=images/��������.png alt=��������><br>"
				Case "��������"
					response.write "<img src=images/��������.png alt=��������><br>"
				Case "�帲"
					response.write "<img src=images/�帲.png alt=�帲><br>"
				Case "��"
					response.write "<img src=images/��.png alt=��><br>"
				Case "����"
					response.write "<img src=images/����.png alt=����><br>"
				Case "����������"
					response.write "<img src=images/����������.png alt=����������><br>"
				Case "�帮����"
					response.write "<img src=images/�帮����.png alt=�帮����><br>"
			End Select 
			'response.write replace(forecast_information_Node(0).childNodes(se).Childnodes(q).Childnodes(2).nodetypedValue, " ", "") & "<br>"
			response.write forecast_information_Node(0).childNodes(se).Childnodes(q).Childnodes(3).NodeTypedValue & "��~" & forecast_information_Node(0).childNodes(se).Childnodes(q).Childnodes(3).NodeTypedValue & "��"
			response.write "</td>"
		Next 
 
	End If 
	se = se + 1 
Next 
'				Case "����"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB01.png alt=����><br>"
'				Case "��������"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB02.png alt=��������><br>"
'				Case "��������"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB03.png alt=��������><br>"
'				Case "�帲"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB04.png alt=�帲><br>"
'				Case "��"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB08.png alt=��><br>"
'				Case "��"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB11.png alt=��><br>"
'				Case "��Ǵ´�"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB12.png alt=��Ǵ´�><br>"
'				Case "���Ǵº�"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB13.png alt=���Ǵº�><br>"
'				Case "õ�չ���"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB14.png alt=õ�չ���><br>"
'				Case "�Ȱ�"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB15.png alt=�Ȱ�><br>"
'				Case "Ȳ��"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB16.png alt=Ȳ��><br>"
'				Case "�ҳ���"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB07.png alt=�ҳ���><br>"
'				Case "������,�Ѷ���"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB20.png alt=������,�Ѷ���><br>"
'				Case "������,�Ѷ���"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB21.png alt=������,�Ѷ���><br>"
'				Case "������Ǵ´�,�Ѷ���Ǵ´�"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB22.png alt=������Ǵ´�,�Ѷ���Ǵ´�><br>"
'				Case "�������Ǵº�,�Ѷ����Ǵº�"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB23.png alt=�������Ǵº�,�Ѷ����Ǵº�><br>"
'				Case "����"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB18.png alt=����><br>"
'				Case "�ڹ�"
'					response.write "<img src=http://www.kma.go.kr/images/icon/NW/NB17.png alt=�ڹ�><br>"

-->
</tr>
</table>

</body>