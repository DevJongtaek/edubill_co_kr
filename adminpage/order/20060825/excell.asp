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

	if searchg="" then
		searchg = "0"
	end if
	if searchc="" then
		searchc = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if

	if searchd="" then
		searchd = replace(left(now(),10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select orderreg "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag='1' "
	SQL = sql & " and idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	imsiorderreg = rs(0)
	rs.close

	if imsiorderreg="y" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,usercode,ordermoney "
		SQL = sql & " from tb_order"
		SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		SQL = sql & " and substring(idx,1,8) = '"& replace(left(now(),10),"-","") &"' "
		SQL = sql & " and flag = 'n' and deflag = 'n' "
		rs.Open sql, db, 1

		do until rs.eof
			SQL = "update tb_order set "
			SQL = SQL & " flag = 'y' ,"
			SQL = SQL & " ordering = '9' ,"
			SQL = SQL & " rordermoney = "&rs(2)&" ,"
			SQL = SQL & " edate = '"& now() &"', "
			SQL = SQL & " euserid = '"& session("Auserid") &"' "
			SQL = SQL & " where idx = '"& rs(0) &"' "
			db.Execute SQL

			set rs2 = server.CreateObject("ADODB.Recordset")
			SQL = " select pidx,ordernum "
			SQL = sql & " from tb_order_product"
			SQL = sql & " where idx = '"& rs(0) &"' "
			rs2.Open sql, db, 1

			do until rs2.eof
				SQL = "update tb_order_product set "
				SQL = SQL & " rordernum = "& rs2(1) &" ,"
				SQL = SQL & " edate = '"& now() &"', "
				SQL = SQL & " euserid = '"& session("Auserid") &"' "
				SQL = SQL & " where pidx = "& rs2(0)
				db.Execute SQL
			rs2.movenext
			loop
			rs2.close
		rs.movenext
		loop
		rs.close

	end if
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	fclass1 = Request("fclass1")
	sclass2 = Request("sclass2")
	tclass3 = Request("tclass3")
	imsifclass1 = right(Request("fclass1"),5)
	imsisclass2 = right(Request("sclass2"),5)
	imsitclass3 = right(Request("tclass3"),5)

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,usercode,comname1,comname2,orderday,ordermoney,carname,ordering,flag,wdate,rordermoney,deflagday,sendhpnum "
	SQL = sql & " from tb_order "

	if session("Ausergubun")="3" then
		SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	SQL = sql & " and idx in (select idx from tb_order_product) "

	if searcha="1" then
		SQL = sql & " and flag = 'n' "
	elseif searcha="2" then
		SQL = sql & " and flag = 'y' and deflag='n' "
	elseif searcha="3" then
		SQL = sql & " and flag = 'y' and deflag='y' "
	end if

	if searchc <> "" and searchc <> "0" then
		SQL = sql & " and substring(usercode,6,5) = '"& searchc &"' "
	end if

	if searchf <> "" and searchf <> "0" then
		SQL = sql & " and substring(usercode,11,5) = '"& searchf &"' "
	end if

	if searchd <> "" then
		SQL = sql & " and orderday >= '"& searchd &"' "
	end if

	if searche <> "" then
		SQL = sql & " and orderday <= '"& searche &"' "
	end if

	if searchg<>"0" then
		SQL = sql & " and  carname = '"& searchg &"' "
	end if

	if imsifclass1<>"" then
		SQL = sql & " and  substring(usercode,1,5) = '"& imsifclass1 &"' "
	end if

	if imsisclass2<>"" then
		SQL = sql & " and  substring(usercode,6,5) = '"& imsisclass2 &"' "
	end if

	if imsitclass3<>"" then
		SQL = sql & " and  substring(usercode,11,5) = '"& imsitclass3 &"' "
	end if

	if searchh = "1" then
		SQL = sql & " and (FtpFile <> '' and FtpFile is not null)"
	elseif searchh = "2" then
		SQL = sql & " and (FtpFile = '' and FtpFile is null)"
	end if

	SQL = sql & " order by idx desc"
	rslist.Open sql, db, 1

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

	if session("Ausergubun")="3" then	'지사로그인시만 체인점정보를 가져옴
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,comname "
		SQL = sql & " from tb_company "
		SQL = sql & " where flag = '3' "
		SQL = sql & " and bidxsub = '"& left(session("Ausercode"),5) &"' "
		SQL = sql & " and idxsub  = '"& mid(session("Ausercode"),6,5) &"' "
		SQL = sql & " order by comname asc"
		rs.Open sql, db, 1
		if not rs.eof then
			barray = rs.GetRows
			barrayint = ubound(barray,2)
		else
			barray = ""
			barrayint = ""
		end if
		rs.close
	end if
%>

<html>
<body>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 주문관리 ]</td>
	</tr>
</table>

<table border=1 cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=7%>코드</td>
		<td width=16%>체인점명</td>
		<td width=17%>주문일시</td>
		<td width=11%>금액</td>
		<td width=9%>호차</td>
		<td width=9%>기사명</td>
		<td width=13%>핸드폰번호</td>
		<td width=11%>배달일자</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF

	imsidaytime = left(rslist("idx"),4)&"/"&mid(rslist("idx"),5,2)&"/"&mid(rslist("idx"),7,2)
	imsidaytime = imsidaytime&" "&mid(rslist("idx"),9,2)&":"&mid(rslist("idx"),11,2)&":"&mid(rslist("idx"),13,2)

	imsimoney=0
	if rslist("flag")="y" then
		imsimoney=rslist("rordermoney")
	else
		imsimoney=rslist("ordermoney")
	end if

	imsidcarname = ""
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarname "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and dcarno = '"& rslist("carname") &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		imsidcarname = rs(0)
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = '"& right(rslist("usercode"),5) &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		imsitcode = rs(0)
	end if
	rs.close


%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=imsitcode%></td>
		<td><a href="write.asp?gotopage=<%=gotopage%>&flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><b><%=rslist("comname2")%></a></td>
		<td><%=imsidaytime%></td>
		<td align=right><%=FormatCurrency(imsimoney)%>&nbsp;</td>
		<td><%=rslist("carname")%>호차</td>
		<td><%=imsidcarname%></td>
		<td><%=rslist("sendhpnum")%></td>
		<td>
			<%if rslist("flag")="n" then%>
			<%elseif rslist("flag")="y" then%>
				<%if rslist("deflagday")="" or isnull(rslist("deflagday")) then%>
					주문확인
				<%else%>
					<%=left(rslist("deflagday"),4)%>/<%=mid(rslist("deflagday"),5,2)%>/<%=right(rslist("deflagday"),2)%>
				<%end if%>
			<%end if%>
		</td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
%>

</form>

</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>