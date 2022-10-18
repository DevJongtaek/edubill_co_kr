<!--#include virtual="/adminpage/incfile/top2.asp"-->
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
	old_imsihapmoney = request("old_imsihapmoney")


	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select usercode,comname1,comname2,orderday,ordermoney,carname,ordering,flag,deflagday,deflag,request_day "
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
	if deflagday="" or isnull(rslist(8)) then
		imsideflagdayint=0
		deflagday=replace(left(now(),10),"-","")
	else
		imsideflagdayint=1
		deflagday=deflagday
	end if
	request_day = rslist(10)
	rslist.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select d_requestday,vatflag,useDistributionTotal"
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& left(usercode,5)
	rs.Open sql, db, 1
	d_requestday = rs(0)
	imsivatflag = rs(1)
	useDistributionTotal = rs(2)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select pidx,idx,pcode,pname,pprice,ordernum,rordernum,flag,pcodeidx "
	SQL = sql & " from tb_order_product "
	SQL = sql & " where idx = '"& idx &"' "
	SQL = sql & " order by pcode asc"
	rs.Open sql, db, 1

	'플러스원
	set rsPlus = server.CreateObject("ADODB.Recordset")
	SQL = " select pidx,idx,o.pcode,pname,c.pprice,ordernum,rordernum,flag,pcodeidx  "
	SQL = sql & " from tb_order_product o "
	SQL = sql & " join (select pcode, pprice from tb_product where usercode = '77275') c  "
	SQL = sql & " on o.pcode = c.pcode "
	SQL = sql & " where idx = '"& idx &"' "
	SQL = sql & " order by c.pcode asc"
	rsPlus.Open sql, db, 1
'response.write sql
%>

<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td width=50%><font color=blue size=3><B>[ 주문내역 ] <!--<a href="excell2.asp?idx=<%=idx%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a>--></td>
		<td width=50% align=right>(<%if imsivatflag="y" then%>.<%elseif imsivatflag="n" then%>.<%elseif imsivatflag="a" then%>.<%end if%>)</td>
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

<script language="javascript">
<!--
function agencycheck(form){
	<%if d_requestday="y" then%>
	if (form.request_day1.value=="") {
		alert("배달요청일자중 월을 입력해 주시기 바랍니다.") ;
		form.request_day1.focus() ;
		return false ;
	}
	if (form.request_day2.value=="") {
		alert("배달요청일자중 일을 입력해 주시기 바랍니다.") ;
		form.request_day2.focus() ;
		return false ;
	}
	<%end if%>

	form.submit() ;
	return false ;
}
-->
</script>

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
<input type=hidden name=d_requestday value="<%=d_requestday%>">

<input type=hidden name=old_imsihapmoney value="<%=old_imsihapmoney%>">

<%if d_requestday="y" then%>
	<tr height="25">
		<td nowrap colspan=7 bgcolor="#F7F7FF" align=right><B>배달요청일자</td>
		<td nowrap bgcolor="#FFFFFF">
<input type=text size=2 maxlenght=2 name="request_day1" value="<%=left(request_day,2)%>" OnKeypress="onlyNumber();">월
<input type=text size=2 maxlenght=2 name="request_day2" value="<%=right(request_day,2)%>" OnKeypress="onlyNumber();">일
		</td>
	</tr>
<%else%>
<input type=hidden name="request_day1" value="00">
<input type=hidden name="request_day2" value="00">
<%end if%>

</table>
<%If left(session("AAusercode"),5) = "19209" Then %>
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr>
		<td align="left"><b>[지엔푸드]</b></td>
	</tr>
</table>
<%End If %>
                    <%If left(session("AAusercode"),5) = "96338" Then %>
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr>
		<td align="left"><b>[94번가]</b></td>
	</tr>
</table>
<%End If %>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=8%>상품코드</td>
		<td width=20%>상품명</td>
		<td width=15%>규격</td>
		<td width=11%>단가</td>
		<td width=8%>주문수량</td>
		<td width=15%>공급가액</td>
		<td width=11%>세액</td>
		<td width=10%>수정수량</td>
		<!--<%if flag="y" then%><td width=10%>배달수량</td><%else%><td width=10%>구분</td><%end if%>-->
	</tr>



<%
imsihap1 = 0
imsihap2 = 0
imsihap3 = 0
imsihap4 = 0
imsinumpage = rs.recordcount

do until rs.EOF

	imsihap1 = imsihap1+CDbl(rs("pprice"))
	imsihap2 = imsihap2+int(rs("ordernum"))
	if flag = "n" then
		imsihap3 = imsihap3+(int(rs("ordernum"))*CDbl(rs("pprice")))
		imsihap4 = imsihap4+int(rs("ordernum"))
	else
		imsihap3 = imsihap3+(int(rs("rordernum"))*CDbl(rs("pprice")))
		imsihap4 = imsihap4+int(rs("rordernum"))
	end if

	imsiptitle = ""
	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select ptitle,gubun "
	SQL = sql & " from tb_product "
	SQL = sql & " where idx = "& rs("pcodeidx")
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsiptitle = rs2(0)
		taxGubun   = rs2(1)
	end if
	rs2.close


	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	rs_price = rs("pprice")
	rs_pcnt  = rs("rordernum")
	'if flag = "n" then	'주문확인안됨
	'	rs_pcnt  = rs("ordernum")
	'else			'주문확인완료
	'	rs_pcnt  = rs("rordernum")
	'end if
	'response.write flag

	kmoney   = CDbl(rs_price)*CDbl(rs_pcnt)	'공급가액
	if taxGubun="과세" then
		if imsivatflag="y" then		'포함
			imsimoney = round(CDbl(rs_price)*(100/110),0)
			taxmoney  = (CDbl(rs_price)-CDbl(imsimoney)) * CDbl(rs_pcnt)
			imsikkmoney = kmoney-taxmoney
in_kmoney = imsimoney
in_smoney = (CDbl(rs_price)-CDbl(imsimoney))
		elseif imsivatflag="n" then	'별도
			taxmoney = round(CDbl(kmoney)*0.1,0)
			imsikkmoney = kmoney
in_kmoney = rs_price
in_smoney = round(CDbl(rs_price)*0.1,0)
		elseif imsivatflag="a" then	'비과세
			taxmoney = 0
			imsikkmoney = kmoney
in_kmoney = rs_price
in_smoney = 0
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''
		'if rs_pcnt>0 then
		'	in_kmoney = CDbl(CDbl(imsikkmoney)/CDbl(rs_pcnt))
		'else
		'	in_kmoney = imsikkmoney
		'end if
		'if taxmoney=0 then
		'	in_smoney = 0
		'else
		'	if rs_pcnt>0 then
		'		in_smoney = CDbl(CDbl(taxmoney)/CDbl(rs_pcnt))
		'	else
		'		in_smoney = taxmoney
		'	end if
		'end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		imsikkmoney = kmoney
		taxmoney = 0
in_kmoney = rs_price
in_smoney = 0
		''''''''''''''''''''''''''''''''''''''''''''''''''''
		'if rs_pcnt>0 then
		'	in_kmoney = CDbl(CDbl(imsikkmoney)/CDbl(rs_pcnt))
		'else
		'	in_kmoney = imsikkmoney
		'end if
		'in_smoney = 0
		''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
	hap1 = hap1+CDbl(rs_price)
	hap2 = hap2+CDbl(rs_pcnt)
	hap3 = hap3+CDbl(imsikkmoney)
	hap4 = hap4+CDbl(taxmoney)
'response.write  in_kmoney &" - "& in_smoney &"<BR>"
%>

<input type=hidden name=pidx value="<%=rs("pidx")%>">
<input type=hidden name=taxGubun value="<%=taxGubun%>">
<input type=hidden name=imsivatflag value="<%=imsivatflag%>">

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs("pcode")%></td>
		<td align=left>&nbsp;<%=rs("pname")%></td>
		<td><%=imsiptitle%></td>
		<td align=right><%=formatnumber(rs("pprice"),0)%>&nbsp;</td>
		<td><%=rs("ordernum")%></td>
		<td align=right><%=formatnumber(imsikkmoney,0)%>&nbsp;</td>
		<td align=right><%=formatnumber(taxmoney,0)%>&nbsp;</td>
		<td>
			<input type=text size=4 maxlength=4 name=ordernum value="<%=rs("rordernum")%>" OnKeypress="onlyNumber();" onkeydown="return down(event)" onkeyup="up(this)" oncontextmenu="return false"  ONBlur="return zeronullcheck(this);">
			<input type=hidden name=in_kmoney value="<%=in_kmoney%>">
			<input type=hidden name=in_smoney value="<%=in_smoney%>">
		</td>


<!--
		<td>
			<%if rs("flag")="T" then%>
				<%=rs("ordernum")%>
			<%else%>
				<%if flag = "n" then%>
					<input type=text size=4 maxlength=8 name=ordernum value="<%=rs("ordernum")%>" OnKeypress="onlyNumber();" ONBlur="return zeronullcheck(this);">
					<input type=hidden name=in_kmoney value="<%=in_kmoney%>">
					<input type=hidden name=in_smoney value="<%=in_smoney%>">
				<%else%>
					<%=rs("ordernum")%>
				<%end if%>
			<%end if%>
		</td>
-->


<!--
		<%if rs("flag")="T" then%>
			<%if flag = "n" then%>
				<td align=right><%=formatnumber(imsikkmoney,0)%>&nbsp;</td>
				<td align=right><%=formatnumber(taxmoney,0)%>&nbsp;</td>
				<td><%=rs("rordernum")%></td>
			<%else%>
				<td align=right><%=formatnumber(int(rs("rordernum"))*CDbl(rs("pprice")),0)%>&nbsp;</td>
				<td align=right><%=formatnumber(taxmoney,0)%>&nbsp;</td>
				<td><%=rs("rordernum")%></td>
			<%end if%>
		<%else%>
			<%if flag = "n" then%>
				<td align=right><%=formatnumber(imsikkmoney,0)%>&nbsp;</td>
				<td align=right><%=formatnumber(taxmoney,0)%>&nbsp;</td>
				<td></td>
			<%else%>
				<td align=right><%=formatnumber(imsikkmoney,0)%>&nbsp;</td>
				<td align=right><%=formatnumber(taxmoney,0)%>&nbsp;</td>
				<td><%=rs("rordernum")%></td>
			<%end if%>
		<%end if%>


		<%if rs("flag")="T" then%>
			<%if flag = "n" then%>
				<td align=right><%=formatnumber(int(rs("ordernum"))*CDbl(rs("pprice")),0)%>&nbsp;</td>
				<td><%=rs("rordernum")%></td>
			<%else%>
				<td align=right><%=formatnumber(int(rs("rordernum"))*CDbl(rs("pprice")),0)%>&nbsp;</td>
				<td><%=rs("rordernum")%></td>
			<%end if%>
		<%else%>
			<%if flag = "n" then%>
				<td align=right><%=formatnumber(int(rs("ordernum"))*CDbl(rs("pprice")),0)%>&nbsp;</td>
				<td></td>
			<%else%>
				<td align=right><%=formatnumber(int(rs("rordernum"))*CDbl(rs("pprice")),0)%>&nbsp;</td>
				<td><%=rs("rordernum")%></td>
			<%end if%>
		<%end if%>
-->
	</tr>

<%
	imsiimsiflag = rs("flag")
rs.MoveNext 
loop 
%>

	<tr height=22 bgcolor=#F7F7FF align=center align=center>
		<td colspan=4>합 계</td>
		<td><%=imsihap2%></td>
		<td colspan=2><%=formatnumber(hap3+hap4,0)%></td>
		<td><%=hap2%></td>

<!--
		<td colspan=4>합 계</td>
		<td><%=hap2%></td>
		<td align=right><%=FormatCurrency(hap3)%>&nbsp;</td>
		<td align=right><%=FormatCurrency(hap4)%>&nbsp;</td>
		<td align=right><%=FormatCurrency(hap3+hap4)%>&nbsp;</td>


		<td colspan=3>합 계</td>
		<td align=right><%=FormatCurrency(imsihap1)%>&nbsp;</td>
		<td><%=imsihap2%></td>
		<td align=right><%=FormatCurrency(imsihap3)%>&nbsp;</td>
		<td align=right><%=FormatCurrency(imsihap3)%>&nbsp;</td>
		<td><%=imsihap4%></td>
-->
	</tr>

<%
	If useDistributionTotal = "y" Then 
		set rsdc = server.CreateObject("ADODB.Recordset")
		SQL = " select case p.dcenterchoice when '0' then '00000' else p.dcenterchoice end, isnull(d.bname, '등록안됨'), "
		If imsi_vatflag = "n" Then
			SQL = sql & " round(sum(c.pprice * rordernum), 0) + sum(round(case p.gubun when '과세' then (c.pprice* rordernum) * 0.1 else 0 end, 0)) "
		Else 
			SQL = sql & " round(sum(c.pprice * rordernum), 0) "
		End If 
		SQL = sql & " from   tb_product p   "
		SQL = sql & " join tb_order_product c "
		SQL = sql & " on p.pcode = c.pcode "
		SQL = sql & " left outer join tb_company_dcenter d "
		SQL = sql & " on d.bidx = p.dcenterchoice "
		SQL = sql & " where c.idx = '" & idx & "' "
		SQL = sql & " and p.usercode = '" & left(usercode,5) & "' "
		SQL = sql & " group by p.dcenterchoice, d.bname "
		SQL = sql & " order by p.dcenterchoice"
		rsdc.Open sql, db, 1
'		response.write sql

		response.write "<tr>"
		response.write "	<td colspan=8 width=10 bgcolor=white></td>"
		response.write "	</tr>"
		do until rsdc.eof
%>
		<tr height=28 bgcolor=#F7F7FF align=center>
			<td colspan=2 align=left>&nbsp;<%=rsdc(1)%></td>
			<td colspan=3 align=right><B>합 계<!--(<%=rs_vatflag%>)-->&nbsp;</td>
			<td colspan=2 align=right><%=FormatNumber(rsdc(2),0)%></td>
			<td></td>
		</tr>
<%

		rsdc.movenext
		i=i+1
		loop
		rsdc.close
	End If 
%>
</table>

<!--플러스원-->
</td>
</tr>
<%If left(session("AAusercode"),5) = "19209"  Then %>
<!--<tr>
<td align="left">
<br>
<b>[플러스원]</b>
<br>
계육 가공 및 배송비
</td>
</tr>-->
<tr>
<td>
<!--<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=8%>상품코드</td>
		<td width=20%>상품명</td>
		<td width=15%>규격</td>
		<td width=11%>단가</td>
		<td width=8%>주문수량</td>
		<td width=15%>공급가액</td>
		<td width=11%>세액</td>
		<td width=10%>배달수량</td>
		
	</tr>



<%
imsihap1 = 0
imsihap2 = 0
imsihap3 = 0
imsihap4 = 0
imsinumpage = rsPlus.recordcount

do until rsPlus.EOF
	imsihap1 = imsihap1+CDbl(rsPlus("pprice"))
	imsihap2 = imsihap2+int(rsPlus("ordernum"))
	if flag = "n" then
		imsihap3 = imsihap3+(int(rsPlus("ordernum"))*CDbl(rsPlus("pprice")))
		imsihap4 = imsihap4+int(rsPlus("ordernum"))
	else
		imsihap3 = imsihap3+(int(rsPlus("rordernum"))*CDbl(rsPlus("pprice")))
		imsihap4 = imsihap4+int(rsPlus("rordernum"))
	end if

	imsiptitle = ""
	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select ptitle,gubun "
	SQL = sql & " from tb_product "
	SQL = sql & " where idx = "& rsPlus("pcodeidx")
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsiptitle = rs2(0)
		taxGubun   = rs2(1)
	end if
	rs2.close


	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	rs_price = rsPlus("pprice")
	rs_pcnt  = rsPlus("rordernum")
	'if flag = "n" then	'주문확인안됨
	'	rs_pcnt  = rs("ordernum")
	'else			'주문확인완료
	'	rs_pcnt  = rs("rordernum")
	'end if
	'response.write flag
	taxGubun = "과세"
	imsivatflag = "y"
	kmoney   = CDbl(rs_price)*CDbl(rs_pcnt)	'공급가액
	if taxGubun="과세" then
		if imsivatflag="y" then		'포함
			imsimoney = round(CDbl(rs_price)*(100/110),0)
			taxmoney  = (CDbl(rs_price)-CDbl(imsimoney)) * CDbl(rs_pcnt)
			imsikkmoney = kmoney-taxmoney
in_kmoney = imsimoney
in_smoney = (CDbl(rs_price)-CDbl(imsimoney))
		elseif imsivatflag="n" then	'별도
			taxmoney = round(CDbl(kmoney)*0.1,0)
			imsikkmoney = kmoney
in_kmoney = rs_price
in_smoney = round(CDbl(rs_price)*0.1,0)
		elseif imsivatflag="a" then	'비과세
			taxmoney = 0
			imsikkmoney = kmoney
in_kmoney = rs_price
in_smoney = 0
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''
		'if rs_pcnt>0 then
		'	in_kmoney = CDbl(CDbl(imsikkmoney)/CDbl(rs_pcnt))
		'else
		'	in_kmoney = imsikkmoney
		'end if
		'if taxmoney=0 then
		'	in_smoney = 0
		'else
		'	if rs_pcnt>0 then
		'		in_smoney = CDbl(CDbl(taxmoney)/CDbl(rs_pcnt))
		'	else
		'		in_smoney = taxmoney
		'	end if
		'end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		imsikkmoney = kmoney
		taxmoney = 0
in_kmoney = rs_price
in_smoney = 0
		''''''''''''''''''''''''''''''''''''''''''''''''''''
		'if rs_pcnt>0 then
		'	in_kmoney = CDbl(CDbl(imsikkmoney)/CDbl(rs_pcnt))
		'else
		'	in_kmoney = imsikkmoney
		'end if
		'in_smoney = 0
		''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
	rsPlushap1 = rsPlushap1+CDbl(rs_price)
	rsPlushap2 = rsPlushap2+CDbl(rs_pcnt)
	rsPlushap3 = rsPlushap3+CDbl(imsikkmoney)
	rsPlushap4 = rsPlushap4+CDbl(taxmoney)
'response.write  in_kmoney &" - "& in_smoney &"<BR>"
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rsPlus("pcode")%></td>
		<td align=left>&nbsp;<%=rsPlus("pname")%></td>
		<td><%=imsiptitle%></td>
		<td align=right><%=formatnumber(rsPlus("pprice"),0)%>&nbsp;</td>
		<td><%=rsPlus("ordernum")%></td>
		<td align=right><%=formatnumber(imsikkmoney,0)%>&nbsp;</td>
		<td align=right><%=formatnumber(taxmoney,0)%>&nbsp;</td>
		<td><%=rsPlus("rordernum")%>
		</td>

	</tr>

<%
rsPlus.MoveNext 
loop 
%>

	<tr height=22 bgcolor=#F7F7FF align=center align=center>
		<td colspan=4>합 계</td>
		<td><%=imsihap2%></td>
		<td colspan=2><%=formatnumber(rsPlushap3+rsPlushap4,0)%></td>
		<td><%=rsPlushap2%></td>


	</tr>
</table>-->
<%End if %>
<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr> 
		<td height=30 align=center>
			<%if imsiimsiflag="F" and flag="n" then%>
				<%
				'if hap3+hap4>0 then
				if hap2>0 then
				%>
					<input type=image  src="/images/admin/l_bu03.gif" border=0 onclick="return agencycheck(this.form)">
					<a href="cancle.asp?cancleMoney=<%=hap3+hap4%>&gotopage=<%=gotopage%>&flag=<%=flag%>&idx=<%=idx%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&searchh=<%=searchh%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="cancle.gif" border=0></a>
				<%end if%>
			<%end if%>
			<a href="#" onclick="javascript:history.back();"><img src="/images/admin/l_bu07.gif" border=0></a>
		</td>
	</tr>

<input type=hidden name=cancleMoney value="<%=hap3+hap4%>">
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

<!--#include virtual="/adminpage/incfile/bottom2.asp"-->