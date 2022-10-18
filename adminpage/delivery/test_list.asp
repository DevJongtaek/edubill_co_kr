<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	imsinow = replace(left(now(),10),"-","")
	imsinow2 = replace(left(now()-1,10),"-","")

	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	if searchc = "" then
		searchc = "0"
	end if

	if searcha="" then
		searcha = imsinow2
	end if
	if searchb="" then
		searchb = imsinow
	end if

	imsiday1 = left(searcha,4)&"/"&mid(searcha,5,2)&"/"&right(searcha,2)
	imsiday2 = left(searchb,4)&"/"&mid(searchb,5,2)&"/"&right(searchb,2)

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select agencycheck2 "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsiagencycheck2 = rs(0)
	else
		imsiagencycheck2 = "n"
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " order by dcarno asc"
	rs.Open sql, db, 1
	if not rs.eof then
		hcararray = rs.GetRows
		hcararrayint = ubound(hcararray,2)
	else
		hcararray = ""
		hcararrayint = ""
	end if
	rs.close


	linksql = "searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 배달관리 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=kindform>
	<tr>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>주문일자</td>
		<td nowrap width="25%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searcha" size="8" maxlength="8" class="box_work" value="<%=searcha%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searchb" size="8" maxlength="8" class="box_work" value="<%=searchb%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="오늘" value="오늘" class="box_work"' onclick="javascript:serchtodaycheck(document.kindform.searcha, document.kindform.searchb);">
		</td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>구 분</td>
		<td nowrap width="55%" bgcolor="#FFFFFF" height="25">
			<select name="searchc" size="1" class="box_work">
				<%if hcararrayint<>"" then%>
          				<option value="0" <%if searchc = "0" then%>selected<%end if%>>호차전체</option>
					<%for i=0 to hcararrayint%>
	        	  			<option value="<%=hcararray(1,i)%>" <%if int(searchc)=int(hcararray(1,i)) then%>selected<%end if%>><%=hcararray(1,i)%>호차
					<%next%>
				<%else%>
	          			<option value="0" <%if searchc = "0" then%>selected<%end if%>>호차등록없음</option>
				<%end if%>
				<option value="99999" <%if searchc = "99999" then%>selected<%end if%>>체인점별 집계1
        		</select>
			<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="초기화" value="초기화" class="box_work"' onclick="javascript:frmzerocheck(this.form,'list.asp?flag=2');">
		</td>
	</tr>

</form>

</table>









<%
if searchc="99998" then





%>









<%

elseif searchc="99999" then

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select isnull(sum(rordermoney),0)"
	SQL = sql & " from tb_order "
	SQL = sql & " where idx <> '' "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	SQL = sql & " and deflag = 'n' "
	SQL = sql & " and flag = 'y' "
	SQL = sql & " and orderday >= '"& searcha &"' "
	SQL = sql & " and orderday <= '"& searchb &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		sumoney=rs(0)
	else
		sumoney=0
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pcode,a.pname,sum(a.rordernum)"
	SQL = sql & " from tb_order_product a, tb_order b "
	SQL = sql & " where a.idx = b.idx "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(b.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
		if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
			SQL = sql & " and a.dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	'SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "

	SQL = sql & " and b.deflag = 'n' "
	SQL = sql & " and b.flag = 'y' "
	'SQL = sql & " and b.carname = '"& carname &"' "
	SQL = sql & " and b.orderday >= '"& searcha &"' "
	SQL = sql & " and b.orderday <= '"& searchb &"' "
	SQL = sql & " group by a.pcode,a.pname "
	SQL = sql & " order by a.pcode asc "
	rs.Open sql, db, 1
%>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=60%>* 전체 <B><%=rs.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=40% align=right><%if searchc="99999" then%><a href="excell.asp?gotopage=<%=gotopage%>&searcha=<%=searcha%>&searchd=<%=searchd%>&searchb=<%=searchb%>&searchc=<%=searchc%>"><img src="/images/admin/excel.gif" border=0></a><%end if%></td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#BDCBE7" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=kindform>
	<tr>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>구분</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25">체인점별집계</td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>주문일자</td>
		<td nowrap width="30%" bgcolor="#FFFFFF" height="25"><%=imsiday1%> ~ <%=imsiday2%></td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>수금금액</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25"><%=FormatCurrency(sumoney,0)%></td>
	</tr>

</form>

</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>상품코드</td>
		<td width=45%>상품명</td>
		<td width=20%>규격</td>
		<td width=20%>배달수량</td>
	</tr>

<%
i=1
do until rs.EOF

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select ptitle "
	SQL = sql & " from tb_product "
	SQL = sql & " where pcode = '"& rs(0) &"' "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	'SQL = sql & " and usercode = '"& left(session("Ausercode"),5) &"' "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsidcarname = rs2(0)
	end if
	rs2.close
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs(0)%></td>
		<td align=left> &nbsp; <%=rs(1)%></td>
		<td><%=imsidcarname%></td>
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

<%
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select substring(usercode,11,5) "
		SQL = sql & " from tb_order "
		SQL = sql & " where flag = 'y' and deflag = 'n' and carname <> ''"

		if session("Ausergubun")="3" then
			SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if

		SQL = sql & " and orderday >= '"& searcha &"' "
		SQL = sql & " and orderday <= '"& searchb &"' "
		SQL = sql & " group by substring(usercode,11,5) "
		SQL = sql & " order by substring(usercode,11,5) asc"
		rs.Open sql, db, 1

	do until rs.eof

	imsiimsitcode = ""
	imsiimsicomname = ""

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode,comname "
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = "& rs(0) &" "
	rs2.Open sql, db, 1
	imsiimsitcode = rs2(0)
	imsiimsicomname = rs2(1)
	rs2.close

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select pcode,pname,pprice,sum(rordernum) "
	SQL = sql & " from tb_order_product"
	SQL = sql & " where idx in "
	SQL = sql & " 	(select idx from tb_order "
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
	SQL = sql & "   and deflag = 'n' "
	SQL = sql & "   and substring(usercode,11,5)='"& rs(0) &"' "
	SQL = sql & "   and flag='y' and carname <> ''   "
	SQL = sql & "   and orderday >= '"& searcha &"' and orderday <= '"& searchb &"' ) "
	SQL = sql & " group by pcode,pname,pprice "
	SQL = sql & " order by pcode asc"
'response.write sql
	rs2.Open sql, db, 1
%>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#BDCBE7" bordercolordark="#FFFFFF" width="100%">
	<tr>
		<td nowrap bgcolor="#FFFFFF" height="25"> &nbsp; <B>[ <%=imsiimsicomname%> (<%=imsiimsitcode%>)]</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>상품코드</td>
		<td width=25%>상품명</td>
		<td width=15%>규격</td>
		<td width=15%>단가</td>
		<td width=10%>배달수량</td>
		<td width=20%>금액</td>
	</tr>

	<%
	imsihap=0
	tphap=0
	tshap=0
	ttphap=0
	do until rs2.EOF

		rs2_pcode = rs2(0)
		rs2_pname = rs2(1)
		rs2_pprice = rs2(2)
		rs2_rordernum = rs2(3)
		imsihap = int(rs2_pprice)*int(rs2_rordernum)

		tphap=tphap+rs2_pprice
		tshap=tshap+rs2_rordernum
		ttphap=ttphap+imsihap

		set rs22 = server.CreateObject("ADODB.Recordset")
		SQL = " select ptitle "
		SQL = sql & " from tb_product "
		SQL = sql & " where pcode = '"& rs2(0) &"' "
		SQL = sql & " and usercode = '"& left(session("Ausercode"),5) &"' "
		rs22.Open sql, db, 1
		if not rs22.eof then
			imsidcarname = rs22(0)
		end if
		rs22.close

	%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs2_pcode%></td>
		<td align=left> &nbsp; <%=rs2_pname%></td>
		<td><%=imsidcarname%></td>
		<td align=right><%=FormatCurrency(rs2_pprice,0)%> &nbsp; </td>
		<td><%=rs2_rordernum%></td>
		<td align=right><%=FormatCurrency(imsihap,0)%> &nbsp; </td>
	</tr>

	<%
	rs2.MoveNext
	loop
	rs2.close
	%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td colspan=3>합계</td>
		<td align=right><%=FormatCurrency(tphap,0)%> &nbsp; </td>
		<td><%=tshap%></td>
		<td align=right><%=FormatCurrency(ttphap,0)%> &nbsp; </td>
	</tr>
</table>

<%
rs.MoveNext 
loop
rs.close
%>












<%
else

		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select carname,count(comname2),sum(rordermoney) "
		SQL = sql & " from tb_order "
		SQL = sql & " where flag = 'y' and deflag = 'n' and carname <> ''"

		if session("Ausergubun")="3" then
			SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if

		SQL = sql & " and orderday >= '"& searcha &"' "
		SQL = sql & " and orderday <= '"& searchb &"' "

		if searchc <> "0" then
			SQL = sql & " and carname = '"& searchc &"' "
		end if

		SQL = sql & " group by carname "
		SQL = sql & " order by carname asc"
response.write sql

		rs.Open sql, db, 1
%>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rs.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right>
			<%if imsiagencycheck2="y" then%><input type="button" name="검 색" value="체인점별집계2" class="box_work"' onclick="javascript:location.href='excell2.asp?<%=linksql%>';"><%end if%>
		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>번호</td>
		<td width=10%>호차</td>
		<td width=15%>기사명</td>
		<td width=25%>주문일자</td>
		<td width=20%>배달체인점수</td>
		<td width=20%>수금금액</td>
	</tr>

<%
i=1
do until rs.EOF

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarname "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and dcarno = '"& rs(0) &"' "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsidcarname = rs2(0)
	end if
	rs2.close
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><a href="write.asp?gotopage=<%=gotopage%>&sumoney=<%=rs(2)%>&searcha=<%=searcha%>&searchd=<%=searchd%>&searchb=<%=searchb%>&searchc=<%=searchc%>&carname=<%=rs(0)%>"><B><%=rs(0)%>호차</a></td>
		<td><%=imsidcarname%></td>
		<td><%=imsiday1%> ~ <%=imsiday2%></td>
		<td><%=rs(1)%></td>
		<td align=right><%=FormatCurrency(rs(2))%> &nbsp; </td>
	</tr>

</form>

<%
rs.MoveNext 
i=i+1
loop 
%>

</table>

<%end if%>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>
<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->