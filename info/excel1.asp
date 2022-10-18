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
	SQL = " select a.*, b.username, c.dname "
	SQL = sql & " from tb_company a, tb_adminuser b, tb_dealer c"
	SQL = sql & " where convert(varchar,a.idx) = b.usercode "
	SQL = sql & " and a.dcode = c.dcode "
	SQL = sql & " and a.flag='1' and a.serviceflag='2' "

	if searcha<>"" then
		SQL = sql & " and a.dcode = '"& searcha &"' "
	end if
	if searchb<>"" then
		SQL = sql & " and a.comname like '%"& searchb &"%' "
	end if
	if searchc<>"" then
		SQL = sql & " and b.username like '%"& searchc &"%' "
	end if

	SQL = sql & " order by a.comname asc"
	rslist.Open sql, db, 1

%>
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
	</tr>

<%
i=1
do until rslist.EOF
	addrarray = rslist("addr")
	if addrarray<>"" then
		addrarray = split(addrarray," ")
		addrarrayint = ubound(addrarray)
		if addrarrayint >= 1 then
			imsiaddrname1 = addrarray(0)
			imsiaddrname2 = addrarray(1)
			imsiaddrname = imsiaddrname1 &" "&imsiaddrname2
			if right(replace(imsiaddrname2," ",""),1)="시" then
				if addrarrayint >= 2 then
					imsiaddrname3 = addrarray(2)
					imsiaddrname = imsiaddrname &" "&imsiaddrname3
				end if
			end if
		end if
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td class="accountnum"><%=i%></td>
		<td class="accountnum"><%=rslist("comname")%></td>
		<td class="accountnum"><%=rslist("username")%></td>
		<td class="accountnum"><%=rslist("dname")%></td>
		<td class="accountnum" align=left>&nbsp;<%=imsiaddrname%></td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
loop 
%>

</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>