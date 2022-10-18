<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","attachment;filename=Sheet1.xls"
%>

<!--#include virtual="/db/db.asp"-->

<%
	imsinow = replace(left(now(),10),"-","")
	imsinow2 = replace(left(now()-1,10),"-","")

	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	if searchc = "" then
		searchc = "0"
	end if

	if searcha="" then
		searcha = imsinow2
	end if
	if searchb="" then
		searchb = imsinow
	end if

	imsiday1 = left(searcha,4)&"/"&mid(searcha,5,2)&"/"&right(searcha,2)
	imsiday2 = left(searchb,4)&"/"&mid(searchb,5,2)&"/"&right(searchb,2)

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
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

%>

<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

</head>

<body leftmargin="0" topmargin="0" onLoad="MM_preloadImages('admin/menu01_1.gif','admin/menu02_1.gif','admin/menu03_1.gif','admin/menu04_1.gif','admin/menu05_1.gif')">

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 체인점별 집계 ]</td>
	</tr>
</table>

<%
if searchc="99999" then

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sum(a.rordernum*a.pprice) "
	SQL = sql & " from tb_order_product a, tb_order b"
	SQL = sql & " where a.idx = b.idx "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(b.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
		if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
			SQL = sql & " and a.dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	SQL = sql & " and b.deflag = 'n' "
	SQL = sql & " and b.flag = 'y' "
	SQL = sql & " and b.orderday >= '"& searcha &"' "
	SQL = sql & " and b.orderday <= '"& searchb &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		sumoney=rs(0)
	else
		sumoney=0
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pcode,a.pname,a.sumrordernum, b.ptitle "
	SQL = sql & " from "
	SQL = sql & " (select pcode,pname,sum(rordernum) as sumrordernum "
	SQL = sql & " from v_tb_order "
	if session("Ausergubun")="3" then
		SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
		if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
			SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	SQL = sql & " and deflag = 'n' and flag = 'y' "
	'SQL = sql & " and carname = '"& carname &"' "
	SQL = sql & " and orderday >= '"& searcha &"' "
	SQL = sql & " and orderday <= '"& searchb &"' "
	SQL = sql & " and rordernum > 0 "
	SQL = sql & " group by pcode,pname) a "
	SQL = sql & " left outer join "
	SQL = sql & " (select pcode,ptitle from tb_product where usercode = '"& left(session("Ausercode"),5) &"') b "
	SQL = sql & " on a.pcode = b.pcode "
	SQL = sql & " order by a.pcode asc "
	rs.Open sql, db, 1
%>

<table border="1">
	<tr>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>구분</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25">체인점별집계</td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>주문일자</td>
		<td nowrap width="30%" bgcolor="#FFFFFF" height="25"><%=imsiday1%> ~ <%=imsiday2%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>수금금액</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25"><%=FormatCurrency(sumoney,0)%></td>
	</tr>
</table>

<table border=1>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>상품코드</td>
		<td width=45%>상품명</td>
		<td width=20%>규격</td>
		<td width=20%>배달수량</td>
	</tr>

<%
i=1
do until rs.EOF

	imsidcarname = rs(3)
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs(0)%></td>
		<td align=left> &nbsp; <%=rs(1)%></td>
		<td><%=imsidcarname%></td>
		<td align=right><%=rs(2)%> &nbsp; </td>
	</tr>

<%
rs.MoveNext 
i=i+1
loop
rs.close
%>

</table>

<BR>

<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.tcode,b.comname2, c.pcode,c.pname,isnull(c.pprice,0),isnull(c.sumrordernum,0) ,c.sumhap, c.usercode,d.ptitle "
	SQL = sql & " from "
	SQL = sql & " 		( select tcode,idx from tb_company where flag = '3' and bidxsub = "& left(session("Ausercode"),5) &" ) a "
	SQL = sql & " right outer join "
	SQL = sql & " 		(select comname2,usercode "
	SQL = sql & " 		from v_tb_order  "
				if session("Ausergubun")="3" then
					SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
					'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
					if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
						SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
					end if
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				else
					SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
				end if
	SQL = sql & " 		and deflag = 'n' and flag = 'y' and carname <> '' "
	'SQL = sql & " 		and carname = '"& carname &"' "
	SQL = sql & " 		and orderday >= '"& searcha &"' and orderday <= '"& searchb &"' "
	SQL = sql & " 		and rordernum>0  "
	SQL = sql & " 		group by comname2,usercode "
	SQL = sql & " 		) b "
	SQL = sql & " on a.idx = substring(b.usercode,11,5) "
		if session("Ausergubun")="3" then
			SQL = sql & " and substring(b.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if
	SQL = sql & " left outer join "
	SQL = sql & " 		(select pcode,pname,pprice,sum(rordernum) as sumrordernum , sum(rordernum*pprice) as sumhap, usercode "
	SQL = sql & " 		from v_tb_order "
				if session("Ausergubun")="3" then
					SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
					'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
					if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
						SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
					end if
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				else
					SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
				end if
	SQL = sql & " 		and deflag = 'n' and flag='y' "
	'SQL = sql & " 		and carname <> '' and carname = '"& carname &"' "
	SQL = sql & " 		and orderday >= '"& searcha &"' and orderday <= '"& searchb &"' "
	SQL = sql & " 		and rordernum > 0  "
	SQL = sql & " 		group by pcode,pname,pprice , usercode) c "
	SQL = sql & " on b.usercode = c.usercode "
	SQL = sql & " left outer join "
	SQL = sql & " 		(select pcode,ptitle from tb_product where usercode = '"& left(session("Ausercode"),5) &"') d "
	SQL = sql & " on d.pcode = c.pcode "
	SQL = sql & " order by b.comname2 asc, c.pcode asc "
'response.write sql
'response.end
	rs.Open sql, db, 1
%>

<%
i=1
imsihap = 0
tphap   = 0
tshap   = 0
ttphap  = 0
do until rs.EOF

	imsiimsitcode = rs(0)
	imsicomname2  = rs(1)
	newtcode = imsiimsitcode

	if i=1 then
		oldtcode = imsiimsitcode
	elseif newtcode<>oldtcode then
		response.write " <tr height=22 bgcolor=#FFFFFF align=center align=center>"
		response.write " <td colspan=3>합계</td>"
		response.write " <td align=right>"& FormatCurrency(tphap,0) &" &nbsp; </td>"
		response.write " <td>"& tshap &"</td>"
		response.write " <td align=right>"& FormatCurrency(ttphap,0) &" &nbsp; </td>"
		response.write " </tr>"
		response.write " </table>"

		response.write "<BR> "
		response.write "<table border='1'> "
		response.write "	<tr> "
		response.write "		<td nowrap bgcolor='#FFFFFF' height='25'> &nbsp; <B>[ "& imsicomname2 &" ("& imsiimsitcode &")]</td> "
		response.write "	</tr> "
		response.write "</table> "
		response.write "<table border=1> "
		response.write "	<tr height=28 bgcolor=#F7F7FF align=center> "
		response.write "		<td width='15%'>상품코드</td> "
		response.write "		<td width='25%'>상품명</td> "
		response.write "		<td width='15%'>규격</td> "
		response.write "		<td width='15%'>단가</td> "
		response.write "		<td width='10%'>배달수량</td> "
		response.write "		<td width='20%'>금액</td> "
		response.write "	</tr> "

		imsihap = 0
		tphap   = 0
		tshap   = 0
		ttphap  = 0
	end if

	'a.tcode,b.comname2, c.pcode,c.pname,c.pprice,c.sumrordernum ,c.sumhap, c.usercode,d.ptitle
	imsidcarname  = rs(8)
	rs2_pcode     = rs(2)
	rs2_pname     = rs(3)
	rs2_pprice    = rs(4)
	rs2_rordernum = rs(5)

	imsihap = CDbl(rs2_pprice)*CDbl(rs2_rordernum)
	tphap =CDbl(tphap)+CDbl(rs2_pprice)
	tshap =CDbl(tshap+rs2_rordernum)
	ttphap=CDbl(ttphap+imsihap)

%>

<%if i=1 then%>
<BR>

<table border="1">
	<tr>
		<td nowrap bgcolor="#FFFFFF" height="25"> &nbsp; <B>[ <%=imsicomname2%> (<%=imsiimsitcode%>)]</td>
	</tr>
</table>

<table border=1>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>상품코드</td>
		<td width=25%>상품명</td>
		<td width=15%>규격</td>
		<td width=15%>단가</td>
		<td width=10%>배달수량</td>
		<td width=20%>금액</td>
	</tr>
<%end if%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs2_pcode%></td>
		<td align=left> &nbsp; <%=rs2_pname%></td>
		<td><%=imsidcarname%></td>
		<td align=right><%=FormatCurrency(rs2_pprice,0)%> &nbsp; </td>
		<td><%=rs2_rordernum%></td>
		<td align=right><%=FormatCurrency(imsihap,0)%> &nbsp; </td>
	</tr>


<%
oldtcode = imsiimsitcode
rs.MoveNext 
i=i+1
loop
rs.close

response.write " <tr height=22 bgcolor=#FFFFFF align=center align=center>"
response.write " <td colspan=3>합계</td>"
response.write " <td align=right>"& FormatCurrency(tphap,0) &" &nbsp; </td>"
response.write " <td>"& tshap &"</td>"
response.write " <td align=right>"& FormatCurrency(ttphap,0) &" &nbsp; </td>"
response.write " </tr>"
response.write " </table>"

%>

<%
else

		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select carname,count(comname2),sum(rordermoney) "
		SQL = sql & " from tb_order "
		SQL = sql & " where flag = 'y' and deflag = 'n' and carname <> ''"

		if session("Ausergubun")="3" then
			SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if

		SQL = sql & " and orderday >= '"& searcha &"' "
		SQL = sql & " and orderday <= '"& searchb &"' "

		if searchc <> "0" then
			SQL = sql & " and carname = '"& searchc &"' "
		end if

		SQL = sql & " group by carname "
		SQL = sql & " order by carname asc"
		rs.Open sql, db, 1
%>

<table border=1>
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rs.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right></td>
	</tr>
</table>

<table border=1>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>번호</td>
		<td width=10%>호차</td>
		<td width=15%>기사명</td>
		<td width=25%>주문일자</td>
		<td width=20%>배달체인점수</td>
		<td width=20%>수금금액</td>
	</tr>

<%
i=1
do until rs.EOF

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarname "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and dcarno = '"& rs(0) &"' "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsidcarname = rs2(0)
	end if
	rs2.close
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><a href="write.asp?gotopage=<%=gotopage%>&sumoney=<%=rs(2)%>&searcha=<%=searcha%>&searchd=<%=searchd%>&searchb=<%=searchb%>&searchc=<%=searchc%>&carname=<%=rs(0)%>"><B><%=rs(0)%>호차</a></td>
		<td><%=imsidcarname%></td>
		<td><%=imsiday1%> ~ <%=imsiday2%></td>
		<td><%=rs(1)%></td>
		<td align=right><%=FormatCurrency(rs(2))%> &nbsp; </td>
	</tr>

</form>

<%
rs.MoveNext 
i=i+1
loop 
%>

</table>

<%end if%>

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
</html>