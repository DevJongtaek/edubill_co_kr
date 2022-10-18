<html>
<head>
<title>대출 상담</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../css/dog.css" type="text/css">
<script language="javascript">
<!--
function fun_submit()
{
	if (frm.pp_yy.value == "" || frm.pp_mm.value == "" || frm.pp_dd.value == "")
	{
		alert("생년월일을 정확히 입력해 주세요")
		return;
	}
	else
	{
		document.frm_age.target = "iframe_hidden";
		document.frm_age.action = "age_cal_ok.asp";
		document.frm_age.submit();
	}
}

<!-- 숫자만 입력받기 -->
function onlyNumber()
{
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}

function CheckInfo() {
	if (form.loanName.value=="") {
		alert("성명을 입력하여 주시기바랍니다.") ;
		form.loanName.focus() ;
		return false ;
	} if (form.loanBirthDay1.value=="") {
		alert("년을 입력하여 주시기바랍니다.") ;
		form.loanBirthDay1.focus() ;
		return false ;
	} if (form.loanBirthDay1.value.length < 4) {
		alert("4자리의 년을 입력하여 주시기바랍니다.") ;
		form.loanBirthDay1.focus() ;
		return false ;
	} if (form.loanBirthDay1.value < 1800) {
		alert("정확한 년을 입력하여 주시기바랍니다.") ;
		form.loanBirthDay1.focus() ;
		return false ;
	} if (form.loanBirthDay2.value=="") {
		alert("월을 입력하여 주시기바랍니다.") ;
		form.loanBirthDay2.focus() ;
		return false;
	}  if (form.loanBirthDay2.value < 1) {
		alert("정확한 월을 입력하여 주시기바랍니다.") ;
		form.loanBirthDay2.focus() ;
		return false;
	} if (form.loanBirthDay3.value=="") {
		alert("일을 입력하여 주시기바랍니다.") ;
		form.loanBirthDay3.focus() ;
		return false;
	} if (form.loanBirthDay3.value < 1) {
		alert("정확한 일을 입력하여 주시기바랍니다.") ;
		form.loanBirthDay3.focus() ;
		return false;
	} if (form.loanTel1.value=="") {
		alert("전화번호를 정확히 입력하여 주시기바랍니다.") ;
		form.loanTel1.focus() ;
		return false ;
	} if (form.loanTel2.value=="") {
		alert("전화번호를 정확히 입력하여 주시기바랍니다.") ;
		form.loanTel2.focus() ;
		return false ;
	} if (form.loanTel3.value=="") {
		alert("전화번호를 정확히 입력하여 주시기바랍니다.") ;
		form.loanTel3.focus() ;
		return false ;
	} if (form.loanHP1.value=="") {
		alert("휴대폰번호를 정확히 입력하여 주시기바랍니다.") ;
		form.loanHP1.focus() ;
		return false ;
	} if (form.loanHP2.value=="") {
		alert("휴대폰번호를 정확히 입력하여 주시기바랍니다.") ;
		form.loanHP2.focus() ;
		return false ;
	} if (form.loanHP3.value=="") {
		alert("휴대폰번호를 정확히 입력하여 주시기바랍니다.") ;
		form.loanHP3.focus() ;
		return false ;
	} if (form.WishMoney.value=="") {
		alert("희망금액을 입력하여 주시기바랍니다.") ;
		form.WishMoney.focus() ;
		return false ;
	} if (form.WishMoney.value < 0) {
		alert("정확한 희망금액을 입력하여 주시기바랍니다.") ;
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
			<p><font face="돋움체"><span style="font-size:9pt;">자격기준 : 사업자등록증을 소지하신 개인 또는 법인(3개월 미만은 별도 진행)</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_06.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_07.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">연 &nbsp;&nbsp;&nbsp;령 : 만 25세 ~ 60세</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_09.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_10.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">지 &nbsp;&nbsp;&nbsp;역 : 전국</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_12.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_13.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">대출한도 : 100만 ~ 5,000만원</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_15.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_16.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">구비서류 : 사업자등록증, 신분증 사본, 주민등록등본 등</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_18.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_19.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(※ 소액대출의 경우, 사업자등록증 사본만으로도 가능)</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_21.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_22.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">대출입금 : 서류접수 후, 4시간 이내 해당 계좌로 즉시 입금(은행 업무 시간 기준)</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_24.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_25.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			 <p><font face="돋움체"><span style="font-size:9pt;">대출금리 : 연 7.9 ~ 29.9%(신용등급에 따라 차등적용)</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_27.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_28.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(※ 단순 가조회 시, 신용등급 하락 없음.)</span></font></b></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_30.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_31.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">신용등급 : 9등급까지도 가능(10등급 이상은 별도 진행)</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_33.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_34.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">상환방법 : 원리금 균등 분할 상환</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_36.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_37.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">대출기간 : 12 ~ 60개월까지</span></font></p></td>
	</tr>
		<tr>
		<td colspan="2">
			<img src="images/Loan_36.gif" width="26" height="16" alt=""></td>
		<td colspan="3">
			<img src="images/Loan_37.gif" width="18" height="16" alt=""></td>
		<td colspan="5">
			<p><font face="돋움체"><span style="font-size:9pt;">금융기관 : IBK 기업은행 캐피탈 등</span></font></p></td>
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
			<p><font face="돋움체"><span style="font-size:9pt;">&nbsp;전화 한 통이면, 가 조회로 등급 하락없이 한도와 금리까지 OK</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_46.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_47.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			 <p><font face="돋움체"><span style="font-size:9pt;">&nbsp;복잡한 절차 없이 단순 서류만으로 신청 OK</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_49.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_50.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			<p><font face="돋움체"><span style="font-size:9pt;">&nbsp;다양한 상품중 원하는 상품으로 One Stop Love Loan Propose</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_52.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_53.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			<p><font face="돋움체"><span style="font-size:9pt;">&nbsp;저축은행, 소비자 사금융의 대출을 쓰시는 분은 통합 가능</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_55.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_56.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			<p><font face="돋움체"><span style="font-size:9pt;">&nbsp;전국 지점에서 당일 대출 가능</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_58.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_59.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			 <p><font face="돋움체"><span style="font-size:9pt;">&nbsp;인터넷 상에서 One Click으로 대출신청 가능</span></font></p></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/Loan_61.gif" width="26" height="16" alt=""></td>
		<td colspan="2">
			<img src="images/Loan_62.gif" width="15" height="16" alt=""></td>
		<td colspan="6">
			<p><font face="돋움체"><span style="font-size:9pt;">&nbsp;고객의 조건에 최적화된 대출로 최고의 만족으로 느끼실 겁니다. &nbsp;</span></font></p></td>
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
			<font color=blue><p style="line-height:120%; margin-top:1; margin-bottom:1;"><font face="돋움체"><span style="font-size:9pt;">① 아래 내용을 기재하여 대출상담을 신청하시면, 에듀빌과 제휴한 금융기관의 대출 담당<br>&nbsp;&nbsp;&nbsp;자가 당일 전화로 친절한 상담을 해 드립니다.</span></font></p>
            <p style="line-height:120%; margin-top:0; margin-bottom:1;"><font face="돋움체"><span style="font-size:9pt;">② 여기 기재된 정보는 대출상담 목적 외에 다른 용도로 절대 사용되지 않습니다. </span></font></p>
            <p style="line-height:120%; margin-top:0; margin-bottom:1;"><font face="돋움체"><span style="font-size:9pt;">③ '남기고 싶은 말' 입력란에 상담 희망시간 등 기타 사항을 자유롭게 작성바랍니다.</span></font></p></font></td>
		<td rowspan="10">
			<img src="images/Loan_71.gif" width="27" height="349" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<font face="돋움체"><span style="font-size:9pt;color:black;">성명</span></font></td>
		<td colspan="3">
			<font face="돋움체"><span style="font-size:9pt;">: <input type="text" name="loanName" maxlength="20" style="width:100;" size="12"></span></font></td>
	</tr>
	<tr>
		<td colspan="2">
			<font face="돋움체"><span style="font-size:9pt;color:black;">생년월일</span></font></td>
		<td colspan="3">
			<font face="돋움체"><span style="font-size:9pt;color:black;">: <input type="text" name="loanBirthDay1" maxlength="4" style="width:40;" size="18" OnKeypress="onlyNumber();">년<input type="text" name="loanBirthDay2" maxlength="2" style="width:30;" size="18" OnKeypress="onlyNumber();">월<input type="text" name="loanBirthDay3" maxlength="2" style="width:30;" size="18" OnKeypress="onlyNumber();">일 </span></font></td>
	</tr>
	<tr>
		<td colspan="2">
			<p><font face="돋움체"><span style="font-size:9pt;color:black;">전화번호</span></font></td>
		<td colspan="3">
			<font face="돋움체"><span style="font-size:9pt;color:black;">: <input type="text" name="loanTel1" maxlength="3" style="width:40;" size="15" OnKeypress="onlyNumber();">-<input type="text" name="loanTel2" maxlength="4" style="width:40;" size="15" OnKeypress="onlyNumber();">-<input type="text" name="loanTel3" maxlength="4" style="width:40;" size="15" OnKeypress="onlyNumber();"></span></font></td>
	</tr>
	<tr>
		<td colspan="2">
			<font face="돋움체"><span style="font-size:9pt;color:black;">핸드폰번호</span></font></td>
		<td colspan="3">
			<font face="돋움체"><span style="font-size:9pt;color:black;">: <input type="text" name="loanHP1" maxlength="3" style="width:40;" size="15" OnKeypress="onlyNumber();">-<input type="text" name="loanHP2" maxlength="4" style="width:40;" size="15" OnKeypress="onlyNumber();">-<input type="text" name="loanHP3" maxlength="4" style="width:40;" size="15" OnKeypress="onlyNumber();"></span></font></td>
	</tr>
	<tr>
		<td colspan="2">
			<p><font face="돋움체"><span style="font-size:9pt;color:black;">희망금액</span></font></p></td>
		<td colspan="3">
			<font face="돋움체"><span style="font-size:9pt;color:black;">: <input type="text" name="WishMoney" maxlength="4" style="width:40;" size="11" OnKeypress="onlyNumber();">만원</span></font></td>
	</tr>
	<tr>
		<td colspan="2">
			<font face="돋움체"><span style="font-size:9pt;color:black;">남기고 싶은말</span></font></td>
		<td colspan="3" valign="top">
			<font face="돋움체"><span style="font-size:9pt;color:black;">&nbsp;&nbsp;<textarea name="contents" cols="55" rows="5" style="border:1 solid #C7C7C7;back-color :black;"></textarea></span></font></td>
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