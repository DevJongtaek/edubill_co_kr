<html>
<head>
<title>::: ���� :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/jin.css" rel="stylesheet" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="100%" height="100%" border=0 cellpadding="0" cellspacing="0">

<script language="JavaScript">
<!--
function checkValue() {
	if (form.pwd.value=="") {
		alert("��й�ȣ�� �Է��ϼ���.") ;
		form.pwd.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
}
//-->
</script>

<form action="del.asp" method=post name=form>
<input type=hidden name=idx value="<%=request("idx")%>">
<input type=hidden name=pagegubun value="<%=request("pagegubun")%>">

	<tr> 
		<td align="center" height=25>
			��й�ȣ : <input name="pwd" type="text" size="10"> <input type=button value="�� ��" onclick="return checkValue()">
		</td>
	</tr>
</form>
</table>

</body>
</html>
