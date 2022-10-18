<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	'주문시간
	searche = request("searche")
	searchf = request("searchf")
	imsiday1 = left(searcha,4)&"/"&mid(searcha,5,2)&"/"&right(searcha,2)
	imsiday2 = left(searchb,4)&"/"&mid(searchb,5,2)&"/"&right(searchb,2)

	carname = Request("carname")
	sumoney = request("sumoney")
	pgubun = request("pgubun")
	prinFlag = request("prinFlag")
	if pgubun="" then pgubun="0"
	if prinFlag="" then prinFlag="1"

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarname "
	SQL = sql & " from tb_car "
	SQL = sql & " where dcarno = '"& carname &"' and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	rs.Open sql, db, 1
	imsicarname = rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select SearchOrderTime, SearchStartTime, SearchEndTime "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		SearchOrderTime = rs(0)    '시간사용
		SearchStartTime = rs(1)	   '시작시간
		SearchEndTime = rs(2)      '종료시간
	else
		SearchOrderTime = "n"
		SearchStartTime = ""
		SearchEndTime = ""
	end if
	rs.close

	'주문시간
	If searche = "" Then 
		If  SearchStartTime = "" Then 
			searche = "000000"
		Else 
			If Len(SearchStartTime) = 4 Then 
				searche = SearchStartTime & "00"
			Else
				searche = "000000"
			End If 
		End If 
	End If 

	If searchf = "" Then 
		If SearchEndTime = ""Then 
			searchf = "235959"
		Else 
			If Len(SearchEndTime) = 4 Then 
				searchf = SearchEndTime & "59"
			Else
				searchf = "235959"
			End If 
		End If
	End If 

	startdate = searcha + searche
	enddate = searchb + searchf

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pcode,a.pname,a.sumrordernum, b.ptitle "
	SQL = sql & " from "
	SQL = sql & " (select pcode,pname,sum(rordernum) as sumrordernum "
	SQL = sql & " from v_tb_order "
	if session("Ausergubun")="3" then
		SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
		if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
			SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	SQL = sql & " and deflag = 'n' and flag = 'y' and carname = '"& carname &"' "
	If searchordertime = "n" Or searchordertime ="" Then 
		SQL = sql & " and orderday >= '"& searcha &"' "
		SQL = sql & " and orderday <= '"& searchb &"' "
	Else 
		SQL = sql & "  and (convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
		SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) )  "
	End If 
	SQL = sql & " and rordernum > 0 "
	SQL = sql & " group by pcode,pname) a "
	SQL = sql & " left outer join "
	SQL = sql & " (select pcode,ptitle from tb_product where usercode = '"& left(session("Ausercode"),5) &"') b "
	SQL = sql & " on a.pcode = b.pcode "
	SQL = sql & " order by a.pcode asc "
	rs.Open sql, db, 1


%>

<html>
<head>
<title>호차별총집계표</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style>
TD {font: 9pt 굴림;}
A   {font: 9pt 굴림; text-decoration: none}
A:link    {font: 9pt 굴림; color:#555555; text-decoration: none}
A:visited {font: 9pt 굴림; color:#555555; text-decoration: none}
A:hover   {font: 9pt 굴림; color:#555555; text-decoration: none;}
A.sssss:hover{font: 9pt 굴림;text-decoration: underline;}
A.autopro:link { color:#0000FF; font-size: 9pt; font-weight: lighter; text-decoration: none; font-family: "굴림"}
</style>
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
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="window.print();">

<table width="650" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center valign=top>

		<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center valign=top>

<table width="100%" border=0 cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">

<form action=newwin.asp method=post name=form>
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=carname value="<%=carname%>">
<input type=hidden name=sumoney value="<%=sumoney%>">

	<tr height="47">
		<td width=50%><font color=blue size=3><B>[ <%if pgubun="0" or pgubun="1" then%>호차별 총<%else%>체인점별<%end if%> 집계표 ]</td>
		<td width=50% align=right>
			<select name=prinFlag>
				<option value=1 <%if prinFlag="1" then%>selected<%end if%>>전체인쇄
				<option value=2 <%if prinFlag="2" then%>selected<%end if%>>체인점별인쇄
			</select>
			<select name=pgubun>
				<option value=0 <%if pgubun="0" then%>selected<%end if%>>전체
				<option value=1 <%if pgubun="1" then%>selected<%end if%>>호차별총집계
				<option value=2 <%if pgubun="2" then%>selected<%end if%>>체인점별집계
			</select> <input type=submit value="확인">
		</td>
	</tr>
</form>
</table>

<table border=1 cellspacing=0 cellpadding=0 bgcolor=black width="100%" bordercolor=silver STYLE="border:0.5px;">

<form action="list.asp" method="POST" name=kindform>
	<tr align=center>
		<td nowrap width="8%" bgcolor="#F7F7FF" height="25"><B>호 차</td>
		<td nowrap width="8%" bgcolor="#FFFFFF" height="25"><%=carname%>호차</td>
		<td nowrap width="8%" bgcolor="#F7F7FF" height="25" align=center><B>기사명</td>
		<td nowrap width="15%" bgcolor="#FFFFFF" height="25"><%=imsicarname%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>주문일자</td>
		<td nowrap width="25%" bgcolor="#FFFFFF" height="25"><%=imsiday1%> ~ <%=imsiday2%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>수금금액</td>
		<td nowrap width="16%" bgcolor="#FFFFFF" height="25"><%=FormatCurrency(sumoney,0)%></td>
	</tr>

</form>

</table>

<%if pgubun="0" or pgubun="1" then%>

<table border=1 cellspacing=0 cellpadding=0 width=100% bgcolor=black bordercolor=silver STYLE="border:0.5px;">
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>상품코드</td>
		<td width=45%>상품명</td>
		<td width=20%>규격</td>
		<td width=20%>배달수량</td>
	</tr>

<%
i=1
do until rs.EOF
	imsidcarname = rs(3)
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs(0)%></td>
		<td align=left> &nbsp; <%=rs(1)%></td>
		<td><%if imsidcarname<>"" then%><%=imsidcarname%><%else%>&nbsp;<%end if%></td>
		<td align=right><%=rs(2)%> &nbsp; </td>
	</tr>

<%
rs.MoveNext 
i=i+1
loop
rs.close
%>

</table>

<BR>

<%if prinFlag="2" then%>&nbsp;<P CLASS="breakhere">&nbsp;<%end if%>

<%end if%>

<%if pgubun="2" or pgubun="0" then%>

<%if  pgubun="0" then%>
<table width="100%" border=0 cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td width=50%><font color=blue size=3><B>[ 체인점별 집계표 ]</td>
		</td>
	</tr>
</table>
<%end if%>

<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.tcode,b.comname2, c.pcode,c.pname,isnull(c.pprice,0),isnull(c.sumrordernum,0) ,c.sumhap, c.usercode,d.ptitle "
	SQL = sql & " from "
	SQL = sql & " 		( select tcode,idx from tb_company where flag = '3' and bidxsub = "& left(session("Ausercode"),5) &" ) a "
	SQL = sql & " right outer join "
	SQL = sql & " 		(select comname2,usercode "
	SQL = sql & " 		from v_tb_order  "
				if session("Ausergubun")="3" then
					SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
					'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
					if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
						SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
					end if
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				else
					SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
				end if
	SQL = sql & " 		and deflag = 'n' and flag = 'y' and carname <> '' and carname = '"& carname &"' "
	If searchordertime = "n" Or searchordertime ="" Then 
		SQL = sql & " 		and orderday >= '"& searcha &"' and orderday <= '"& searchb &"' "
	Else 
		SQL = sql & "  and (convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
		SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) )  "
	End If
	SQL = sql & " 		and rordernum>0  "
	SQL = sql & " 		group by comname2,usercode "
	SQL = sql & " 		) b "
	SQL = sql & " on a.idx = substring(b.usercode,11,5) "
		if session("Ausergubun")="3" then
			SQL = sql & " and substring(b.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if
	SQL = sql & " left outer join "
	SQL = sql & " 		(select pcode,pname,pprice,sum(rordernum) as sumrordernum , sum(rordernum*pprice) as sumhap, usercode "
	SQL = sql & " 		from v_tb_order "
				if session("Ausergubun")="3" then
					SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
					'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
					if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
						SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
					end if
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				else
					SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
				end if
	SQL = sql & " 		and deflag = 'n' and flag='y' and carname <> '' and carname = '"& carname &"' "
	If searchordertime = "n" Or searchordertime ="" Then 
		SQL = sql & " 		and orderday >= '"& searcha &"' and orderday <= '"& searchb &"' "
	Else 
		SQL = sql & "  and (convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
		SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) )  "
	End If
	SQL = sql & " 		and rordernum > 0  "
	SQL = sql & " 		group by pcode,pname,pprice , usercode) c "
	SQL = sql & " on b.usercode = c.usercode "
	SQL = sql & " left outer join "
	SQL = sql & " 		(select pcode,ptitle from tb_product where usercode = '"& left(session("Ausercode"),5) &"') d "
	SQL = sql & " on d.pcode = c.pcode "
	SQL = sql & " order by b.comname2 asc, c.pcode asc "
'response.write sql
'response.end
	rs.Open sql, db, 1
%>



<%
i=1
imsihap = 0
tphap   = 0
tshap   = 0
ttphap  = 0
do until rs.EOF

	imsiimsitcode = rs(0)
	imsicomname2  = rs(1)
	newtcode = imsiimsitcode

	if i=1 then
		oldtcode = imsiimsitcode
	elseif newtcode<>oldtcode then
		response.write " <tr height=22 bgcolor=#FFFFFF align=center align=center>"
		response.write " <td colspan=3>합계</td>"
		response.write " <td align=right>"& FormatCurrency(tphap,0) &" &nbsp; </td>"
		response.write " <td>"& tshap &"</td>"
		response.write " <td align=right>"& FormatCurrency(ttphap,0) &" &nbsp; </td>"
		response.write " </tr>"
		response.write " </table>"

		response.write "<BR> "

if prinFlag="2" then response.write "&nbsp;<P CLASS='breakhere'>&nbsp;"

		response.write "<table border=1 STYLE='border:0.5px;' cellspacing='0' cellpadding='2' bordercolorlight='#BDCBE7' bordercolordark='#FFFFFF' width='100%'> "
		response.write "	<tr> "
		response.write "		<td nowrap bgcolor='#FFFFFF' height='25'> &nbsp; <B>[ "& imsicomname2 &" ("& imsiimsitcode &")]</td> "
		response.write "	</tr> "
		response.write "</table> "
		response.write "<table border=1 STYLE='border:0.5px;' cellspacing='1' cellpadding='1' width=100% bgcolor=#BDCBE7> "
		response.write "	<tr height=28 bgcolor=#F7F7FF align=center> "
		response.write "		<td width='15%'>상품코드</td> "
		response.write "		<td width='25%'>상품명</td> "
		response.write "		<td width='15%'>규격</td> "
		response.write "		<td width='15%'>단가</td> "
		response.write "		<td width='10%'>배달수량</td> "
		response.write "		<td width='20%'>금액</td> "
		response.write "	</tr> "

		imsihap = 0
		tphap   = 0
		tshap   = 0
		ttphap  = 0
	end if

	'a.tcode,b.comname2, c.pcode,c.pname,c.pprice,c.sumrordernum ,c.sumhap, c.usercode,d.ptitle
	imsidcarname  = rs(8)
	rs2_pcode     = rs(2)
	rs2_pname     = rs(3)
	rs2_pprice    = rs(4)
	rs2_rordernum = rs(5)

	imsihap = CDbl(rs2_pprice)*CDbl(rs2_rordernum)
	tphap =CDbl(tphap)+CDbl(rs2_pprice)
	tshap =CDbl(tshap+rs2_rordernum)
	ttphap=CDbl(ttphap+imsihap)

%>

<%if i=1 then%>
<BR>

<table border=1 STYLE="border:0.5px;" cellspacing="0" cellpadding="2" bordercolorlight="#BDCBE7" bordercolordark="#FFFFFF" width="100%">
	<tr>
		<td nowrap bgcolor="#FFFFFF" height="25"> &nbsp; <B>[ <%=imsicomname2%> (<%=imsiimsitcode%>)]</td>
	</tr>
</table>

<table border=1 STYLE="border:0.5px;" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>상품코드</td>
		<td width=25%>상품명</td>
		<td width=15%>규격</td>
		<td width=15%>단가</td>
		<td width=10%>배달수량</td>
		<td width=20%>금액</td>
	</tr>
<%end if%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs2_pcode%></td>
		<td align=left> &nbsp; <%=rs2_pname%></td>
		<td><%=imsidcarname%></td>
		<td align=right><%=FormatCurrency(rs2_pprice,0)%> &nbsp; </td>
		<td><%=rs2_rordernum%></td>
		<td align=right><%=FormatCurrency(imsihap,0)%> &nbsp; </td>
	</tr>


<%
oldtcode = imsiimsitcode
rs.MoveNext 
i=i+1
loop
rs.close

db.close
set db=nothing

response.write " <tr height=22 bgcolor=#FFFFFF align=center align=center>"
response.write " <td colspan=3>합계</td>"
response.write " <td align=right>"& FormatCurrency(tphap,0) &" &nbsp; </td>"
response.write " <td>"& tshap &"</td>"
response.write " <td align=right>"& FormatCurrency(ttphap,0) &" &nbsp; </td>"
response.write " </tr>"
response.write " </table>"

%>

<%end if%>

<BR>



				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>