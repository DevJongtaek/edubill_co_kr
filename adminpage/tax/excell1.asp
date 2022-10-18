<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=order.xls"
%>

<!--#include virtual="/db/db.asp"-->

<%
'Server.ScriptTimeOut = 1000000

	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	if searcha = "" then
		searcha = replace(left(now()-1,10),"-","")
	end if
	if searchd = "" then
		searchd = replace(left(now(),10),"-","")
	end if
	if searchb="" then
		searchb="0"
	end If
	
	searchdate = "● 기간 : " & Left(searcha, 4) & "/" & Mid(searcha, 5,2) & "/" & Mid(searcha, 7,2) & " ~ " & Left(searchd, 4) & "/" & Mid(searchd, 5,2) & "/" & Mid(searchd, 7,2)


	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select vatflag,isnull(maechulflag,'') as maechulflag "
	SQL = SQL & " from tb_company where idx = "& left(session("Ausercode"),5) &" "
	rs2.Open sql, db, 1
	if not rs2.eof then
		vatflag = rs2(0)
		maechulflag = rs2(1)
	end if
	rs2.close

	if maechulflag="n" or maechulflag="" then
		response.write "<Script language=javascript>"
		response.write "	alert(""지금은 사용하실 수 없습니다. !!!"");"
		response.write "	history.go(-1);"
		response.write "</Script>"
		response.end
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " order by dcarno asc"
	rs.Open sql, db, 1
	if not rs.eof then
		hcararray = rs.GetRows
		hcararrayint = ubound(hcararray,2)
	else
		hcararray = ""
		hcararrayint = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select b.jisacode, b.jisaname, sum(isnull(a.sumrordermoney,0)) , sum(isnull(c.imsiordermoney1,0)) as imsiordermoney1, sum(isnull(d.imsiordermoney2,0)) as imsiordermoney2 "
	SQL = sql & " from  "
	SQL = sql & " 	( select carname as carname, usercode as usercode, isnull(sum(rordermoney),0) as sumrordermoney "
	SQL = sql & " 	from tb_order "
	SQL = sql & " 	where flag='y'  "
			if session("Ausergubun")="3" then 
				SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			else
				SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			end if
	SQL = sql & " 	and orderday >= '"& searcha &"' and orderday <= '"& searchd &"' " 
	SQL = sql & " 	group by carname,usercode) a "

	SQL = sql & " left outer join  "
	SQL = sql & " 	(select C1.idx, c1.tcode as tcode, c1.comname, c2.tcode as jisacode, C2.comname as jisaname from tb_company C1 join (select idx, tcode, comname from tb_company where flag= '2') C2 on c1.idxsub = c2.idx where c1.flag = '3') b "
	SQL = sql & " on b.idx = substring(a.usercode,11,5) "

	SQL = sql & " left outer join  "
	SQL = sql & " 	(select aa.usercode,isnull(sum(cc.rordernum*cc.pprice),0) as imsiordermoney1 "
	SQL = sql & " 	from tb_order aa, tb_product bb , tb_order_product cc "
	SQL = sql & " 	where aa.idx=cc.idx and cc.pcodeidx=bb.idx "
	SQL = sql & " 	and bb.gubun='과세' "
	SQL = sql & " 	and aa.orderday >= '"& searcha &"' and aa.orderday <= '"& searchd &"' and aa.flag = 'y' "
	SQL = sql & " 	group by aa.usercode) c "
	SQL = sql & " on a.usercode=c.usercode  "
			if session("Ausergubun")="3" then
				SQL = sql & " and substring(c.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			else
				SQL = sql & " and substring(c.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			end if

	SQL = sql & " left outer join  "
	SQL = sql & " 	(select aa.usercode,isnull(sum(cc.rordernum*cc.pprice),0) as imsiordermoney2 "
	SQL = sql & " 	from tb_order aa, tb_product bb , tb_order_product cc "
	SQL = sql & " 	where aa.idx=cc.idx and cc.pcodeidx=bb.idx "
	SQL = sql & " 	and bb.gubun='비과세' "
	SQL = sql & " 	and aa.orderday >= '"& searcha &"' and aa.orderday <= '"& searchd &"' and aa.flag = 'y' "
	SQL = sql & " 	group by aa.usercode) d "
	SQL = sql & " on a.usercode=d.usercode  "
			if session("Ausergubun")="3" then 
				SQL = sql & " and substring(d.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			else
				SQL = sql & " and substring(d.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			end if
	SQL = sql & " group by b.jisacode, b.jisaname "
  	SQL = sql & " order by b.jisacode asc"
'response.write sql
	rs.Open sql, db, 1

%>

<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
</head>

<body leftmargin="0" topmargin="0">

<table border=1>
	<tr>
		<td colspan=7 align="center"><b><font size=4>지사/체인점 기간별 매출현황</font></b></td>
	</tr>
	<tr height="20">
		<td colspan=7 ><%=searchdate%><%=vatflag%></td>
	</tr>
	<tr height=28 align=center>
		<td>번호</td>
		<td>지사코드</td>
		<td>지사명</td>
		<td>거래기간</td>
		<td>금액</td>
		<td>부가세</td>
		<td>매출액</td>
	</tr>

<%
i=1
do until rs.EOF
	imsirs2tcode=""
	imsimoney = 0
	imsimoney_vat = 0
	imsimoney_hap = 0

'	a.carname, a.usercode, isnull(a.sumrordermoney,0),b.idx, b.tcode,b.comname, isnull(c.imsiordermoney1,0),isnull(d.imsiordermoney2,0)

	imsirordermoney1 = CDbl(rs("imsiordermoney1"))
	imsirordermoney2 = CDbl(rs("imsiordermoney2"))

'imsirordermoney1 = CDbl(imsirordermoney1)
'imsirordermoney2 = CDbl(imsirordermoney2)
'response.write imsirordermoney1 & "<BR>"
'response.write imsirordermoney2 & "<BR>"

	if vatflag="y"  Or vatflag= "a" then	'포함
		'imsirordermoney = imsirordermoney1+imsirordermoney2	'포함가
		'imsirordermoney22 = round(imsirordermoney1*(100/110),0)
		'imsirordermoney_vat = imsirordermoney1-imsirordermoney22
		'imsirordermoney_hap = imsirordermoney+imsirordermoney_vat

		imsirordermoney22 = imsirordermoney1+imsirordermoney2	'포함가
		imsirordermoney = round(imsirordermoney1,0)
		imsirordermoney_vat = imsirordermoney1-imsirordermoney
		imsirordermoney = imsirordermoney+imsirordermoney2
		imsirordermoney_hap = imsirordermoney+imsirordermoney_vat
	else			'별도
		imsirordermoney = imsirordermoney1+imsirordermoney2
		imsirordermoney_vat = round(imsirordermoney1*0.1,0)
		imsirordermoney_hap = imsirordermoney+imsirordermoney_vat
	end if
%>

	<tr height=25 align=center>
		<td><%=i%></td>
		<td><%=rs("jisacode")%></td>
		<td><%=rs("jisaname")%></td>
		<td><%=left(searcha,4)%>/<%=mid(searcha,5,2)%>/<%=right(searcha,2)%>~<%=left(searchd,4)%>/<%=mid(searchd,5,2)%>/<%=right(searchd,2)%></td>
		<td align=right><%=FormatCurrency(imsirordermoney,0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(imsirordermoney_vat,0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(imsirordermoney_hap,0)%> &nbsp; </td>
	</tr>

<%
	imsihap1 = imsihap1+imsirordermoney
	imsihap2 = imsihap2+imsirordermoney_vat
	imsihap3 = imsihap3+imsirordermoney_hap
rs.MoveNext 
i=i+1
loop 
%>

	<tr height=28 bgcolor=#F7F7FF align=center>
		<td colspan=4>합 계</td>
		<td align=right> <%=FormatCurrency(imsihap1,0)%> &nbsp; </td>
		<td align=right> <%=FormatCurrency(imsihap2,0)%> &nbsp; </td>
		<td align=right> <%=FormatCurrency(imsihap3,0)%> &nbsp; </td>
	</tr>

</table>


<%
	db.close
	set db=nothing
%>

</body>