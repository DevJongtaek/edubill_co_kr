<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	imsiday1 = left(searcha,4)&"/"&mid(searcha,5,2)&"/"&right(searcha,2)
	imsiday2 = left(searchb,4)&"/"&mid(searchb,5,2)&"/"&right(searchb,2)

	carname = Request("carname")
	sumoney = request("sumoney")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarname "
	SQL = sql & " from tb_car "
	SQL = sql & " where dcarno = '"& carname &"' "
	SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	rs.Open sql, db, 1
	imsicarname = rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pcode,a.pname,sum(a.rordernum)"
	SQL = sql & " from tb_order_product a, tb_order b "
	SQL = sql & " where a.idx = b.idx "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(b.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
		if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
			SQL = sql & " and a.dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	'SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "

	SQL = sql & " and b.deflag = 'n' "
	SQL = sql & " and b.flag = 'y' "
	SQL = sql & " and b.carname = '"& carname &"' "
	SQL = sql & " and b.orderday >= '"& searcha &"' "
	SQL = sql & " and b.orderday <= '"& searchb &"' "
	SQL = sql & " group by a.pcode,a.pname "
	SQL = sql & " order by a.pcode asc "
	rs.Open sql, db, 1

%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 호차별 총 집계표 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#BDCBE7" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=kindform>
	<tr>
		<td nowrap width="8%" bgcolor="#F7F7FF" height="25" align=center><B>호 차</td>
		<td nowrap width="15%" bgcolor="#FFFFFF" height="25"><%=carname%>호차</td>
		<td nowrap width="8%" bgcolor="#F7F7FF" height="25" align=center><B>기사명</td>
		<td nowrap width="15%" bgcolor="#FFFFFF" height="25"><%=imsicarname%></td>
		<td nowrap width="8%" bgcolor="#F7F7FF" height="25" align=center><B>주문일자</td>
		<td nowrap width="25%" bgcolor="#FFFFFF" height="25"><%=imsiday1%> ~ <%=imsiday2%></td>
		<td nowrap width="8%" bgcolor="#F7F7FF" height="25" align=center><B>수금금액</td>
		<td nowrap width="13%" bgcolor="#FFFFFF" height="25"><%=FormatCurrency(sumoney,0)%></td>
	</tr>

</form>

</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>상품코드</td>
		<td width=45%>상품명</td>
		<td width=20%>규격</td>
		<td width=20%>배달수량</td>
	</tr>

<%
i=1
do until rs.EOF

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select ptitle "
	SQL = sql & " from tb_product "
	SQL = sql & " where pcode = '"& rs(0) &"' "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	'SQL = sql & " and usercode = '"& left(session("Ausercode"),5) &"' "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsidcarname = rs2(0)
	end if
	rs2.close
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs(0)%></td>
		<td align=left> &nbsp; <%=rs(1)%></td>
		<td><%=imsidcarname%></td>
		<td align=right><%=rs(2)%> &nbsp; </td>
	</tr>

<%
rs.MoveNext 
i=i+1
loop
rs.close
%>

</table>

<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select distinct comname2,usercode "
	SQL = sql & " from tb_order"

	if session("Ausergubun")="3" then
		SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	'SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "

	SQL = sql & " and deflag = 'n' "
	SQL = sql & " and flag = 'y' and carname <> '' "
	SQL = sql & " and carname = '"& carname &"' "
	SQL = sql & " and orderday >= '"& searcha &"' "
	SQL = sql & " and orderday <= '"& searchb &"' "
	SQL = sql & " order by comname2 asc"
'response.write sql
	rs.Open sql, db, 1
%>

<%
i=1
do until rs.EOF

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select pcode,pname,pprice,sum(rordernum) "
	SQL = sql & " from tb_order_product"
	SQL = sql & " where idx in "

	SQL = sql & " 	(select idx from tb_order "
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
	'SQL = sql & " 	where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & "   and deflag = 'n' "

	'SQL = sql & "   and comname2 = '"& rs(0) &"' "
	SQL = sql & "   and usercode = '"& rs(1) &"' "

	SQL = sql & "   and flag='y' and carname <> '' and carname='"& carname &"'  "
	SQL = sql & "   and orderday >= '"& searcha &"' and orderday <= '"& searchb &"' ) "

	SQL = sql & " group by pcode,pname,pprice "
	SQL = sql & " order by pcode asc"
'response.write sql
	rs2.Open sql, db, 1

	set rs3 = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode "
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = "& right(rs(1),5) &" "
	SQL = sql & " and flag = '3' "
	SQL = sql & " and bidxsub = "& left(session("Ausercode"),5) &" "
	rs3.Open sql, db, 1
	imsiimsitcode = rs3(0)
	rs3.close
%>

<BR>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#BDCBE7" bordercolordark="#FFFFFF" width="100%">
	<tr>
		<td nowrap bgcolor="#FFFFFF" height="25"> &nbsp; <B>[ <%=rs(0)%> (<%=imsiimsitcode%>)]</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>상품코드</td>
		<td width=25%>상품명</td>
		<td width=15%>규격</td>
		<td width=15%>단가</td>
		<td width=10%>배달수량</td>
		<td width=20%>금액</td>
	</tr>

	<%
	imsihap=0
	tphap=0
	tshap=0
	ttphap=0
	do until rs2.EOF

		rs2_pcode = rs2(0)
		rs2_pname = rs2(1)
		rs2_pprice = rs2(2)
		rs2_rordernum = rs2(3)
		imsihap = int(rs2_pprice)*int(rs2_rordernum)

		tphap=tphap+rs2_pprice
		tshap=tshap+rs2_rordernum
		ttphap=ttphap+imsihap

		set rs22 = server.CreateObject("ADODB.Recordset")
		SQL = " select ptitle "
		SQL = sql & " from tb_product "
		SQL = sql & " where pcode = '"& rs2(0) &"' "
		SQL = sql & " and usercode = '"& left(session("Ausercode"),5) &"' "
		rs22.Open sql, db, 1
		if not rs22.eof then
			imsidcarname = rs22(0)
		end if
		rs22.close

	%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs2_pcode%></td>
		<td align=left> &nbsp; <%=rs2_pname%></td>
		<td><%=imsidcarname%></td>
		<td align=right><%=FormatCurrency(rs2_pprice,0)%> &nbsp; </td>
		<td><%=rs2_rordernum%></td>
		<td align=right><%=FormatCurrency(imsihap,0)%> &nbsp; </td>
	</tr>

	<%
	rs2.MoveNext
	loop
	rs2.close
	%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td colspan=3>합계</td>
		<td align=right><%=FormatCurrency(tphap,0)%> &nbsp; </td>
		<td><%=tshap%></td>
		<td align=right><%=FormatCurrency(ttphap,0)%> &nbsp; </td>
	</tr>
</table>

<%
rs.MoveNext 
i=i+1
loop
rs.close

db.close
set db=nothing
%>

<BR>

<script language="JavaScript">
<!--
function pwinnew(){
	window.open("newwin.asp?gotopage=<%=request("gotopage")%>&sumoney=<%=request("sumoney")%>&searcha=<%=request("searcha")%>&searchb=<%=request("searchb")%>&searchc=<%=request("searchc")%>&searchd=<%=request("searchd")%>&carname=<%=request("carname")%>","AutoAddr","toolbar=no,menubar=no,scrollbars=1,resizable=no,width=670,height=700");
}
//-->
</script>

<table border="0" cellspacing="0" cellpadding="0" width=100%>

<form>

	<tr> 
		<td height=30 align=center>
			<a href="#" onclick="javascript:pwinnew();"><img src="/images/admin/l_bu15.gif" border=0></a>
			<a href="#" onclick="javascript:history.back();"><img src="/images/admin/l_bu07.gif" border=0></a>
		</td>
	</tr>

</form>

</table>


				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->