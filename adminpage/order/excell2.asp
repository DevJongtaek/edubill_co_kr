<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename="&replace(left(now(),10),"-","")&".xls"
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
	SQL = " select usercode,comname1,comname2,orderday,ordermoney,carname,ordering,flag,deflagday,idx "
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
	imsiidx = rslist(9)
	rslist.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(right(usercode,5)) &" "
	rs.Open sql, db, 1
	imsitcode=rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select pidx,idx,pcode,pname,pprice,ordernum,rordernum "
	SQL = sql & " from tb_order_product "
	SQL = sql & " where idx = '"& idx &"' "
	SQL = sql & " order by pcode asc"
	rs.Open sql, db, 1
%>

<html>
<body>

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

	if len(rs("ordernum"))=5 then
		imsirsordernum = rs("ordernum")
	elseif len(rs("ordernum"))=4 then
		imsirsordernum = rs("ordernum")&"&nbsp;"
	elseif len(rs("ordernum"))=3 then
		imsirsordernum = rs("ordernum")&"&nbsp;&nbsp;"
	elseif len(rs("ordernum"))=2 then
		imsirsordernum = rs("ordernum")&"&nbsp;&nbsp;&nbsp;"
	elseif len(rs("ordernum"))=1 then
		imsirsordernum = rs("ordernum")&"&nbsp;&nbsp;&nbsp;&nbsp;"
	elseif len(rs("ordernum"))=0 then
		imsirsordernum = rs("ordernum")&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	end if
%>
<%=left(rs("idx"),8)%><%=rs("pcode")%><%=imsitcode%><%=imsirsordernum%><BR>
<%
rs.MoveNext 
loop 
%>

</body>
</html>