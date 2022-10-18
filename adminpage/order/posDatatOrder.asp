<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>POS 주문</title>
<link href="/css/jin.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">
<!--
function onlyNumber(){
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}

function infosend(form) {
	if (form.ymd1.value=="") {
		alert("날짜를 입력하여 주시기바랍니다.") ;
		form.ymd1.focus() ;
		return false ;
	}
	if (form.ymd2.value=="") {
		alert("날짜를 입력하여 주시기바랍니다.") ;
		form.ymd2.focus() ;
		return false ;
	}
	document.all("btn1").disabled = true;
	document.all("btn2").disabled = true;
	document.all("btn3").disabled = true;
	form.submit() ;
	return false ;
}

function infosend2(form) {
	if (form.ymd1.value=="") {
		alert("날짜를 입력하여 주시기바랍니다.") ;
		form.ymd1.focus() ;
		return false ;
	}
	if (form.ymd2.value=="") {
		alert("날짜를 입력하여 주시기바랍니다.") ;
		form.ymd2.focus() ;
		return false ;
	}
	document.all("btn1").disabled = true;
	document.all("btn2").disabled = true;
	document.all("btn3").disabled = true;
	form.action = "posDatatOrderDel.asp";
	form.submit() ;
	return false ;
}
//-->
</script>
</head>
<body topmargin="0" leftmargin="10">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height=45><font color=blue size=3><B>[POS 주문]</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor=#D7D7D7>

<form action="posDataOderok.asp" method="POST" name=form>

	<tr bgcolor=#EDF7FA height=25>
		<td align=center><B>POS 주문 데이터 끌어오기 기간설정</td>
	</tr>
	<tr bgcolor=#EDF7FA height=25>
		<td bgcolor=white align=center>
			<input type=text name=ymd1 size=8 maxlength=8 onkeypress="onlyNumber()" value="<%=replace(left(now(),10),"-","")%>">
			~
			<input type=text name=ymd2 size=8 maxlength=8 onkeypress="onlyNumber()" value="<%=replace(left(now(),10),"-","")%>">
			<br>
			<input type=button value="확 인" name="btn1" onclick="return infosend(this.form);">
			<input type=button value="창닫기" name="btn2" onclick="window.close()">
			<input type=button value="임시테이블삭제" name="btn3" onclick="return infosend2(this.form);">
		</td>
	</tr>

</form>

</table>

</body>
</html>