<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")

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

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select d_requestday "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& left(session("Ausercode"),5)
	rs.Open sql, db, 1
	imsi_d_requestday = rs(0)
	rs.close

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select usercode,comname1,comname2,orderday,ordermoney,carname,ordering,flag,deflagday,deflag,isnull(request_day,'') as request_day "
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
	dflag = rslist(9)
	request_day = rslist(10)

	if deflagday="" or isnull(rslist(8)) then
		imsideflagdayint=0
		deflagday=replace(left(now(),10),"-","")
	else
		imsideflagdayint=1
		deflagday=deflagday
	end if
	rslist.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select pidx,idx,pcode,pname,pprice,ordernum,rordernum "
	SQL = sql & " from tb_order_product "
	SQL = sql & " where idx = '"& idx &"' "
	SQL = sql & " order by pcode asc"
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
		<td><font color=blue size=3><B>[ 주문내역 ] <!--<a href="excell2.asp?idx=<%=idx%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a>--></td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height="25">
		<td nowrap width="10%" bgcolor="#F7F7FF" align=center><B>주문일자</td>
		<td nowrap width="15%" bgcolor="#FFFFFF"><%=left(orderday,4)%>/<%=mid(orderday,5,2)%>/<%=right(orderday,2)%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" align=center><B>지사(점)명</td>
		<td nowrap width="15%" bgcolor="#FFFFFF"><%=comname1%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" align=center><B>체인점명</td>
		<td nowrap width="15%" bgcolor="#FFFFFF"><%=comname2%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" align=center><B>호차</td>
		<td nowrap width="15%" bgcolor="#FFFFFF"><%=carname%>호차</td>
	</tr>

<%if request_day<>"" and imsi_d_requestday="y" then%>

<script language="JavaScript">
<!--
function imsidaychecked() {
	if (imsifrm.request_day1.value=="") {
		alert("배달요청일자중 월을 입력하여 주시기바랍니다.") ;
		imsifrm.request_day1.focus() ;
		return false ;
	}
	if (imsifrm.request_day2.value=="") {
		alert("배달요청일자중  일을 입력하여 주시기바랍니다.") ;
		imsifrm.request_day2.focus() ;
		return false ;
	}
	imsifrm.submit() ;
	return false ;
}
//-->
</script>

<form action=imsiok.asp method=post name="imsifrm" onsubmit="return imsidaychecked()">
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=gotopage value="<%=gotopage%>">

<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=searchd value="<%=searchd%>">
<input type=hidden name=searche value="<%=searche%>">
<input type=hidden name=searchf value="<%=searchf%>">
<input type=hidden name=searchg value="<%=searchg%>">

<input type=hidden name=fclass1 value="<%=fclass1%>">
<input type=hidden name=sclass2 value="<%=sclass2%>">
<input type=hidden name=tclass3 value="<%=tclass3%>">


	<tr height="25">
		<td nowrap bgcolor="#F7F7FF" colspan=6 align=right><B>배달요청일자</td>
		<td nowrap bgcolor="#FFFFFF" colspan=2>
			<input type=text name="request_day1" value="<%=left(request_day,2)%>" OnKeypress="onlyNumber();" ONBlur="return zeronullcheck(this);" size=2 maxlength=2>월
			<input type=text name="request_day2" value="<%=right(request_day,2)%>" OnKeypress="onlyNumber();" ONBlur="return zeronullcheck(this);" size=2 maxlength=2>일
			<%if session("Ausergubun")="2" or session("Ausergubun")="3" then%>
				<%if session("Auserwrite")="y" and flag="n" then%>
					<input type="image" src="/images/admin/l_bu03.gif" border=0>
				<%end if%>
			<%end if%>
		</td>
	</tr>
</form>
<%end if%>

</table>

<table border=0 cellspacing="0" cellpadding=0 width=100%>

<form action=ok.asp method=post name=form222 onsubmit="return deokcheck();">
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=gotopage value="<%=gotopage%>">

<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=searchd value="<%=searchd%>">
<input type=hidden name=searche value="<%=searche%>">
<input type=hidden name=searchf value="<%=searchf%>">
<input type=hidden name=searchg value="<%=searchg%>">

<input type=hidden name=fclass1 value="<%=fclass1%>">
<input type=hidden name=sclass2 value="<%=sclass2%>">
<input type=hidden name=tclass3 value="<%=tclass3%>">

<%if flag="y" then%>
	<%if imsideflagdayint=0 then%>
		<tr height="25">
			<td width=99% align=right>배달일자 : <input type=text name=deflagday size=8 maxlength=8 value="<%=deflagday%>" OnKeypress="onlyNumber();"></td>
			<td width=1%><%if session("Auserwrite")="y" then%><input type=image src="/images/admin/l_bu18.gif" border=0><%end if%></td>
		</tr>
	<%else%>
		<tr height="25">
			<td width=100% align=right>배달일자 : <input type=text name=deflagday size=8 maxlength=8 value="<%=deflagday%>" OnKeypress="onlyNumber();"></td>
		</tr>
	<%end if%>
<%end if%>

</form>

</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>

<form action=writeok.asp method=post name=form>
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=gotopage value="<%=gotopage%>">

<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=searchd value="<%=searchd%>">
<input type=hidden name=searche value="<%=searche%>">
<input type=hidden name=searchf value="<%=searchf%>">
<input type=hidden name=searchg value="<%=searchg%>">
<input type=hidden name=searchh value="<%=searchh%>">

<input type=hidden name=fclass1 value="<%=fclass1%>">
<input type=hidden name=sclass2 value="<%=sclass2%>">
<input type=hidden name=tclass3 value="<%=tclass3%>">

<input type=hidden name=oogubun>

	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>상품코드</td>
		<td width=20%>상품명</td>
		<td width=15%>규격</td>
		<td width=15%>단가</td>
		<td width=10%>주문수량</td>
		<td width=20%>금액</td>
		<td width=10%>배달수량</td>
	</tr>

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

%>

<input type=hidden name=pidx value="<%=rs("pidx")%>">

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs("pcode")%></td>
		<td align=left>&nbsp;<%=rs("pname")%></td>
		<td><%=imsiptitle%></td>
		<td align=right><%=FormatCurrency(rs("pprice"))%>&nbsp;</td>
		<td><%=rs("ordernum")%></td>
		<%if flag = "n" then%>
			<td align=right><%=FormatCurrency(int(rs("ordernum"))*int(rs("pprice")))%>&nbsp;</td>
			<td><input type=text size=4 maxlength=8 name=rordernum value="<%=rs("rordernum")%>" OnKeypress="onlyNumber();" ONBlur="return zeronullcheck(this);"></td>
		<%else%>
			<td align=right><%=FormatCurrency(int(rs("rordernum"))*int(rs("pprice")))%>&nbsp;</td>
			<td><input type=text size=4 maxlength=8 name=rordernum value="<%=rs("rordernum")%>" OnKeypress="onlyNumber();" ONBlur="return zeronullcheck(this);"></td>
		<%end if%>

	</tr>

<%
rs.MoveNext 
loop 
%>

	<tr height=22 bgcolor=#F7F7FF align=center align=center>
		<td colspan=3>합 계</td>
		<td align=right><%=FormatCurrency(imsihap1)%>&nbsp;</td>
		<td><%=imsihap2%></td>
		<td align=right><%=FormatCurrency(imsihap3)%>&nbsp;</td>
		<td><%=imsihap4%></td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr> 
		<td height=30 align=center>

<%if session("Ausergubun")="2" or session("Ausergubun")="3" then%>
	<%if session("Auserwrite")="y" then%>
		<%if (imsinumpage > 0) and (flag = "n" or flag = "") then%>
			<input type="image" src="/images/admin/l_bu17.gif" border=0 onclick="return orderwrite();">
		<%elseif (imsinumpage > 0) and (dflag = "n" and flag = "y") then%>
			<input type="image" src="/images/ordercancle.gif" border=0 onclick="return orderwrite2();">
		<%elseif dflag = "y" and flag = "y" then%>
			<input type="image" src="/images/admin/l_bu28.gif" border=0 onclick="return orderwrite3();">
		<%end if%>
	<%end if%>
<%end if%>
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

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->