<html>
<head>
<title>::: 올리기 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/jin.css" rel="stylesheet" type="text/css">

<script language="JavaScript">
<!--
function checkValue() {
	if (form1.bfile1.value=="") {
		alert("올리실 엑셀파일을 선택하여 주시기 바랍니다.") ;
		form1.bfile1.focus() ;
		return false ;
	}
	form1.submit() ;
	return false ;
}
//-->
</script>

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="100%" border=0 cellpadding="0" cellspacing="0" valign=top>
	<tr height="35"> 
		<td bgcolor="#DEDEDE" align="center"> 

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> 
				<td align="center"><font color=red>* 엑셀파일을 올려주시기 바랍니다.</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR>

<table width="100%" border=0 cellpadding="0" cellspacing="0" valign=top>

<form action="excell_up_ok.asp" method=post name=form1 ENCTYPE="MULTIPART/FORM-DATA">

	<tr> 
		<td valign="top" align="center">

		<table width=90% border="0" cellpadding="0" cellspacing="0">
			<tr height="25"> 
				<td>
					<input name="bfile1" type="file" size=32>
					<input type="button" value="올리기" onclick="return checkValue();">
				</td>
			</tr>
		</table>

		</td>
	</tr>

</form>

</table>

<BR>

<table width="100%" border=0 cellpadding="0" cellspacing="0" valign=top>
	<tr height="35"> 
		<td bgcolor="#DEDEDE" align="center"> 

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> 
				<td align="center">
					<a href="javascript:window.close();"><B>닫기</a>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>

