<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=3.0, minimum-scale=1.0, user-scalable=1, target-densitydpi=medium-dpi" />
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<script language="JavaScript">
<!--
function characterCheck() {
	var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\+┼<>@\#$%&\'\"\\\(\=]/gi;//정규식 구문
	var obj = document.getElementsByName("uid")[0]
	if (RegExp.test(obj.value)) {
		alert("특수문자는 입력하실 수 없습니다.");
		obj.value = obj.value.substring(0, obj.value.length - 1);//특수문자를 지우는 구문
		}
}
//-->
</script>
</head>
<body>
<table border=0 width="100%">
<tr>
	<td><img src="../fileupdown/에듀빌.bmp"></td>
</tr>
<tr>
	<td>
		<table id="Table_01" width="300" height="155" border="0" cellpadding="0" cellspacing="0" style="background-color:fffbff;">
		<form name="form" action="loginok2.asp">
			<tr>
				<td colspan="5">
					<img src="images/Mobile/Mobile_01.gif" width="300" height="54" alt=""></td>
			</tr>
			<tr>
				<td rowspan="2">
					<img src="images/Mobile/Mobile_02.gif" width="20" height="60" alt=""></td>
				<td rowspan="2">
					<img src="images/Mobile/Mobile_03.gif" width="120" height="60" alt=""></td>
				<td width="88" height="30" align="center">
					<input type="text" name="bccode" size="8" maxlength="8" onkeyup="characterCheck()" onkeydown="characterCheck()"></td>
				<td rowspan="2">
					<input type=image src="images/Mobile/Mobile_05.gif" width="51" height="60" alt=""></td>
				<td rowspan="2">
					<img src="images/Mobile/Mobile_06.gif" width="21" height="60" alt=""></td>
			</tr>
			<tr>
				<td width="88" height="30" align="center">
					<input type="text" name="pwd" size="8" maxlength="8"></td>
			</tr>
			<tr>
				<td rowspan="2">
					<img src="images/Mobile/Mobile_08.gif" width="20" height="41" alt=""></td>
				<td colspan="3" align="center"  height="29">
					<INPUT type="checkbox" name="cbksave"><font style="font-size:11px;">가맹점코드 저장</font></input></td>
				<td rowspan="2">
					<img src="images/Mobile/Mobile_10.gif" width="21" height="41" alt=""></td>
			</tr>
			<tr>
				<td colspan="3">
					<img src="images/Mobile/Mobile_11.gif" width="259" height="12" alt=""></td>
			</tr>
		</form>
		</table>
	</td>
</tr>
<tr>
	<td><img src="images/Mobile/bottom.gif" alt=""></td>
</tr>
</table>
</body>
</html>