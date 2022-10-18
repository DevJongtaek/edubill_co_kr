<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=Sheet1.xls"
%>
<!--#include virtual="/db/db.asp"-->
<%
	


%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type="text/css">
<!--
td.accountnum
{mso-number-format:\@}
-->
</STYLE>
<body>

<table border=1>
	<tr>
		<td>핸드폰번호</td>

		
	</tr>



	<tr>
		<td></td>
	</tr>



</table>

</body>
</html>