<html>
<head>
<title>거래명세서</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="jin.css" type="text/css">
<style type="text/css">
P.breakhere {page-break-before: always}
</style>

<script language="javascript" src="/adminpage/incfile/javascript_data.js"></script>
<object id="factory" style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="/adminpage/account/smsx.cab#Version=6,2,433,70">
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

 //function click() {
 //     if ((event.button==2) || (event.button==3)) {
 //        alert('출력하시려면 F5(새로고침)을 하여 인쇄하시기 바랍니다!');
 //     }
 //  }
 //  document.onmousedown=click;

</script>
<script language="javascript" src="/adminpage/incfile/javascript_data.js"></script>

</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="printWindow();">

<%
	'comname2 체인점명
	'imsiusercode 전체코드
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	if searcha = "" then
		searcha = replace(left(now()-1,10),"-","")
	end if
	if searchd = "" then
		searchd = replace(left(now(),10),"-","")
	end if
	if searchb="" then
		searchb="0"
	end if

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname2,usercode "

	if session("Ausergubun")="3" and session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
		SQL = sql & " from (select b.* from tb_order_product a, tb_order b where a.idx = b.idx  AND ISNULL(Rgubun,0) != 1  and a.dcenterchoice = '"& trim(session("Adcenteridx")) &"') c "
	else
		SQL = sql & " from tb_order "
	end if

	SQL = sql & " where flag='y' "
	'SQL = sql & " and rordermoney > 0 "
       sql = sql & " AND ISNULL(Rgubun,0) != 1 "
	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	SQL = sql & " and orderday >= '"& searcha &"' and orderday <= '"& searchd &"' "

	if searchb<>"0" then
		SQL = sql & " and carname = '"& searchb &"' "
	end if

	if searchc="flag" then
		SQL = sql & " and deflag = 'n' "
	elseif searchc="deflag" then
		SQL = sql & " and deflag = 'y' "
	end if

	SQL = sql & " group by comname2,comname2,carname,usercode"
	SQL = sql & " order by comname2 asc"
	rs.Open sql, db, 1
	if not rs.eof then
		rsarray = rs.GetRows
		rsarrayint = ubound(rsarray,2)
	else
		rsarray = ""
		rsarrayint = ""
	end if
	rs.close
	
	'직인
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sealname "
	SQL = sql & " from tb_adminuser "
	SQL = sql & " where usercode = '"& session("Ausercode") &"' "
	rs.Open sql, db, 1
	imsisealname = rs(0)
	rs.close
	
	
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
if rsarrayint<>"" then
for t=0 to rsarrayint
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'세금부과
	comname2           = rsarray(0,t)
	imsiusercode       = rsarray(1,t)
	printflag          = "y"
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	busercode   = int(left(imsiusercode,5))		'본사코드
	jusercode   = int(mid(imsiusercode,6,5))	'지사코드
	cusercode   = int(mid(imsiusercode,11,5))	'체인점코드
	imsiokday   = replace(left(now(),10),"-","")
	imsiokday_y = left(imsiokday,4)
	imsiokday_m = mid(imsiokday,5,2)
	imsiokday_d = mid(imsiokday,7,2)

	'공급자-본사
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select companynum1,companynum2,companynum3,comname,name,addr,addr2,uptae,upjong,vatflag,taxtitle,tel1,tel2,tel3,fax1,fax2,fax3 "
	SQL = sql & " from tb_company"




	if session("Ausergubun")="3" then	'지사
		if session("Ausergubun")="3" and session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then	'물류센터지사정보 가져옴
			SQL = sql & " where choiceDcenter = "& session("Adcenteridx") &" "
		else
			SQL = sql & " where idx = "& jusercode &" "
		end if
	else	'본사
		SQL = sql & " where idx = "& busercode &" "
	end if













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

	'공급자-본사/지사
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select vatflag,misuprint,premisuprint "
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = "& busercode &" "
	rs.Open sql, db, 1
	vatflag = rs(0)
	misuprint = rs(1)
    premisuprint = rs(2)
	rs.close

	'공급받는자-체인점
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname,mi_money,preye_money"
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = '"& cusercode &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		c_comname = rs(0)
		misuprint_money = rs(1)
    premisuprint_money = rs(2)
	else
		c_comname = ""
		misuprint_money = 0
	end if
	rs.close

	if vatflag="y" then						'포함
		ordermoney     = round(imsirordermoney*(100/110),0)	'공급가액
		ordermoney_vat = imsirordermoney-ordermoney		'부가세
		ordermoney_hap = ordermoney+ordermoney_vat		'부가세포함

	else								'별도
		ordermoney_vat = round(imsirordermoney*0.1,0)		'부가세
		ordermoney     = imsirordermoney			'공급가액
		ordermoney_hap = ordermoney+ordermoney_vat		'부가세포함
	end if


	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pname,b.ptitle,sum(a.rordernum),a.pprice,sum(a.rordernum*a.pprice),b.gubun,a.pcode,SUBSTRING(a.wDate,6,2)+'/'+SUBSTRING(a.wDate,9,2) as wDate  "
	SQL = sql & " from tb_order_product a, tb_product b"
	SQL = sql & " where a.pcode = b.pcode "
	SQL = sql & " and b.usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and a.idx in ( "
		SQL = sql & " select idx "
		SQL = sql & " from tb_order "
		SQL = sql & " where comname2 = '"& comname2 &"' "
       sql = sql & " AND ISNULL(Rgubun,0) != 1 "
		if session("Ausergubun")="3" then
			SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.03.05'''''''''''''''''''''''''
			if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
				SQL = sql & " and a.dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
			end if
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		else
			SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if

		SQL = sql & " and orderday >= '"& searcha &"' and orderday <= '"& searchd &"' "

		if searchb<>"0" then
			SQL = sql & " and carname = '"& searchb &"' "
		end if

		if searchc="flag" then
			SQL = sql & " and flag = 'y' and deflag = 'n' "
		elseif searchc="deflag" then
			SQL = sql & " and flag = 'y' and deflag = 'y' "
		else
			SQL = sql & " and flag = 'y' "
		end if
	SQL = sql & " ) "
	SQL = sql & " group by a.pcode,a.pname,b.ptitle,b.gubun,a.pprice,SUBSTRING(a.wDate,6,2)+'/'+SUBSTRING(a.wDate,9,2) "
	SQL = sql & " order by SUBSTRING(a.wDate,6,2)+'/'+SUBSTRING(a.wDate,9,2),a.pcode asc "
	rs.Open sql, db, 1

		imsiimsiorderhap  = 0
		imsiimsiorder     = 0
		imsiimsiorder_vat = 0
		do until rs.eof
			imsipprice = 0
			imsimoney = 0
			ptitle = rs(1)

			imsisuryang = rs(2)		'수량
			imsipprice = CDbl(rs("pprice"))	'단가

			if rs(5)="과세" then							'포함

				if vatflag="y" then
					imsimoney      = round(imsipprice*(100/110),0)
					imsipprice_g   = CDbl(imsimoney*imsisuryang)				'공급가액
					imsipprice_vat = (imsipprice-imsimoney)*imsisuryang		'세액
				else								'별도
					imsimoney = CDbl(imsipprice)

					imsipprice_g   = CDbl(imsipprice)*CDbl(imsisuryang)				'공급가액
					imsipprice_vat = round(imsipprice_g*0.1,0)			'세액

				end if

			elseif rs(5)="비과세" then						'별도
				imsipprice_g = CDbl(imsipprice)*imsisuryang				'공급가액
				imsipprice_vat = 0						'세액
			end if

			imsiimsiorder     = imsiimsiorder+imsipprice_g
			imsiimsiorder_vat = imsiimsiorder_vat+imsipprice_vat
		rs.movenext
		loop
		imsiimsiorderhap  = imsiimsiorder+imsiimsiorder_vat
	rs.close




	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pname,b.ptitle,sum(a.rordernum),a.pprice,sum(a.rordernum*a.pprice),b.gubun,a.pcode,SUBSTRING(a.wDate,6,2)+'/'+SUBSTRING(a.wDate,9,2) as wDate  "
	SQL = sql & " from tb_order_product a, tb_product b"
	SQL = sql & " where a.pcode = b.pcode "

	'20060825수정
	SQL = sql & " AND a.rordernum > 0 "

	'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.03.05'''''''''''''''''''''''''
	if session("Ausergubun")="3" then
		if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
			SQL = sql & " and a.dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if

	SQL = sql & " and b.usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and a.idx in ( "
		SQL = sql & " select idx "
		SQL = sql & " from tb_order "
		SQL = sql & " where comname2 = '"& comname2 &"' "
       sql = sql & " AND ISNULL(Rgubun,0) != 1 "
		if session("Ausergubun")="3" then
			SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if

		SQL = sql & " and orderday >= '"& searcha &"' and orderday <= '"& searchd &"' "

		if searchb<>"0" then
			SQL = sql & " and carname = '"& searchb &"' "
		end if

		if searchc="flag" then
			SQL = sql & " and flag = 'y' and deflag = 'n' "
		elseif searchc="deflag" then
			SQL = sql & " and flag = 'y' and deflag = 'y' "
		else
			SQL = sql & " and flag = 'y' "
		end if
	SQL = sql & " ) "
	SQL = sql & " group by a.pcode,a.pname,b.ptitle,b.gubun,a.pprice,SUBSTRING(a.wDate,6,2)+'/'+SUBSTRING(a.wDate,9,2) "
	SQL = sql & " order by SUBSTRING(a.wDate,6,2)+'/'+SUBSTRING(a.wDate,9,2),a.pcode asc "
	rs.Open sql, db, 1
   
	imsirsrecordcount = rs.recordcount
%>

<table width="650" height=<%if imsirsrecordcount <= 10 then%>48<%else%>100<%end if%>% bordercolor=#999999 cellspacing=0 cellpadding=3 bordercolordark=black bordercolorlight=black border="1" align=center>
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
						<td align=right><font size=2><B>출력일 :<%=imsiokday_y%>년&nbsp;<%=imsiokday_m%>월&nbsp;<%=imsiokday_d%>일</td>
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
								<td><u><font size="2"><B>합계 : <%=formatnumber(imsiimsiorderhap,0)%></b>원&nbsp;</font></u>&nbsp;</td>
							</tr>
						</table>


						</td>
					</tr>
				</table>

				</td>
				<td width=23% align=center valign=top>

				<table width="100%" border=0 cellspacing="0" cellpadding="0" align=center>
					<tr height=20>
						<td align=center><u><font size="4"><B>거래명세서</B></font></u><BR>(공급자보관용)</td>
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
						<td width=30%><table width="99%" border="0" cellspacing="0" cellpadding="0">
						<tr>
						<td width=70%>&nbsp;<%=b_name%></td>
						<td width=30%><%if imsisealname<>"" then%><img src="/fileupdown/logo/<%=imsisealname%>" width="35" height="35"><%end if%></td></td>
						</tr>
						</table></td>
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
						<td width=22%>규 격</td>
						<td width=8%>수 량</td>
						<td width=10%>단 가</td>
						<td width=13%>공급가액</td>
						<td width=12%>세 액</td>
					</tr>

			<%
				i=1
				do until rs.eof

					imsipprice = 0
					imsimoney = 0
					ptitle = rs(1)

					imsisuryang = rs(2)		'수량
					imsipprice  = CDbl(rs("pprice"))	'단가

					if rs(5)="과세" then							'포함

						if vatflag="y" then	'포함
							imsimoney = round(imsipprice*(100/110),0)
							imsipprice_g = imsimoney*imsisuryang				'공급가액
							imsipprice_vat = (imsipprice-imsimoney)*imsisuryang		'세액
						else
							imsimoney = imsipprice
							imsipprice_g = CDbl(imsipprice)*CDbl(imsisuryang)				'공급가액
							imsipprice_vat = round(imsipprice_g*0.1,0)		'세액
						end if

					elseif rs(5)="비과세" then						'별도
						imsipprice_g = CDbl(imsipprice)*imsisuryang				'공급가액
						imsipprice_vat = 0						'세액
					end if
			%>

					<tr height=10 align=center>
						<td><%=rs(7)%></td>
						<td align=left>&nbsp;<%=rs(0)%></td>
						<td align="left">&nbsp;<%=ptitle%></td>
						<td><%=imsisuryang%></td>
						<td align=right><%=formatnumber(imsipprice,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice_g,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice_vat,0)%>&nbsp;</td>
					</tr>

			<%
				rs.movenext
				i=i+1
				loop
				rs.close

			if imsirsrecordcount <= 10 then
				fornum = 10
			else
				fornum = 31
			end if

				for j=1 to (fornum-i)
			%>

					<tr height=10 align=center>
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
					<tr height=50>
						<td width=65%><%if premisuprint="y" then%><b>직전미수금 : </B><%=formatnumber(premisuprint_money,0)%>원<%end if%> &nbsp;&nbsp; <%if misuprint="y" then%><b>현재미수금 : </B><%=formatnumber(misuprint_money,0)%>원<%end if%></td>
						<td width=15% align=right>인수자</td>
						<td width=17%>&nbsp;:&nbsp;</td>
						<td width=3%>(인)</td>
					</tr>
				</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table> 

<table width="650" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td height=3></td>
	</tr>
</table>

<table width="650" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td background="dot.gif" width=650 height=1></td>
	</tr>
</table>

<table width="650" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td height=3></td>
	</tr>
</table>

<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pname,b.ptitle,sum(a.rordernum),a.pprice,sum(a.rordernum*a.pprice),b.gubun,a.pcode,SUBSTRING(a.wDate,6,2)+'/'+SUBSTRING(a.wDate,9,2) as wDate  "
	SQL = sql & " from tb_order_product a, tb_product b"
	SQL = sql & " where a.pcode = b.pcode "

	'20060825수정
	SQL = sql & " AND a.rordernum > 0 "
	'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.03.05'''''''''''''''''''''''''
	if session("Ausergubun")="3" then
		if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
			SQL = sql & " and a.dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if

	SQL = sql & " and b.usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and a.idx in ( "
		SQL = sql & " select idx "
		SQL = sql & " from tb_order "
		SQL = sql & " where comname2 = '"& comname2 &"' "
       sql = sql & " AND ISNULL(Rgubun,0) != 1 "
		if session("Ausergubun")="3" then
			SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if

		SQL = sql & " and orderday >= '"& searcha &"' and orderday <= '"& searchd &"' "

		if searchb<>"0" then
			SQL = sql & " and carname = '"& searchb &"' "
		end if

		if searchc="flag" then
			SQL = sql & " and flag = 'y' and deflag = 'n' "
		elseif searchc="deflag" then
			SQL = sql & " and flag = 'y' and deflag = 'y' "
		else
			SQL = sql & " and flag = 'y' "
		end if
	SQL = sql & " ) "
	SQL = sql & " group by a.pcode,a.pname,b.ptitle,b.gubun,a.pprice,SUBSTRING(a.wDate,6,2)+'/'+SUBSTRING(a.wDate,9,2) "
	SQL = sql & " order by SUBSTRING(a.wDate,6,2)+'/'+SUBSTRING(a.wDate,9,2), a.pcode asc "
	rs.Open sql, db, 1
%>

<table width="650" height=<%if imsirsrecordcount <= 10 then%>48<%else%>100<%end if%>% bordercolor=#999999 cellspacing=0 cellpadding=3 bordercolordark=black bordercolorlight=black border="1" align=center>
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
						<td align=right><font size=2><B>출력일 :<%=imsiokday_y%>년&nbsp;<%=imsiokday_m%>월&nbsp;<%=imsiokday_d%>일</td>
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
								<td><u><font size="2"><B>합계 : <%=formatnumber(imsiimsiorderhap,0)%></b>원&nbsp;</font></u>&nbsp;</td>
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
						<td width=30%><table width="99%" border="0" cellspacing="0" cellpadding="0">
						<tr>
						<td width=70%>&nbsp;<%=b_name%></td>
						<td width=30%><%if imsisealname<>"" then%><img src="/fileupdown/logo/<%=imsisealname%>" width="35" height="35"><%end if%></td></td>
						</tr>
						</table></td>
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
						<td width=22%>규 격</td>
						<td width=8%>수 량</td>
						<td width=10%>단 가</td>
						<td width=13%>공급가액</td>
						<td width=12%>세 액</td>
					</tr>

			<%
				i=1
				do until rs.eof

					imsipprice = 0
					imsimoney = 0
					ptitle = rs(1)

					imsisuryang = rs(2)		'수량
					imsipprice  = CDbl(rs("pprice"))	'단가

					if rs(5)="과세" then							'포함

						if vatflag="y" then	'포함
							imsimoney = round(imsipprice*(100/110),0)
							imsipprice_g = imsimoney*imsisuryang				'공급가액
							imsipprice_vat = (imsipprice-imsimoney)*imsisuryang		'세액
						else
							imsimoney = imsipprice
							imsipprice_g = CDbl(imsipprice)*CDbl(imsisuryang)				'공급가액
							imsipprice_vat = round(imsipprice_g*0.1,0)		'세액
						end if

					elseif rs(5)="비과세" then						'별도
						imsipprice_g = CDbl(imsipprice)*imsisuryang				'공급가액
						imsipprice_vat = 0						'세액
					end if
			%>

					<tr height=10 align=center>
						<td><%=rs(7)%></td>
						<td align=left>&nbsp;<%=rs(0)%></td>
						<td align="left">&nbsp;<%=ptitle%></td>
						<td><%=imsisuryang%></td>
						<td align=right><%=formatnumber(imsipprice,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice_g,0)%>&nbsp;</td>
						<td align=right><%=formatnumber(imsipprice_vat,0)%>&nbsp;</td>
					</tr>

			<%
				rs.movenext
				i=i+1
				loop
				rs.close

			if imsirsrecordcount <= 10 then
				fornum = 10
			else
				fornum = 31
			end if

				for j=1 to (fornum-i)
			%>

					<tr height=10 align=center>
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
					<tr height=50>
						<td width=65%><%if premisuprint="y" then%><b>직전미수금 : </B><%=formatnumber(premisuprint_money,0)%>원<%end if%> &nbsp;&nbsp; <%if misuprint="y" then%><b>현재미수금 : </B><%=formatnumber(misuprint_money,0)%>원<%end if%></td>
						<td width=15% align=right>인수자</td>
						<td width=17%>&nbsp;:&nbsp;</td>
						<td width=3%>(인)</td>
					</tr>
				</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table> 

<!--
<div id="Layer1" style="position:absolute; left:243px; top:85px; height:40px; z-index:1"> 
  <table width="115" border="0" cellspacing="0" cellpadding="0" height="40" bordercolor="#C81642">
    <tr> 
      <td align="center" style="border:2 solid #EC557B;font-family:굴림체;font-size:12pt;color:#C81642;padding-top:2px;line-height:16px"><b><b>(주)비바빅스</b></b></td>
    </tr>
  </table>
</div>
도장 -->

<%if t<rsarrayint then%>&nbsp;<P CLASS="breakhere">&nbsp;<%end if%>

<%next%>

<%end if%>

</body>
</html>