<!--#include virtual="/db/db2.asp"-->
<%
	customerid = request("id")
	dutynum = request("num")
	printflag = "n"

	'공급자-본사
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select "
	SQL = sql & " left(MCLIENTNO, 3) + '-' + SUBSTRING(MCLIENTNO, 4,2) + '-' + SUBSTRING(MCLIENTNO, 6, 5) MCompany, "
	SQL = sql & " MSANGHO, MCEONM, MADDR, MUPTEA, MUPJONG, CLIENTNO, SANGHO, CEONM, ADDR, UPTEA, UPJONG, WDATE, COST, VAT "
	SQL = sql & "  from CM_DUTYMASTER "
	SQL = sql & " where CUSTOMERID = '" & customerid &  "' "
	SQL = sql & " and DUTY_NUM = '" & dutynum &  "' "

	rs.Open sql, db, 1
	
	if rs.EOF then 
%>
		<script language="javascript">
			alert("데이타가 없습니다.");
			parent.window.close();
		</script>
<%
	else

	b_companynum = rs(0)
	b_comname = rs(1)
	b_name = rs(2)
	b_addr = rs(3)
	b_uptae = rs(4)
	b_upjong = rs(5)
	vatflag = "n"
	taxtitle = ""
	'''''''''''''''''''''''''''''''''''''''''''''''
	'공급받는자-체인점
	c_companynum = rs(6)
	c_comname = rs(7)
	c_name = rs(8)
	c_addr = rs(9)
	c_uptae = rs(10)
	c_upjong = rs(11)
	'날짜 & 합계
	imsiokday = rs(12)
	imsiokday_y = left(imsiokday,4)
	imsiokday_m = mid(imsiokday,5,2)
	imsiokday_d = mid(imsiokday,7,2)
	ordermoney = rs(13)
	ordermoney_vat = rs(14)
	rs.close

	ordermoney_hap = ordermoney

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = "  select ITMNM, ITMNET, COST, VAT from CM_DUTYDETAIL "
	SQL = sql & " where CUSTOMERID = '" & customerid & "' "
	SQL = sql & " and duty_num= '" & dutynum & "'"
	SQL = sql & " order by ITMSEQ "
	rslist.Open sql, db, 1

	binlencount = 11-len(ordermoney)	'공란수

	for i=1 to binlencount
		loopbin = loopbin&"a"
	next
	loopordermoney = loopbin&ordermoney

		gcount1 = mid(loopordermoney,1,1)
		if gcount1="a" then
			gcount1=""
		end if
		gcount2 = mid(loopordermoney,2,1)
		if gcount2="a" then
			gcount2=""
		end if
		gcount3 = mid(loopordermoney,3,1)
		if gcount3="a" then
			gcount3=""
		end if
		gcount4 = mid(loopordermoney,4,1)
		if gcount4="a" then
			gcount4=""
		end if
		gcount5 = mid(loopordermoney,5,1)
		if gcount5="a" then
			gcount5=""
		end if
		gcount6 = mid(loopordermoney,6,1)
		if gcount6="a" then
			gcount6=""
		end if
		gcount7 = mid(loopordermoney,7,1)
		if gcount7="a" then
			gcount7=""
		end if
		gcount8 = mid(loopordermoney,8,1)
		if gcount8="a" then
			gcount8=""
		end if
		gcount9 = mid(loopordermoney,9,1)
		if gcount9="a" then
			gcount9=""
		end if
		gcount10 = mid(loopordermoney,10,1)
		if gcount10="a" then
			gcount10=""
		end if
		gcount11 = mid(loopordermoney,11,1)
		if gcount11="a" then
			gcount11=""
		end if

	binlencount2 = 10-len(ordermoney_vat)	'공란수
	loopbin = ""
	for i=1 to (binlencount2)
		loopbin = loopbin&"a"
	next
	loopordermoney_vat = loopbin&ordermoney_vat

	scount1 = mid(loopordermoney_vat,1,1)
	if scount1="a" then
		scount1=""
	end if
	scount2 = mid(loopordermoney_vat,2,1)
	if scount2="a" then
		scount2=""
	end if
	scount3 = mid(loopordermoney_vat,3,1)
	if scount3="a" then
		scount3=""
	end if
	scount4 = mid(loopordermoney_vat,4,1)
	if scount4="a" then
		scount4=""
	end if
	scount5 = mid(loopordermoney_vat,5,1)
	if scount5="a" then
		scount5=""
	end if
	scount6 = mid(loopordermoney_vat,6,1)
	if scount6="a" then
		scount6=""
	end if
	scount7 = mid(loopordermoney_vat,7,1)
	if scount7="a" then
		scount7=""
	end if
	scount8 = mid(loopordermoney_vat,8,1)
	if scount8="a" then
		scount8=""
	end if
	scount9 = mid(loopordermoney_vat,9,1)
	if scount9="a" then
		scount9=""
	end if
	scount10 = mid(loopordermoney_vat,10,1)
	if scount10="a" then
		scount10=""
	end if
%>

<html>
<head>
<title>계산서</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="stylefont_document.css" type="text/css">

<script language="javascript" src="/adminpage/incfile/javascript_data.js"></script>

</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="window.print();">

<table width="650" border="0" cellspacing="0" cellpadding="0">



<form action=newwin2.asp method=post name=form>
<input type=hidden name=pgubun value="<%=pgubun%>">
<input type=hidden name=comname2 value="<%=comname2%>">
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=searchd value="<%=searchd%>">
<input type=hidden name=printflag value="y">
<input type=hidden name=saveflag>
<input type=hidden name=old_ordermoney value="<%=ordermoney%>">
<input type=hidden name=old_ordermoney_vat value="<%=ordermoney_vat%>">
<input type=hidden name=imsiusercode value="<%=imsiusercode%>">

	<tr> 
		<td colspan="4" height="4"></td>
	</tr>
	<tr> 
		<td width="5" height="2">&nbsp;</td>
		<td height="2" width="310" class="stylefont1" valign="bottom"><font color="#4956C7">[별지 제11호 서식]</font></td>
		<td height="2" width="310" class="stylefont1" align="right" valign="bottom"><font color="#4956C7">[청색]</font></td>
    		<td width="5" height="2">&nbsp;</td>
	</tr>
	<tr> 
		<td width="25" height="2">&nbsp;</td>
		<td height="2" colspan="2"> 

		<table width="620" border=0" cellspacing="0" cellpadding="0">
			<tr> 
          			<td rowspan="2" class="tdbd_blue_top2left2bottom1"> 

				<table width="497" border="0" cellspacing="0" cellpadding="0">
              				<tr> 
                				<td rowspan="2" align="center" width="447">
							<font style="font-size:11pt"><b><font color="#4956C7" size="5">계산서</font></b></font> 
                  					<font color="#4956C7"><span class="stylefont1">(공급 받는자용)</span></font>
						</td>
                				<td width="50" class="stylefont1" align="center" height="18" valign="bottom"><font color="#4956C7">책 &nbsp;번 호</font></td>
					</tr>
              				<tr> 
                				<td width="50" class="stylefont1" align="center" height="18" valign="bottom"><font color="#4956C7">일련번호</font></td>
					</tr>
				</table>

				</td>
				<td colspan="3" class="tdbd_blue_top2left1" height="20" align="right" valign="bottom">&nbsp;<font color="#4956C7">권</font></td>
				<td colspan="4" class="tdbd_blue_top2left1right2" height="20" align="right" valign="bottom">&nbsp;<font color="#4956C7">호</font></td>
			</tr>
        		<tr> 
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom1">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1right2bottom1">&nbsp;</td>
        		</tr>
      		</table>

      		<table width="620" border="0" cellspacing="0" cellpadding="1">
			<tr> 
          			<td class="tdbd_blue_top1left2bottom1" rowspan="4" align="center" height="25" width="15">
					<font color="#4956C7">공<br><br>급<br><br>자</font>
				</td>
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">등록번호</font></td>
          			<td class="tdbd_blue_top1left1" colspan="3" height="32" align="center"><b><%=b_companynum%></b>&nbsp;</td>
          			<td class="tdbd_blue_top1left1bottom1" rowspan="4" height="32" align="center" width="15">
					<font color="#4956C7">공<br>급<br>받<br>는<br>자</font>
				</td>
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">등록번호</font></td>
          			<td class="tdbd_blue_top1left1right2" colspan="3" height="32" align="center"><b><%=c_companynum%></b>&nbsp;</td>
        		</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">상 &nbsp;&nbsp;호<br>(법인명)</font></td>
				<td class="tdbd_blue_top1left1" height="32" width="87">&nbsp;<%=b_comname%></td>
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">성 명<br>(대표자)</font></td>
				<td class="tdbd_blue_top1left1" height="32" width="87" align="center"><%=b_name%><font color="#4956C7">(인)</font></td>
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">상 &nbsp;&nbsp;호<br>(법인명)</font></td>
				<td class="tdbd_blue_top1left1" height="32" width="87">&nbsp;<%=c_comname%></td>
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">성 &nbsp;&nbsp;명<br>(대표자)</font></td>
          			<td class="tdbd_blue_top1left1right2" height="32" width="87" align="center">&nbsp;<%=c_name%><span class="stylefont5"><font color="#4956C7">(인)</font></span></td>
        		</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">사업장<br>주 &nbsp;&nbsp;소</font></td>
				<td class="tdbd_blue_top1left1" colspan="3" height="32">&nbsp;<%=b_addr%></td>
				<td class="tdbd_blue_top1left1" height="32" align="center" width="50"><font color="#4956C7">사업장<br>주 &nbsp;&nbsp;소</font></td>
				<td class="tdbd_blue_top1left1right2" colspan="3" height="32">&nbsp;<%=c_addr%></td>
			</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left1bottom1" height="32" align="center" width="50"><font color="#4956C7">업 &nbsp;&nbsp;태</font></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" width="87">&nbsp;<%=b_uptae%></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" align="center" width="50"><font color="#4956C7">종 목</font></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" width="87">&nbsp;<%=b_upjong%></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" align="center" width="50"><font color="#4956C7">업 &nbsp;&nbsp;태</font></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" width="87">&nbsp;<%=c_uptae%></td>
				<td class="tdbd_blue_top1left1bottom1" height="32" align="center" width="50"><font color="#4956C7">종 목</font></td>
				<td class="tdbd_blue_top1left1right2bottom1" height="32" width="87">&nbsp;<%=c_upjong%></td>
			</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
        		<tr align="center" valign="bottom"> 
          			<td colspan="3" class="tdbd_blue_top1left2" height="20"><font color="#4956C7">작 &nbsp;&nbsp;성</font></td>
				<td colspan="12" class="tdbd_blue_top1left1" height="20"><font color="#4956C7">공 &nbsp;급 &nbsp;가 &nbsp;액</font></td>
				<td colspan="10" class="tdbd_blue_top1left1" height="20"><font color="#4956C7">세 &nbsp;&nbsp;액</font></td>
				<td class="tdbd_blue_top1left1right2" height="20" width="125"><font color="#4956C7">비 고</font></td>
			</tr>
        		<tr> 
				<td width="40" class="tdbd_blue_top1left2" align="center" valign="bottom"><font color="#4956C7">년</font></td>
				<td class="tdbd_blue_top1left1" align="center" width="20" valign="bottom"><font color="#4956C7">월</font></td>
				<td class="tdbd_blue_top1left1" width="20" align="center" valign="bottom"><font color="#4956C7">일</font></td>
				<td class="tdbd_blue_top1left1" width="36" align="center" valign="bottom"><font color="#4956C7">공란수</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">백</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">십</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">억</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">천</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">백</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">십</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">만</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">천</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">백</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">십</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">일</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">십</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">억</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">천</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">백</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">십</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">만</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">천</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">백</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">십</font></td>
				<td class="tdbd_blue_top1left1" width="13" align="center" valign="bottom"><font color="#4956C7">일</font></td>
				<td rowspan="2" class="tdbd_blue_top1left1right2bottom1">&nbsp;</td>
			</tr>
        		<tr> 
				<td width="40" class="tdbd_blue_top1left2bottom1" align="center" height="30">&nbsp;<%=imsiokday_y%></td>
				<td class="tdbd_blue_top1left1bottom1" align="center" width="20" height="30">&nbsp;<%=imsiokday_m%></td>
				<td width="20" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=imsiokday_d%></td>
				<td width="36" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=binlencount%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount1%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount2%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount3%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount4%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount5%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount6%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount7%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount8%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount9%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount10%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=gcount11%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount1%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount2%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount3%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount4%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount5%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount6%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount7%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount8%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount9%></td>
				<td width="13" class="tdbd_blue_top1left1bottom1" align="center" height="30">&nbsp;<%=scount10%></td>
			</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
			<tr align="center" valign="bottom"> 
          			<td class="tdbd_blue_top1left2" height="25" width="20"><font color="#4956C7">월</font></td>
          			<td class="tdbd_blue_top1left1" height="25" width="20"><font color="#4956C7">일</font></td>
          			<td class="tdbd_blue_top1left1" height="25" width="122"><font color="#4956C7">품 목</font></td>
				<td class="tdbd_blue_top1left1" height="25" width="70"><font color="#4956C7">규 격</font></td>
				<td class="tdbd_blue_top1left1" height="25" width="30"><font color="#4956C7">수 량</font></td>
				<td class="tdbd_blue_top1left1" height="25" width="75"><font color="#4956C7">단 가</font></td>
				<td class="tdbd_blue_top1left1" height="25" width="100"><font color="#4956C7">공급가액</font></td>
				<td class="tdbd_blue_top1left1" height="25" width="95"><font color="#4956C7">세 액</font></td>
				<td class="tdbd_blue_top1left1right2" height="25" width="50"><font color="#4956C7">비 고</font></td>
			</tr>
			<% do until rslist.EOF 
				taxtitle = rslist(0)
				ordermoney = rslist(1)
				ordermoney_vat = rslist(3)
			%>
        		<tr> 
				<td class="tdbd_blue_top1left2" height="25" width="20" align="center">&nbsp;<%=imsiokday_m%></td>
          			<td class="tdbd_blue_top1left1" height="25" width="20" align="center">&nbsp;<%=imsiokday_d%></td>
          			<td class="tdbd_blue_top1left1" height="25" width="122">&nbsp;<%=taxtitle%></td>
          			<td class="tdbd_blue_top1left1" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="30" align="center">&nbsp;1</td>
	       			<td class="tdbd_blue_top1left1" height="25" width="75" align="right">&nbsp;<%=formatnumber(ordermoney,0)%></td>
          			<td class="tdbd_blue_top1left1" height="25" width="100" align="right">&nbsp;<%=formatnumber(ordermoney,0)%></td>
          			<td class="tdbd_blue_top1left1" height="25" width="95" align="right">&nbsp;<%=formatnumber(ordermoney_vat,0)%></td>
          			<td class="tdbd_blue_top1left1right2" height="25" width="50">&nbsp;</td>
        		</tr>
				<% rslist.MoveNext 
					loop 
				%>
			<tr> 
				<td class="tdbd_blue_top1left2" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right2" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left2" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right2" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left2" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right2" height="25" width="50">&nbsp;</td>
        		</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
        		<tr align="center"> 
          			<td class="tdbd_blue_top1left2" width="124" valign="bottom" height="20"><font color="#4956C7">합 계 금 액</font></td>
				<td class="tdbd_blue_top1left1" width="90" valign="bottom" height="20"><font color="#4956C7">현 금</font></td>
				<td class="tdbd_blue_top1left1" width="90" valign="bottom" height="20"><font color="#4956C7">수 표</font></td>
				<td class="tdbd_blue_top1left1" width="90" valign="bottom" height="20"><font color="#4956C7">어 음</font></td>
				<td class="tdbd_blue_top1left1" width="90" valign="bottom" height="20"><font color="#4956C7">외상미수금</font></td>
          			<td class="tdbd_blue_top1left1right2bottom2" rowspan="2" valign="middle" width="110">위 금액을 청구함.<BR><font color=white>위 금액을</font> 영수<font color=white>함.</td>
			</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left2bottom2" width="124" height="30" align="right">&nbsp;<%=formatnumber(ordermoney_hap,0)%></td>
          			<td class="tdbd_blue_top1left1bottom2" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom2" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom2" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom2" width="90" height="30" align="right">&nbsp;0</td>
        		</tr>
      		</table>

		</td>
    		<td width="5" height="2">&nbsp;</td>
  	</tr>
  	<tr> 
		<td height="2">&nbsp;</td>
		<td class="stylefont5" height="2"><font color="#4956C7">22226-28131일 '96.2.27.개정</font></td>
    		<td class="stylefont5" height="2" align="right"><font color="#4956C7">182mm x128mm 인쇄용지(특급)</font></td>
		<td height="2">&nbsp;</td>
	</tr>
</table>

<br>

<%if printflag="" then%>
	<center>
	<input type=button value="세금계산서 발행" onclick="return taxchecked('y');">
	</center>
</form>
<%end if%>

<%if printflag="y" then%>

<table width="650" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td background="dot.gif" width=650 height=1></td>
	</tr>
</table>

<BR>

<table width="650" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td colspan="4" height="4"></td>
	</tr>
	<tr> 
		<td width="5" height="2">&nbsp;</td>
		<td height="2" width="310" class="stylefont1" valign="bottom"><font color="#F81840">[별지 제11호 서식]</font></td>
		<td height="2" width="310" class="stylefont1" align="right" valign="bottom"><font color="#F81840">[적색]</font></td>
    		<td width="5" height="2">&nbsp;</td>
	</tr>
	<tr> 
		<td width="25" height="2">&nbsp;</td>
		<td height="2" colspan="2"> 

		<table width="620" border=0 cellspacing="0" cellpadding="0">
			<tr> 
          			<td rowspan="2" class="tdbd_blue_top2left2bottom11"> 

				<table width="497" border="0" cellspacing="0" cellpadding="0">
              				<tr> 
                				<td rowspan="2" align="center" width="447">
							<font style="font-size:11pt"><b><font color="#F81840" size="5">세금계산서</font></b></font> 
                  					<font color="#F81840"><span class="stylefont1">(공급자 보관용)</span></font>
						</td>
                				<td width="50" class="stylefont1" align="center" height="18" valign="bottom"><font color="#F81840">책 &nbsp;번 호</font></td>
					</tr>
              				<tr> 
                				<td width="50" class="stylefont1" align="center" height="18" valign="bottom"><font color="#F81840">일련번호</font></td>
					</tr>
				</table>

				</td>
				<td colspan="3" class="tdbd_blue_top2left11" height="20" align="right" valign="bottom">&nbsp;<font color="#F81840">권</font></td>
				<td colspan="4" class="tdbd_blue_top2left1right22" height="20" align="right" valign="bottom">&nbsp;<font color="#F81840">호</font></td>
			</tr>
        		<tr> 
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1bottom11">&nbsp;</td>
          			<td width="15" height="20" class="tdbd_blue_top1left1right2bottom11">&nbsp;</td>
        		</tr>
      		</table>

      		<table width="620" border="0" cellspacing="0" cellpadding="1">
			<tr> 
          			<td class="tdbd_blue_top1left2bottom11" rowspan="4" align="center" height="25" width="15">
					<font color="#F81840">공<br><br>급<br><br>자</font>
				</td>
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">등록번호</font></td>
          			<td class="tdbd_blue_top1left11" colspan="3" height="32" align="center"><b><%=b_companynum%></b>&nbsp;</td>
          			<td class="tdbd_blue_top1left1bottom11" rowspan="4" height="32" align="center" width="15">
					<font color="#F81840">공<br>급<br>받<br>는<br>자</font>
				</td>
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">등록번호</font></td>
          			<td class="tdbd_blue_top1left1right22" colspan="3" height="32" align="center"><b><%=c_companynum%></b>&nbsp;</td>
        		</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">상 &nbsp;&nbsp;호<br>(법인명)</font></td>
				<td class="tdbd_blue_top1left11" height="32" width="87">&nbsp;<%=b_comname%></td>
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">성 명<br>(대표자)</font></td>
				<td class="tdbd_blue_top1left11" height="32" width="87" align="center"><%=b_name%><font color="#F81840">(인)</font></td>
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">상 &nbsp;&nbsp;호<br>(법인명)</font></td>
				<td class="tdbd_blue_top1left11" height="32" width="87">&nbsp;<%=c_comname%></td>
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">성 &nbsp;&nbsp;명<br>(대표자)</font></td>
          			<td class="tdbd_blue_top1left1right22" height="32" width="87" align="center">&nbsp;<%=c_comname%><span class="stylefont5"><font color="#F81840">(인)</font></span></td>
        		</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">사업장<br>주 &nbsp;&nbsp;소</font></td>
				<td class="tdbd_blue_top1left11" colspan="3" height="32">&nbsp;<%=b_addr%></td>
				<td class="tdbd_blue_top1left11" height="32" align="center" width="50"><font color="#F81840">사업장<br>주 &nbsp;&nbsp;소</font></td>
				<td class="tdbd_blue_top1left1right22" colspan="3" height="32">&nbsp;<%=c_addr%></td>
			</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left1bottom11" height="32" align="center" width="50"><font color="#F81840">업 &nbsp;&nbsp;태</font></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" width="87">&nbsp;<%=b_uptae%></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" align="center" width="50"><font color="#F81840">종 목</font></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" width="87">&nbsp;<%=b_upjong%></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" align="center" width="50"><font color="#F81840">업 &nbsp;&nbsp;태</font></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" width="87">&nbsp;<%=c_uptae%></td>
				<td class="tdbd_blue_top1left1bottom11" height="32" align="center" width="50"><font color="#F81840">종 목</font></td>
				<td class="tdbd_blue_top1left1right2bottom11" height="32" width="87">&nbsp;<%=c_upjong%></td>
			</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
        		<tr align="center" valign="bottom"> 
          			<td colspan="3" class="tdbd_blue_top1left22" height="20"><font color="#F81840">작 &nbsp;&nbsp;성</font></td>
				<td colspan="12" class="tdbd_blue_top1left11" height="20"><font color="#F81840">공 &nbsp;급 &nbsp;가 &nbsp;액</font></td>
				<td colspan="10" class="tdbd_blue_top1left11" height="20"><font color="#F81840">세 &nbsp;&nbsp;액</font></td>
				<td class="tdbd_blue_top1left1right22" height="20" width="125"><font color="#F81840">비 고</font></td>
			</tr>
        		<tr> 
				<td width="40" class="tdbd_blue_top1left22" align="center" valign="bottom"><font color="#F81840">년</font></td>
				<td class="tdbd_blue_top1left11" align="center" width="20" valign="bottom"><font color="#F81840">월</font></td>
				<td class="tdbd_blue_top1left11" width="20" align="center" valign="bottom"><font color="#F81840">일</font></td>
				<td class="tdbd_blue_top1left11" width="36" align="center" valign="bottom"><font color="#F81840">공란수</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">백</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">십</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">억</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">천</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">백</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">십</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">만</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">천</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">백</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">십</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">일</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">십</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">억</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">천</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">백</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">십</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">만</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">천</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">백</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">십</font></td>
				<td class="tdbd_blue_top1left11" width="13" align="center" valign="bottom"><font color="#F81840">일</font></td>
				<td rowspan="2" class="tdbd_blue_top1left1right2bottom11">&nbsp;</td>
			</tr>
        		<tr> 
				<td width="40" class="tdbd_blue_top1left2bottom11" align="center" height="30">&nbsp;<%=imsiokday_y%></td>
				<td class="tdbd_blue_top1left1bottom11" align="center" width="20" height="30">&nbsp;<%=imsiokday_m%></td>
				<td width="20" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=imsiokday_d%></td>
				<td width="36" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=binlencount%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount1%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount2%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount3%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount4%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount5%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount6%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount7%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount8%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount9%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount10%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=gcount11%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount1%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount2%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount3%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount4%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount5%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount6%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount7%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount8%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount9%></td>
				<td width="13" class="tdbd_blue_top1left1bottom11" align="center" height="30">&nbsp;<%=scount10%></td>
			</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
			<tr align="center" valign="bottom"> 
          			<td class="tdbd_blue_top1left22" height="25" width="20"><font color="#F81840">월</font></td>
          			<td class="tdbd_blue_top1left11" height="25" width="20"><font color="#F81840">일</font></td>
          			<td class="tdbd_blue_top1left11" height="25" width="122"><font color="#F81840">품 목</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="70"><font color="#F81840">규 격</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="30"><font color="#F81840">수 량</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="75"><font color="#F81840">단 가</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="100"><font color="#F81840">공급가액</font></td>
				<td class="tdbd_blue_top1left11" height="25" width="95"><font color="#F81840">세 액</font></td>
				<td class="tdbd_blue_top1left1right22" height="25" width="50"><font color="#F81840">비 고</font></td>
			</tr>
        		<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;<%=imsiokday_m%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;<%=imsiokday_d%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="122">&nbsp;<%=taxtitle%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;1</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;<%=formatnumber(ordermoney,0)%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;<%=formatnumber(ordermoney,0)%></td>
          			<td class="tdbd_blue_top1left11" height="25" width="95" align="right">&nbsp;<%=formatnumber(ordermoney_vat,0)%></td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
			<tr> 
				<td class="tdbd_blue_top1left22" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="20" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="122">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="70">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="30" align="center">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="75" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="100" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left11" height="25" width="95" align="right">&nbsp;</td>
          			<td class="tdbd_blue_top1left1right22" height="25" width="50">&nbsp;</td>
        		</tr>
		</table>

		<table width="620" border="0" cellspacing="0" cellpadding="1">
        		<tr align="center"> 
          			<td class="tdbd_blue_top1left22" width="124" valign="bottom" height="20"><font color="#F81840">합 계 금 액</font></td>
				<td class="tdbd_blue_top1left11" width="90" valign="bottom" height="20"><font color="#F81840">현 금</font></td>
				<td class="tdbd_blue_top1left11" width="90" valign="bottom" height="20"><font color="#F81840">수 표</font></td>
				<td class="tdbd_blue_top1left11" width="90" valign="bottom" height="20"><font color="#F81840">어 음</font></td>
				<td class="tdbd_blue_top1left11" width="90" valign="bottom" height="20"><font color="#F81840">외상미수금</font></td>
          			<td class="tdbd_blue_top1left1right2bottom22" rowspan="2" valign="middle" width="110">위 금액을 청구함.<BR><font color=white>위 금액을</font> 영수<font color=white>함.</td>
			</tr>
        		<tr> 
          			<td class="tdbd_blue_top1left2bottom22" width="124" height="30" align="right">&nbsp;<%=formatnumber(ordermoney_hap,0)%></td>
          			<td class="tdbd_blue_top1left1bottom22" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom22" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom22" width="90" height="30" align="right">&nbsp;0</td>
          			<td class="tdbd_blue_top1left1bottom22" width="90" height="30" align="right">&nbsp;0</td>
        		</tr>
      		</table>

		</td>
    		<td width="5" height="2">&nbsp;</td>
  	</tr>
  	<tr> 
		<td height="2">&nbsp;</td>
		<td class="stylefont5" height="2"><font color="#F81840">22226-28131일 '96.2.27.개정</font></td>
    		<td class="stylefont5" height="2" align="right"><font color="#F81840">182mm x128mm 인쇄용지(특급)</font></td>
		<td height="2">&nbsp;</td>
	</tr>
</table>

<br>
<br>

<!--
<div id="Layer1" style="position:absolute; left:243px; top:85px; height:40px; z-index:1"> 
  <table width="115" border="0" cellspacing="0" cellpadding="0" height="40" bordercolor="#C81642">
    <tr> 
      <td align="center" style="border:2 solid #EC557B;font-family:굴림체;font-size:12pt;color:#C81642;padding-top:2px;line-height:16px"><b><b>(주)비바빅스</b></b></td>
    </tr>
  </table>
</div>
도장 -->
</body>
</html>
<%	End If %>
<%end if%>