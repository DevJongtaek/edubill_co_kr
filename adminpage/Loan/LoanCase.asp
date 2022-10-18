<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>상담 신청 내역</title>
<%
	seq = request("seq")

	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select convert(varchar(10), RequestDay, 111) RequestDay ,RequestName  ,substring(RequestAge,1,4) + '/' + substring(RequestAge,5,2) + '/' + substring(RequestAge,7,2) RequestAge,RequestTel  ,RequestHP  ,WishMoney, contents, LoanOrg  ,LoanProduct  ,LoanMoney  ,[InterestRate ]  ,convert(varchar(10), LoanDay, 111) LoanDay, StatusMemo from tb_loan  where seq = " & seq
	rs.Open sql, db, 1

	RequestDay = rs(0)
	RequestName = rs(1)
	RequestAge = rs(2)
	RequestTel = rs(3)
	RequestHP = rs(4)
	WishMoney = rs(5)
	contents = rs(6)
	LoanOrg = rs(7)
	LoanProduct = rs(8)
	LoanMoney = rs(9)
	InterestRate = rs(10)
	LoanDay = rs(11)
	StatusMemo = rs(12)
%>
<script language="JavaScript">

function onlyNumber()
{
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}

function FloatNumber()
{
   if((event.keyCode<46)||(event.keyCode>57)&&(event.keyCode=47))
      event.returnValue=false;
}

function DateNumber()
{
   if((event.keyCode<47)||(event.keyCode>57))
      event.returnValue=false;
}

</script>
</head>
<body onload="winResize()">
<table width="360" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>
		<table border="0" cellspacing="1" cellpadding="1" width=360 bgcolor=#BDCBE7 id="searchlist">
			<tr height=28 bgcolor=#F7F7FF>
				<td width="110" align=left colspan=2>&nbsp;* 상담 신청 내역</td>
			</tr>
			<tr height=28 >
				<td width="110" align=right bgcolor=#F7F7FF>성명&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestName%></td>
			</tr>
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>생년월일&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestAge%></td>
			</tr>
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>전화번호&nbsp;</td>
				<td  bgcolor=#FFFFFF>&nbsp;<%=RequestTel%></td>
			</tr>
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>핸드폰번호&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestHP%></td>
			</tr>
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>희망금액(만원)&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=WishMoney%></td>
			</tr>
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>남기고 싶은 말&nbsp;</td>
				<td bgcolor=#FFFFFF><textarea name="contents" cols="30" rows="3" style="border:1 solid #C7C7C7;back-color :black;" readonly><%=contents%></textarea></td>
			</tr>
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>상담신청일&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestDay%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="5">
		</td>
	</tr>
	<tr>
		<td>
		<form name = "form" action="loancaseok.asp">
			<table border="0" cellspacing="1" cellpadding="1" width=360 bgcolor=#BDCBE7 id="searchlist">
					<tr height=28 bgcolor=#F7F7FF>
						<td width="110" align=left colspan=2>&nbsp;* 대출내역</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>금융기관&nbsp;</td>
						<td bgcolor=#FFFFFF><input type="text" name="LoanOrg" maxlength="10" style="width:100;" size="11" value="<%=LoanOrg%>"></td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>대출상품&nbsp;</td>
						<td bgcolor=#FFFFFF><input type="text" name="LoanProduct" maxlength="20" style="width:100;" size="11" value="<%=LoanProduct%>"></td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>대출금액&nbsp;</td>
						<td bgcolor=#FFFFFF><input type="text" name="LoanMoney" maxlength="4" style="width:40;" size="11" value="<%=LoanMoney%>" OnKeypress="onlyNumber();">만원</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>금리&nbsp;</td>
						<td bgcolor=#FFFFFF><input type="text" name="InterestRate" maxlength="4" style="width:40;" size="11" value="<%=InterestRate%>"  OnKeypress="FloatNumber();">(%)</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>대출완료일&nbsp;</td>
						<td bgcolor=#FFFFFF><input type="text" name="LoanDay" maxlength="10" style="width:100;" size="11" value="<%=LoanDay%>" OnKeypress="DateNumber();"> (예:2011/03/15)</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>진행상황&nbsp;</td>
						<td bgcolor=#FFFFFF><textarea name="StatusMemo" cols="30" rows="3" style="border:1 solid #C7C7C7;back-color :black;" ><%=StatusMemo%></textarea></td>
					</tr>
					<tr  bgcolor=#FFFFFF>
						<td align="center" colspan=2><input type="image" src="/images/admin/l_bu03.gif" border=0>&nbsp;
						<!--<input type="button" name="del" value="닫기"  class="box_work" onclick="javascript:window.close();">--></td>
					</tr>
					<input name="Seq" type=hidden value="<%=seq%>">
					</form>
				</table>
		</td>
	</tr>
</table>
</body>
</html>
