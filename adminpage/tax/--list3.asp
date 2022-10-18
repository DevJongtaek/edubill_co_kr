<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
'Server.ScriptTimeOut = 1000000

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

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select vatflag,isnull(maechulflag,'') as maechulflag "
	SQL = SQL & " from tb_company where idx = "& left(session("Ausercode"),5) &" "
	rs2.Open sql, db, 1
	if not rs2.eof then
		vatflag = rs2(0)
		maechulflag = rs2(1)
	end if
	rs2.close

	if maechulflag="n" or maechulflag="" then
		response.write "<Script language=javascript>"
		response.write "	alert(""지금은 사용하실 수 없습니다. !!!"");"
		response.write "	history.go(-1);"
		response.write "</Script>"
		response.end
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
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

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname2,carname,usercode,sum(rordermoney) "
	SQL = sql & " from tb_order "
	SQL = sql & " where flag='y' "

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
	end if

	SQL = sql & " group by comname2,comname2,carname,usercode"
	SQL = sql & " order by usercode asc"
	rs.Open sql, db, 1

%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 매출집계표 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list3.asp" method="POST" name=kindform>
	<tr>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>주문일자</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searcha" size="8" maxlength="8" class="box_work" value="<%=searcha%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
		</td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>호차</td>
		<td nowrap width="15%" bgcolor="#FFFFFF" height="25">
			<select name="searchb" size="1" class="box_work">
				<%if hcararrayint<>"" then%>
	          			<option value="0" <%if searchb = "" then%>selected<%end if%>>호차전체</option>
					<%for i=0 to hcararrayint%>
	        	  			<option value="<%=hcararray(1,i)%>" <%if int(searchb)=int(hcararray(1,i)) then%>selected<%end if%>><%=hcararray(1,i)%>호차
					<%next%>
				<%else%>
	          			<option value="0" <%if searchb = "" then%>selected<%end if%>>호차등록없음</option>
				<%end if%>
        		</select>
		</td>

		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>구분</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25">
			<select name="searchc" size="1" class="box_work">
          			<option value="" <%if searchc = "" then%>selected<%end if%>>전체</option>
          			<option value="flag" <%if searchc = "flag" then%>selected<%end if%>>주문확인</option>
          			<option value="deflag" <%if searchc = "deflag" then%>selected<%end if%>>배달완료</option>
	       		</select>
		</td>

		<td nowrap width="15%" bgcolor="#FFFFFF" height="25">
	        	<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="초기화" value="초기화" class="box_work"' onclick="javascript:frmzerocheck(this.form,'list3.asp');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rs.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right><a href="excell.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>"><img src="/images/admin/excel.gif" border=0></a></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=15%>체인점코드</td>
		<td width=15%>체인점명</td>
		<td width=20%>거래기간</td>
		<td width=15%>거래금액</td>
		<td width=15%>부가세</td>
		<td width=15%>매출액</td>
	</tr>

<form name=form2 method=post>

<%
i=1
do until rs.EOF
	imsirs2tcode=""
	imsimoney = 0
	imsimoney_vat = 0
	imsimoney_hap = 0

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode"
	SQL = SQL & " from tb_company where idx = "& right(rs(2),5) &" "
	rs2.Open sql, db, 1
	imsirs2tcode = rs2(0)
	rs2.close

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select isnull(sum(a.rordernum*a.pprice),0) "
	SQL = sql & " from tb_order_product a, tb_product b"
	SQL = sql & " where a.pcodeidx = b.idx "
	SQL = sql & " and b.gubun = '과세' "
	SQL = sql & " and a.idx in ( "
		SQL = sql & " select idx "
		SQL = sql & " from tb_order "
		SQL = sql & " where comname2 = '"& rs(0) &"' "

		if session("Ausergubun")="3" then
			SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if

		SQL = sql & " and orderday >= '"& searcha &"' and orderday <= '"& searchd &"' "

		if searchb<>"0" then
			SQL = sql & " and carname = '"& searchb &"' "
		end if

		if searchc<>"" then
			if searchc="flag" then
				SQL = sql & " and flag = 'y' and deflag = 'n' "
			else
				SQL = sql & " and flag = 'y' and deflag = 'y' "
			end if
		else
			SQL = sql & " and flag = 'y' "
		end if
	SQL = sql & " ) "
	rs2.Open sql, db, 1
	imsirordermoney1 = rs2(0)
	rs2.close

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select isnull(sum(a.rordernum*a.pprice),0) "
	SQL = sql & " from tb_order_product a, tb_product b"
	SQL = sql & " where a.pcodeidx = b.idx "
	SQL = sql & " and b.gubun = '비과세' "
	SQL = sql & " and a.idx in ( "
		SQL = sql & " select idx "
		SQL = sql & " from tb_order "
		SQL = sql & " where comname2 = '"& rs(0) &"' "

		if session("Ausergubun")="3" then
			SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if

		SQL = sql & " and orderday >= '"& searcha &"' and orderday <= '"& searchd &"' "

		if searchb<>"0" then
			SQL = sql & " and carname = '"& searchb &"' "
		end if

		if searchc<>"" then
			if searchc="flag" then
				SQL = sql & " and flag = 'y' and deflag = 'n' "
			else
				SQL = sql & " and flag = 'y' and deflag = 'y' "
			end if
		else
			SQL = sql & " and flag = 'y' "
		end if
	SQL = sql & " ) "
	rs2.Open sql, db, 1
	imsirordermoney2 = rs2(0)
	rs2.close

'imsirordermoney1 = CDbl(imsirordermoney1)
'imsirordermoney2 = CDbl(imsirordermoney2)
'response.write imsirordermoney1 & "<BR>"
'response.write imsirordermoney2 & "<BR>"

	if vatflag="y" then	'포함
		'imsirordermoney = imsirordermoney1+imsirordermoney2	'포함가
		'imsirordermoney22 = round(imsirordermoney1*(100/110),0)
		'imsirordermoney_vat = imsirordermoney1-imsirordermoney22
		'imsirordermoney_hap = imsirordermoney+imsirordermoney_vat

		imsirordermoney22 = imsirordermoney1+imsirordermoney2	'포함가
		imsirordermoney = round(imsirordermoney1*(100/110),0)
		imsirordermoney_vat = imsirordermoney1-imsirordermoney
		imsirordermoney = imsirordermoney+imsirordermoney2
		imsirordermoney_hap = imsirordermoney+imsirordermoney_vat
	else			'별도
		imsirordermoney = imsirordermoney1+imsirordermoney2
		imsirordermoney_vat = round(imsirordermoney1*0.1,0)
		imsirordermoney_hap = imsirordermoney+imsirordermoney_vat
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><%=imsirs2tcode%></td>
		<td><%=rs(0)%></td>
		<td><%=left(searcha,4)%>/<%=mid(searcha,5,2)%>/<%=right(searcha,2)%>~<%=left(searchd,4)%>/<%=mid(searchd,5,2)%>/<%=right(searchd,2)%></td>
		<td align=right><%=FormatCurrency(imsirordermoney,0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(imsirordermoney_vat,0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(imsirordermoney_hap,0)%> &nbsp; </td>
	</tr>

<%
rs.MoveNext 
i=i+1
loop 
%>

</form>

</table>

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