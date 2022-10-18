<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=order2.xls"
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

	if searchg="" then
		searchg = "0"
	end if

	fclass1 = Request("fclass1")
	sclass2 = Request("sclass2")
	tclass3 = Request("tclass3")
	imsifclass1 = right(Request("fclass1"),5)
	imsisclass2 = right(Request("sclass2"),5)
	imsitclass3 = right(Request("tclass3"),5)

	idx = Request("idx")
	GotoPage = Request("GotoPage")

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select usercode,comname1,comname2,orderday,ordermoney,carname,ordering,flag,deflagday "
	SQL = sql & " from tb_order "
	SQL = sql & " where idx = '"& idx &"' "
	rslist.Open sql, db, 1
	usercode = rslist(0)
	comname1 = rslist(1)
	comname2 = rslist(2)
	orderday = rslist(3)
	ordermoney = rslist(4)
	carname = rslist(5)
	ordering = rslist(6)
	flag = rslist(7)
	deflagday = rslist(8)
	if deflagday="" or isnull(rslist(8)) then
		imsideflagdayint=0
		deflagday=replace(left(now(),10),"-","")
	else
		imsideflagdayint=1
		deflagday=deflagday
	end if
	rslist.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select pidx,idx,pcode,pname,pprice,ordernum,rordernum "
	SQL = sql & " from tb_order_product "
	SQL = sql & " where idx = '"& idx &"' "
	SQL = sql & " order by pcode asc"
	rs.Open sql, db, 1
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
		<td><font color=blue size=3><B>[ 주문내역 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height="25">
		<td nowrap width="10%" bgcolor="#F7F7FF" align=center><B>주문일자</td>
		<td nowrap width="15%" bgcolor="#FFFFFF"><%=left(orderday,4)%>/<%=mid(orderday,5,2)%>/<%=right(orderday,2)%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" align=center><B>지사(점)명</td>
		<td nowrap width="15%" bgcolor="#FFFFFF"><%=comname1%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" align=center><B>체인점명</td>
		<td nowrap width="15%" bgcolor="#FFFFFF"><%=comname2%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" align=center><B>호차</td>
		<td nowrap width="15%" bgcolor="#FFFFFF"><%=carname%>호차</td>
	</tr>
</table>

<BR>

<table border=1 cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>상품코드</td>
		<td width=20%>상품명</td>
		<td width=15%>규격</td>
		<td width=15%>단가</td>
		<td width=10%>주문수량</td>
		<td width=20%>금액</td>
		<td width=10%>배달수량</td>
	</tr>

<%
imsihap1 = 0
imsihap2 = 0
imsihap3 = 0
imsihap4 = 0
imsinumpage = rs.recordcount

do until rs.EOF

	imsihap1 = imsihap1+int(rs("pprice"))
	imsihap2 = imsihap2+int(rs("ordernum"))
	if flag = "n" then
		imsihap3 = imsihap3+(int(rs("ordernum"))*int(rs("pprice")))
		imsihap4 = imsihap4+int(rs("ordernum"))
	else
		imsihap3 = imsihap3+(int(rs("rordernum"))*int(rs("pprice")))
		imsihap4 = imsihap4+int(rs("rordernum"))
	end if

	imsiptitle = ""
	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select ptitle "
	SQL = sql & " from tb_product "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and pcode = '"& rs("pcode") &"' "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsiptitle = rs2(0)
	end if
	rs2.close

%>

<input type=hidden name=pidx value="<%=rs("pidx")%>">

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs("pcode")%></td>
		<td align=left>&nbsp;<%=rs("pname")%></td>
		<td><%=imsiptitle%></td>
		<td align=right><%=FormatCurrency(rs("pprice"))%>&nbsp;</td>
		<td><%=rs("ordernum")%></td>
		<%if flag = "n" then%>
			<td align=right><%=FormatCurrency(int(rs("ordernum"))*int(rs("pprice")))%>&nbsp;</td>
			<td><%=rs("ordernum")%></td>
		<%else%>
			<td align=right><%=FormatCurrency(int(rs("rordernum"))*int(rs("pprice")))%>&nbsp;</td>
			<td><%=rs("rordernum")%></td>
		<%end if%>

	</tr>

<%
rs.MoveNext 
loop 
%>

	<tr height=22 bgcolor=#F7F7FF align=center align=center>
		<td colspan=3>합 계</td>
		<td align=right><%=FormatCurrency(imsihap1)%>&nbsp;</td>
		<td><%=imsihap2%></td>
		<td align=right><%=FormatCurrency(imsihap3)%>&nbsp;</td>
		<td><%=imsihap4%></td>
	</tr>
</table>


				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>