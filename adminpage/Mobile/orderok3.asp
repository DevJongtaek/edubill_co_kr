<!--#include virtual="/db/db.asp"-->
<%
	Response.Expires = 0   
	Response.AddHeader "Pragma","no-cache"   
	Response.AddHeader "Cache-Control","no-cache,must-revalidate" 

	call ordertimechb(left(session("AAusercode"),5))	'주문차단시간 체크
	busercode = left(session("AAusercode"),5)	'본사실제코드
	jusercode = mid(session("AAusercode"),6,5)	'지사실제코드
	cusercode = mid(session("AAusercode"),11,5)	'체인점실제코드
	usercode = session("AAusercode")		'체인점 전체코드

	pcode = trim(request("pcode"))			'상품코드
	ordernum = trim(request("ordernum"))		'주문수량

	array_pcode = split(pcode,",")
	array_ordernum = split(ordernum,",")
	loopcount = ubound(array_pcode)

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select mi_money,ye_money "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& cusercode
	rs.Open sql, db, 1
	if not rs.eof then
		imsimi_money = rs(0)	'미수금액
		imsiye_money = rs(1)	'여신금액
	else
		imsimi_money = 0
		imsiye_money = 0
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select d_requestday,vatflag,myflag,myflag_select,noteflag,conSeeflag "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& busercode
	rs.Open sql, db, 1
	d_requestday = rs(0)
	rs_vatflag = rs(1)
	myflag        = rs(2)	'미수금체크 - 미수,여신체크 구분 y/n
	myflag_select = rs(3)	'미수금체크 - 1:잔여여신만 체크 2:잔여여신과 주문금액 체크
	noteflag      = rs(4)	'쪽지/녹음 지원
	conSeeflag    = rs(5)
	rs.close
	imsi_vatflag = rs_vatflag
	if rs_vatflag="y" then
		rs_vatflag = "VAT포함"
	elseif rs_vatflag="n" then
		rs_vatflag = "VAT별도"
	else
		rs_vatflag = "비과세"
	end if
%>

<!--#include virtual="/adminpage/incfile/mtop2.asp"-->

<script language="javascript">
function bwrite() {
	document.all("btn1").style.display="none";
	form.submit() ;
}
</script>


<table width="310" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" >
	<tr height="47">
		<td align=center>

		<table width="310" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center colspan=2>

<table width="310" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><B>[ 체인점 주문내역 확인 ]</td>
	</tr>
	<%If left(session("AAusercode"),5) = "19209" Then %>
	<tr>
		<td align="left"><b>[지엔푸드]</b></td>
	</tr>
	<%End If %>
    <%If left(session("AAusercode"),5) = "96338" Then %>
	<tr>
		<td align="left"><b>[94번가]</b></td>
	</tr>
	<%End If %>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=8%>코드</td>
		<td width=23%>상품명</td>
		<!-- <td width=15%>규격</td> -->
		<td width=10%>단가</td>
		<td width=10%>수량</td>
		<td width=14%>공급가</td>
		<td width=10%>세액</td>
		<!-- <td width=10%>비고</td> -->
	</tr>

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	j=1
	kmoneyHap = 0
	tmoneyHap = 0
	for i=0 to loopcount
		pro_idx = ""		'실제상품코드
		pro_pcode = ""		'입력상품코드
		pro_pname = ""		'상품명
		pro_pprice = ""		'상품단가
		imsicount = 0
		ptitle = ""
		bigo = ""
		imsiaaaa = trim(array_pcode(i))
		imsibbbb = trim(array_ordernum(i))
		if imsiaaaa <> "" and imsibbbb <> "" then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select idx,pcode,pname,pprice,ptitle,bigo,gubun "
			SQL = sql & " from tb_product "
			SQL = sql & " where usercode = '"& busercode &"' "
			SQL = sql & " and pcode = '"& trim(array_pcode(i)) &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				pro_idx = rs(0)		'실제상품코드
				pro_pcode = rs(1)	'입력상품코드
				pro_pname = rs(2)	'상품명
				pro_pprice = rs(3)	'상품단가
				pro_money_hap = pro_money_hap+(pro_pprice*array_ordernum(i))
				imsicount = 1
				ptitle = rs(4)
				bigo = rs(5)
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				taxGubun = rs(6)	'과세/비과세 / imsi_vatflag
				kmoney = pro_pprice*array_ordernum(i)	'공급가액
				if taxGubun="과세" then
					if imsi_vatflag="y" then	'포함
						imsimoney = round(pro_pprice*(100/110),0)
						taxmoney  = (pro_pprice-imsimoney)*array_ordernum(i)
						imsikkmoney = kmoney-taxmoney
					elseif imsi_vatflag="n" then	'별도
						taxmoney = round(kmoney*0.1,0)
						imsikkmoney = kmoney
					elseif imsi_vatflag="a" then	'비과세
						taxmoney = 0
						imsikkmoney = kmoney
					end if
				else
					imsikkmoney = kmoney
					taxmoney = 0
				end if
				if taxmoney="" then taxmoney=0
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				kmoneyHap = kmoneyHap + imsikkmoney
				tmoneyHap = tmoneyHap + taxmoney
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				response.write "<tr height=22 bgcolor=#FFFFFF align=center>"
				response.write "<td>"&pro_pcode&"</td>"
				response.write "<td align=left>"&pro_pname&"</td>"
				'response.write "<td>"&ptitle&"</td>"
				response.write "<td align=right>"&formatnumber(pro_pprice,0)&"&nbsp;</td>"
				response.write "<td>"&array_ordernum(i)&"</td>"
				response.write "<td align=right>"&formatnumber(imsikkmoney,0)&"&nbsp;</td>"
				response.write "<td align=right>"& formatnumber(taxmoney,0) &"&nbsp;</td>"
				'response.write "<td>"&bigo&"</td>"
				response.write "</tr>"

				j=j+1
			end if
			rs.close
		end if
	next
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	totHap = kmoneyHap + tmoneyHap
	pro_money_hap = totHap
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

	<tr height=28 bgcolor=#F7F7FF align=center>
		<td colspan=4 align=right><B>합 계<!--(<%=rs_vatflag%>)-->&nbsp;</td>
		<td colspan=2 align=right><B><%=formatnumber(pro_money_hap,0)%>&nbsp;</td>
	</tr>
	<tr>
		<td colspan=8 width=10 bgcolor=white></td>
	</tr>
	<%
		set rsdc = server.CreateObject("ADODB.Recordset")
		SQL = " select p.dcenterchoice, d.bname, sum(c.pprice * pcnt) "
		SQL = sql & " from tb_product p  "
		SQL = sql & " join tb_product_cart c "
		SQL = sql & " on p.pcode = c.pcode "
		SQL = sql & " join tb_company_dcenter d "
		SQL = sql & " on d.bidx = p.dcenterchoice "
		SQL = sql & " where c.usercode = '" & usercode & "' "
		SQL = sql & " and p.usercode = '" & busercode & "' "
		SQL = sql & " group by p.dcenterchoice, d.bname "
		rsdc.Open sql, db, 1
		'response.write sql

		do until rsdc.eof
%>
		<tr bgcolor=#F7F7FF align=center>
			<td colspan=2 align=left><%=rsdc(1)%></td>
			<td colspan=2 align=right>소 계</td>
			<td align=rigjt><%=FormatNumber(rsdc(2),0)%></td>
			<td>&nbsp;</td>
		</tr>
<%

		rsdc.movenext
		i=i+1
		loop
		rsdc.close
	%>

</table>
<!--플러스원-->

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Function FunErrorMsg(errormsg)	'에러메세지
			FunErrorMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg &"');location.href = ""/adminpage/mobile/mAgencyOrderCartFRM.asp"";</SCRIPT>"
			response.write FunErrorMsg
			response.end
	End Function

	OrderMoney    = imsiye_money-imsimi_money
	CutOrderMoney = OrderMoney-pro_money_hap
    Ye_money  = imsiye_money
	if myflag="y" and myflag_select="2" then
		if CutOrderMoney<0 then
			JavaOrderOkMoney  = formatnumber(OrderMoney,0)
			JavaOrderMoney    = formatnumber(pro_money_hap,0)
			JavaOrderNotMoney = formatnumber(CutOrderMoney,0)
			JavaTxt = "여신한도가 초과되어 주문을 하실 수 없습니다.\n\n"
			JavaTxt = JavaTxt & "주문내역을 조정하여 다시 주문 바랍니다.!!!\n\n"
			JavaTxt = JavaTxt & "▶ 주문가능 금액 : "& JavaOrderOkMoney  &" 원\n\n"
			JavaTxt = JavaTxt & "▶ 주문하신 금액 : "& JavaOrderMoney    &" 원\n\n"
			JavaTxt = JavaTxt & "▶ 초과 금액     : "& JavaOrderNotMoney &" 원"
			call FunErrorMsg(JavaTxt)
		end if
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

      if myflag="y" and myflag_select="4" then
		if CutOrderMoney<0 then
			JavaOrderOkMoney  = formatnumber(OrderMoney,0) '주문가능금액
			JavaOrderMoney    = formatnumber(pro_money_hap,0) '주문금액
			JavaOrderNotMoney = formatnumber(CutOrderMoney,0) '초과금액
            Javeye_money = formatnumber(Ye_money,0) '여신금액
            

    

		
		end if
	end if
%>

<form action="orderok4.asp" name=form method=post >
<input type=hidden name="pcode" value="<%=request("pcode")%>">
<input type=hidden name="ordernum" value="<%=request("ordernum")%>">
<input type=hidden name="d_requestday" value="<%=d_requestday%>">

<input type=hidden name="PMmoney" value="<%=pro_money_hap%>">
    <input type=hidden name="YeMoney" value="<%=Javeye_money%>">
<%'if noteflag="y" then  2011.04.05 남기고 싶은말 없애기%>
<%if conSeeflag="y" then%>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=20 align=center>메<BR>모</td>
		<td  bgcolor=white><textarea align="left" name="order_cmt" class="writebox" id="message2"  style='width:290; height:60px;padding:3px;border:1px solid #AFAFAF;'></textarea></td>
	</tr>
<%'end if%>
<%end if%>

<%if d_requestday="y" then%>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td align=center>배달요청일자</td>
		<td colspan=7 bgcolor=white align=left>
			<input type=text name="request_day1" size=2 maxlength=2 OnKeypress="onlyNumber();">월<input type=text name="request_day2" size=2 maxlength=2 OnKeypress="onlyNumber();">일
			(*필요시 배달 요청일자를 입력해 주세요. (월2자리 일2자리))

		</td>
	</tr>
<%end if%>

</table>

<table align=center>
	<tr> 
		<td height=20 align=center>
			<font color=blue><B>☞ 반드시 "등록" 버튼을 누르셔야만 주문이 완료 됩니다.!!
		</td>
	</tr>
	<tr> 
		<td height=30 align=center>
			<input type="image" src="/images/admin/l_bu01.gif" border=0 name=btn1 onclick="return bwrite()">
			<a href="mAgencyOrderCartFRM.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>"><img src="/images/admin/l_bu07.gif" border=0></a>
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

<BR><BR>

<!--#include virtual="/adminpage/incfile/mbottom2.asp"-->