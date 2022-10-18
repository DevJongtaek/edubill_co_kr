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
	SQL = " select a.carname, a.usercode, isnull(a.sumrordermoney,0),b.idx, b.tcode,b.comname, isnull(c.imsiordermoney1,0) as imsiordermoney1,isnull(d.imsiordermoney2,0) as imsiordermoney2 "
	SQL = sql & " from  "
	SQL = sql & " 	( select carname as carname, usercode as usercode, isnull(sum(rordermoney),0) as sumrordermoney "
	SQL = sql & " 	from tb_order "
	SQL = sql & " 	where flag='y'  "
       sql = sql & " AND ISNULL(Rgubun,0) != 1 "
			if session("Ausergubun")="3" then 
				SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			else
				SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			end if
	SQL = sql & " 	and orderday >= '"& searcha &"' and orderday <= '"& searchd &"' " 
	SQL = sql & " 	group by carname,usercode) a "

	SQL = sql & " left outer join  "
	SQL = sql & " 	(select idx, tcode as tcode, comname as comname from tb_company where flag = '3') b "
	SQL = sql & " on b.idx = substring(a.usercode,11,5) "

	SQL = sql & " left outer join  "
	SQL = sql & " 	(select aa.usercode,isnull(sum(cc.rordernum*cc.pprice),0) as imsiordermoney1 "
	SQL = sql & " 	from tb_order aa, tb_product bb , tb_order_product cc "
	SQL = sql & " 	where aa.idx=cc.idx and cc.pcodeidx=bb.idx "
       sql = sql & " AND ISNULL(aa.Rgubun,0) != 1 "
	SQL = sql & " 	and bb.gubun='과세' "
	SQL = sql & " 	and aa.orderday >= '"& searcha &"' and aa.orderday <= '"& searchd &"' and aa.flag = 'y' "
	SQL = sql & " 	group by aa.usercode) c "
	SQL = sql & " on a.usercode=c.usercode  "
			if session("Ausergubun")="3" then
				SQL = sql & " and substring(c.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			else
				SQL = sql & " and substring(c.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			end if

	SQL = sql & " left outer join  "
	SQL = sql & " 	(select aa.usercode,isnull(sum(cc.rordernum*cc.pprice),0) as imsiordermoney2 "
	SQL = sql & " 	from tb_order aa, tb_product bb , tb_order_product cc "
	SQL = sql & " 	where aa.idx=cc.idx and cc.pcodeidx=bb.idx "
	SQL = sql & " 	and bb.gubun='비과세' "
       sql = sql & " AND ISNULL(aa.Rgubun,0) != 1 "
	SQL = sql & " 	and aa.orderday >= '"& searcha &"' and aa.orderday <= '"& searchd &"' and aa.flag = 'y' "
	SQL = sql & " 	group by aa.usercode) d "
	SQL = sql & " on a.usercode=d.usercode  "
			if session("Ausergubun")="3" then 
				SQL = sql & " and substring(d.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			else
				SQL = sql & " and substring(d.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			end if
	SQL = sql & " order by b.comname asc"
'response.write sql
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
	        	  			<option value="<%=hcararray(1,i)%>" <%if searchb=hcararray(1,i) then%>selected<%end if%>><%=hcararray(1,i)%>호차
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
		<td width=30% align=right><a href="excell.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>"><img src="/images/admin/excel.gif" border=0 alt="매출집계표"></a> <a href="excell1.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>"><img src="/images/admin/excel.gif" border=0 alt="매출집계표(지사 합계)"></a></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=15%>체인점코드</td>
		<td width=15%>체인점명</td>
		<td width=20%>거래기간</td>
		<td width=15%>공급가액</td>
		<td width=15%>세액</td>
		<td width=15%>합계금액</td>
	</tr>

<form name=form2 method=post>

<%
i=1
do until rs.EOF
	imsirs2tcode=""
	imsimoney = 0
	imsimoney_vat = 0
	imsimoney_hap = 0

'	a.carname, a.usercode, isnull(a.sumrordermoney,0),b.idx, b.tcode,b.comname, isnull(c.imsiordermoney1,0),isnull(d.imsiordermoney2,0)

	imsirs2tcode     = rs("tcode")
	imsirordermoney1 = CDbl(rs("imsiordermoney1"))
	imsirordermoney2 = CDbl(rs("imsiordermoney2"))

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
	elseif vatflag="n" then	'별도
		imsirordermoney = imsirordermoney1+imsirordermoney2
		imsirordermoney_vat = round(imsirordermoney1*0.1,0)
		imsirordermoney_hap = imsirordermoney+imsirordermoney_vat
	elseif vatflag="a" then	'비과세
		imsirordermoney = imsirordermoney1+imsirordermoney2
		imsirordermoney_vat = 0
		imsirordermoney_hap = imsirordermoney+imsirordermoney_vat
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><%=imsirs2tcode%></td>
		<td><%=rs("comname")%></td>
		<td><%=left(searcha,4)%>/<%=mid(searcha,5,2)%>/<%=right(searcha,2)%>~<%=left(searchd,4)%>/<%=mid(searchd,5,2)%>/<%=right(searchd,2)%></td>
		<td align=right><%=FormatCurrency(imsirordermoney,0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(imsirordermoney_vat,0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(imsirordermoney_hap,0)%> &nbsp; </td>
	</tr>

<%
	imsihap1 = imsihap1+imsirordermoney
	imsihap2 = imsihap2+imsirordermoney_vat
	imsihap3 = imsihap3+imsirordermoney_hap


rs.MoveNext 
i=i+1
loop 
%>

</form>

	<tr height=28 bgcolor=#F7F7FF align=center>
		<td colspan=4>합 계</td>
		<td align=right> <%=FormatCurrency(imsihap1,0)%> &nbsp; </td>
		<td align=right> <%=FormatCurrency(imsihap2,0)%> &nbsp; </td>
		<td align=right> <%=FormatCurrency(imsihap3,0)%> &nbsp; </td>
	</tr>

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