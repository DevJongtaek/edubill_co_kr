<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=tax.xls"
%>

<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	if searcha = "" then
		searcha = replace(left(now,10),"-","")
	end if
	if searchb = "" then
		searchb = replace(left(now,10),"-","")
	end if

	'공급자-본사
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select vatflag "
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	vatflag = rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select flag,usercode,sday1,sday2,regday,title,tnum,tprice,tprice2,tprice_vat,"
	SQL = SQL & " gcompany,gcompanyno,gcompanyname,gcompanyaddr,guptae,gupjong, "
	SQL = SQL & " scompany,scompanyno,scompanyname,scompanyaddr,suptae,supjong,wdate,oldmoneyhap,oldmoneyhap_vat "
	SQL = sql & " from tb_taxlog "
	SQL = sql & " where regday >= '"& searcha &"' "
	SQL = sql & " and regday <= '"& searchb &"' "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	if searchc<>"" then
		SQL = sql & " and flag = '"& searchc &"' "
	end if

	SQL = sql & " order by idx desc"
	rs.Open sql, db, 1

%>

<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
</head>

<body leftmargin="0" topmargin="0">

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>발행일</td>
		<td width=20%>거래기간</td>
		<td width=10%>체인점명</td>
		<td width=15%>거래금액</td>
		<td width=10%>거래세액</td>
		<td width=10%>청구금액</td>
		<td width=10%>청구세액</td>
		<td width=10%>청구합계</td>
		<td width=5%>구분</td>
	</tr>

<form name=form2 method=post>

<%
i=1
do until rs.EOF

	if rs("flag")="1" then
		imsiflag = "세금"
	else
		imsiflag = "면세"
	end if

%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=left(rs("regday"),4)%>/<%=mid(rs("regday"),5,2)%>/<%=right(rs("regday"),2)%></td>
		<td><%=left(rs("sday1"),4)%>/<%=mid(rs("sday1"),5,2)%>/<%=right(rs("sday1"),2)%>~<%=left(rs("sday2"),4)%>/<%=mid(rs("sday2"),5,2)%>/<%=right(rs("sday2"),2)%></td>
		<td><%=rs("scompany")%></td>
		<td align=right><%=FormatCurrency(rs("oldmoneyhap"),0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(rs("oldmoneyhap_vat"),0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(rs("tprice2"),0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(rs("tprice_vat"),0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(rs("tprice2")+rs("tprice_vat"),0)%> &nbsp; </td>
		<td><%=imsiflag%></td>
	</tr>

<%
rs.MoveNext 
i=i+1
loop 
%>

</form>

</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>



<%
	db.close
	set db=nothing
%>

</body>