<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%

	seq = request("seq")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tAccountM "
	SQL = sql & " where seq="&seq
	rs.Open sql, db, 1
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

<!--
<div id="Layer1" style="position:absolute; left:243px; top:85px; height:40px; z-index:1"> 
  <table width="115" border="0" cellspacing="0" cellpadding="0" height="40" bordercolor="#C81642">
    <tr> 
      <td align="center" style="border:2 solid #EC557B;font-family:����ü;font-size:12pt;color:#C81642;padding-top:2px;line-height:16px"><b><b>(��)��ٺ�</b></b></td>
    </tr>
  </table>
</div>
���� -->
</body>
</html>

<%end if%>
<%end if%>