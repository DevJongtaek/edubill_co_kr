<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
'if session("sessionid") = "" or isnull(session("sessionid")) = true then
'	response.redirect("check.html")
'end if
%>
<html>
<head>
	<title>������ â</title>
<SCRIPT LANGUAGE="JavaScript" SRC="formValid.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="send_msg.js"></SCRIPT>		
<SCRIPT>
/*
 Param : str - string
 Return : str's byte length
*/
function Length(str)
{
	var temp;
	var mycount = 0;
	for(var i = 0; i < str.length; i++){
		temp = str.charAt(i);
		if (escape(temp).length > 4)
			mycount += 2;
		else
			mycount++;
	}
	return mycount;
}

/*
 �޽����Էµ� ������ ���̸� ����Ͽ� Form �� ����.
*/
function setMessageLen()
{
	var frm = document.frmMsg;
	frm.messageLen.value = Length(frm.message.value);	
}
</SCRIPT>
</head>

<body onLoad="document.forms[0].elements[0].focus();">
<!---------��� �޴��� ����----------->
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

<!---------��� �޴��� ��-------------->
<!---------���� ����--------------->
<form method="post" name="frmMsg" action="send_exe.asp">

<table border=0 cellpadding=0 cellspacing=0 width="620" align="center">
<tr>
<td width="560" align="center" bgcolor="#aa8c9b">
<!--------------���� ���� ����---------->
<table border=0 cellpadding=0 cellspacing=0>
<tr>
<td><font face="����" size="2" color="#FFFFFF">������ ��ȣ</font></td>
<td><input type="text" name="receiver" size="20" value=""></td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td><font face="����" size="2" color="#FFFFFF">ȸ�� ��ȣ</font></td>
<td><input type="text" name="callback" size="20" value=""></td>
</tr>
<tr>
<td colspan="2">&nbsp;</td>
</tr>
<tr>
<td colspan="2"><font face="����" size="2" color="#FFFFFF">�޽���</font></td>
</tr>
<tr>
<td colspan="2"><INPUT NAME=messageLen TYPE=TEXT SIZE=2 READONLY VALUE=0
 style="Border: 1x SOLID BLACK; text-align: right; 
		font-size: 9pt; font-family: Tahoma;"><font face="����" size="2" color="#FFFFFF">byte(74byte�̳� ����)</font></td>
</tr>
<tr>
<td colspan="2"><TEXTAREA NAME=message COLS=30 ROWS=4 
		WRAP="VIRTUAL" ID=content
		OnKeyUp="setMessageLen();" onChange="setMessageLen();"></TEXTAREA></td>
</tr>
<tr>
<td colspan="2"><font face="����" size="2" color="#FFFFFF">���</font><input type="radio" name="resOrNot" value="soon" checked></td>
</tr>
	<%
		temp_year = year(date)
		temp_month = month(date)
		temp_day = day(date)
		temp_hour = hour(time)
		temp_minute = minute(time)
		If Len(temp_month) = 1 Then
			temp_month = "0"&temp_month
		End If
		If Len(temp_day) = 1 Then
			temp_day = "0"&temp_day
		End If
		If Len(temp_hour) = 1 Then
			temp_hour = "0"&temp_hour
		End If
		If Len(temp_minute) = 1 Then
			temp_minute = "0"&temp_minute
		End If
		temp_date = temp_year&temp_month&temp_day
		temp_time = temp_hour&temp_minute
	%>

<tr>
<td colspan=2"><font face="����" size="2" color="#FFFFFF">���೯¥:</font><input type="radio" name="resOrNot" value="reserv" onClick="document.frmMsg.date.focus();">
<input type="text" name="date" size="12" value="<%=temp_date%>" maxlength="10" onFocus="this.select()" onClick="this.form.resOrNot[1].checked = true">
<font face="����" size=2" color="#FFFFFF">�ð�:</font><input type="text" name="time" size=12 value="<%=temp_time%>" maxlength="4" onFocus="this.select()" onClick="this.form.resOrNot[1].checked = true"></td>
</tr>
<tr>
<td colspan="2">&nbsp;</td>
</tr>
<tr>
<td colspan="2" align="center"><input type="submit" value="Ȯ��">&nbsp;&nbsp;<input type="reset" value="�ٽþ���"></td>
</tr>
</table>
<!----------ĳ���� ��� �޴�----->
<table border=0 cellpadding=0 cellspacing=0 align="center">
<tr>
<td><font face="����" size=2>
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
<A HREF="javascript:;" onClick="AddChar('��');return false;">��</A> 
</font>
</td>
</tr>
</table>
<!---------ĳ���� ��� �޴� ��----->
</td>
<!---------------���� ���� ��---------------->
<!---------------������ ���� ����------------>
<td>
<table>
<tr>
<td><input type=button value="<-�߰�" onClick="receiver_add(); return false;"></td>
<td>
<table>
<tr>
<td bgcolor="#aa8c9b"><font face="����" size="2" color="FFFFFF"><b>�̸�/�׷�</b></font></td>
</tr>
<tr>
<td>
<SELECT NAME="address" SIZE="12" MULTIPLE onDblClick="receiver_add();return false;">
<%
sql1 = "select personName from em_addr_person where userId = '"&officenum&"'"
set rs = DBConn.Execute(sql1)
%>

<% while not rs.eof %>
<option value="<%=rs("personName")%>"><%=rs("personName")%></option>
<% 
rs.movenext 
wend
%>
<%
sql2 = "select groupName from em_addr_group where userId = '"&officenum&"'"
set rs = DBConn.Execute(sql2)
%>

<% while not rs.eof %>
<option value="<%=rs("groupName")%>">[G]<%=rs("groupName")%></option>
<% 
rs.movenext 
wend
%>

<SCRIPT LANGUAGE="JavaScript">
if (frmMsg.address.length == 0)
{
	document.write ("<OPTION>�ּҷϿ� </OPTION>");
	document.write ("<OPTION>��ϵ�</OPTION>");
	document.write ("<OPTION>�����</OPTION>");
	document.write ("<OPTION> �����ϴ�.  </OPTION>");
}
</SCRIPT>

</select>

</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
<!---------------������ ���� ��-------------->

</tr>
</table>
</form>
<!----------���� ��------------->
</center>
</body>
</html>

<%
DBConn.close
set DBConn=nothing
%>
