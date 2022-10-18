<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	'세금부과
	'pgubun = request("pgubun")
	comname2 = request("comname2")
	'searcha = request("searcha")
	'searchb = request("searchb")
	'searchc = request("searchc")
	'searchd = request("searchd")
	printflag = request("printflag")
	imsitprice = request("imsitprice")

	'set rs = server.CreateObject("ADODB.Recordset")
	'SQL = " select top 1 usercode,orderday,rordermoney"
	'SQL = sql & " from tb_order "
	'SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' and comname2='"& comname2 &"' "
	'rs.Open sql, db, 1
	'imsiusercode = rs(0)
	imsiusercode = request("imsiusercode")
	busercode = int(left(imsiusercode,5))		'본사코드
	jusercode = int(mid(imsiusercode,6,5))		'지사코드
	cusercode = int(mid(imsiusercode,11,5))		'체인점코드
	'rs.close
	imsiokday = replace(left(now(),10),"-","")
	imsiokday_y = left(imsiokday,4)
	imsiokday_m = mid(imsiokday,5,2)
	imsiokday_d = mid(imsiokday,7,2)

'response.write session("Adcenteridx")
'choiceDcenter=10049

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
	SQL = " select vatflag,misuprint "
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = "& busercode &" "
	rs.Open sql, db, 1
	vatflag   = rs(0)
	misuprint = rs(1)
	rs.close

	'공급받는자-체인점
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname,mi_money"
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = '"& cusercode &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		c_comname = rs(0)
		misuprint_money = rs(1)
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
	SQL = " select a.pname,b.ptitle,sum(a.rordernum),a.pprice,sum(a.rordernum*a.pprice),b.gubun,a.pcode"
	SQL = sql & " from tb_order_product a, tb_product b"
	SQL = sql & " where a.pcode = b.pcode "
	SQL = sql & " and b.usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and a.idx in ( "
		SQL = sql & " select idx "
		SQL = sql & " from tb_order "
		SQL = sql & " where comname2 = '"& comname2 &"' "

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
	SQL = sql & " group by a.pcode,a.pname,b.ptitle,b.gubun,a.pprice "
	SQL = sql & " order by a.pcode asc "
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
	SQL = " select a.pname,b.ptitle,sum(a.rordernum),a.pprice,sum(a.rordernum*a.pprice),b.gubun,a.pcode"
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
	SQL = sql & " group by a.pcode,a.pname,b.ptitle,b.gubun,a.pprice "
	SQL = sql & " order by a.pcode asc "
	rs.Open sql, db, 1

	imsirsrecordcount = rs.recordcount
%>

<html>
<head>
<title>전표출력</title>
<link rel="stylesheet" href="jin.css" type="text/css">

</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="window.print();">

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
						<td><%=imsiokday_m%>/<%=imsiokday_d%></td>
						<td align=left>&nbsp;<%=rs(0)%></td>
						<td>&nbsp;<%=ptitle%></td>
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
						<td width=40%><%if misuprint="y" then%><b>총 미수금 : </B><%=formatnumber(misuprint_money,0)%>원<%end if%></td>
						<td width=40% align=right>인수자</td>
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

<br>

<table width="650" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td background="dot.gif" width=650 height=1></td>
	</tr>
</table>

<BR>

<%


	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pname,b.ptitle,sum(a.rordernum),a.pprice,sum(a.rordernum*a.pprice),b.gubun,a.pcode"
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
	SQL = sql & " group by a.pcode,a.pname,b.ptitle,b.gubun,a.pprice "
	SQL = sql & " order by a.pcode asc "
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
						<td><%=imsiokday_m%>/<%=imsiokday_d%></td>
						<td align=left>&nbsp;<%=rs(0)%></td>
						<td>&nbsp;<%=ptitle%></td>
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
						<td width=40%><%if misuprint="y" then%><b>총 미수금 : </B><%=formatnumber(misuprint_money,0)%>원<%end if%></td>
						<td width=40% align=right>인수자</td>
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
</body>
</html>