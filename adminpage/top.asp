<!--#include virtual="/adminpage/incfile/sessionend.asp"-->

<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=euc-kr">
<link rel="stylesheet" href="/css/jin.css">

<script language="javascript">
function levelno() {
	alert("�������� �����ϴ�.\n\n�����ڿ� �����ϼ���!");
}

</script>
</head>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0">

<table width="100%" height=100% border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td height="28" colspan=2 valign=top>

		<table border="0" cellspacing="0" cellpadding="0" width=100% bgcolor=#CCCCCC height="28">
        		<tr> 
          			<td>&nbsp;<font size="3" color="#FFFFFF" face="��������ü"><B>EDUBILL INTRANET PAGE</font></td>
		        </tr>
      		</table>

		</td>
	</tr>
	<tr bgcolor=white>
		<td width=160 align=center>[ID : <font color=#804E17><%=session("Auserid")%></font>] &nbsp; <a href="logout.asp" target="_top">[Logout]</a></td>
		<td valign=top>

		<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor=#CCCCCC height=30 valign=top>
			<tr bgcolor="#FFFFFF" align=center> 

<%if session("Ausergubun")="1" then%>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="code/" target="main">�ڵ����</a></td>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="#" onclick="javascript:levelno();">�ֹ�����</a></td>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="#" onclick="javascript:levelno();">��ް���</a></td>
	<td width="31%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="#" onclick="javascript:levelno();">���ݰ�꼭/�ŷ����� ����</a></td>
<%else%>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="code/" target="main">�ڵ����</a></td>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="order/" target="main">�ֹ�����</a></td>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="delivery/" target="main">��ް���</a></td>
	<td width="31%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="tax/" target="main">���ݰ�꼭/�ŷ����� ����</a></td>
<%end if%>

                    </tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>
