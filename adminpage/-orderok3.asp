<!--#include virtual="/db/db.asp"-->
<%
	call ordertimechb(left(session("AAusercode"),5))	'�ֹ����ܽð� üũ
	busercode = left(session("AAusercode"),5)	'��������ڵ�
	jusercode = mid(session("AAusercode"),6,5)	'��������ڵ�
	cusercode = mid(session("AAusercode"),11,5)	'ü���������ڵ�
	usercode = session("AAusercode")		'ü���� ��ü�ڵ�

	pcode = trim(request("pcode"))			'��ǰ�ڵ�
	ordernum = trim(request("ordernum"))		'�ֹ�����

	array_pcode = split(pcode,",")
	array_ordernum = split(ordernum,",")
	loopcount = ubound(array_pcode)

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select mi_money,ye_money "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& cusercode
	rs.Open sql, db, 1
	if not rs.eof then
		imsimi_money = rs(0)	'�̼��ݾ�
		imsiye_money = rs(1)	'���űݾ�
	else
		imsimi_money = 0
		imsiye_money = 0
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select d_requestday,vatflag,myflag,myflag_select,noteflag "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& busercode
	rs.Open sql, db, 1
	d_requestday = rs(0)
	rs_vatflag = rs(1)
	myflag        = rs(2)	'�̼���üũ - �̼�,����üũ ���� y/n
	myflag_select = rs(3)	'�̼���üũ - 1:�ܿ����Ÿ� üũ 2:�ܿ����Ű� �ֹ��ݾ� üũ
	noteflag      = rs(4)	'����/���� ����
	rs.close
	if rs_vatflag="y" then
		rs_vatflag = "VAT����"
	else
		rs_vatflag = "VAT����"
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
		<td><B>[ ü���� �ֹ����� Ȯ�� ]</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=14%>��ȣ</td>
		<td width=8%>��ǰ�ڵ�</td>
		<td width=23%>��ǰ��</td>
		<td width=15%>�԰�</td>
		<td width=10%>����</td>
		<td width=10%>�ֹ�����</td>
		<td width=10%>�հ�</td>
		<td width=10%>���</td>
	</tr>

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	j=1
	for i=0 to loopcount
		pro_idx = ""		'������ǰ�ڵ�
		pro_pcode = ""		'�Է»�ǰ�ڵ�
		pro_pname = ""		'��ǰ��
		pro_pprice = ""		'��ǰ�ܰ�
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
				pro_idx = rs(0)		'������ǰ�ڵ�
				pro_pcode = rs(1)	'�Է»�ǰ�ڵ�
				pro_pname = rs(2)	'��ǰ��
				pro_pprice = rs(3)	'��ǰ�ܰ�
				pro_money_hap = pro_money_hap+(pro_pprice*array_ordernum(i))
				imsicount = 1
				ptitle = rs(4)
				bigo = rs(5)

				response.write "<tr height=22 bgcolor=#FFFFFF align=center>"
				response.write "<td>"&j&"</td>"
				response.write "<td>"&pro_pcode&"</td>"
				response.write "<td>"&pro_pname&"</td>"
				response.write "<td>"&ptitle&"</td>"
				response.write "<td align=right>"&formatnumber(pro_pprice,0)&"&nbsp;</td>"
				response.write "<td>"&array_ordernum(i)&"</td>"
				response.write "<td align=right>"&formatnumber(pro_pprice*array_ordernum(i),0)&"&nbsp;</td>"
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
		<td colspan=6 align=right><B>�ֹ��Ѿ�(<%=rs_vatflag%>)&nbsp;</td>
		<td align=right><B><%=formatnumber(pro_money_hap,0)%>&nbsp;</td>
		<td></td>
	</tr>

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Function FunErrorMsg(errormsg)	'�����޼���
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
			JavaTxt = "�����ѵ��� �ʰ��Ǿ� �ֹ��� �Ͻ� �� �����ϴ�.\n\n"
			JavaTxt = JavaTxt & "�ֹ������� �����Ͽ� �ٽ� �ֹ� �ٶ��ϴ�.!!!\n\n"
			JavaTxt = JavaTxt & "�� �ֹ����� �ݾ� : "& JavaOrderOkMoney  &" ��\n\n"
			JavaTxt = JavaTxt & "�� �ֹ��Ͻ� �ݾ� : "& JavaOrderMoney    &" ��\n\n"
			JavaTxt = JavaTxt & "�� �ʰ� �ݾ�     : "& JavaOrderNotMoney &" ��"
			call FunErrorMsg(JavaTxt)
		end if
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<form action="orderok4.asp" name=form method=post>
<input type=hidden name="pcode" value="<%=request("pcode")%>">
<input type=hidden name="ordernum" value="<%=request("ordernum")%>">
<input type=hidden name="d_requestday" value="<%=d_requestday%>">

<%if noteflag="y" then%>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td align=center>�����<BR>������</td>
		<td colspan=7 bgcolor=white><textarea align="left" name="order_cmt" class="writebox" id="message2" style='width:100%; height:60px;padding:3px;border:1px solid #AFAFAF;'></textarea></td>
	</tr>
<%end if%>

<%if d_requestday="y" then%>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td align=center>��޿�û����</td>
		<td colspan=7 bgcolor=white align=left>
			<input type=text name="request_day1" size=2 maxlength=2 OnKeypress="onlyNumber();">��<input type=text name="request_day2" size=2 maxlength=2 OnKeypress="onlyNumber();">��
			(*�ʿ�� ��� ��û���ڸ� �Է��� �ּ���. (��2�ڸ� ��2�ڸ�))

		</td>
	</tr>
<%end if%>

</table>

<table align=center>
	<tr> 
		<td height=20 align=center>
			<font color=blue><B>�� �ݵ�� "���" ��ư�� �����ž߸� �ֹ��� �Ϸ� �˴ϴ�.!!
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