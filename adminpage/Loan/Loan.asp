<html>
<head>
<title>���� ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../css/dog.css" type="text/css">
<script language="javascript">
<!--
function fun_submit()
{
	if (frm.pp_yy.value == "" || frm.pp_mm.value == "" || frm.pp_dd.value == "")
	{
		alert("��������� ��Ȯ�� �Է��� �ּ���")
		return;
	}
	else
	{
		document.frm_age.target = "iframe_hidden";
		document.frm_age.action = "age_cal_ok.asp";
		document.frm_age.submit();
	}
}

<!-- ���ڸ� �Է¹ޱ� -->
function onlyNumber()
{
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}

function CheckInfo() {
	if (form.loanName.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanName.focus() ;
		return false ;
	} if (form.loanBirthDay1.value=="") {
		alert("���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanBirthDay1.focus() ;
		return false ;
	} if (form.loanBirthDay1.value.length < 4) {
		alert("4�ڸ��� ���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanBirthDay1.focus() ;
		return false ;
	} if (form.loanBirthDay1.value < 1800) {
		alert("��Ȯ�� ���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanBirthDay1.focus() ;
		return false ;
	} if (form.loanBirthDay2.value=="") {
		alert("���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanBirthDay2.focus() ;
		return false;
	}  if (form.loanBirthDay2.value < 1) {
		alert("��Ȯ�� ���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanBirthDay2.focus() ;
		return false;
	} if (form.loanBirthDay3.value=="") {
		alert("���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanBirthDay3.focus() ;
		return false;
	} if (form.loanBirthDay3.value < 1) {
		alert("��Ȯ�� ���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanBirthDay3.focus() ;
		return false;
	} if (form.loanTel1.value=="") {
		alert("��ȭ��ȣ�� ��Ȯ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanTel1.focus() ;
		return false ;
	} if (form.loanTel2.value=="") {
		alert("��ȭ��ȣ�� ��Ȯ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanTel2.focus() ;
		return false ;
	} if (form.loanTel3.value=="") {
		alert("��ȭ��ȣ�� ��Ȯ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanTel3.focus() ;
		return false ;
	} if (form.loanHP1.value=="") {
		alert("�޴�����ȣ�� ��Ȯ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanHP1.focus() ;
		return false ;
	} if (form.loanHP2.value=="") {
		alert("�޴�����ȣ�� ��Ȯ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanHP2.focus() ;
		return false ;
	} if (form.loanHP3.value=="") {
		alert("�޴�����ȣ�� ��Ȯ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.loanHP3.focus() ;
		return false ;
	} if (form.WishMoney.value=="") {
		alert("����ݾ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.WishMoney.focus() ;
		return false ;
	} if (form.WishMoney.value < 0) {
		alert("��Ȯ�� ����ݾ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.WishMoney.focus() ;
		return false ;
	}
//	form.submit() ;
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form action="loanok.asp" name=form method=post onsubmit="return CheckInfo();">
<table width ="100%" height="100%">
<tr>
	<td align=center>
<table id="Table_01" width="573" height="915" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="10">
			<img src="images/Loan_01.gif" width="573" height="47" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="images/Loan_02.gif" width="573" height="117" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_03.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_04.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">�ڰݱ��� : ����ڵ������ �����Ͻ� ���� �Ǵ� ����(3���� �̸��� ���� ����)</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_06.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_07.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">�� &nbsp;&nbsp;&nbsp;�� : �� 25�� ~ 60��</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_09.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_10.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">�� &nbsp;&nbsp;&nbsp;�� : ����</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_12.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_13.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">�����ѵ� : 100�� ~ 5,000����</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_15.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_16.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">���񼭷� : ����ڵ����, �ź��� �纻, �ֹε�ϵ ��</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_18.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_19.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(�� �Ҿ״����� ���, ����ڵ���� �纻�����ε� ����)</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_21.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_22.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">�����Ա� : �������� ��, 4�ð� �̳� �ش� ���·� ��� �Ա�(���� ���� �ð� ����)</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_24.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_25.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			 <p><font face="����ü"><span style="font-size:9pt;">����ݸ� : �� 7.9 ~ 29.9%(�ſ��޿� ���� ��������)</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_27.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_28.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(�� �ܼ� ����ȸ ��, �ſ��� �϶� ����.)</span></font></b></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_30.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_31.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">�ſ��� : 9��ޱ����� ����(10��� �̻��� ���� ����)</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_33.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_34.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">��ȯ��� : ������ �յ� ���� ��ȯ</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_36.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_37.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">����Ⱓ : 12 ~ 60��������</span></font></p></td>
	</tr>
		<tr>
		<td colspan="2">
			<img src="images/Loan_36.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_37.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="����ü"><span style="font-size:9pt;">������� : IBK ������� ĳ��Ż ��</span></font></p></td>
	</tr>
	<tr>
		<td colspan="10"  height="19">
			</td>
	</tr>
	<tr>
		<td>
			<img src="images/Loan_40.gif" width="12" height="20" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_41.gif" width="18" height="20" alt=""></td>
		<td colspan="7" height="27" valign="top">
			<img src="images/Loan_42.gif" width="543" height="20" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_43.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_44.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			<p><font face="����ü"><span style="font-size:9pt;">&nbsp;��ȭ �� ���̸�, �� ��ȸ�� ��� �϶����� �ѵ��� �ݸ����� OK</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_46.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_47.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			 <p><font face="����ü"><span style="font-size:9pt;">&nbsp;������ ���� ���� �ܼ� ���������� ��û OK</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_49.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_50.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			<p><font face="����ü"><span style="font-size:9pt;">&nbsp;�پ��� ��ǰ�� ���ϴ� ��ǰ���� One Stop Love Loan Propose</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_52.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_53.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			<p><font face="����ü"><span style="font-size:9pt;">&nbsp;��������, �Һ��� ������� ������ ���ô� ���� ���� ����</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_55.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_56.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			<p><font face="����ü"><span style="font-size:9pt;">&nbsp;���� �������� ���� ���� ����</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_58.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_59.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			 <p><font face="����ü"><span style="font-size:9pt;">&nbsp;���ͳ� �󿡼� One Click���� �����û ����</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_61.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_62.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			<p><font face="����ü"><span style="font-size:9pt;">&nbsp;���� ���ǿ� ����ȭ�� ����� �ְ��� �������� ������ �̴ϴ�. &nbsp;</span></font></p></td>
	</tr>
	<tr>
		<td colspan="10"  height="23">
			</td>
	</tr>
	<tr>
		<td>
			<img src="images/Loan_65.gif" width="12" height="20" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_66.gif" width="18" height="20" alt=""></td>
		<td colspan="7">
			<img src="images/Loan_67.gif" width="543" height="20" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="images/Loan_68.gif" width="573" height="15" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="10">
			<img src="images/Loan_69.gif" width="41" height="349" alt=""></td>
		<td colspan="5"  width="505">
			<font color=blue><p style="line-height:120%; margin-top:1; margin-bottom:1;"><font face="����ü"><span style="font-size:9pt;">�� �Ʒ� ������ �����Ͽ� �������� ��û�Ͻø�, ������� ������ ��������� ���� ���<br>&nbsp;&nbsp;&nbsp;�ڰ� ���� ��ȭ�� ģ���� ����� �� �帳�ϴ�.</span></font></p>
            <p style="line-height:120%; margin-top:0; margin-bottom:1;"><font face="����ü"><span style="font-size:9pt;">�� ���� ����� ������ ������ ���� �ܿ� �ٸ� �뵵�� ���� ������ �ʽ��ϴ�. </span></font></p>
            <p style="line-height:120%; margin-top:0; margin-bottom:1;"><font face="����ü"><span style="font-size:9pt;">�� '����� ���� ��' �Է¶��� ��� ����ð� �� ��Ÿ ������ �����Ӱ� �ۼ��ٶ��ϴ�.</span></font></p></font></td>
		<td rowspan="10">
			<img src="images/Loan_71.gif" width="27" height="349" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<font face="����ü"><span style="font-size:9pt;color:black;">����</span></font></td>
		<td colspan="3">
			<font face="����ü"><span style="font-size:9pt;">: <input type="text" name="loanName" maxlength="20" style="width:100;" size="12"></span></font></td>
	</tr>
	<tr>
		<td colspan="2">
			<font face="����ü"><span style="font-size:9pt;color:black;">�������</span></font></td>
		<td colspan="3">
			<font face="����ü"><span style="font-size:9pt;color:black;">: <input type="text" name="loanBirthDay1" maxlength="4" style="width:40;" size="18" OnKeypress="onlyNumber();">��<input type="text" name="loanBirthDay2" maxlength="2" style="width:30;" size="18" OnKeypress="onlyNumber();">��<input type="text" name="loanBirthDay3" maxlength="2" style="width:30;" size="18" OnKeypress="onlyNumber();">�� </span></font></td>
	</tr>
	<tr>
		<td colspan="2">
			<p><font face="����ü"><span style="font-size:9pt;color:black;">��ȭ��ȣ</span></font></td>
		<td colspan="3">
			<font face="����ü"><span style="font-size:9pt;color:black;">: <input type="text" name="loanTel1" maxlength="3" style="width:40;" size="15" OnKeypress="onlyNumber();">-<input type="text" name="loanTel2" maxlength="4" style="width:40;" size="15" OnKeypress="onlyNumber();">-<input type="text" name="loanTel3" maxlength="4" style="width:40;" size="15" OnKeypress="onlyNumber();"></span></font></td>
	</tr>
	<tr>
		<td colspan="2">
			<font face="����ü"><span style="font-size:9pt;color:black;">�ڵ�����ȣ</span></font></td>
		<td colspan="3">
			<font face="����ü"><span style="font-size:9pt;color:black;">: <input type="text" name="loanHP1" maxlength="3" style="width:40;" size="15" OnKeypress="onlyNumber();">-<input type="text" name="loanHP2" maxlength="4" style="width:40;" size="15" OnKeypress="onlyNumber();">-<input type="text" name="loanHP3" maxlength="4" style="width:40;" size="15" OnKeypress="onlyNumber();"></span></font></td>
	</tr>
	<tr>
		<td colspan="2">
			<p><font face="����ü"><span style="font-size:9pt;color:black;">����ݾ�</span></font></p></td>
		<td colspan="3">
			<font face="����ü"><span style="font-size:9pt;color:black;">: <input type="text" name="WishMoney" maxlength="4" style="width:40;" size="11" OnKeypress="onlyNumber();">����</span></font></td>
	</tr>
	<tr>
		<td colspan="2">
			<font face="����ü"><span style="font-size:9pt;color:black;">����� ������</span></font></td>
		<td colspan="3" valign="top">
			<font face="����ü"><span style="font-size:9pt;color:black;">&nbsp;&nbsp;<textarea name="contents" cols="55" rows="5" style="border:1 solid #C7C7C7;back-color :black;"></textarea></span></font></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="2">
			<img src="images/Loan_84.gif" width="168" height="41" alt=""></td>
		<td align=right >
			<input type="image" src="images/Loan_85.gif" width="120" height="26" alt=""></td>
		<td rowspan="2">
			<img src="images/Loan_86.gif" width="182" height="41" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/Loan_87.gif" width="155" height="8" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="images/Loan_88.gif" width="505" height="22" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/spacer.gif" width="12" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="14" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="4" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="11" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="3" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="75" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="90" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="155" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="182" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="27" height="60" alt=""></td>
	</tr>
</table>
</td>
</tr>
</table>
</form>
</body>
</html>