<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=Sheet1.xls"
%>
<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	userid = session("Auserid")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname, orderflag from tb_company " 
	SQL = SQL & " where bidxsub = (select left(usercode, 5) "
    SQL = SQL & " from tb_adminuser "
    SQL = SQL & " where dbo.tb_adminuser.userid = '" & userid & "') "
	SQL = SQL & " and flag = '3' "
	SQL = SQL & " order by tcode "
'response.write  sql
	rs.Open sql, db, 1
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type="text/css">
<!--
td.accountnum
{mso-number-format:\@}
-->
</STYLE>
<body>

<table border="1">
	<tr height=28 align=center>
		<td bgcolor="yellow" align="center" width="140"><font color="blue">ü�����ڵ�</font></td>
		<td bgcolor="yellow" align="center" width="320"><font color="blue">ü������</font></td>
		<td bgcolor="yellow" align="center" width="140"><font color="blue">�ֹ�����</font></td>
		<td bgcolor="yellow" align="center" width="180"><font color="blue">���</font></td>
	</tr>

<%
do until rs.EOF

	If (IsNull(rs("tcode"))) Then
		tcode = ""
		rs.MoveNext 
	Else
    	tcode = rs("tcode")
	End If

	If (IsNull(rs("comname"))) Then
		comname = ""
		rs.MoveNext 
	Else
		comname = rs("comname")
	End If

	If (IsNull(rs("orderflag"))) Then
		orderflag = ""
	Else
		orderflag = rs("orderflag")
	End If	
	
	If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then 
		'misugum = "�̼���1"
    misugum = "�ֹ�����"
	Else
		misugum = "�̼���"
	End if 

	Select Case orderflag
		Case "y"
			bigo = "�ֹ���"
		Case "1"
			bigo =  misugum & "(����)"
		Case "2"
			bigo = "���(����)"
		Case "3"
			bigo = "�޾�(����)"
		Case "4"
			bigo = "���1(�ֹ�)"
		Case "5"
			bigo = "���2(�ֹ�)"
    	Case "6"
			bigo = "���������(����)"
		Case Else 
			bigo = ""
	End Select 

	If tcode = "" Then
	Else
	
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td class='accountnum'><%=tcode%></td>
		<td class='accountnum' align="left"><%=comname%></td>
		<td class='accountnum'><%=orderflag%></td>
		<td align="left"><%=bigo%></td>
	</tr>

</form>

<%
End If 
rs.MoveNext 
loop 
%>

	<!--tr>
	<td colspan = "4" >�ֹ����� : y -> �ֹ���, 1 -> �̼���(����), 2 -> ���(����), 3 -> �޾�(����), 4 -> ���1(�ֹ�), 5 -> ���2(�ֹ�)</td>
	</tr-->
</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>