<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	imsiday1 = left(searcha,4)&"/"&mid(searcha,5,2)&"/"&right(searcha,2)
	imsiday2 = left(searchb,4)&"/"&mid(searchb,5,2)&"/"&right(searchb,2)

	carname = Request("carname")
	sumoney = request("sumoney")
	pgubun = request("pgubun")
	if pgubun="" then
		pgubun="0"
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarname "
	SQL = sql & " from tb_car "
	SQL = sql & " where dcarno = '"& carname &"' and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	rs.Open sql, db, 1
	imsicarname = rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pcode,a.pname,a.sumrordernum, b.ptitle "
	SQL = sql & " from "
	SQL = sql & " (select pcode,pname,sum(rordernum) as sumrordernum "
	SQL = sql & " from v_tb_order "
	if session("Ausergubun")="3" then
		SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
		if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
			SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	SQL = sql & " and deflag = 'n' and flag = 'y' and carname = '"& carname &"' "
	SQL = sql & " and orderday >= '"& searcha &"' "
	SQL = sql & " and orderday <= '"& searchb &"' "
	SQL = sql & " and rordernum > 0 "
	SQL = sql & " group by pcode,pname) a "
	SQL = sql & " left outer join "
	SQL = sql & " (select pcode,ptitle from tb_product where usercode = '"& left(session("Ausercode"),5) &"') b "
	SQL = sql & " on a.pcode = b.pcode "
	SQL = sql & " order by a.pcode asc "
	rs.Open sql, db, 1


%>

<html>
<head>
<title>호차별총집계표</title>
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

<table width="100%" border=0 cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">

<form action=newwin.asp method=post name=form>
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=carname value="<%=carname%>">
<input type=hidden name=sumoney value="<%=sumoney%>">

	<tr height="47">
		<td width=50%><font color=blue size=3><B>[ <%if pgubun="0" or pgubun="1" then%>호차별 총<%else%>체인점별<%end if%> 집계표 ]</td>
		<td width=50% align=right>
			<select name=prinFlag>
				<option value=1 <%if prinFlag="1" then%>selected<%end if%>>전체인쇄
				<option value=2 <%if prinFlag="2" then%>selected<%end if%>>체인점별인쇄
			</select>
			<select name=pgubun>
				<option value=0 <%if pgubun="0" then%>selected<%end if%>>전체
				<option value=1 <%if pgubun="1" then%>selected<%end if%>>호차별총집계
				<option value=2 <%if pgubun="2" then%>selected<%end if%>>체인점별집계
			</select> <input type=submit value="확인">
		</td>
	</tr>
</form>
</table>

<table border=1 cellspacing=0 cellpadding=0 bgcolor=black width="100%" bordercolor=silver STYLE="border:0.5px;">

<form action="list.asp" method="POST" name=kindform>
	<tr align=center>
		<td nowrap width="8%" bgcolor="#F7F7FF" height="25"><B>호 차</td>
		<td nowrap width="8%" bgcolor="#FFFFFF" height="25"><%=carname%>호차</td>
		<td nowrap width="8%" bgcolor="#F7F7FF" height="25" align=center><B>기사명</td>
		<td nowrap width="15%" bgcolor="#FFFFFF" height="25"><%=imsicarname%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>주문일자</td>
		<td nowrap width="25%" bgcolor="#FFFFFF" height="25"><%=imsiday1%> ~ <%=imsiday2%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>수금금액</td>
		<td nowrap width="16%" bgcolor="#FFFFFF" height="25"><%=FormatCurrency(sumoney,0)%></td>
	</tr>

</form>

</table>

<%if pgubun="0" or pgubun="1" then%>

<table border=1 cellspacing=0 cellpadding=0 width=100% bgcolor=black bordercolor=silver STYLE="border:0.5px;">
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>상품코드</td>
		<td width=45%>상품명</td>
		<td width=20%>규격</td>
		<td width=20%>배달수량</td>
	</tr>

<%
i=1
do until rs.EOF
	imsidcarname = rs(3)
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs(0)%></td>
		<td align=left> &nbsp; <%=rs(1)%></td>
		<td><%if imsidcarname<>"" then%><%=imsidcarname%><%else%>&nbsp;<%end if%></td>
		<td align=right><%=rs(2)%> &nbsp; </td>
	</tr>

<%
rs.MoveNext 
i=i+1
loop
rs.close
%>

</table>

<BR>
<%end if%>

<%if pgubun="2" or pgubun="0" then%>

<%if  pgubun="0" then%>
<table width="100%" border=0 cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td width=50%><font color=blue size=3><B>[ 체인점별 집계표 ]</td>
		</td>
	</tr>
</table>
<%end if%>

<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.tcode,b.comname2, c.pcode,c.pname,isnull(c.pprice,0),isnull(c.sumrordernum,0) ,c.sumhap, c.usercode,d.ptitle "
	SQL = sql & " from "
	SQL = sql & " 		( select tcode,idx from tb_company where flag = '3' and bidxsub = "& left(session("Ausercode"),5) &" ) a "
	SQL = sql & " right outer join "
	SQL = sql & " 		(select comname2,usercode "
	SQL = sql & " 		from v_tb_order  "
				if session("Ausergubun")="3" then
					SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
					'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
					if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
						SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
					end if
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				else
					SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
				end if
	SQL = sql & " 		and deflag = 'n' and flag = 'y' and carname <> '' and carname = '"& carname &"' "
	SQL = sql & " 		and orderday >= '"& searcha &"' and orderday <= '"& searchb &"' "
	SQL = sql & " 		and rordernum>0  "
	SQL = sql & " 		group by comname2,usercode "
	SQL = sql & " 		) b "
	SQL = sql & " on a.idx = substring(b.usercode,11,5) "
		if session("Ausergubun")="3" then
			SQL = sql & " and substring(b.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if
	SQL = sql & " left outer join "
	SQL = sql & " 		(select pcode,pname,pprice,sum(rordernum) as sumrordernum , sum(rordernum*pprice) as sumhap, usercode "
	SQL = sql & " 		from v_tb_order "
				if session("Ausergubun")="3" then
					SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
					'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
					if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
						SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
					end if
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				else
					SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
				end if
	SQL = sql & " 		and deflag = 'n' and flag='y' and carname <> '' and carname = '"& carname &"' "
	SQL = sql & " 		and orderday >= '"& searcha &"' and orderday <= '"& searchb &"' "
	SQL = sql & " 		and rordernum > 0  "
	SQL = sql & " 		group by pcode,pname,pprice , usercode) c "
	SQL = sql & " on b.usercode = c.usercode "
	SQL = sql & " left outer join "
	SQL = sql & " 		(select pcode,ptitle from tb_product where usercode = '"& left(session("Ausercode"),5) &"') d "
	SQL = sql & " on d.pcode = c.pcode "
	SQL = sql & " order by b.comname2 asc, c.pcode asc "
'response.write sql
'response.end
	rs.Open sql, db, 1
%>



<%
i=1
imsihap = 0
tphap   = 0
tshap   = 0
ttphap  = 0
do until rs.EOF

	imsiimsitcode = rs(0)
	imsicomname2  = rs(1)
	newtcode = imsiimsitcode

	if i=1 then
		oldtcode = imsiimsitcode
	elseif newtcode<>oldtcode then
		response.write " <tr height=22 bgcolor=#FFFFFF align=center align=center>"
		response.write " <td colspan=3>합계</td>"
		response.write " <td align=right>"& FormatCurrency(tphap,0) &" &nbsp; </td>"
		response.write " <td>"& tshap &"</td>"
		response.write " <td align=right>"& FormatCurrency(ttphap,0) &" &nbsp; </td>"
		response.write " </tr>"
		response.write " </table>"

		response.write "<BR> "
		response.write "<table border=1 STYLE='border:0.5px;' cellspacing='0' cellpadding='2' bordercolorlight='#BDCBE7' bordercolordark='#FFFFFF' width='100%'> "
		response.write "	<tr> "
		response.write "		<td nowrap bgcolor='#FFFFFF' height='25'> &nbsp; <B>[ "& imsicomname2 &" ("& imsiimsitcode &")]</td> "
		response.write "	</tr> "
		response.write "</table> "
		response.write "<table border=1 STYLE='border:0.5px;' cellspacing='1' cellpadding='1' width=100% bgcolor=#BDCBE7> "
		response.write "	<tr height=28 bgcolor=#F7F7FF align=center> "
		response.write "		<td width='15%'>상품코드</td> "
		response.write "		<td width='25%'>상품명</td> "
		response.write "		<td width='15%'>규격</td> "
		response.write "		<td width='15%'>단가</td> "
		response.write "		<td width='10%'>배달수량</td> "
		response.write "		<td width='20%'>금액</td> "
		response.write "	</tr> "

		imsihap = 0
		tphap   = 0
		tshap   = 0
		ttphap  = 0
	end if

	'a.tcode,b.comname2, c.pcode,c.pname,c.pprice,c.sumrordernum ,c.sumhap, c.usercode,d.ptitle
	imsidcarname  = rs(8)
	rs2_pcode     = rs(2)
	rs2_pname     = rs(3)
	rs2_pprice    = rs(4)
	rs2_rordernum = rs(5)

	imsihap = CDbl(rs2_pprice)*CDbl(rs2_rordernum)
	tphap =CDbl(tphap)+CDbl(rs2_pprice)
	tshap =CDbl(tshap+rs2_rordernum)
	ttphap=CDbl(ttphap+imsihap)

%>

<%if i=1 then%>
<BR>

<table border=1 STYLE="border:0.5px;" cellspacing="0" cellpadding="2" bordercolorlight="#BDCBE7" bordercolordark="#FFFFFF" width="100%">
	<tr>
		<td nowrap bgcolor="#FFFFFF" height="25"> &nbsp; <B>[ <%=imsicomname2%> (<%=imsiimsitcode%>)]</td>
	</tr>
</table>

<table border=1 STYLE="border:0.5px;" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>상품코드</td>
		<td width=25%>상품명</td>
		<td width=15%>규격</td>
		<td width=15%>단가</td>
		<td width=10%>배달수량</td>
		<td width=20%>금액</td>
	</tr>
<%end if%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs2_pcode%></td>
		<td align=left> &nbsp; <%=rs2_pname%></td>
		<td><%=imsidcarname%></td>
		<td align=right><%=FormatCurrency(rs2_pprice,0)%> &nbsp; </td>
		<td><%=rs2_rordernum%></td>
		<td align=right><%=FormatCurrency(imsihap,0)%> &nbsp; </td>
	</tr>


<%
oldtcode = imsiimsitcode
rs.MoveNext 
i=i+1
loop
rs.close

db.close
set db=nothing

response.write " <tr height=22 bgcolor=#FFFFFF align=center align=center>"
response.write " <td colspan=3>합계</td>"
response.write " <td align=right>"& FormatCurrency(tphap,0) &" &nbsp; </td>"
response.write " <td>"& tshap &"</td>"
response.write " <td align=right>"& FormatCurrency(ttphap,0) &" &nbsp; </td>"
response.write " </tr>"
response.write " </table>"

%>

<%end if%>

<BR>



				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>