<!--#include virtual="/db/db.asp"-->
<%
	busercode = left(session("AAusercode"),5)	'��������ڵ�
	jusercode = mid(session("AAusercode"),6,5)	'��������ڵ�
	cusercode = mid(session("AAusercode"),11,5)	'ü���������ڵ�
	usercode = session("AAusercode")		'ü���� ��ü�ڵ�

	pcode = trim(request("pcode"))			'��ǰ�ڵ�
	ordernum = trim(request("ordernum"))		'�ֹ�����

	array_pcode = split(pcode,",")
	array_ordernum = split(ordernum,",")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select mi_money,ye_money "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& cusercode
	rs.Open sql, db, 1
	imsimi_money = rs(0)	'�̼��ݾ�
	imsiye_money = rs(1)	'���űݾ�
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select d_requestday,vatflag,myflag,myflag_select,noteflag,conSeeflag "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& busercode
	rs.Open sql, db, 1
	d_requestday = rs(0)
	rs_vatflag = rs(1)
	myflag        = rs(2)	'�̼���üũ - �̼�,����üũ ���� y/n
	myflag_select = rs(3)	'�̼���üũ - 1:�ܿ����Ÿ� üũ 2:�ܿ����Ű� �ֹ��ݾ� üũ
	noteflag      = rs(4)	'����/���� ����
	conSeeflag    = rs(5)
	rs.close
	imsi_vatflag = rs_vatflag
	if rs_vatflag="y" then
		rs_vatflag = "VAT����"
	elseif rs_vatflag="n" then
		rs_vatflag = "VAT����"
	else
		rs_vatflag = "�����"
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
		<td width=8%>��ǰ�ڵ�</td>
		<td width=23%>��ǰ��</td>
		<td width=15%>�԰�</td>
		<td width=10%>�ܰ�</td>
		<td width=10%>����</td>
		<td width=14%>���ް���</td>
		<td width=10%>����</td>
		<td width=10%>���</td>
	</tr>

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	j=1
	kmoneyHap = 0
	tmoneyHap = 0
	for i=0 to 59
		pro_idx = ""		'������ǰ�ڵ�
		pro_pcode = ""		'�Է»�ǰ�ڵ�
		pro_pname = ""		'��ǰ��
		pro_pprice = ""		'��ǰ�ܰ�
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
					pro_idx = rs(0)		'������ǰ�ڵ�
					pro_pcode = rs(1)	'�Է»�ǰ�ڵ�
					pro_pname = rs(2)	'��ǰ��
					pro_pprice = rs(3)	'��ǰ�ܰ�
					pro_money_hap = pro_money_hap+(pro_pprice*array_ordernum(i))
					imsicount = 1
					ptitle = rs(4)
					bigo = rs(5)
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					taxGubun   = rs(7)	'����/����� / imsi_vatflag
					kmoney = pro_pprice*array_ordernum(i)	'���ް���
					if taxGubun="����" then
						if imsi_vatflag="y" then	'����
							imsimoney = round(pro_pprice*(100/110),0)
							taxmoney  = (pro_pprice-imsimoney)*array_ordernum(i)
							imsikkmoney = kmoney-taxmoney
						elseif imsi_vatflag="n" then	'����
							taxmoney = round(kmoney*0.1,0)
							imsikkmoney = kmoney
						elseif imsi_vatflag="a" then	'�����
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
					pro_idx = rs(0)		'������ǰ�ڵ�
					pro_pcode = rs(1)	'�Է»�ǰ�ڵ�
					pro_pname = rs(2)	'��ǰ��
					pro_pprice = rs(3)	'��ǰ�ܰ�
					pro_money_hap = 0
					imsicount = 1
					ptitle = rs(4)
					bigo = rs(5)
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					taxGubun   = rs(7)	'����/����� / imsi_vatflag
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
					response.write "<td><font color=red>ǰ��</td>"
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
		response.write "	alert(""�ֹ��� �ٽ��� �ּ���!"");"
		response.write "	history.go(-1);"
		response.write "</Script>"
		response.end
	end if
%>

	<tr height=28 bgcolor=#F7F7FF align=center>
		<td colspan=5 align=right><B>�ֹ��Ѿ�(<%=rs_vatflag%>)&nbsp;</td>
		<td colspan=2 align=right><B><%=FormatCurrency(pro_money_hap,0)%>&nbsp;</td>
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
<input type=hidden name="PMmoney" value="<%=pro_money_hap%>">

<%if noteflag="y" then%>
<%'if conSeeflag="y" then%>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td align=center>�����<BR>������</td>
		<td colspan=7 bgcolor=white><textarea align="left" name="order_cmt" class="writebox" id="message2" style='width:100%; height:60px;padding:3px;border:1px solid #AFAFAF;'></textarea></td>
	</tr>
<%'end if%>
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