<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>로그인 화면</title>
</head>

<body>
<center>
<form  method="post" name="form" action="check_exe.asp">
<table><br><br><br><br>
<tr>
<td><font face="굴림" size=2>사번입력</font></td>
<td><input type="password" name="passwd" size="10" maxlength="4">&nbsp;<input type="submit" value="확인"></td>
</tr>
</table>
<input type="hidden" name="passwd" value="<%"passwd"%>">
</form>
</center>
</body>
</html>
