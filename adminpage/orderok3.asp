<!--#include virtual="/db/db.asp"-->
<%

	Response.Expires = 0   
	Response.AddHeader "Pragma","no-cache"   
	Response.AddHeader "Cache-Control","no-cache,must-revalidate"  

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
	SQL = " select d_requestday,vatflag,myflag,myflag_select,noteflag,conSeeflag,useDistributionTotal,MinOrderCheck ,MinOrderAmt  "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& busercode
	rs.Open sql, db, 1
	d_requestday = rs(0)
	rs_vatflag = rs(1)
	myflag        = rs(2)	'�̼���üũ - �̼�,����üũ ���� y/n
	myflag_select = rs(3)	'�̼���üũ - 1:�ܿ����Ÿ� üũ 2:�ܿ����Ű� �ֹ��ݾ� üũ
	noteflag      = rs(4)	'����/���� ����
	conSeeflag    = rs(5)
	useDistributionTotal   = rs(6)
    MinOrderCheck   = rs(7)
    MinOrderAmt   = rs(8)
	rs.close
	imsi_vatflag = rs_vatflag
	if rs_vatflag="y" then
		rs_vatflag = "VAT����"
	elseif rs_vatflag="n" then
		rs_vatflag = "VAT����"
	else
		rs_vatflag = "�����"
	end if

 
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select virtual_acnt3,virtual_acnt3_bank,virtual_name3 "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& busercode
	rs.Open sql, db, 1
	if not rs.eof then
		virtual_acnt3 = rs(0)	'�Ա�����
		virtual_acnt3_bank = rs(1)	'�Աݰ��¹�ȣ
        virtual_name3 = rs(2) '������
	else
		virtual_acnt3 = 0
		virtual_acnt3_bank = 0
	end if
	

    set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select count(*) "
	SQL = sql & " from tb_order "
	SQL = sql & " where usercode = '"& usercode &"' "
    SQL = sql & " and orderday = '"& replace(left(now(),10),"-","") &"' "
    SQL = sql & " and rordermoney != 0 "
	rs.Open sql, db, 1
	if not rs.eof then
		ordercnt = rs(0)	'�Ա�����
	
	else
		ordercnt = 0
		
	end if
	rs.close
%>

<!--#include virtual="/adminpage/incfile/top2.asp"-->

<script language="javascript">
function bwrite() {
	document.all("btn1").disabled = true;
	form.submit() ;
}
</script>


<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" >
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center colspan=2>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><B>[ ü���� �ֹ����� Ȯ�� ]</td>
	</tr>
	<%If left(session("AAusercode"),5) = "19209" Then %>
	<tr>
		<td align="left"><b>[����Ǫ��]</b></td>
	</tr>
	<%End If %>
    <%If left(session("AAusercode"),5) = "96338" Then %>
	<tr>
		<td align="left"><b>[94����]</b></td>
	</tr>
	<%End If %>
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
			SQL = " select idx,pcode,pname,pprice,ptitle,bigo,gubun "
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
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				taxGubun = rs(6)	'����/����� / imsi_vatflag
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
				response.write "<td align=left>&nbsp;"&pro_pname&"</td>"
				response.write "<td align=left>&nbsp;"&ptitle&"</td>"
				response.write "<td align=right>"&formatnumber(pro_pprice,0)&"&nbsp;</td>"
				response.write "<td>"&array_ordernum(i)&"</td>"
				response.write "<td align=right>"&formatnumber(imsikkmoney,0)&"&nbsp;</td>"
				response.write "<td align=right>"& formatnumber(taxmoney,0) &"&nbsp;</td>"
				response.write "<td>"&bigo&"</td>"
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
		<td colspan=5 align=right><B>�� ��<!--(<%=rs_vatflag%>)-->&nbsp;</td>
		<td colspan=2 align=right><B><%=formatnumber(pro_money_hap,0)%>&nbsp;</td>
		<td></td>
	</tr>
	<%
	If useDistributionTotal = "y" Then 
		set rsdc = server.CreateObject("ADODB.Recordset")
SQL = " select case p.dcenterchoice when '0' then '00000' else p.dcenterchoice end, isnull(d.bname, '��Ͼȵ�'), "
		If imsi_vatflag = "n" Then
			SQL = sql & " round(sum(c.pprice * pcnt), 0) + sum(round(case p.gubun when '����' then (c.pprice* pcnt) * 0.1 else 0 end, 0)) "
		Else 
			SQL = sql & " round(sum(c.pprice * pcnt), 0) "
		End If 
		SQL = sql & " from   tb_product p   "
		SQL = sql & " join tb_product_cart c "
		SQL = sql & " on p.pcode = c.pcode "
		SQL = sql & " left outer join tb_company_dcenter d "
		SQL = sql & " on d.bidx = p.dcenterchoice "
		SQL = sql & " where c.usercode = '" & usercode & "' "
		SQL = sql & " and p.usercode = '" & busercode & "' "
		SQL = sql & " group by p.dcenterchoice, d.bname "
		SQL = sql & " order by dcenterchoice"
		rsdc.Open sql, db, 1
'		response.write sql

		response.write "<tr>"
		response.write "	<td colspan=8 width=10 bgcolor=white></td>"
		response.write "	</tr>"
		do until rsdc.eof
%>
		<tr height=28 bgcolor=#F7F7FF align=center>
			<td colspan=2 align=left>&nbsp;<%=rsdc(1)%></td>
			<td colspan=3 align=right><B>�� ��<!--(<%=rs_vatflag%>)-->&nbsp;</td>
			<td colspan=2 align=right><%=FormatNumber(rsdc(2),0)%></td>
			<td>&nbsp;</td>
		</tr>
<%

		rsdc.movenext
		i=i+1
		loop
		rsdc.close
	End If 
%>
</table>
<!--�÷�����-->
<%If left(session("AAusercode"),5) = "19209" Then %>
<!--<tr>
<td align="left">
<br>
<b>[�÷�����]</b>
<br>
���� ���� �� ��ۺ�
</td>
</tr>-->
<tr>
<td>
<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<!--<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=8%>��ǰ�ڵ�</td>
		<td width=23%>��ǰ��</td>
		<td width=15%>�԰�</td>
		<td width=10%>�ܰ�</td>
		<td width=10%>����</td>
		<td width=14%>���ް���</td>
		<td width=10%>����</td>
		<td width=10%>���</td>
	</tr>-->

<!--<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	j=1
	kmoneyHap = 0
	tmoneyHap = 0
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
			SQL = "  select idx,p.pcode,pname,c.pprice,ptitle,bigo,gubun  "
			SQL = sql & " from tb_product p  "
			SQL = sql & "  join (select pcode, pprice from tb_product where usercode = '77275') c "
			SQL = sql & "  on p.pcode = c.pcode "
			SQL = sql & " where usercode = '"& busercode &"' "
			SQL = sql & " and p.pcode = '"& trim(array_pcode(i)) &"' "
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
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				taxGubun = rs(6)	'����/����� / imsi_vatflag
				kmoney = pro_pprice*array_ordernum(i)	'���ް���
				taxGubun="����"
				imsi_vatflag="y"
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
				response.write "<td align=right>"&formatnumber(imsikkmoney,0)&"&nbsp;</td>"
				response.write "<td align=right>"& formatnumber(taxmoney,0) &"&nbsp;</td>"
				response.write "<td>"&bigo&"</td>"
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
%>-->

	<!--<tr height=28 bgcolor=#F7F7FF align=center>
		<td colspan=5 align=right><B>�� ��&nbsp;</td>
		<td colspan=2 align=right><B><%=formatnumber(pro_money_hap,0)%>&nbsp;</td>
		<td></td>
	</tr>-->

<%End If %>
<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Function FunErrorMsg(errormsg)	'�����޼���
			FunErrorMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg &"');history.back(-1);</SCRIPT>"
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
			JavaTxt = "�����ѵ��� �ʰ��Ǿ� �ֹ��� �Ͻ� �� �����ϴ�.\n\n"
			JavaTxt = JavaTxt & "�ֹ������� �����Ͽ� �ٽ� �ֹ� �ٶ��ϴ�.!!!\n\n"
			JavaTxt = JavaTxt & "�� �ֹ����� �ݾ� : "& JavaOrderOkMoney  &" ��\n\n"
			JavaTxt = JavaTxt & "�� �ֹ��Ͻ� �ݾ� : "& JavaOrderMoney    &" ��\n\n"
			JavaTxt = JavaTxt & "�� �ʰ� �ݾ�     : "& JavaOrderNotMoney &" ��"
			call FunErrorMsg(JavaTxt)
		end if
	end if

    'response.Write pro_money_hap 
   ' response.Write pro_money_hap
    if MinOrderCheck="y" and ordercnt = "0" then
        if pro_money_hap < MinOrderAmt then
            JavaTxt = "ü�κ��翡�� ������ ""�ּ��ֹ��ݾ�"" ���� ����,\n\n"
			JavaTxt = JavaTxt & "�ֹ� ����� ���� �ʾҽ��ϴ�.\n\n"
			JavaTxt = JavaTxt & "�ּ� �ֹ��ݾ��� "& formatnumber(MinOrderAmt,0)  &" �� �Դϴ�\n\n"
			JavaTxt = JavaTxt & "Ȯ�� ��,�ٽ� �ֹ� �ٶ��ϴ�."&ordercnt
			call FunErrorMsg(JavaTxt)
		end if
    end if

    if myflag="y" and myflag_select="4" then
		if CutOrderMoney<0 then
			JavaOrderOkMoney  = formatnumber(OrderMoney,0) '�ֹ����ɱݾ�
			JavaOrderMoney    = formatnumber(pro_money_hap,0) '�ֹ��ݾ�
			JavaOrderNotMoney = formatnumber(CutOrderMoney,0) '�ʰ��ݾ�
            Javeye_money = formatnumber(Ye_money,0) '���űݾ�
            

    

		
		end if
	end if

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<form action="orderok4.asp" name=form method=post>
<input type=hidden name="pcode" value="<%=request("pcode")%>">
<input type=hidden name="ordernum" value="<%=request("ordernum")%>">
<input type=hidden name="d_requestday" value="<%=d_requestday%>">
<input type=hidden name="virtual_acnt3_bank" value="<%=virtual_acnt3_bank%>">

<input type=hidden name="PMmoney" value="<%=pro_money_hap%>">
<input type=hidden name="YeMoney" value="<%=Javeye_money%>">
   

<%'if noteflag="y" then  2011.04.05 ����� ������ ���ֱ�%>
<%if conSeeflag="y" then%>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=8% align=center>�����<BR>������</td>
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
   
    <%if virtual_acnt3_bank <> "" then%>
   <tr height=28 bgcolor=#F7F7FF align=center>
       <td align=center>�Աݰ���</td>
		<td colspan=7 bgcolor=white align=left>
       
		<b> &nbsp; ����� : <%=virtual_acnt3_bank%>���� /&nbsp; ���¹�ȣ :  <%=virtual_acnt3%> /&nbsp;  ������ : <%=virtual_name3%> </b></td>
	</tr>
    <%end if %>

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
			<a href="#" onclick="javascript:history.back();"><img src="/images/admin/l_bu77.gif" border=0></a>
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