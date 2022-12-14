<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=상품별집계표(체인)"&replace(left(now(),10),"-","")&".xls"
%>

<!--#include virtual="/db/db.asp"-->
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")

	if searcha="" then
		searcha = replace(left(now()-1,10),"-","")
	end if

	if searchb="" then
		searchb = replace(left(now(),10),"-","")
	end if

	If searchd = "" Then 
		searchd = "000000"
	End If 

	If searche = "" then 
		searche = "235959"
	End If 

	startdate = searcha & searchd
	enddate = searchb & searche

	sqlmake = ""
	fieldCount = 0
	rowCount = 0
	set rs1 = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT	idx, comname, tcode "
	SQL = SQL & " FROM          tb_company "
	SQL = SQL & " WHERE      (bidxsub = '"& left(session("Ausercode"),5) &"') AND (flag = 3) "
	SQL = SQL & " order by tcode "
    'response.write  sql
	rs1.Open SQL, db, 1
	do while (Not rs1.EOF)
		imsiidx = rs1(0)
		imsiname = rs1(1)
		imsicode = rs1(2)
		sqlmake = sqlmake & " convert(varchar, isnull(sum(case SUBSTRING(usercode, 11, 5) when '" & imsiidx & "' then rordernum end ), 0)) '" & imsiname & "(" & imsicode & ")', "
	rs1.MoveNext
	Loop
	
	sqlmake = Left(sqlmake, Len(sqlmake) -2)
response.write titlemake & "<br>"
	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = "select B.pcode , B.pname, C.ptitle, SUM(B.rordernum) as 합계, "
	SQL = SQL & sqlmake
	SQL = SQL & " from tb_order A left join "
	SQL = SQL & " tb_order_product B  "
	SQL = SQL & " on A.idx = B.idx  "
	SQL = SQL & " left join (select pcode,ptitle,pprice from tb_product where usercode = '"& left(session("Ausercode"),5) &"') C "
	SQL = SQL & " on C.pcode = B.pcode "
	SQL = SQL & " where deflag='n' and A.flag='y'  "
	SQL = SQL & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	If Len(startdate) = 14 And searchf = "y" Then 
		SQL = SQL & " and convert(datetime, left(A.idx, 4) + '-' + substring(A.idx, 5, 2) + '-' + substring(A.idx, 7, 2) + ' ' + substring(A.idx, 9, 2) + ':' + substring(A.idx, 11, 2) + ':' + substring(A.idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "			
	Else
		SQL = SQL & " and orderday >= '"& searcha &"' "
	End If 
	If Len(enddate) = 14  And searchf = "y" Then 
		SQL = SQL & " and convert(datetime, left(A.idx, 4) + '-' + substring(A.idx, 5, 2) + '-' + substring(A.idx, 7, 2) + ' ' + substring(A.idx, 9, 2) + ':' + substring(A.idx, 11, 2) + ':' + substring(A.idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) "			
	Else
		SQL = SQL & " and orderday <= '"& searchb &"' "	
	End If 
	SQL = SQL & " and B.pcode is not null "
	SQL = SQL & " group by B.pcode, B.pname, C.ptitle "
	SQL = SQL & " union "
	SQL = SQL & " select '합계', '', '', SUM(B.rordernum), "
	SQL = SQL & sqlmake
	SQL = SQL & " from tb_order A left join "
	SQL = SQL & " tb_order_product B " 
	SQL = SQL & " on A.idx = B.idx "
	SQL = SQL & " where deflag='n' and A.flag='y' "
	SQL = SQL & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	If Len(startdate) = 14 And searchf = "y" Then 
		SQL = SQL & " and convert(datetime, left(A.idx, 4) + '-' + substring(A.idx, 5, 2) + '-' + substring(A.idx, 7, 2) + ' ' + substring(A.idx, 9, 2) + ':' + substring(A.idx, 11, 2) + ':' + substring(A.idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "			
	Else
		SQL = SQL & " and orderday >= '"& searcha &"' "
	End If 
	If Len(enddate) = 14  And searchf = "y" Then 
		SQL = SQL & " and convert(datetime, left(A.idx, 4) + '-' + substring(A.idx, 5, 2) + '-' + substring(A.idx, 7, 2) + ' ' + substring(A.idx, 9, 2) + ':' + substring(A.idx, 11, 2) + ':' + substring(A.idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) "			
	Else
		SQL = SQL & " and orderday <= '"& searchb &"' "
	End If 
	SQL = SQL & " and B.pcode is not null "
	SQL = SQL & " order by B.pcode "
    'response.write  SQL
	rs2.Open SQL, db, 1
	'필드 카운트 저장
	fieldCount = rs2.Fields.Count
	rowCount = rs2.RecordCount
	'fiedlCount = rs2.Fields.Count 
	'do while (Not rs.EOF)
		'response.write rs(0) & "|" & rs(0) & "|" & rs(1) & "|" & rs(2) & "|" & rs(3) & "|" & rs(4) & "|" & rs(5) & "|" & rs(6) & "|" & rs(7) & "|" & "<br>"
	'rs.MoveNext
	'Loop
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
</head>
<body>

<table border="1">
	<tr> 
		<td colspan="<%=fieldCount + 1%>" align="center" height="35"><font color="blue" size =4>지사별 주문상품 집계표</font></td>
	</tr>
	<tr>
		<td colspan="<%=fieldCount + 1%>">■ 기간 : <%=searcha%> - <%=searchb%></td>
	</tr>
	<tr height=28 align=center>
		<th bgcolor="yellow">번호</th>
		<th bgcolor="yellow">상품코드</th>
		<th bgcolor="yellow">상품명</th>
		<th bgcolor="yellow">규격</th>
		<th bgcolor="yellow">합계</th>
	<%  
    set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT	idx, comname, tcode "
	SQL = SQL & " FROM          tb_company "
	SQL = SQL & " WHERE      (bidxsub = '"& left(session("Ausercode"),5) &"') AND (flag = 3) "
	SQL = SQL & " order by tcode "
    'response.write  sql
	rs.Open SQL, db, 1
	do while (Not rs.EOF)
	%>
		<th bgcolor="yellow"><%=rs(1)%>(<%=rs(2)%>)</th>
	<%
	rs.MoveNext
	Loop 
	%>

	</tr>
<%
count = 1
do until rs2.EOF
%>
	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<% If (count = rowcount) Then %>
			<td bgcolor="yellow"><b>합계</b></td>
			<td bgcolor="yellow"></td>
			<td bgcolor="yellow"></td>
			<td bgcolor="yellow"></td>
		<%	Else %>
			<td><%=count%></td>
			<td><%=rs2(0)%></td>
			<td><%=rs2(1)%></td>
			<td><%=rs2(2)%></td>
		<%	End If 
			%></td>

<% For i = 3 To fieldCount - 1 
	If (count = rowcount) Then %>
		<td bgcolor="yellow" align ="right"><b><%=FormatNumber(rs2(i), 0)%></b></td>
<% Else %>
		<td align ="right"><%=FormatNumber(rs2(i), 0)%></td>
<% End If 
   Next %>
	</tr>
	<%
	rs2.MoveNext
	count = count + 1
	Loop 
	%>
</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>