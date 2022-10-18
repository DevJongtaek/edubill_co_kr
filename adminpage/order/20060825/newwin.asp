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
		<td><%if imsidcarname<>"" then%><%=imsidcarname%><%else%>&nbsp;<%end if%></td>
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

<BR>



				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>