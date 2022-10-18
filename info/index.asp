<!--#include file="top.asp" -->

<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" height=100% border="0" cellspacing="0" cellpadding="0" align="center">

<script Language="JavaScript">
<!-- 
function checkValue() {
	if (form.mid.value=="") {
		alert("아이디를 입력하여 주시기바랍니다.") ;
		form.mid.focus() ;
		return false ;
	} if (form.mpwd.value=="") {
		alert("비밀번호를 입력하여 주십시요.") ;
		form.mpwd.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
}
//-->
</script>
<body  onload="form.mid.focus()">
<form action=loginok.asp name=form method=post onsubmit="return checkValue()">

	<tr>
		<td align=center>

		<table width="400" height=250 border="0" cellspacing="0" cellpadding="0" align="center" bgcolor=#52CAE3>
			<tr bgcolor=white>
				<td colspan=3 height=6></td>
			</tr>
			<tr>
				<td width=3 bgcolor=white>&nbsp;</td>
				<td width=394 align=center>

				<table border="0" cellspacing="0" cellpadding="0" align="center">
					<tr>
						<td align=center colspan=3 height=40><font color=black><B>관리자페이지</b></td>
					</tr>
				</table>

				<table border="0" cellspacing="0" cellpadding="0" align="center">
					<tr>
						<td align=right><font color=black>아 이 디&nbsp;</td>
						<td><input type=text name=mid size=20 tabindex=1 maxlength=10></td>
						<td rowspan=2 width=62 align=center><input type=image src="/adminpage/images/login.gif" border=0 tabindex=3></td>
					</tr>
					<tr>
						<td align=right><font color=black>비 밀 번 호&nbsp;</td>
						<td><input type=password name=mpwd size=21 tabindex=2 maxlength=10></td>
					</tr>
				</table>

				</td>
				<td width=3 bgcolor=white>&nbsp;</td>
			</tr>
			<tr bgcolor=white>
				<td colspan=3 height=6></td>
			</tr>
		</table>

		</td>
	</tr>

</form>

</table>

<!--#include file="bottom.asp" -->