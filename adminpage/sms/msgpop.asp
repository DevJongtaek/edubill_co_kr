<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	msg = replace(request("msg"),"$$","""")
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>edubill.co.kr</title>
</head>

<body leftmargin="0" topmargin="0">

<table border="0" cellspacing="2" cellpadding="2" width="100%" height=100%>
	<tr height="30">
		<td align=center><font color=blue size=3><B>[ SMS 전송메세지 ]</td>
	</tr>
	<tr align=center>
		<td><font color=black><%=msg%></td>
	</tr>
	<tr align=center>
		<td height="25"><a href="#" onclick="window.close();"><b>[창닫기]</td>
	</tr>
</table>

</body>
</html>