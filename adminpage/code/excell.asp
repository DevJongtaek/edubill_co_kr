<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=Sheet1.xls"
%>

<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,pcode,pname,pprice,ptitle,gubun,bigo,fileregcode,prochoice,proimage "
	SQL = sql & " from tb_product "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "

	if searcha <> "" then
		SQL = sql & " and "& searcha &" like '"& searchb &"%' "
	end if

	if searchc <> "" then
		SQL = sql & " and (cbrandchoice like '%"& searchc &"%' or cbrandchoice like '%00000%')"
	end if

	SQL = sql & " order by pcode asc"
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

<body leftmargin="0" topmargin="0" onLoad="MM_preloadImages('admin/menu01_1.gif','admin/menu02_1.gif','admin/menu03_1.gif','admin/menu04_1.gif','admin/menu05_1.gif')">

<table border=1>
	<tr height=28 align=center>
		<td>상품코드</td>
		<td>상품명</td>
		<td>규격</td>
		<td>단가</td>
		<td>구분</td>
		<td>비고</td>
		<td>파일생성코드</td>
		<td>서브매뉴</td>
		<td>상품사진명</td>
	</tr>

<%
do until rslist.EOF

	if rslist("prochoice")="" or isnull(rslist("prochoice")) then
		imsisname = ""
	else
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select sname "
		SQL = sql & " from tb_product_submenu "
		SQL = sql & " where sidx = "& rslist("prochoice") &" "
		rs.Open sql, db, 1
		if not rs.eof then
			imsisname = rs(0)
		end if
		rs.close
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td class='accountnum'><%=cstr(rslist("pcode"))%></td>
		<td><%=rslist("pname")%></td>
		<td><%=rslist("ptitle")%></td>
		<td><%=rslist("pprice")%></td>
		<td><%=rslist("gubun")%></td>
		<td><%=rslist("bigo")%></td>
		<td class='accountnum'><%=rslist("fileregcode")%></td>

		<td><%=imsisname%></td>
		<td><%=rslist("proimage")%></td>
	</tr>

</form>

<%
rslist.MoveNext 
loop 
%>

</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>