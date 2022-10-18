<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=excell4.xls"
%>
<!--#include virtual="/db/db.asp"-->
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	if searchc="y" then
		imsititle = "배달"
	elseif searchc="n" then
		imsititle = "주문"
	elseif searchc="" then
		imsititle = "주문/배달"
	end if

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	if searcha="" then
		searcha = replace(left(now(),10),"-","")
	end if

	if searchb="" then
		searchb = replace(left(now(),10),"-","")
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select pcode,pname,sum(ordernum)"
	SQL = sql & " from tb_order_product "
	SQL = sql & " where idx in "

	SQL = sql & " 	( "
	SQL = sql & " 	select idx from tb_order where deflag='n' "
	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
 	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	if (searcha<>"") and (len(searcha)=8) then
		SQL = sql & " and orderday >= '"& searcha &"' "
	end if
	if (searchb<>"") and (len(searchb)=8) then
		SQL = sql & " and orderday <= '"& searchb &"' "
	end if
	SQL = sql & " 	) "

	SQL = sql & " group by pcode,pname "
	SQL = sql & " order by pcode asc "
	rs.Open sql, db, 1
%>

<html>
<body>

<table border="1" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>번호</td>
		<td width=10%>상품코드</td>
		<td width=35%>상품명</td>
		<td width=15%>규격</td>
		<td width=15%>주문상태</td>
		<td width=15%>주문확인</td>
	</tr>

<%
i=1
do until rs.EOF

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select ptitle "
	SQL = sql & " from tb_product "
	SQL = sql & " where pcode = '"& rs(0) &"' "
	SQL = sql & " and usercode = '"& left(session("Ausercode"),5) &"' "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsidcarname = rs2(0)
	end if
	rs2.close

	set rs3 = server.CreateObject("ADODB.Recordset")
	SQL = " select sum(rordernum)"
	SQL = sql & " from tb_order_product "
	SQL = sql & " where pcode = '"& rs(0) &"' "
	SQL = sql & " and idx in "

	SQL = sql & " 	( "
	SQL = sql & " select idx from tb_order where deflag='n' and flag='y' "
	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
 	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	if (searcha<>"") and (len(searcha)=8) then
		SQL = sql & " and orderday >= '"& searcha &"' "
	end if
	if (searchb<>"") and (len(searchb)=8) then
		SQL = sql & " and orderday <= '"& searchb &"' "
	end if
	SQL = sql & " 	) "
	rs3.Open sql, db, 1
	imsiimsirordernum=rs3(0)
	rs3.close
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><%=rs(0)%></td>
		<td><%=rs(1)%></td>
		<td><%=imsidcarname%></td>
		<td align=right><%=rs(2)%> &nbsp; </td>
		<td align=right><%=imsiimsirordernum%> &nbsp; </td>
	</tr>

</form>

<%
rs.MoveNext 
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