<html>
<meta http-equiv="Content-Type" content="text/html;charset=EUC-KR">
<link rel="stylesheet" href="../common/StyleSheet.css"> 
<body bgcolor="white">

<CENTER><br><br>
<P><font face="����" size="4"><B>E M M A</B></font></p>
<P>
<A HREF="./send_msg.asp"><font face="����" size="2">�޽���������</font></A>
<B>|</B>
<A HREF="./SentMailbox.asp"><font face="����" size="2">�����޽�����</font></A>
<B>|</B>
<A HREF="./ReservMailbox.asp"><font face="����" size="2">����޽�����</font></A>
<B>|</B>
<A HREF="./addrlist.asp"><font face="����" size="2">�ּҷ�</font></A>
<B>|</B>
<A HREF="./logout.asp"><font face="����" size="2">�α׾ƿ�</font></A>
</P>
</CENTER>

<!---------------- �����κ�  ------------------------>

<!-- #include file = "./DBConnect.inc"  -->
<CENTER>
<%
page=Request.QueryString("page")
startpage=Request.QueryString("startpage")
msgkey=Request.QueryString("msgkey")

officenum = session("sessionid")

%>
<center>
<font face="����" size="2"><b>���� �޽��� ����</b></font><br>
<br>
<table border="0" cellpadding="1" cellspacing="1"><tr><td>
<table width="640" border="0" cellspacing="1" cellpadding=3>
  <tr> 
    <td width=82 bgcolor="#aa8c9b" align="center"><font face="����" size="2" color="#FFFFFF">����������</font></td>
    <td width=100 bgcolor="#aa8c9b" align="center"><font face="����" size="2" color="#FFFFFF">�����ڹ�ȣ</font></td>
	<td bgcolor="#aa8c9b" align="center"><font face="����" size="2" color="#FFFFFF">�޽���</font></td>
	<td width=120 bgcolor="#aa8c9b" align="center"><font face="����" size="2" color="#FFFFFF">�ۼ��ð�</font></td>
	<td width=120 bgcolor="#aa8c9b" align="center"><font face="����" size="2" color="#FFFFFF">���۽ð�</font></td>
    <td width=40 bgcolor="#aa8c9b" align="center"><font face="����" size="2" color="#FFFFFF">���</font></td>
  </tr>
  <tr><td colspan=6><hr></td>
  </tr>
<%
yea=YEAR(NOW)
mon=MONTH(NOW)
if mon < 10 then
	mon= "0" & mon
end if

sql1="SELECT tran_pr, tran_date, tran_rsltdate, tran_phone, tran_etc1, tran_msg, tran_rslt, tran_status FROM em_log_" & yea & mon & " WHERE tran_id = '" & officenum & "' AND tran_etc4= '" & msgkey & "' UNION SELECT tran_pr, tran_date, tran_rsltdate, tran_phone, tran_etc1, tran_msg, tran_rslt, tran_status FROM em_tran WHERE tran_id = '" & officenum & "' AND tran_etc4= '" & msgkey & "'"
Set rs1=DBConn.Execute(sql1)
'Response.Write sql1
	i=0
	do while not rs1.eof
	i=i+1
	tran_pr=rs1(0)
	tran_date=rs1(1)
	tran_rsltdate=rs1(2)
	tran_phone=rs1(3)
	tran_etc1=rs1(4)
	tran_msg=rs1(5)
	tran_rslt=rs1(6)
	tran_status=rs1(7)

	if (tran_rslt = "0") then
		rslt= "����"
	else if (tran_rslt = "1") then
		rslt= "����"
	else if (tran_rslt = "2") then
		rslt= "�Ұ�"
	else if (tran_status="3") then
		rslt= "����"
	else if (tran_status="2") then
		sql2="SELECT tran_status FROM em_tran WHERE tran_id = '" & officenum & "' AND tran_pr= '" & tran_pr & "'"
		Set rs2=DBConn.Execute(sql2)
		if rs2.eof or rs2.bof then
			rslt= "����"
		else
			rslt= "ó����"
		end if
	end if
	end if
	end if
	end if
	end if
%>
  <tr> 
    <td align="center"><font face="����" size="2"><%=tran_etc1%></font></td>
    <td align="center"><font face="����" size="2"><%=tran_phone%></font></td>
    <td align="center"><font face="����" size="2"><%=tran_msg%></font></td>
    <td align="center"><font face="����" size="2"><%=tran_date%></font></td>
    <td align="center"><font face="����" size="2"><%=tran_rsltdate%></font></td>
    <td align="center"><font face="����" size="2"><%=rslt%></font></td>
  </tr>
<%
	rs1.movenext
	LOOP
%>
  <tr><td colspan=6><hr></td></tr>
</table>
</td></tr></table><br>
  <table width="600" border="0" cellspacing="1">
  <tr>
    <td width="600" class="tblNoColor" colspan=6 align=center><font face="����" size="2">
    [<a href="JavaScript:this.location.href = location.href">���ΰ�ħ</a>][<a href="SentMailbox.asp?page=<%=page%>&startpage=<%=startpage%>">�����޽�����</a>]
    </font></td>
  </tr>
  </table>
</center>
</body>
</html>
