<!--#include virtual="/db/db.asp" -->

<%
	imsi_userid = trim(request("userid"))
	flag = request("flag")

	set Rs = server.CreateObject("ADODB.Recordset")
	sql = "SELECT count(idx) FROM tb_adminuser WHERE userid = '"& imsi_userid &"' "
	Set Rs = Db.Execute(sql)
	imsiidcount = rs(0)
	rs.close
	db.close

	select case imsiidcount
		case "0"
			imsiidcountmsg = "<font color=#990033><B>"&imsi_userid&"</b></font> �� ��� <font color=red>������</font> ���̵��Դϴ�."
		case else
			imsiidcountmsg = "<font color=#990033><B>"&imsi_userid&"</b></font> �� ��� <font color=red>�Ұ�����</font> ���̵��Դϴ�."
	end select
%>

<html>
<head>
<title>::: ȸ�����̵� Ȯ�� :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/dog.css" rel="stylesheet" type="text/css">

<script language="JavaScript">
<!--

<%if flag = "1" then%>
	var imsi_userid = "<%=imsi_userid%>";
	opener.form.userid.value=imsi_userid;
	parent.window.close();
<%end if%>

function checkValue() {
	if (form.userid.value=="") {
		alert("���̵� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.userid.focus() ;
		return false ;
	} if ((form.userid.value.length<4)||(form.userid.value.length>=11)){
		alert("ID�� 4�ڸ� �̻� 10�ڸ� �̸����� �����ϼž� �մϴ�.");
		form.userid.focus();
		return false;
	}
	form.submit() ;
	return false ;
}

//-->
</script>

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="300" height="200" border="0" cellpadding="0" cellspacing="0">
	<tr> 
    		<td height="50"><img src="../images/member_08.gif" width="300" height="50"></td>
  	</tr>
  	<tr>
    		<td height="126">

		<table width="270" height="96" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#DEDEDE">
        		<tr> 
          			<td bgcolor="#FFFFFF">

				<table width="270" height="84" border="0" cellpadding="0" cellspacing="0">
		              		<tr height=25> 
		                		<td colspan=2 align="center"><%=imsiidcountmsg%></td>
              				</tr>

<form action="UserIdCheck.asp" method=post name=form onsubmit="return checkValue();">

              				<tr>
						<td width="199" align="center">���̵� : <input name="userid" type="text" size="16" maxlength="10" style="background-color:#ffffff;border:1 solid #999999; width:130px" value="<%=imsi_userid%>"></td>
 		      				<td width="71"><input type=image src="../images/member_07.gif" width="71" height="21"></td>
					</tr>

</form>

		            	</table>

				</td>
        		</tr>
		</table>

		</td>
	</tr>
  	<tr>
    		<td height="24" bgcolor="#DEDEDE" align="center">
			<a href="UserIdCheck.asp?userid=<%=imsi_userid%>&flag=1"><img src="../images/member_06.gif" width="57" height="24" border="0"></a>
		</td>
	</tr>
</table>

</body>
</html>
