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
	loopcount = ubound(array_pcode)

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select d_requestday "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& busercode
	rs.Open sql, db, 1
	d_requestday = rs(0)
	rs.close
%>

<!--#include virtual="/adminpage/incfile/top2.asp"-->

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
		<td width=14%>번호</td>
		<td width=8%>상품코드</td>
		<td width=23%>상품명</td>
		<td width=15%>규격</td>
		<td width=10%>가격</td>
		<td width=10%>주문수량</td>
		<td width=10%>합계</td>
		<td width=10%>비고</td>
	</tr>

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	j=1
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
			SQL = " select idx,pcode,pname,pprice,ptitle,bigo "
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

				response.write "<tr height=22 bgcolor=#FFFFFF align=center>"
				response.write "<td>"&j&"</td>"
				response.write "<td>"&pro_pcode&"</td>"
				response.write "<td>"&pro_pname&"</td>"
				response.write "<td>"&ptitle&"</td>"
				response.write "<td>"&FormatCurrency(pro_pprice,0)&"</td>"
				response.write "<td>"&array_ordernum(i)&"</td>"
				response.write "<td>"&FormatCurrency(pro_pprice*array_ordernum(i),0)&"</td>"
				response.write "<td>"&bigo&"</td>"
				response.write "</tr>"

				j=j+1
			end if
			rs.close
		end if
	next
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

	<tr height=28 bgcolor=#F7F7FF align=center>
		<td colspan=6 align=right><B>주문총액&nbsp;</td>
		<td><B><%=FormatCurrency(pro_money_hap,0)%></td>
		<td></td>
	</tr>

<form action="orderok4.asp" name=form method=post>
<input type=hidden name="pcode" value="<%=request("pcode")%>">
<input type=hidden name="ordernum" value="<%=request("ordernum")%>">
<input type=hidden name="d_requestday" value="<%=d_requestday%>">

	<tr height=28 bgcolor=#F7F7FF align=center>
		<td align=center>남기고<BR>싶은말</td>
		<td colspan=7 bgcolor=white><textarea align="left" name="order_cmt" class="writebox" id="message2" style='width:100%; height:60px;padding:3px;border:1px solid #AFAFAF;'></textarea></td>
	</tr>

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

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>
			<input type="image" src="/images/admin/l_bu01.gif" border=0>
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