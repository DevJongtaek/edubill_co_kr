<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	seq = request("seq")

set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,accountflag,homepage,comname from tb_company where flag='1' "
	SQL = sql & " and idx="&seq
	rs.Open sql, db, 1
	idx   = rs(0)
	wdate = rs(1)
	homepage = rs(2)
	c_comname    = rs(3)
	rs.close
	

%>

<html>
<head>
<title>세금계산서</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/adminpage/tax/stylefont_document.css" type="text/css">

<script language="javascript" src="/adminpage/incfile/javascript_data.js"></script>
<object id="factory" style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" 
codebase="/adminpage/account/smsx.cab#Version=6,2,433,70">
</object>
<script>
function printWindow() {
factory.printing.header        = "";   // Header에 들어갈 문장
factory.printing.footer        = "";   // Footer에 들어갈 문장
factory.printing.portrait      = true	// true 세로출력 , false 가로출력
factory.printing.leftMargin    = 10   // 왼쪽 여백 사이즈
factory.printing.topMargin     = 10   // 위 여백 사이즈
factory.printing.rightMargin   = 10   // 오른쪽 여백 사이즈
factory.printing.bottomMargin  = 10   // 아래 여백 사이즈

//factory.printing.SetMarginMeasure(2); // 테두리 여백 사이즈 단위를 인치로 설정합니다.
//factory.printing.printer = "HP DeskJet 870C";  // 프린트 할 프린터 이름
//factory.printing.paperSource = "Manual feed";   // 종이 Feed 방식
//factory.printing.collate = true;   //  순서대로 출력하기
//factory.printing.copies = 2;   // 인쇄할 매수
//factory.printing.SetPageRange(false, 1, 3); // True로 설정하고 1, 3이면 1페이지에서 3페이지까지 출력
//factory.printing.paperSize = "A4";   // 용지 사이즈
factory.printing.Print(false, window)	 // 대화상자 표시여부 / 출력될 프레임명
}

 function click() {
      if ((event.button==2) || (event.button==3)) {
         alert('출력하시려면 F5(새로고침)을 하여 인쇄하시기 바랍니다!');
      }
   }
   document.onmousedown=click;

</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<table width="650" border="0" cellspacing="0" cellpadding="0">
  <tr height=5>
	<td>&nbsp;</td>
	</tr>
	<tr>
	 <td width="20px"></td><td>정부에서 2014년 7월 1일부터 전자세금계산서 의무 발행을 확대 시행함에 따라<td>
	</tr>
	<tr height=5>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>당 사에서도 이베 발맞춰 2014년 7월분 부터 아래와 같이 전자세금계산서를<td>
	</tr>
	<tr height=5>
	<td>&nbsp;</td>
	</tr>
	<tr>
	 <td width="20px"></td><td>발행하고 있습니다. 업무에 차질 없도록 협조 바랍니다.<td>
	</tr>
	<tr height=10>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>▶ 거래명세서 발행 : 매 월 20일 (당 사 홈페이지에서 확인 가능 )</td>
	</tr>
	<tr height=10>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>▶ 전자세금계산서 발행 : 매 월 25일</td>
	</tr>
	<tr height=10>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>▶ 전자세금계산서 전송 : 매 월 26일 (회원사가 지정한 e-메일로 확인 가능 )</td>
	</tr>
	<tr height=10>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>▶ e-메일 : <font color="#0100FF"><%=homepage%> ( <%=c_comname%> )</font></td>
	</tr>
	<tr height=10>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>▶ 문 의 : 02-853-5111</td>
	</tr>
</table>


<br>
<br>




</body>
</html>

