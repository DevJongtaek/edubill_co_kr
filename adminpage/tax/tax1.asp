<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	'���ݺΰ�
	'pgubun = request("pgubun")
	comname2 = request("comname2")
	'searcha = request("searcha")
	'searchb = request("searchb")
	'searchc = request("searchc")
	'searchd = request("searchd")
	printflag = request("printflag")
	imsitprice = request("imsitprice")
	old_ordermoney = request("old_ordermoney")
	old_ordermoney_vat = request("old_ordermoney_vat")

	'set rs = server.CreateObject("ADODB.Recordset")
	'SQL = " select usercode"
	'SQL = sql & " from tb_order "
	'SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' and comname2='"& comname2 &"' "
	'rs.Open sql, db, 1
	imsiusercode = request("imsiusercode")
	busercode = int(left(imsiusercode,5))		'�����ڵ�
	jusercode = int(mid(imsiusercode,6,5))		'�����ڵ�
	cusercode = int(mid(imsiusercode,11,5))		'ü�����ڵ�
	'rs.close
	imsiokday = replace(left(now(),10),"-","")
	imsiokday_y = left(imsiokday,4)
	imsiokday_m = mid(imsiokday,5,2)
	imsiokday_d = mid(imsiokday,7,2)

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select isnull(sum(a.rordernum*a.pprice),0) "
	SQL = sql & " from tb_order_product a, tb_product b"
	SQL = sql & " where a.pcodeidx = b.idx "
	SQL = sql & " and b.gubun = '����' "
	SQL = sql & " and a.idx in ( "
		SQL = sql & " select idx "
		SQL = sql & " from tb_order "
		SQL = sql & " where comname2 = '"& comname2 &"' "
    sql = sql & " AND ISNULL(Rgubun,0) != 1 "
		if session("Ausergubun")="3" then
			SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if

		SQL = sql & " and orderday >= '"& searcha &"' and orderday <= '"& searchd &"' "

		if searchb<>"0" then
			SQL = sql & " and carname = '"& searchb &"' "
		end if

		if searchc="flag" then
			SQL = sql & " and flag = 'y' and deflag = 'n' "
		elseif searchc="deflag" then
			SQL = sql & " and flag = 'y' and deflag = 'y' "
		else
			SQL = sql & " and flag = 'y' "
		end if
	SQL = sql & " ) "
	rs.Open sql, db, 1
	imsirordermoney = CDbl(rs(0))
	rs.close

	if CDbl(imsirordermoney)=0 then
%>

		<script language="javascript">
			alert("����Ÿ�� �����ϴ�.");
			parent.window.close();
		</script>

<%
	else

	'������-����/����
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select companynum1,companynum2,companynum3,comname,name,addr,addr2,uptae,upjong,vatflag,taxtitle "
	SQL = sql & " from tb_company"

	if session("Ausergubun")="3" then	'����
		SQL = sql & " where idx = "& jusercode &" "
	else	'����
		SQL = sql & " where idx = "& busercode &" "
	end if

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
	rs.close

	'������-����/����
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select vatflag "
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = "& busercode &" "
	rs.Open sql, db, 1
	vatflag = rs(0)
	rs.close

	'���޹޴���-ü����
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select companynum1,companynum2,companynum3,comname,name,addr,addr2,uptae,upjong"
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = '"& cusercode &"' "
	rs.Open sql, db, 1
	if not rs.eof then
	c_companynum1 = rs(0)
	c_companynum2 = rs(1)
	c_companynum3 = rs(2)
	c_companynum = c_companynum1&"-"&c_companynum2&"-"&c_companynum3
	c_comname = rs(3)
	c_name = rs(4)
	c_addr = rs(5)
	c_addr2 = rs(6)
	c_addr = c_addr&" "&c_addr2
	c_uptae = rs(7)
	c_upjong = rs(8)
	end if
	rs.close

   '����
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sealname "
	SQL = sql & " from tb_adminuser "
	SQL = sql & " where usercode = '"& session("Ausercode") &"' "
	rs.Open sql, db, 1
	imsisealname = rs(0)
	rs.close

	



	if vatflag="y" then							'�ΰ�������
		if printflag="y" then						'�ܰ�������
			if old_ordermoney=imsitprice then
				ordermoney     = round(imsirordermoney*(100/110),0)	'���������ް���
				ordermoney_vat = imsirordermoney-ordermoney		'�ΰ���
			else
				ordermoney     = round(imsitprice*(100/110),0)		'�����İ��ް���
				ordermoney_vat = imsitprice-ordermoney			'�ΰ���
			end if
		else
			ordermoney     = round(imsirordermoney*(100/110),0)	'���������ް���
			ordermoney_vat = imsirordermoney-ordermoney		'�ΰ���
		end if
		ordermoney_hap = ordermoney+ordermoney_vat			'�ΰ�������

	else									'�ΰ�������
		if printflag="y" then						'�ܰ�������
			ordermoney     = CDbl(imsitprice)				'�����İ��ް���
		else
			ordermoney     = CDbl(imsirordermoney)			'���������ް���
		end if
		ordermoney_vat = round(ordermoney*0.1,0)			'�ΰ���
		ordermoney_hap = ordermoney+ordermoney_vat			'�ΰ�������

	end if

	binlencount = 11-len(ordermoney)	'������

	for i=1 to binlencount
		loopbin = loopbin&"a"
	next
	loopordermoney = loopbin&ordermoney

		gcount1 = mid(loopordermoney,1,1)
		if gcount1="a" then
			gcount1=""
		end if
		gcount2 = mid(loopordermoney,2,1)
		if gcount2="a" then
			gcount2=""
		end if
		gcount3 = mid(loopordermoney,3,1)
		if gcount3="a" then
			gcount3=""
		end if
		gcount4 = mid(loopordermoney,4,1)
		if gcount4="a" then
			gcount4=""
		end if
		gcount5 = mid(loopordermoney,5,1)
		if gcount5="a" then
			gcount5=""
		end if
		gcount6 = mid(loopordermoney,6,1)
		if gcount6="a" then
			gcount6=""
		end if
		gcount7 = mid(loopordermoney,7,1)
		if gcount7="a" then
			gcount7=""
		end if
		gcount8 = mid(loopordermoney,8,1)
		if gcount8="a" then
			gcount8=""
		end if
		gcount9 = mid(loopordermoney,9,1)
		if gcount9="a" then
			gcount9=""
		end if
		gcount10 = mid(loopordermoney,10,1)
		if gcount10="a" then
			gcount10=""
		end if
		gcount11 = mid(loopordermoney,11,1)
		if gcount11="a" then
			gcount11=""
		end if

	loopbin = ""
	for i=1 to (binlencount)
		loopbin = loopbin&"a"
	next
	loopordermoney_vat = loopbin&ordermoney_vat

	scount1 = mid(loopordermoney_vat,1,1)
	if scount1="a" then
		scount1=""
	end if
	scount2 = mid(loopordermoney_vat,2,1)
	if scount2="a" then
		scount2=""
	end if
	scount3 = mid(loopordermoney_vat,3,1)
	if scount3="a" then
		scount3=""
	end if
	scount4 = mid(loopordermoney_vat,4,1)
	if scount4="a" then
		scount4=""
	end if
	scount5 = mid(loopordermoney_vat,5,1)
	if scount5="a" then
		scount5=""
	end if
	scount6 = mid(loopordermoney_vat,6,1)
	if scount6="a" then
		scount6=""
	end if
	scount7 = mid(loopordermoney_vat,7,1)
	if scount7="a" then
		scount7=""
	end if
	scount8 = mid(loopordermoney_vat,8,1)
	if scount8="a" then
		scount8=""
	end if
	scount9 = mid(loopordermoney_vat,9,1)
	if scount9="a" then
		scount9=""
	end if
	scount10 = mid(loopordermoney_vat,10,1)
	if scount10="a" then
		scount10=""
	end if

	if printflag="y" then	'����
		SQL = "INSERT INTO tb_taxlog(flag,usercode,sday1,sday2,regday,title,tnum,tprice,tprice2,tprice_vat,"
		SQL = SQL & " gcompany,gcompanyno,gcompanyname,gcompanyaddr,guptae,gupjong, "
		SQL = SQL & " scompany,scompanyno,scompanyname,scompanyaddr,suptae,supjong,oldmoneyhap,oldmoneyhap_vat,wdate) VALUES "
		SQL = SQL & " ('"& pgubun &"',"
		SQL = SQL & " '"& imsiusercode &"',"
		SQL = SQL & " '"& searcha &"',"
		SQL = SQL & " '"& searchd &"',"
		SQL = SQL & " '"& searchd &"',"
		SQL = SQL & " '"& imsiokday &"',"
		SQL = SQL & " '"& taxtitle &"',"
		SQL = SQL & " 1,"
		SQL = SQL & " "& ordermoney &","
		SQL = SQL & " "& ordermoney_vat &","

		SQL = SQL & " '"& b_comname &"',"
		SQL = SQL & " '"& b_companynum &"',"
		SQL = SQL & " '"& b_name &"',"
		SQL = SQL & " '"& b_addr &"',"
		SQL = SQL & " '"& b_uptae &"',"
		SQL = SQL & " '"& b_upjong &"',"

		SQL = SQL & " '"& c_comname &"',"
		SQL = SQL & " '"& c_companynum &"',"
		SQL = SQL & " '"& c_name &"',"
		SQL = SQL & " '"& c_addr &"',"
		SQL = SQL & " '"& c_uptae &"',"
		SQL = SQL & " '"& c_upjong &"',"
		SQL = SQL & " "& old_ordermoney &","
		SQL = SQL & " "& old_ordermoney_vat &","
		SQL = SQL & " '"& now() &"')"
		db.Execute SQL
	end if
%>

<html>
<head>
<title>���ݰ�꼭</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="stylefont_document.css" type="text/css">

<script language="javascript" src="/adminpage/incfile/javascript_data.js"></script>

</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" <%if printflag="y" then%>onload="window.print();"<%end if%>>

<table width="650" border="0" cellspacing="0" cellpadding="0">



<form action=newwin2.asp method=post name=form>
<input type=hidden name=pgubun value="<%=pgubun%>">
<input type=hidden name=comname2 value="<%=comname2%>">
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=searchd value="<%=searchd%>">
<input type=hidden name=printflag value="y">
<input type=hidden name=saveflag>
<input type=hidden name=old_ordermoney value="<%=ordermoney%>">
<input type=hidden name=old_ordermoney_vat value="<%=ordermoney_vat%>">
<input type=hidden name=imsiusercode value="<%=imsiusercode%>">

	<tr> 
		<td colspan="4" height="4"></td>
	</tr>
	<tr> 
		<td width="5" height="2">&nbsp;</td>
		<td height="2" width="310" class="stylefont1" valign="bottom"><font color="#4956C7">[���� ��11ȣ ����]</font></td>
		<td height="2" width="310" class="stylefont1" align="right" valign="bottom"><font color="#4956C7">[û��]</font></td>
    		<td width="5" height="2">&nbsp;</td>
	</tr>
	<tr> 
		<td width="25" height="2">&nbsp;</td>
		<td height="2" colspan="2"> 

		<table width="620" border=0" cellspacing="0" cellpadding="0">
			<tr> 
          			<td rowspan="2" class="tdbd_blue_top2left2bottom1"> 

				<table width="497" border="0" cellspacing="0" cellpadding="0">
              				<tr> 
                				<td rowspan="2" align="center" width="447">
							<font style="font-size:11pt"><b><font color="#4956C7" size="5">���ݰ�꼭</font></b></font> 
                  					<font color="#4956C7"><span class="stylefont1">(���� �޴��ڿ�)</span></font>
						</td>
                				<td width="50" class="stylefont1" align="center" height="18" valign="bottom"><font color="#4956C7">å &nbsp;�� ȣ</font></td>
					</tr>
              				<tr> 
                				<td width="50" class="stylefont1" align="center" height="18" valign="bottom"><font color="#4956C7">�Ϸù�ȣ</font></td>
					</tr>
				</table>

				</td>
				<td colspan="3" class="tdbd_blue_top2left1" height="20" align="right" valign="bottom">&nbsp;<font color="#4956C7">��</font></td>
				<td colspan="4" class="tdbd_blue_top2left1right2" height="20" align="right" valign="bottom">&nbsp;<font color="#4956C7">ȣ</font></td>
			</tr>
        		<tr> 
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1right2bottom1">&nbsp;</td>
        		</tr>
      		</table>

      		<table width="620" border="0" cellspacing="0" cellpadding="1">
			<tr> 
          			<td class="tdbd_blue_top1left2bottom1" rowspan="4" align="center" height="25" width="15">
					<font color="#4956C7">��<br><br>��<br><br>��</font>
				</td>
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">��Ϲ�ȣ</font></td>
          			<td class="tdbd_blue_top1left1" colspan="3" height="32" align="center"><b><%=b_companynum%></b>&nbsp;</td>
          			<td class="tdbd_blue_top1left1bottom1" rowspan="4" height="32" align="center" width="15">
					<font color="#4956C7">��<br>��<br>��<br>��<br>��</font>
				</td>
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">��Ϲ�ȣ</font></td>
          			<td class="tdbd_blue_top1left1right2" colspan="3" height="32" align="center"><b><%=c_companynum%></b>&nbsp;</td>
        		</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">�� &nbsp;&nbsp;ȣ<br>(���θ�)</font></td>
				<td class="tdbd_blue_top1left1" height="32" width="87">&nbsp;<%=b_comname%></td>
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">�� ��<br>(��ǥ��)</font></td>
				<td class="tdbd_blue_top1left1" height="32" width="87" align="center"><%=b_name%><font color="#4956C7">(��)</font></td>
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">�� &nbsp;&nbsp;ȣ<br>(���θ�)</font></td>
				<td class="tdbd_blue_top1left1" height="32" width="87">&nbsp;<%=c_comname%></td>
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">�� &nbsp;&nbsp;��<br>(��ǥ��)</font></td>
          			<td class="tdbd_blue_top1left1right2" height="32" width="87" align="center">&nbsp;<%=c_name%><span class="stylefont5"><font color="#4956C7">(��)</font></span></td>
        		</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">�����<br>�� &nbsp;&nbsp;��</font></td>
				<td class="tdbd_blue_top1left1" colspan="3" height="32">&nbsp;<%=b_addr%></td>
				<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">�����<br>�� &nbsp;&nbsp;��</font></td>
				<td class="tdbd_blue_top1left1right2" colspan="3" height="32">&nbsp;<%=c_addr%></td>
			</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left1bottom1" height="32" align="center" width="50"><font color="#4956C7">�� &nbsp;&nbsp;��</font></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" width="87">&nbsp;<%=b_uptae%></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" align="center" width="50"><font color="#4956C7">�� ��</font></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" width="87">&nbsp;<%=b_upjong%></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" align="center" width="50"><font color="#4956C7">�� &nbsp;&nbsp;��</font></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" width="87">&nbsp;<%=c_uptae%></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" align="center" width="50"><font color="#4956C7">�� ��</font></td>
				<td class="tdbd_blue_top1left1right2bottom1" height="32" width="87">&nbsp;<%=c_upjong%></td>
			</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
        		<tr align="center" valign="bottom"> 
          			<td colspan="3" class="tdbd_blue_top1left2" height="20"><font color="#4956C7">�� &nbsp;&nbsp;��</font></td>
				<td colspan="12" class="tdbd_blue_top1left1" height="20"><font color="#4956C7">�� &nbsp;�� &nbsp;�� &nbsp;��</font></td>
				<td colspan="10" class="tdbd_blue_top1left1" height="20"><font color="#4956C7">�� &nbsp;&nbsp;��</font></td>
				<td class="tdbd_blue_top1left1right2" height="20" width="125"><font color="#4956C7">�� ��</font></td>
			</tr>
        		<tr> 
				<td width="40" class="tdbd_blue_top1left2" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" align="center" width="20" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="20" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="36" align="center" valign="bottom"><font color="#4956C7">������</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">õ</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">õ</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">õ</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">õ</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">��</font></td>
				<td rowspan="2" class="tdbd_blue_top1left1right2bottom1">&nbsp;</td>
			</tr>
        		<tr> 
				<td width="40" class="tdbd_blue_top1left2bottom1" align="center" height="30">&nbsp;<%=imsiokday_y%></td>
				<td class="tdbd_blue_top1left1bottom1" align="center" width="20" height="30">&nbsp;<%=imsiokday_m%></td>
				<td width="20" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=imsiokday_d%></td>
				<td width="36" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=binlencount%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount1%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount2%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount3%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount4%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount5%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount6%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount7%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount8%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount9%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount10%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount11%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount1%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount2%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount3%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount4%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount5%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount6%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount7%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount8%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount9%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount10%></td>
			</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
			<tr align="center" valign="bottom"> 
          			<td class="tdbd_blue_top1left2" height="25" width="20"><font color="#4956C7">��</font></td>
          			<td class="tdbd_blue_top1left1" height="25" width="20"><font color="#4956C7">��</font></td>
          			<td class="tdbd_blue_top1left1" height="25" width="122"><font color="#4956C7">ǰ ��</font></td>
				<td class="tdbd_blue_top1left1" height="25" width="70"><font color="#4956C7">�� ��</font></td>
				<td class="tdbd_blue_top1left1" height="25" width="30"><font color="#4956C7">�� ��</font></td>
				<td class="tdbd_blue_top1left1" height="25" width="75"><font color="#4956C7">�� ��</font></td>
				<td class="tdbd_blue_top1left1" height="25" width="100"><font color="#4956C7">���ް���</font></td>
				<td class="tdbd_blue_top1left1" height="25" width="95"><font color="#4956C7">�� ��</font></td>
				<td class="tdbd_blue_top1left1right2" height="25" width="50"><font color="#4956C7">�� ��</font></td>
			</tr>
        		<tr> 
				<td class="tdbd_blue_top1left2" height="25" width="20" align="center">&nbsp;<%=imsiokday_m%></td>
          			<td class="tdbd_blue_top1left1" height="25" width="20" align="center">&nbsp;<%=imsiokday_d%></td>
          			<td class="tdbd_blue_top1left1" height="25" width="122">&nbsp;<%=taxtitle%></td>
          			<td class="tdbd_blue_top1left1" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="30" align="center">&nbsp;1</td>

				<%if printflag="" then%>
	          			<td class="tdbd_blue_top1left1" height="25" width="75" align="right">
						<input type=text name=imsitprice value="<%=ordermoney%>" onkeypress="onlyNumber();" maxlength=9 size=9>
					</td>
				<%else%>
	          			<td class="tdbd_blue_top1left1" height="25" width="75" align="right">&nbsp;<%=formatnumber(ordermoney,0)%></td>
				<%end if%>

          			<td class="tdbd_blue_top1left1" height="25" width="100" align="right">&nbsp;<%=formatnumber(ordermoney,0)%></td>
          			<td class="tdbd_blue_top1left1" height="25" width="95" align="right">&nbsp;<%=formatnumber(ordermoney_vat,0)%></td>
          			<td class="tdbd_blue_top1left1right2" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left2" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right2" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left2" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right2" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left2" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right2" height="25" width="50">&nbsp;</td>
        		</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
        		<tr align="center"> 
          			<td class="tdbd_blue_top1left2" width="124" valign="bottom" height="20"><font color="#4956C7">�� �� �� ��</font></td>
				<td class="tdbd_blue_top1left1" width="90" valign="bottom" height="20"><font color="#4956C7">�� ��</font></td>
				<td class="tdbd_blue_top1left1" width="90" valign="bottom" height="20"><font color="#4956C7">�� ǥ</font></td>
				<td class="tdbd_blue_top1left1" width="90" valign="bottom" height="20"><font color="#4956C7">�� ��</font></td>
				<td class="tdbd_blue_top1left1" width="90" valign="bottom" height="20"><font color="#4956C7">�ܻ�̼���</font></td>
          			<td class="tdbd_blue_top1left1right2bottom2" rowspan="2" valign="middle" width="110">�� �ݾ��� û����.<BR><font color=white>�� �ݾ���</font> ����<font color=white>��.</td>
			</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left2bottom2" width="124" height="30" align="right">&nbsp;<%=formatnumber(ordermoney_hap,0)%></td>
          			<td class="tdbd_blue_top1left1bottom2" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom2" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom2" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom2" width="90" height="30" align="right">&nbsp;0</td>
        		</tr>
      		</table>

		</td>
    		<td width="5" height="2">&nbsp;</td>
  	</tr>
  	<tr> 
		<td height="2">&nbsp;</td>
		<td class="stylefont5" height="2"><font color="#4956C7">22226-28131�� '96.2.27.����</font></td>
    		<td class="stylefont5" height="2" align="right"><font color="#4956C7">182mm x128mm �μ����(Ư��)</font></td>
		<td height="2">&nbsp;</td>
	</tr>
</table>

<br>
<div id="Layer1" style="position:absolute; left:264px; top:85px; height:40px; z-index:1"> 
  <table width="115" border="0" cellspacing="0" cellpadding="0" height="40" bordercolor="#C81642">
    <tr> 
      <td align="center"><%if imsisealname<>"" then%><img src="/fileupdown/logo/<%=imsisealname%>" width="45" height="45"><%end if%></td>
    </tr>
  </table>
</div>
<%if printflag="" then%>
	<center>
	<input type=button value="���ݰ�꼭 ����" onclick="return taxchecked('y');">
	</center>
</form>
<%end if%>

<%if printflag="y" then%>

<table width="650" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td background="dot.gif" width=650 height=1></td>
	</tr>
</table>

<BR>

<table width="650" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td colspan="4" height="4"></td>
	</tr>
	<tr> 
		<td width="5" height="2">&nbsp;</td>
		<td height="2" width="310" class="stylefont1" valign="bottom"><font color="#F81840">[���� ��11ȣ ����]</font></td>
		<td height="2" width="310" class="stylefont1" align="right" valign="bottom"><font color="#F81840">[����]</font></td>
    		<td width="5" height="2">&nbsp;</td>
	</tr>
	<tr> 
		<td width="25" height="2">&nbsp;</td>
		<td height="2" colspan="2"> 

		<table width="620" border=0 cellspacing="0" cellpadding="0">
			<tr> 
          			<td rowspan="2" class="tdbd_blue_top2left2bottom11"> 

				<table width="497" border="0" cellspacing="0" cellpadding="0">
              				<tr> 
                				<td rowspan="2" align="center" width="447">
							<font style="font-size:11pt"><b><font color="#F81840" size="5">���ݰ�꼭</font></b></font> 
                  					<font color="#F81840"><span class="stylefont1">(������ ������)</span></font>
						</td>
                				<td width="50" class="stylefont1" align="center" height="18" valign="bottom"><font color="#F81840">å &nbsp;�� ȣ</font></td>
					</tr>
              				<tr> 
                				<td width="50" class="stylefont1" align="center" height="18" valign="bottom"><font color="#F81840">�Ϸù�ȣ</font></td>
					</tr>
				</table>

				</td>
				<td colspan="3" class="tdbd_blue_top2left11" height="20" align="right" valign="bottom">&nbsp;<font color="#F81840">��</font></td>
				<td colspan="4" class="tdbd_blue_top2left1right22" height="20" align="right" valign="bottom">&nbsp;<font color="#F81840">ȣ</font></td>
			</tr>
        		<tr> 
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1right2bottom11">&nbsp;</td>
        		</tr>
      		</table>

      		<table width="620" border="0" cellspacing="0" cellpadding="1">
			<tr> 
          			<td class="tdbd_blue_top1left2bottom11" rowspan="4" align="center" height="25" width="15">
					<font color="#F81840">��<br><br>��<br><br>��</font>
				</td>
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">��Ϲ�ȣ</font></td>
          			<td class="tdbd_blue_top1left11" colspan="3" height="32" align="center"><b><%=b_companynum%></b>&nbsp;</td>
          			<td class="tdbd_blue_top1left1bottom11" rowspan="4" height="32" align="center" width="15">
					<font color="#F81840">��<br>��<br>��<br>��<br>��</font>
				</td>
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">��Ϲ�ȣ</font></td>
          			<td class="tdbd_blue_top1left1right22" colspan="3" height="32" align="center"><b><%=c_companynum%></b>&nbsp;</td>
        		</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">�� &nbsp;&nbsp;ȣ<br>(���θ�)</font></td>
				<td class="tdbd_blue_top1left11" height="32" width="87">&nbsp;<%=b_comname%></td>
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">�� ��<br>(��ǥ��)</font></td>
				<td class="tdbd_blue_top1left11" height="32" width="87" align="center"><%=b_name%><font color="#F81840">(��)</font></td>
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">�� &nbsp;&nbsp;ȣ<br>(���θ�)</font></td>
				<td class="tdbd_blue_top1left11" height="32" width="87">&nbsp;<%=c_comname%></td>
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">�� &nbsp;&nbsp;��<br>(��ǥ��)</font></td>
          			<td class="tdbd_blue_top1left1right22" height="32" width="87" align="center">&nbsp;<%=c_comname%><span class="stylefont5"><font color="#F81840">(��)</font></span></td>
        		</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">�����<br>�� &nbsp;&nbsp;��</font></td>
				<td class="tdbd_blue_top1left11" colspan="3" height="32">&nbsp;<%=b_addr%></td>
				<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">�����<br>�� &nbsp;&nbsp;��</font></td>
				<td class="tdbd_blue_top1left1right22" colspan="3" height="32">&nbsp;<%=c_addr%></td>
			</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left1bottom11" height="32" align="center" width="50"><font color="#F81840">�� &nbsp;&nbsp;��</font></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" width="87">&nbsp;<%=b_uptae%></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" align="center" width="50"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" width="87">&nbsp;<%=b_upjong%></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" align="center" width="50"><font color="#F81840">�� &nbsp;&nbsp;��</font></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" width="87">&nbsp;<%=c_uptae%></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" align="center" width="50"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left1right2bottom11" height="32" width="87">&nbsp;<%=c_upjong%></td>
			</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
        		<tr align="center" valign="bottom"> 
          			<td colspan="3" class="tdbd_blue_top1left22" height="20"><font color="#F81840">�� &nbsp;&nbsp;��</font></td>
				<td colspan="12" class="tdbd_blue_top1left11" height="20"><font color="#F81840">�� &nbsp;�� &nbsp;�� &nbsp;��</font></td>
				<td colspan="10" class="tdbd_blue_top1left11" height="20"><font color="#F81840">�� &nbsp;&nbsp;��</font></td>
				<td class="tdbd_blue_top1left1right22" height="20" width="125"><font color="#F81840">�� ��</font></td>
			</tr>
        		<tr> 
				<td width="40" class="tdbd_blue_top1left22" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" align="center" width="20" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="20" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="36" align="center" valign="bottom"><font color="#F81840">������</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">õ</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">õ</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">õ</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">õ</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">��</font></td>
				<td rowspan="2" class="tdbd_blue_top1left1right2bottom11">&nbsp;</td>
			</tr>
        		<tr> 
				<td width="40" class="tdbd_blue_top1left2bottom11" align="center" height="30">&nbsp;<%=imsiokday_y%></td>
				<td class="tdbd_blue_top1left1bottom11" align="center" width="20" height="30">&nbsp;<%=imsiokday_m%></td>
				<td width="20" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=imsiokday_d%></td>
				<td width="36" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=binlencount%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount1%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount2%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount3%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount4%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount5%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount6%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount7%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount8%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount9%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount10%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount11%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount1%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount2%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount3%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount4%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount5%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount6%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount7%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount8%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount9%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount10%></td>
			</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
			<tr align="center" valign="bottom"> 
          			<td class="tdbd_blue_top1left22" height="25" width="20"><font color="#F81840">��</font></td>
          			<td class="tdbd_blue_top1left11" height="25" width="20"><font color="#F81840">��</font></td>
          			<td class="tdbd_blue_top1left11" height="25" width="122"><font color="#F81840">ǰ ��</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="70"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="30"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="75"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="100"><font color="#F81840">���ް���</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="95"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left1right22" height="25" width="50"><font color="#F81840">�� ��</font></td>
			</tr>
        		<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;<%=imsiokday_m%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;<%=imsiokday_d%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="122">&nbsp;<%=taxtitle%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;1</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;<%=formatnumber(ordermoney,0)%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;<%=formatnumber(ordermoney,0)%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="95" align="right">&nbsp;<%=formatnumber(ordermoney_vat,0)%></td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
        		<tr align="center"> 
          			<td class="tdbd_blue_top1left22" width="124" valign="bottom" height="20"><font color="#F81840">�� �� �� ��</font></td>
				<td class="tdbd_blue_top1left11" width="90" valign="bottom" height="20"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left11" width="90" valign="bottom" height="20"><font color="#F81840">�� ǥ</font></td>
				<td class="tdbd_blue_top1left11" width="90" valign="bottom" height="20"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left11" width="90" valign="bottom" height="20"><font color="#F81840">�ܻ�̼���</font></td>
          			<td class="tdbd_blue_top1left1right2bottom22" rowspan="2" valign="middle" width="110">�� �ݾ��� û����.<BR><font color=white>�� �ݾ���</font> ����<font color=white>��.</td>
			</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left2bottom22" width="124" height="30" align="right">&nbsp;<%=formatnumber(ordermoney_hap,0)%></td>
          			<td class="tdbd_blue_top1left1bottom22" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom22" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom22" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom22" width="90" height="30" align="right">&nbsp;0</td>
        		</tr>
      		</table>

		</td>
    		<td width="5" height="2">&nbsp;</td>
  	</tr>
  	<tr> 
		<td height="2">&nbsp;</td>
		<td class="stylefont5" height="2"><font color="#F81840">22226-28131�� '96.2.27.����</font></td>
    		<td class="stylefont5" height="2" align="right"><font color="#F81840">182mm x128mm �μ����(Ư��)</font></td>
		<td height="2">&nbsp;</td>
	</tr>
</table>

<br>
<br>
<div id="Layer1" style="position:absolute; left:264px; top:85px; height:40px; z-index:1"> 
  <table width="115" border="0" cellspacing="0" cellpadding="0" height="40" bordercolor="#C81642">
    <tr> 
      <td align="center"><%if imsisealname<>"" then%><img src="/fileupdown/logo/<%=imsisealname%>" width="45" height="45"><%end if%></td>
    </tr>
  </table>
</div>

</body>
</html>

<%end if%>
<%end if%>