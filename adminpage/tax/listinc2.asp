<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	idx = request("idx")
	flag = request("flag")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select usercode,orderday,rordermoney "
	SQL = sql & " from tb_order"
	SQL = sql & " where idx = '"& idx &"' "
	rs.Open sql, db, 1
	imsiusercode = rs(0)
	busercode = int(left(imsiusercode,5))		'�����ڵ�
	jusercode = int(mid(imsiusercode,6,5))		'�����ڵ�
	cusercode = int(mid(imsiusercode,11,5))		'ü�����ڵ�
	imsiokday = rs(1)
	imsiokday_y = left(imsiokday,4)
	imsiokday_m = mid(imsiokday,5,2)
	imsiokday_d = mid(imsiokday,7,2)
	imsirordermoney = rs(2)
	rs.close

	'������-����
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select companynum1,companynum2,companynum3,comname,name,addr,addr2,uptae,upjong,vatflag,taxtitle,tel1,tel2,tel3,fax1,fax2,fax3 "
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = "& busercode &" "
	rs.Open sql, db, 1
	b_companynum1 = rs(0)
	b_companynum2 = rs(1)
	b_companynum3 = rs(2)
	b_companynum = b_companynum1&"-"&b_companynum2&"-"&b_companynum3
	b_comname = rs(3)
	b_name = rs(4)
	b_addr = rs(5)
	b_addr2 = rs(6)
	b_addr = b_addr&" "&b_addr2
	b_uptae = rs(7)
	b_upjong = rs(8)
	vatflag = rs(9)
	taxtitle = rs(10)
	b_tel1 = rs(11)
	b_tel2 = rs(12)
	b_tel3 = rs(13)
	b_tel = b_tel1&"-"&b_tel2&"-"&b_tel3
	b_fax1 = rs(14)
	b_fax2 = rs(15)
	b_fax3 = rs(16)
	b_fax = b_fax1&"-"&b_fax2&"-"&b_fax3
	rs.close

	'���޹޴���-ü����
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname"
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = '"& cusercode &"' "
	rs.Open sql, db, 1
	c_comname = rs(0)
	rs.close

	if vatflag="y" then						'����
		ordermoney     = round(imsirordermoney*(100/110),0)	'���ް���
		ordermoney_vat = imsirordermoney-ordermoney		'�ΰ���
		ordermoney_hap = ordermoney+ordermoney_vat		'�ΰ�������

	else								'����
		ordermoney_vat = round(imsirordermoney*0.1,0)		'�ΰ���
		ordermoney     = imsirordermoney			'���ް���
		ordermoney_hap = ordermoney+ordermoney_vat		'�ΰ�������
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pname,b.ptitle,a.rordernum,a.pprice"
	SQL = sql & " from tb_order_product a, tb_product b"
	SQL = sql & " where a.pcode = b.pcode "
	SQL = sql & " and a.idx = '"& idx &"' "
	SQL = sql & " order by a.pname asc "
	rs.Open sql, db, 1
%>

<html>
<head>
<title>�ŷ�����</title>
<link rel="stylesheet" href="jin.css" type="text/css">

</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="window.print();">

<table width="650" height=100% bordercolor=#999999 cellspacing=0 cellpadding=3 bordercolordark=black bordercolorlight=black border="1" align=center>
	<tr>
		<td align=center valign=top>

		<table width="98%" border=0 cellspacing="0" cellpadding="0" align=center>
			<tr>
				<td height=10 colspan=3></td>
			</tr>
			<tr>
				<td width=30% valign=top>

				<table width="95%" border=0 cellspacing="0" cellpadding="0">
					<tr height=20>
						<td width=17%><B>NO :</B></td>
						<td width=83%>&nbsp;</td>
					</tr>
				</table>

				<table width="95%" cellspacing="0" cellpadding="1" bordercolordark=black bordercolorlight=black border="1">
					<tr height=25>
						<td align=right><font size=2><B>���� <%=imsiokday_y%>��&nbsp;&nbsp;<%=imsiokday_m%>��&nbsp;&nbsp;<%=imsiokday_d%>��&nbsp;</td>
					</tr>
					<tr height=35>
						<td align=right><font size=2><B><%=c_comname%><B>&nbsp;&nbsp;����&nbsp;</td>
					</tr>
					<tr height=20>
						<td align=center>

						<table width="100%" cellspacing="0" cellpadding="0">
							<tr height=30>
								<td>&nbsp;�Ʒ��� ���� �ŷ� �մϴ�</td>
							</tr>
							<tr height=45 align=right>
								<td><u><font size="3"><B>�հ� : <%=formatnumber(ordermoney_hap,0)%></b>��&nbsp;</font></u>&nbsp;</td>
							</tr>
						</table>


						</td>
					</tr>
				</table>

				</td>
				<td width=23% align=center valign=top>

				<table width="100%" border=0 cellspacing="0" cellpadding="0" align=center>
					<tr height=20>
						<td align=center><u><font size="4"><B>�� �� �� �� ��</B></font></u><BR>(�����ں�����)</td>
					</tr>
				</table>

				</td>
				<td width=47% valign=top>

				<table width="99%" border="0" cellspacing="0" cellpadding="0">
					<tr height=20>
						<td width=17%>TEL : 021-2214-0833 &nbsp;&nbsp; FAX : 021-2214-0833</td>
					</tr>
				</table>

				<table width="100%" cellspacing="0" cellpadding="0" bordercolordark=black bordercolorlight=black border="1">
					<tr height=1 align=center>
						<td width=10% rowspan=4><B>��<BR><BR><B>��<BR><BR><B>��</td>
						<td width=20%>��Ϲ�ȣ</td>
						<td width=70% colspan=3>&nbsp;<%=b_companynum%></td>
					</tr>
					<tr height=1 align=center>
						<td>��ȣ</td>
						<td width=30%>&nbsp;<%=b_comname%></td>
						<td width=10%>��<BR>��</td>
						<td width=30%>&nbsp;<%=b_name%></td>
					</tr>
					<tr height=1 align=center>
						<td>�����<BR>�ּ�</td>
						<td colspan=3>&nbsp;<%=b_addr%></td>
					</tr>
					<tr height=1 align=center>
						<td>����</td>
						<td>&nbsp;<%=b_uptae%></td>
						<td>��<BR>��</td>
						<td>&nbsp;<%=b_upjong%></td>
					</tr>
				</table>

				</td>
			</tr>
			<tr height=100>
				<td colspan=3 align=center valign=top>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height=10>
						<td></td>
					</tr>
				</table>

				<table width="100%" cellspacing="0" cellpadding="0" bordercolordark=black bordercolorlight=black border="1">
					<tr height=15 align=center>
						<td width=8%>��/��</td>
						<td width=25%>ǰ ��</td>
						<td width=14%>�� ��</td>
						<td width=8%>�� ��</td>
						<td width=8%>�� ��</td>
						<td width=10%>�� ��</td>
						<td width=13%>���ް���</td>
						<td width=12%>�� ��</td>
					</tr>

			<%
				i=1
				do until rs.eof

					imsipprice = 0
					imsimoney = 0
					ptitle = rs(1)

					imsisuryang = rs(2)		'����
					imsipprice = rs("pprice")	'�ܰ�

					if vatflag="y" then							'����
						imsimoney = round(imsipprice*(100/110),0)
						imsipprice_g = imsimoney*imsisuryang				'���ް���
						imsipprice_vat = (imsipprice-imsimoney)*imsisuryang		'����
					else									'����
						imsipprice_g = imsipprice*imsisuryang				'���ް���
						imsipprice_vat = round(imsipprice*0.1,0)*imsisuryang		'����
					end if
			%>

					<tr height=10 align=center>
						<td><%=imsiokday_m%>/<%=imsiokday_d%></td>
						<td align=left>&nbsp;<%=rs(0)%></td>
						<td>&nbsp;<%=ptitle%></td>
						<td><%=imsisuryang%></td>
						<td>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice_g,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice_vat,0)%>&nbsp;</td>
					</tr>

			<%
				rs.movenext
				i=i+1
				loop
				rs.close

				for j=1 to (31-i)
			%>

					<tr height=10 align=center>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
			<%
				next
			%>

				</table>

				</td>
			</tr>
			<tr>
				<td height=10 colspan=3>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height=10>
						<td></td>
					</tr>
				</table>

				<table width="100%" cellspacing="0" cellpadding="0">
					<tr height=50>
						<td width=80% align=right>�μ���</td>
						<td width=17%>&nbsp;:&nbsp;</td>
						<td width=3%>(��)</td>
					</tr>
				</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table> 

<br>

<table width="650" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td background="dot.gif" width=650 height=1></td>
	</tr>
</table>

<BR>

<%
	idx = request("idx")
	flag = request("flag")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select usercode,orderday,rordermoney "
	SQL = sql & " from tb_order"
	SQL = sql & " where idx = '"& idx &"' "
	rs.Open sql, db, 1
	imsiusercode = rs(0)
	busercode = int(left(imsiusercode,5))		'�����ڵ�
	jusercode = int(mid(imsiusercode,6,5))		'�����ڵ�
	cusercode = int(mid(imsiusercode,11,5))		'ü�����ڵ�
	imsiokday = rs(1)
	imsiokday_y = left(imsiokday,4)
	imsiokday_m = mid(imsiokday,5,2)
	imsiokday_d = mid(imsiokday,7,2)
	imsirordermoney = rs(2)
	rs.close

	'������-����
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select companynum1,companynum2,companynum3,comname,name,addr,addr2,uptae,upjong,vatflag,taxtitle,tel1,tel2,tel3,fax1,fax2,fax3 "
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = "& busercode &" "
	rs.Open sql, db, 1
	b_companynum1 = rs(0)
	b_companynum2 = rs(1)
	b_companynum3 = rs(2)
	b_companynum = b_companynum1&"-"&b_companynum2&"-"&b_companynum3
	b_comname = rs(3)
	b_name = rs(4)
	b_addr = rs(5)
	b_addr2 = rs(6)
	b_addr = b_addr&" "&b_addr2
	b_uptae = rs(7)
	b_upjong = rs(8)
	vatflag = rs(9)
	taxtitle = rs(10)
	b_tel1 = rs(11)
	b_tel2 = rs(12)
	b_tel3 = rs(13)
	b_tel = b_tel1&"-"&b_tel2&"-"&b_tel3
	b_fax1 = rs(14)
	b_fax2 = rs(15)
	b_fax3 = rs(16)
	b_fax = b_fax1&"-"&b_fax2&"-"&b_fax3
	rs.close

	'���޹޴���-ü����
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname"
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = '"& cusercode &"' "
	rs.Open sql, db, 1
	c_comname = rs(0)
	rs.close

	if vatflag="y" then						'����
		ordermoney     = round(imsirordermoney*(100/110),0)	'���ް���
		ordermoney_vat = imsirordermoney-ordermoney		'�ΰ���
		ordermoney_hap = ordermoney+ordermoney_vat		'�ΰ�������

	else								'����
		ordermoney_vat = round(imsirordermoney*0.1,0)		'�ΰ���
		ordermoney     = imsirordermoney			'���ް���
		ordermoney_hap = ordermoney+ordermoney_vat		'�ΰ�������
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pname,b.ptitle,a.rordernum,a.pprice"
	SQL = sql & " from tb_order_product a, tb_product b"
	SQL = sql & " where a.pcode = b.pcode "
	SQL = sql & " and a.idx = '"& idx &"' "
	SQL = sql & " order by a.pname asc "
	rs.Open sql, db, 1
%>

<table width="650" height=100% bordercolor=#999999 cellspacing=0 cellpadding=3 bordercolordark=black bordercolorlight=black border="1" align=center>
	<tr>
		<td align=center valign=top>

		<table width="98%" border=0 cellspacing="0" cellpadding="0" align=center>
			<tr>
				<td height=10 colspan=3></td>
			</tr>
			<tr>
				<td width=30% valign=top>

				<table width="95%" border=0 cellspacing="0" cellpadding="0">
					<tr height=20>
						<td width=17%><B>NO :</B></td>
						<td width=83%>&nbsp;</td>
					</tr>
				</table>

				<table width="95%" cellspacing="0" cellpadding="1" bordercolordark=black bordercolorlight=black border="1">
					<tr height=25>
						<td align=right><font size=2><B>���� <%=imsiokday_y%>��&nbsp;&nbsp;<%=imsiokday_m%>��&nbsp;&nbsp;<%=imsiokday_d%>��&nbsp;</td>
					</tr>
					<tr height=35>
						<td align=right><font size=2><B><%=c_comname%><B>&nbsp;&nbsp;����&nbsp;</td>
					</tr>
					<tr height=20>
						<td align=center>

						<table width="100%" cellspacing="0" cellpadding="0">
							<tr height=30>
								<td>&nbsp;�Ʒ��� ���� �ŷ� �մϴ�</td>
							</tr>
							<tr height=45 align=right>
								<td><u><font size="3"><B>�հ� : <%=formatnumber(ordermoney_hap,0)%></b>��&nbsp;</font></u>&nbsp;</td>
							</tr>
						</table>


						</td>
					</tr>
				</table>

				</td>
				<td width=23% align=center valign=top>

				<table width="100%" border=0 cellspacing="0" cellpadding="0" align=center>
					<tr height=20>
						<td align=center><u><font size="4"><B>�� �� �� �� ��</B></font></u><BR>(���޹޴��ں�����)</td>
					</tr>
				</table>

				</td>
				<td width=47% valign=top>

				<table width="99%" border="0" cellspacing="0" cellpadding="0">
					<tr height=20>
						<td width=17%>TEL : 021-2214-0833 &nbsp;&nbsp; FAX : 021-2214-0833</td>
					</tr>
				</table>

				<table width="100%" cellspacing="0" cellpadding="0" bordercolordark=black bordercolorlight=black border="1">
					<tr height=1 align=center>
						<td width=10% rowspan=4><B>��<BR><BR><B>��<BR><BR><B>��</td>
						<td width=20%>��Ϲ�ȣ</td>
						<td width=70% colspan=3>&nbsp;<%=b_companynum%></td>
					</tr>
					<tr height=1 align=center>
						<td>��ȣ</td>
						<td width=30%>&nbsp;<%=b_comname%></td>
						<td width=10%>��<BR>��</td>
						<td width=30%>&nbsp;<%=b_name%></td>
					</tr>
					<tr height=1 align=center>
						<td>�����<BR>�ּ�</td>
						<td colspan=3>&nbsp;<%=b_addr%></td>
					</tr>
					<tr height=1 align=center>
						<td>����</td>
						<td>&nbsp;<%=b_uptae%></td>
						<td>��<BR>��</td>
						<td>&nbsp;<%=b_upjong%></td>
					</tr>
				</table>

				</td>
			</tr>
			<tr height=100>
				<td colspan=3 align=center valign=top>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height=10>
						<td></td>
					</tr>
				</table>

				<table width="100%" cellspacing="0" cellpadding="0" bordercolordark=black bordercolorlight=black border="1">
					<tr height=15 align=center>
						<td width=8%>��/��</td>
						<td width=25%>ǰ ��</td>
						<td width=14%>�� ��</td>
						<td width=8%>�� ��</td>
						<td width=8%>�� ��</td>
						<td width=10%>�� ��</td>
						<td width=13%>���ް���</td>
						<td width=12%>�� ��</td>
					</tr>

			<%
				i=1
				do until rs.eof

					imsipprice = 0
					imsimoney = 0
					ptitle = rs(1)

					imsisuryang = rs(2)		'����
					imsipprice = rs("pprice")	'�ܰ�

					if vatflag="y" then							'����
						imsimoney = round(imsipprice*(100/110),0)
						imsipprice_g = imsimoney*imsisuryang				'���ް���
						imsipprice_vat = (imsipprice-imsimoney)*imsisuryang		'����
					else									'����
						imsipprice_g = imsipprice*imsisuryang				'���ް���
						imsipprice_vat = round(imsipprice*0.1,0)*imsisuryang		'����
					end if
			%>

					<tr height=10 align=center>
						<td><%=imsiokday_m%>/<%=imsiokday_d%></td>
						<td align=left>&nbsp;<%=rs(0)%></td>
						<td>&nbsp;<%=ptitle%></td>
						<td><%=imsisuryang%></td>
						<td>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice_g,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice_vat,0)%>&nbsp;</td>
					</tr>

			<%
				rs.movenext
				i=i+1
				loop
				rs.close

				for j=1 to (31-i)
			%>

					<tr height=10 align=center>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
			<%
				next
			%>

				</table>

				</td>
			</tr>
			<tr>
				<td height=10 colspan=3>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height=10>
						<td></td>
					</tr>
				</table>

				<table width="100%" cellspacing="0" cellpadding="0">
					<tr height=50>
						<td width=80% align=right>�μ���</td>
						<td width=17%>&nbsp;:&nbsp;</td>
						<td width=3%>(��)</td>
					</tr>
				</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table> 
</body>
</html>