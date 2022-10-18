<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	seq=request("seq")

	'공급자-에듀빌
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select companynum1,companynum2,companynum3,comname,name,addr,addr2,uptae,upjong,vatflag,taxtitle,tel1,tel2,tel3,fax1,fax2,fax3 "
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = 10339 "

    'response.Write sql
	rs.Open sql, db, 1
	b_companynum1 = rs(0)
	b_companynum2 = rs(1)
	b_companynum3 = rs(2)
	b_companynum = b_companynum1&"-"&b_companynum2&"-"&b_companynum3
	b_comname = rs(3)
	b_name = rs(4)
	b_addr = rs(5)
	b_addr2 = rs(6)
	b_addr = b_addr&" "&b_addr2
	b_uptae = rs(7)
	b_upjong = rs(8)
	vatflag = rs(9)
	taxtitle = rs(10)
	b_tel1 = rs(11)
	b_tel2 = rs(12)
	b_tel3 = rs(13)
	b_tel = b_tel1&"-"&b_tel2&"-"&b_tel3
	b_fax1 = rs(14)
	b_fax2 = rs(15)
	b_fax3 = rs(16)
	b_fax = b_fax1&"-"&b_fax2&"-"&b_fax3
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select virtual_acnt2,virtual_acnt2_bank from tb_company "

	if len(session("Ausercode"))=5 then
		SQL = sql & " where idx = "& left(session("Ausercode"),5) &" "
	else
		SQL = sql & " where idx = "& mid(session("Ausercode"),6,5) &" "
	end if

	rs.Open sql, db, 1
	virtual_acnt = rs(0)
	virtual_acnt_bank = rs(1)
	rs.close

	'공급받는자-회원사
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,wdate,tcode,hname,companynum,companyName,companyAddr,companyUptae,companyUpjong,Aym,Aymd,textPname,umoney,textPname2,kmoney,smoney,Anum,hmoney,jtcode "
	SQL = sql & " from tAccountM "
	SQL = sql & " where seq="&seq
	rs.Open sql, db, 1
	idx   = rs(0)
	wdate = rs(1)
	tcode = rs(2)
	c_comname    = rs(3)
	c_companynum = rs(4)
	c_name   = rs(5)
	c_addr   = rs(6)
	c_uptae  = rs(7)
	c_upjong = rs(8)

	Aym  = rs(9)
	Aymd = rs(10)
	imsiokday_y = left(Aymd,4)
	imsiokday_m = mid(Aymd,5,2)
	imsiokday_d = right(Aymd,2)

	taxtitle = rs(11)
	c_umoney = rs(12)
	textPname2 = rs(13)
	c_kmoney = rs(14)
	c_smoney = rs(15)
	c_Anum = rs(16)
	c_hmoney = rs(17)
	jtcode   = rs(18)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select accountflag "
	SQL = sql & " from tb_company"
	SQL = sql & " where flag='1' and idx = "& idx
	rs.Open sql, db, 1
	accountflag = rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sum(Anum) as Anum,sum(kmoney) as kmoney,sum(smoney) as smoney,sum(hmoney) as hmoney from tAccountM where idx = "& idx &" and wdate = '"& wdate &"' "
	if jtcode<>"" then
		SQL = SQL & " and jtcode = '"& jtcode &"' "
	else
		SQL = SQL & " and jtcode = '' "
	end if

	rs.Open sql, db, 1
	Anum   = rs(0)
	kmoney = rs(1)
	smoney = rs(2)
	hmoney = rs(3)
	rs.close

	if accountflag="n" then
		c_smoney = 0
		c_hmoney = c_kmoney
	end if

	ordermoney     = kmoney		'공급가액
	ordermoney_vat = smoney		'부가세
	ordermoney_hap = hmoney		'부가세포함

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select * from tAccountM where flag = '0' and tcode = '"& tcode &"' and wdate = '"& wdate &"' "
	if jtcode<>"" then
		SQL = SQL & " and jtcode = '"& jtcode &"' "
	end if
	SQL = SQL & " order by seq asc"
	rs.Open sql, db, 1
	imsirsrecordcount = rs.recordcount

	if imsirsrecordcount=0 then
		imsitextPname = taxtitle
	else
		imsitextPname = textPname2
	end if
%>

<html>
<head>
<title>거래명세서</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/adminpage/tax/jin.css" type="text/css">

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

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="printWindow()">

<table width="650" height=<%if imsirsrecordcount <= 9 then%>48<%else%>100<%end if%>% bordercolor=#999999 cellspacing=0 cellpadding=3 bordercolordark=black bordercolorlight=black border="1" align=center>
	<tr>
		<td align=center valign=top>

		<table width="98%" border=0 cellspacing="0" cellpadding="0" align=center>
			<tr>
				<td height=10 colspan=3></td>
			</tr>
			<tr>
				<td width=30% valign=top>

				<table width="95%" border=0 cellspacing="0" cellpadding="0">
					<tr height=20>
						<td width=17%><B>NO :</B></td>
						<td width=83%>&nbsp;</td>
					</tr>
				</table>

				<table width="95%" cellspacing="0" cellpadding="1" bordercolordark=black bordercolorlight=black border="1">
					<tr height=25>
						<td align=right><font size=2><B> <%=imsiokday_y%>년&nbsp;&nbsp;<%=imsiokday_m%>월&nbsp;&nbsp;<%=imsiokday_d%>일&nbsp;</td>
					</tr>
					<tr height=35>
						<td align=right><font size=2><B><%=c_comname%><B>&nbsp;&nbsp;귀하&nbsp;</td>
					</tr>
					<tr height=20>
						<td align=center>

						<table width="100%" cellspacing="0" cellpadding="0">
							<tr height=30>
								<td>&nbsp;아래와 같이 거래 합니다</td>
							</tr>
							<tr height=45 align=right>
								<td><u><font size="2"><B>합계 : <%if accountflag="y" then%><%=formatnumber(hmoney,0)%><%else%><%=formatnumber(kmoney,0)%><%end if%></b>원&nbsp;</font></u>&nbsp;</td>
							</tr>
						</table>


						</td>
					</tr>
				</table>

				</td>
				<td width=23% align=center valign=top>

				<table width="100%" border=0 cellspacing="0" cellpadding="0" align=center>
					<tr height=20>
						<td align=center><u><font size="4"><B>거래명세서</B></font></u><BR>(공급받는자보관용)</td>
					</tr>
				</table>

				</td>
				<td width=47% valign=top>

				<table width="99%" border="0" cellspacing="0" cellpadding="0">
					<tr height=20>
						<td width=17%>TEL : <%=b_tel%> &nbsp;&nbsp; FAX : <%=b_fax%></td>
					</tr>
				</table>

				<table width="100%" cellspacing="0" cellpadding="0" bordercolordark=black bordercolorlight=black border="1">
					<tr height=1 align=center>
						<td width=10% rowspan=4><B>공<BR><BR><B>급<BR><BR><B>자</td>
						<td width=20%>등록번호</td>
						<td width=70% colspan=3>&nbsp;<%=b_companynum%></td>
					</tr>
					<tr height=1 align=center>
						<td>상호</td>
						<td width=30%>&nbsp;<%=b_comname%></td>
						<td width=10%>성<BR>명</td>
						<td width=30%>&nbsp;<%=b_name%></td>
					</tr>
					<tr height=1 align=center>
						<td>사업장<BR>주소</td>
						<td colspan=3>&nbsp;<%=b_addr%></td>
					</tr>
					<tr height=1 align=center>
						<td>업태</td>
						<td>&nbsp;<%=b_uptae%></td>
						<td>종<BR>목</td>
						<td>&nbsp;<%=b_upjong%></td>
					</tr>
				</table>

				</td>
			</tr>
			<tr height=100>
				<td colspan=3 align=center valign=top>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height=10>
						<td></td>
					</tr>
				</table>

				<table width="100%" cellspacing="0" cellpadding="0" bordercolordark=black bordercolorlight=black border="1">
					<tr height=15 align=center>
						<td width=8%>월/일</td>
						<td width=25%>품 명</td>
						<td width=10%>규 격</td>
						<td width=10%>수 량</td>
						<td width=10%>단 가</td>
						<td width=12%>공급가액</td>
						<td width=10%>세 액</td>
						<td width=13%>합 계</td>
					</tr>
					<tr height=10 align=center>
						<td><%=mid(Aymd,5,2)%>/<%=mid(Aymd,7,2)%></td>
						<td align=left>&nbsp;<%=imsitextPname%></td>
						<td>&nbsp;</td>
						<td><%=c_Anum%></td>
						<td align=right><%=formatnumber(c_umoney,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(c_kmoney,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(c_smoney,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(c_hmoney,0)%>&nbsp;</td>
					</tr>

			<%
				imsihap1 = c_Anum
				imsihap2 = c_kmoney
				imsihap3 = c_smoney
				imsihap4 = c_hmoney
				i=1
				do until rs.eof

					if accountflag="y" then
						imsisuryang    = rs("Anum")	'체인점수
						imsipprice     = rs("umoney")	'이용료
						imsipprice_g   = rs("kmoney")	'공급가액
						imsipprice_vat = rs("smoney")	'세액
						hmoney	       = rs("hmoney")	'합계
					else
						imsisuryang    = rs("Anum")	'체인점수
						imsipprice     = rs("umoney")	'이용료
						imsipprice_g   = rs("kmoney")	'공급가액
						imsipprice_vat = 0		'세액
						hmoney	       = rs("kmoney")	'합계
					end if
			%>

					<tr height=10 align=center>
						<td><%=mid(rs("Aymd"),5,2)%>/<%=mid(rs("Aymd"),7,2)%></td>
						<td align=left>&nbsp;<%=rs("textPname2")%></td>
						<td>&nbsp;</td>
						<td><%=imsisuryang%></td>
						<td align=right><%=formatnumber(imsipprice,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice_g,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice_vat,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(hmoney,0)%>&nbsp;</td>
					</tr>

			<%
					imsihap1 = imsihap1+imsisuryang
					imsihap2 = imsihap2+imsipprice_g
					imsihap3 = imsihap3+imsipprice_vat
					imsihap4 = imsihap4+hmoney

				rs.movenext
				i=i+1
				loop
				rs.close

				if i>10 then
					jj=34
				else
					jj=8
				end if
					for j=1 to (jj-i)
			%>

					<tr height=10 align=center>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
			<%
					next

			%>

					<tr height=10 align=center>
						<td colspan=3>합 계</td>
						<td><%=formatnumber(imsihap1,0)%>&nbsp;</td>
						<td>&nbsp;</td>
						<td align=right><%=formatnumber(imsihap2,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsihap3,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsihap4,0)%>&nbsp;</td>
					</tr>
				</table>

				</td>
			</tr>
			<tr>
				<td height=10 colspan=3>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height=10>
						<td></td>
					</tr>
				</table>

				<table width="100%" cellspacing="0" cellpadding="0">
					<tr height=20>
						<td width=80% align=right>인수자</td>
						<td width=17%>&nbsp;:&nbsp;</td>
						<td width=3%>(인)</td>
					</tr>
				</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td>
		<table width="600" border="0" cellspacing="0" cellpadding="1">
        		<tr> 
				<td class="stylefont5">
				<BR>
				고객님의 입금가능한 계좌번호는 다음과 같습니다.<BR>
				<B>-은 행 명 : <%=virtual_acnt_bank%><BR>
				-계좌번호 : <%=virtual_acnt%><BR>
				-예 금 주 : 박양우(에듀빌)<BR>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table> 


<div id="Layer1" style="position:absolute; left:590px; top:57px; height:40px; z-index:1"> 
  <table width="115" border="0" cellspacing="0" cellpadding="0" height="40" bordercolor="#C81642">
    <tr> 
      <td align="center"><img src="/fileupdown/logo/edubill.gif"></td>
    </tr>
  </table>
</div>

</body>
</html>

