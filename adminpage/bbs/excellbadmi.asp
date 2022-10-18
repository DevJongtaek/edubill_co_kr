<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=badmi.xls"
%>

<!--#include virtual="/db/db.asp"-->
<%
	imsititlename = "어플주문내역"
	'stxt1 = request("stxt1")
	'stxt2 = request("stxt2")
'	imsiwdate = request("imsiwdate")

	'if stxt2="" then
'		stxt2 = "Aym"
	'end if
'	if stxt1="" then
'		stxt1 = replace(left(now(),7),"-","")
'	end if

   ' if
		
	 searchd = request("searchd")
	 searche = request("searche")

	'GotoPage = Request("GotoPage")
	'if GotoPage = "" then
	'	GotoPage = 1
	'end if

set rslist = server.CreateObject("ADODB.Recordset")
	SQL = "  select a.orderidx,a.usercode ,b.comname, a.comname2,convert(varchar,a.createdate,120) as CreateDate,b.tcode from mobileorder as a join tb_company b on  SUBSTRING(a.usercode,1,5) = convert(varchar,b.idx) "
    
    SQL = sql & " and convert(varchar,a.createdate,112) >= '"& searchd &"' "
    SQL = sql & " and convert(varchar,a.createdate,112) <= '"& searche &"' "
    SQL = sql & " order by createdate desc "

	rslist.Open sql, db, 1

	

%>

<html>
<body>

<table border=1>
	<tr height=28 align=center>
		<td width=5%>번호</td>
		<td width=15%>코드</td>
		<td width=25%>회원사명</td>
		<td width="25%">체인점명</td>
        <td width="30%">주문일시</td>
	</tr>

<%
i=1

do until rslist.EOF 
   
	
	
	
%>
<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td><%=rslist("tcode")%></td>
		<td><%=rslist("comname")%></td>
      <td><%=rslist("comname2")%></td>
        <td><%=rslist("CreateDate")%></td>
	</tr>

<%
rslist.MoveNext 
i=i+1

loop
%>
	

</table>

<%
	rslist.close
	db.close
	set rs=nothing
	set rslist=nothing
	set db=nothing
%>

</body>
</html>