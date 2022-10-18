<!--#include virtual="/db/db.asp"-->
<%
	busercode = left(session("AAusercode"),5)	'본사실제코드
	jusercode = mid(session("AAusercode"),6,5)	'지사실제코드
	cusercode = mid(session("AAusercode"),11,5)	'체인점실제코드
	usercode = session("AAusercode")		'체인점 전체코드

	pcode = trim(request("pcode"))			'상품코드
	ordernum = trim(request("ordernum"))		'주문수량

	array_pcode = split(pcode,",")
	array_ordernum = split(ordernum,",")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select mi_money,ye_money "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& cusercode
	rs.Open sql, db, 1
	imsimi_money = rs(0)	'미수금액
	imsiye_money = rs(1)	'여신금액
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

<!--#include virtual="/adminpage/incfile/top2.asp"-->

<script language="javascript">
function bwrite() {
	document.all("btn1").disabled = true;
	form.submit() ;
}
</script>

<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><B>[ 체인점 주문내역 확인 ]</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=8%>상품코드</td>
		<td width=23%>상품명</td>
		<td width=15%>규격</td>
		<td width=10%>단가</td>
		<td width=10%>수량</td>
		<td width=14%>공급가액</td>
		<td width=10%>세액</td>
		<td width=10%>비고</td>
	</tr>

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	j=1
	kmoneyHap = 0
	tmoneyHap = 0
	for i=0 to 59
		pro_idx = ""		'실제상품코드
		pro_pcode = ""		'입력상품코드
		pro_pname = ""		'상품명
		pro_pprice = ""		'상품단가
		imsicount = 0
		ptitle = ""
		bigo = ""

		if trim(array_pcode(i)) <> "" and trim(array_ordernum(i)) <> "" then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select idx,pcode,pname,pprice,ptitle,bigo,proout,gubun "
			SQL = sql & " from tb_product "
			SQL = sql & " where usercode = '"& busercode &"' "
			SQL = sql & " and pcode = '"& trim(array_pcode(i)) &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				proout = rs(6)
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				if proout="y" then
					pro_idx = rs(0)		'실제상품코드
					pro_pcode = rs(1)	'입력상품코드
					pro_pname = rs(2)	'상품명
					pro_pprice = rs(3)	'상품단가
					pro_money_hap = pro_money_hap+(pro_pprice*array_ordernum(i))
					imsicount = 1
					ptitle = rs(4)
					bigo = rs(5)
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					taxGubun   = rs(7)	'과세/비과세 / imsi_vatflag
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
					response.write "<td>"&pro_pname&"</td>"
					response.write "<td>"&ptitle&"</td>"
					response.write "<td align=right>"&formatnumber(pro_pprice,0)&"&nbsp;</td>"
					response.write "<td>"&array_ordernum(i)&"</td>"
					response.write "<td align=right>"& formatnumber(imsikkmoney,0)&"&nbsp;</td>"
					response.write "<td align=right>"&formatnumber(taxmoney,0) &"&nbsp;</td>"
					response.write "<td>"&bigo&"</td>"
					response.write "</tr>"
				else
					pro_idx = rs(0)		'실제상품코드
					pro_pcode = rs(1)	'입력상품코드
					pro_pname = rs(2)	'상품명
					pro_pprice = rs(3)	'상품단가
					pro_money_hap = 0
					imsicount = 1
					ptitle = rs(4)
					bigo = rs(5)
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					taxGubun   = rs(7)	'과세/비과세 / imsi_vatflag
					kmoney = 0
					taxmoney = 0
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					kmoneyHap = kmoneyHap + kmoney
					tmoneyHap = tmoneyHap + taxmoney
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					response.write "<tr height=22 bgcolor=#FFFFFF align=center>"
					response.write "<td>"&pro_pcode&"</td>"
					response.write "<td>"&pro_pname&"</td>"
					response.write "<td>"&ptitle&"</td>"
					response.write "<td align=right>"&formatnumber(pro_pprice,0)&"&nbsp;</td>"
					response.write "<td><font color=red>품절</td>"
					response.write "<td align=right>0&nbsp;</td>"
					response.write "<td align=right>0&nbsp;</td>"
					response.write "<td>"&bigo&"</td>"
					response.write "</tr>"
				end if
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				j=j+1
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			end if
			rs.close
		end if
	next
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	totHap = kmoneyHap + tmoneyHap
	pro_money_hap = totHap
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if pro_money_hap=0 then
		response.write "<Script language=javascript>"
		response.write "	alert(""주문을 다시해 주세요!"");"
		response.write "	history.go(-1);"
		response.write "</Script>"
		response.end
	end if
%>

	<tr height=28 bgcolor=#F7F7FF align=center>
		<td colspan=5 align=right><B>주문총액(<%=rs_vatflag%>)&nbsp;</td>
		<td colspan=2 align=right><B><%=FormatCurrency(pro_money_hap,0)%>&nbsp;</td>
		<td></td>
	</tr>


<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Function FunErrorMsg(errormsg)	'에러메세지
			FunErrorMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg &"');history.back(-1);</SCRIPT>"
			response.write FunErrorMsg
			response.end
	End Function

	OrderMoney    = imsiye_money-imsimi_money
	CutOrderMoney = OrderMoney-pro_money_hap
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
%>



<form action="orderok4.asp" name=form method=post>
<input type=hidden name="pcode" value="<%=request("pcode")%>">
<input type=hidden name="ordernum" value="<%=request("ordernum")%>">
<input type=hidden name="d_requestday" value="<%=d_requestday%>">
<input type=hidden name="PMmoney" value="<%=pro_money_hap%>">

<%if noteflag="y" then%>
<%'if conSeeflag="y" then%>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td align=center>남기고<BR>싶은말</td>
		<td colspan=7 bgcolor=white><textarea align="left" name="order_cmt" class="writebox" id="message2" style='width:100%; height:60px;padding:3px;border:1px solid #AFAFAF;'></textarea></td>
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

<BR><BR>

<!--#include virtual="/adminpage/incfile/bottom2.asp"-->