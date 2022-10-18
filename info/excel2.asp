<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=order.xls"
%>

<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tb_info"

	if searcha<>"" then
		SQL = sql & " where dname = '"& searcha &"' "
	end if

	SQL = sql & " order by idx desc"
	rslist.Open sql, db, 1

%>

<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<style type="text/css">
<!--
td.accountnum
{mso-number-format:\@}
-->
</STYLE>
</head>

<body>

<table border=1>
	<tr height=28 align=center>
		<td>번호</td>
		<td>회사명</td>
		<td>프렌차이즈명</td>
		<td>관리자</td>
		<td>소재지</td>
		<td>등록일자</td>
	</tr>

<%
i=1
do until rslist.EOF
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td class="accountnum"><%=i%></td>
		<td class="accountnum"><%=rslist("comname")%></td>
		<td class="accountnum"><%=rslist("fname")%></td>
		<td class="accountnum"><%=rslist("dname")%></td>
		<td class="accountnum" align=left>&nbsp;<%=rslist("addr")%></td>
		<td class="accountnum"><%=replace(left(rslist("wdate"),10),"-","/")%></td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 
%>

</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>