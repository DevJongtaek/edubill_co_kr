<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/account/dataup/fun.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	seq = request("seq")
	stxt1 = request("stxt1")
	stxt2 = request("stxt2")
	imsiwdate = request("imsiwdate")

	if stxt1<>"" and stxt2<>"" then
		if stxt2="Aym" then
			imsiorderby = " order by tcode asc, hname asc"
		elseif stxt2="tcode" or stxt2="hname" then
			imsiorderby = " order by Aym asc, tcode asc"
		end if

		if stxt2 = "Aym" then
			sendSQL = " Aym = '"& stxt1 &"' "
			if imsiwdate<>"" then
				sendSQL = sendSQL & " and wdate = '"& imsiwdate &"' "
			end if
		elseif stxt2 = "tcode" then
			sendSQL = " tcode = '"& stxt1 &"' "
			if imsiwdate<>"" then
				sendSQL = sendSQL & " and wdate = '"& imsiwdate &"' "
			end if
		elseif stxt2 = "hname" then
			sendSQL = " hname like '%"& stxt1 &"%' "
			if imsiwdate<>"" then
				sendSQL = sendSQL & " and wdate = '"& imsiwdate &"' "
			end if
		end if

		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select seq from tAccountM "
		SQL = sql & " where idx in (select idx from tb_company where flag='1' and accountflag='y') "
		SQL = sql & " and flag='1' "
		SQL = sql & " and "& sendSQL &" "
		SQL = sql & imsiorderby
'response.write sql
'response.end
		rslist.Open sql, db, 1
		if not rslist.eof then
			seqArray    = rslist.GetRows
			seqArrayint = ubound(seqArray,2)
		else
			call FunErrorMsg("��µ���Ÿ�� �����ϴ�.")
		end if
		rslist.close
	else
		call FunErrorMsg("��ȸ������ �����ϴ�.")
	end if
%>

<html>
<head>
<title>���ݰ�꼭</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/adminpage/tax/stylefont_document.css" type="text/css">

<style type="text/css">
P.breakhere {page-break-before: always}
</style>

<script language="javascript" src="/adminpage/incfile/javascript_data.js"></script>
<object id="factory" style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="/adminpage/account/smsx.cab#Version=6,2,433,70">
</object>
<script>
function printWindow() {
factory.printing.header        = "";   // Header�� �� ����
factory.printing.footer        = "";   // Footer�� �� ����
factory.printing.portrait      = true	// true ������� , false �������
factory.printing.leftMargin    = 10   // ���� ���� ������
factory.printing.topMargin     = 10   // �� ���� ������
factory.printing.rightMargin   = 10   // ������ ���� ������
factory.printing.bottomMargin  = 10   // �Ʒ� ���� ������

//factory.printing.SetMarginMeasure(2); // �׵θ� ���� ������ ������ ��ġ�� �����մϴ�.
//factory.printing.printer = "HP DeskJet 870C";  // ����Ʈ �� ������ �̸�
//factory.printing.paperSource = "Manual feed";   // ���� Feed ���
//factory.printing.collate = true;   //  ������� ����ϱ�
//factory.printing.copies = 2;   // �μ��� �ż�
//factory.printing.SetPageRange(false, 1, 3); // True�� �����ϰ� 1, 3�̸� 1���������� 3���������� ���
//factory.printing.paperSize = "A4";   // ���� ������
factory.printing.Print(false, window)	 // ��ȭ���� ǥ�ÿ��� / ��µ� �����Ӹ�
}

 //function click() {
 //     if ((event.button==2) || (event.button==3)) {
 //        alert('����Ͻ÷��� F5(���ΰ�ħ)�� �Ͽ� �μ��Ͻñ� �ٶ��ϴ�!');
 //     }
 //  }
 //  document.onmousedown=click;

</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="printWindow()">

<%
'==================================
for k=0 to seqArrayint
	seq = trim(seqArray(0,k))
'==================================
	gcount1=""
	gcount2=""
	gcount3=""
	gcount4=""
	gcount5=""
	gcount6=""
	gcount7=""
	gcount8=""
	gcount9=""
	gcount10=""
	gcount11=""

	scount1=""
	scount2=""
	scount3=""
	scount4=""
	scount5=""
	scount6=""
	scount7=""
	scount8=""
	scount9=""
	scount10=""

	binlencount = 0
	loopbin=""

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,wdate,tcode,hname,companynum,companyName,companyAddr,companyUptae,companyUpjong,Aym,Aymd,textPname,umoney,jtcode "
	SQL = sql & " from tAccountM "
	SQL = sql & " where seq="&seq
	rs.Open sql, db, 1
	idx   = rs(0)
	wdate = rs(1)
	tcode = rs(2)
	c_comname    = rs(3)
	c_companynum = rs(4)
	c_name   = rs(5)
	c_addr   = rs(6)
	c_uptae  = rs(7)
	c_upjong = rs(8)

	Aym  = rs(9)
	Aymd = rs(10)
	imsiokday_y = left(Aymd,4)
	imsiokday_m = mid(Aymd,5,2)
	imsiokday_d = right(Aymd,2)

	taxtitle = rs(11)
	umoney = rs(12)
	jtcode = rs(13)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sum(Anum) as Anum,sum(kmoney) as kmoney,sum(smoney) as smoney,sum(hmoney) as hmoney from tAccountM where idx = "& idx &" and wdate = '"& wdate &"' "
	if jtcode<>"" then
		SQL = SQL & " and jtcode = '"& jtcode &"' "
	end if
	rs.Open sql, db, 1
	Anum   = rs(0)
	kmoney = rs(1)
	smoney = rs(2)
	hmoney = rs(3)
	rs.close

	'������-�����
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select companynum1,companynum2,companynum3,comname,name,addr,addr2,uptae,upjong,vatflag,taxtitle "
	SQL = sql & " from tb_company where idx = 38135 "
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
	rs.close

	ordermoney     = kmoney	'���ް���
	ordermoney_vat = smoney	'����
	ordermoney_hap = hmoney	'�հ�ݾ�

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

%>

<div style="position:relative; left:44%; top:17%; z-index:1"><img src="/fileupdown/logo/edubill.gif" width=45 height=45></div>

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
          			<td class="tdbd_blue_top1left1right22" height="32" width="87" align="center">&nbsp;<%=c_name%><span class="stylefont5"><font color="#F81840">(��)</font></span></td>
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
				<td rowspan="2" class="tdbd_blue_top1left1right2bottom11">&nbsp;<%=tcode%></td>
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
          			<td class="tdbd_blue_top1left11" height="25" width="142"><font color="#F81840">ǰ ��</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="60"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="30"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="75"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="100"><font color="#F81840">���ް���</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="85"><font color="#F81840">�� ��</font></td>
				<td class="tdbd_blue_top1left1right22" height="25" width="50"><font color="#F81840">�� ��</font></td>
			</tr>
        		<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;<%=imsiokday_m%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;<%=imsiokday_d%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="142">&nbsp;<%=taxtitle%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="60">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;<%=Anum%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;<%=formatnumber(umoney,0)%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;<%=formatnumber(ordermoney,0)%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="85" align="right">&nbsp;<%=formatnumber(ordermoney_vat,0)%></td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="142">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="60">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="85" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="142">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="60">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="85" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="142">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="60">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="85" align="right">&nbsp;</td>
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
          			<td class="tdbd_blue_top1left1right2bottom22" rowspan="2" valign="middle" width="110">�� �ݾ��� û����.</td>
			</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left2bottom22" width="124" height="30" align="right">&nbsp;<%=formatnumber(ordermoney_hap,0)%></td>
          			<td class="tdbd_blue_top1left1bottom22" width="90" height="30" align="right">&nbsp;<%=formatnumber(ordermoney_hap,0)%></td>
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


<%if k>0 and (k mod 2)<>0 then%>&nbsp;<P CLASS="breakhere">&nbsp;<%end if%>

<%
'==================================
next
'==================================
%>

</body>
</html>
