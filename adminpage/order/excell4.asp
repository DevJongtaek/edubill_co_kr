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
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")

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
		searcha = replace(left(now()-1,10),"-","")
	end if

	if searchb="" then
		searchb = replace(left(now(),10),"-","")
	end If
	
	If searchd = "" Then 
		searchd = "000000"
	End If 

	If searche = "" then 
		searche = "235959"
	End If 

	startdate = searcha & searchd
	enddate = searchb & searche

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select  a.pcode,a.pname,isnull(a.sumordernum, 0) as sumordernum, b.ptitle, a.sumrordernum, isnull(b.pprice, 0) as pprice "
	SQL = sql & " from "
	SQL = sql & " 	(select pcode,pname,sum(ordernum) as sumordernum , sum(case when flag='y' then rordernum end) as sumrordernum "
	SQL = sql & " 	from v_tb_order "
	SQL = sql & " 	where deflag='n' and flag='y' AND ISNULL(Rgubun,0) != 1   "
			if session("Ausergubun")="3" then
				SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
 			else
				SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			end if
			If Len(startdate) = 14 And searchordertime = "y" Then 
				SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "			
			Else
				if (searcha<>"") and (len(searcha)=8) then
					SQL = sql & " and orderday >= '"& searcha &"' "
				end if
			end If
			If Len(enddate) = 14  And searchordertime = "y" Then 
				SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) "			
			Else
				if (searchb<>"") and (len(searchb)=8) then
					SQL = sql & " and orderday <= '"& searchb &"' "
				end if
			End If 
			if session("Ausergubun")="3" then
				'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
				if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
					SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
				end if
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			end if
	'SQL = sql & " 	and ordernum>0 group by pcode,pname) a "
    SQL = sql & "  group by pcode,pname) a "
	SQL = sql & " left outer join "
	SQL = sql & " 	(select pcode,ptitle,pprice from tb_product where usercode = '"& left(session("Ausercode"),5) &"' ) b "
	SQL = sql & " on a.pcode = b.pcode "
	SQL = sql & " order by a.pcode asc "
'response.write  sql
	rs.Open sql, db, 1
%>

<html>
<body>

<table border="1">
	<tr height=28 align=center>
		<td>번호</td>
		<td>상품코드</td>
		<td>상품명</td>
		<td>규격</td>

		<td>배달수량</td>
		<td>단가</td>
		<td>금액</td>
	</tr>

<%
i=1
imsihap1 = 0
imsihap2 = 0
imsihap3 = 0
imsihap4 = 0
do until rs.EOF

	'a.pcode,a.pname,a.sumordernum, b.ptitle, c.sumrordernum
	imsidcarname      = rs("ptitle")
    imsiimsirordernum = rs("sumrordernum")
	if imsiimsirordernum="" or isnull(imsiimsirordernum) then imsiimsirordernum=rs(2)
'	imsiimsirordernum = rs("sumrordernum")
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><%=rs(0)%></td>
		<td><%=rs(1)%></td>
		<td><%=imsidcarname%></td>

		<td align=right><%=formatnumber(imsiimsirordernum, 0)%> &nbsp; </td>
		<td align=right><%=formatnumber(rs("pprice"),0)%> &nbsp; </td>
		<!--<td align=right><%=formatnumber(rs("pprice")*imsiimsirordernum,0)%> &nbsp; </td>-->
        <td align=right><%if imsiimsirordernum=0 then%>0<%else%><%=formatnumber(imsiimsirordernum*rs("pprice"),0)%><%end if%> &nbsp; </td>
	</tr>

</form>

<%
if imsiimsirordernum="" then imsiimsirordernum=0
imsihap1 = imsihap1 + rs(2)
imsihap2 = imsihap2 + imsiimsirordernum
imsihap3 = imsihap3 + rs("pprice")
'imsihap4 = imsihap4 + (rs("pprice")*imsiimsirordernum)
imsihap4 = imsihap4 + (imsiimsirordernum*rs("pprice"))

rs.MoveNext 
i=i+1
loop 
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td colspan=4>합 계</td>
		<td align=right><%=formatnumber(imsihap2,0)%> &nbsp; </td>
		<td align=right><%=formatnumber(imsihap3,0)%> &nbsp; </td>
		<td align=right><%=formatnumber(imsihap4,0)%> &nbsp; </td>
	</tr>

</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>