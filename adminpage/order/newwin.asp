<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
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
		searcha = replace(left(now()-1,10),"-","")
	end if

	if searchb="" then
		searchb = replace(left(now(),10),"-","")
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select  a.pcode,a.pname,a.sumordernum, b.ptitle, a.sumrordernum, b.pprice "
	SQL = sql & " from "
	SQL = sql & " 	(select pcode,pname,sum(ordernum) as sumordernum , sum(case when flag='y' then rordernum end) as sumrordernum "
	SQL = sql & " 	from v_tb_order "
	SQL = sql & " 	where deflag='n'  and flag='y' "
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
			if session("Ausergubun")="3" then
				'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
				if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
					SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
				end if
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			end if
	SQL = sql & " 	and ordernum>0 group by pcode,pname) a "
	SQL = sql & " left outer join "
	SQL = sql & " 	(select pcode,ptitle,pprice from tb_product where usercode = '"& left(session("Ausercode"),5) &"' ) b "
	SQL = sql & " on a.pcode = b.pcode "
	SQL = sql & " order by a.pcode asc "
'response.write  sql
	rs.Open sql, db, 1
%>

<html>
<head>
<title>상품별 집계표</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style>
TD {font: 9pt 굴림;}
A   {font: 9pt 굴림; text-decoration: none}
A:link    {font: 9pt 굴림; color:#555555; text-decoration: none}
A:visited {font: 9pt 굴림; color:#555555; text-decoration: none}
A:hover   {font: 9pt 굴림; color:#555555; text-decoration: none;}
A.sssss:hover{font: 9pt 굴림;text-decoration: underline;}
A.autopro:link { color:#0000FF; font-size: 9pt; font-weight: lighter; text-decoration: none; font-family: "굴림"}
</style>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="window.print();">

<table width="650" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 상품별 집계표 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr>
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25" align=center><B>주문일자</td>
		<td nowrap width="70%" bgcolor="#FFFFFF" height="25"><%=left(searcha,4)%>-<%=mid(searcha,5,2)%>-<%=right(searcha,2)%> ~ <%=left(searchb,4)%>-<%=mid(searchb,5,2)%>-<%=right(searchb,2)%></td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="0" width=100% bordercolor=silver STYLE="border:0.5px;">
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>번호</td>
		<td width=10%>상품코드</td>
		<td width=25%>상품명</td>
		<td width=15%>규격</td>
		<td width=10%>배달수량</td>
		<td width=15%>단가</td>
		<td width=15%>금액</td>
	</tr>

<%
i=1
hap1 = 0
hap2 = 0
do until rs.EOF

	'a.pcode,a.pname,a.sumordernum, b.ptitle, a.sumrordernum, b.pprice
	imsidcarname      = rs("ptitle")
	imsiimsirordernum = rs("sumrordernum")
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><%=rs(0)%></td>
		<td><%=rs(1)%></td>
		<td><%if imsidcarname<>"" then%><%=imsidcarname%><%else%>&nbsp;<%end if%></td>
		<td align=right><%=formatnumber(rs(4),0)%> &nbsp; </td>
		<td align=right><%=formatnumber(rs(5),0)%> &nbsp; </td>
		<td align=right><%=formatnumber(rs(4)*rs(5),0)%> &nbsp; </td>
	</tr>

<%
	hap1 = hap1+rs(4)
	hap2 = hap2+(rs(5)*rs(4))
rs.MoveNext 
i=i+1
loop 
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td colspan=4>합 계</td>
		<td align=right><%=formatnumber(hap1,0)%> &nbsp; </td>
		<td>&nbsp;</td>
		<td align=right><%=formatnumber(hap2,0)%> &nbsp; </td>
	</tr>

</table>

<BR>



				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>