<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	if searchc="y" then
		imsititle = "배달"
	elseif searchc="n" then
		imsititle = "주문"
	elseif searchc="" then
		imsititle = "주문/배달"
	end if

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	if searcha="" then
		searcha = replace(left(now()-1,10),"-","")
	end if

	if searchb="" then
		searchb = replace(left(now(),10),"-","")
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select pcode,pname,sum(ordernum)"
	SQL = sql & " from tb_order_product "
	SQL = sql & " where idx in "

	SQL = sql & " 	( "
	SQL = sql & " 	select idx from tb_order where deflag='n' "
	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
 	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	if (searcha<>"") and (len(searcha)=8) then
		SQL = sql & " and orderday >= '"& searcha &"' "
	end if
	if (searchb<>"") and (len(searchb)=8) then
		SQL = sql & " and orderday <= '"& searchb &"' "
	end if
	SQL = sql & " 	) "

	SQL = sql & " group by pcode,pname "
	SQL = sql & " order by pcode asc "
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
		<td><font color=blue size=3><B>[ 상품별 집계표 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="tlist.asp" method="POST" name=kindform>
	<tr>
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25" align=center><B>주문일자</td>
		<td nowrap width="70%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searcha" size="8" maxlength="8" class="box_work" value="<%=searcha%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searchb" size="8" maxlength="8" class="box_work" value="<%=searchb%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="오늘" value="오늘" class="box_work"' onclick="javascript:serchtodaycheck(document.kindform.searcha, document.kindform.searchb);">
		</td>
<!--
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>구 분</td>
		<td nowrap width="25%" bgcolor="#FFFFFF" height="25">
			<select name=searchc>
				<option value="" <%if searchc="" then%>selected<%end if%>>주문/배달
				<option value="n" <%if searchc="n" then%>selected<%end if%>>주문상태
				<option value="y" <%if searchc="y" then%>selected<%end if%>>주문확인
			</select>
		</td>
-->
		<td nowrap width="15%">
			<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="초기화" value="초기화" class="box_work"' onclick="javascript:frmzerocheck(this.form,'tlist.asp?flag=2');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rs.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right><a href="excell4.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&gotopage=<%=gotopage%>"><img src="/images/admin/excel.gif" border=0></a></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>번호</td>
		<td width=10%>상품코드</td>
		<td width=35%>상품명</td>
		<td width=15%>규격</td>
		<td width=15%>주문상태</td>
		<td width=15%>주문확인</td>
	</tr>

<%
i=1
do until rs.EOF

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select ptitle "
	SQL = sql & " from tb_product "
	SQL = sql & " where pcode = '"& rs(0) &"' "
	SQL = sql & " and usercode = '"& left(session("Ausercode"),5) &"' "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsidcarname = rs2(0)
	end if
	rs2.close

	set rs3 = server.CreateObject("ADODB.Recordset")
	SQL = " select sum(rordernum)"
	SQL = sql & " from tb_order_product "
	SQL = sql & " where pcode = '"& rs(0) &"' "
	SQL = sql & " and idx in "

	SQL = sql & " 	( "
	SQL = sql & " select idx from tb_order where deflag='n' and flag='y' "
	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
 	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	if (searcha<>"") and (len(searcha)=8) then
		SQL = sql & " and orderday >= '"& searcha &"' "
	end if
	if (searchb<>"") and (len(searchb)=8) then
		SQL = sql & " and orderday <= '"& searchb &"' "
	end if
	SQL = sql & " 	) "
	rs3.Open sql, db, 1
	imsiimsirordernum=rs3(0)
	rs3.close
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><%=rs(0)%></td>
		<td><%=rs(1)%></td>
		<td><%=imsidcarname%></td>
		<td align=right><%=rs(2)%> &nbsp; </td>
		<td align=right><%=imsiimsirordernum%> &nbsp; </td>
	</tr>

</form>

<%
rs.MoveNext 
i=i+1
loop 
%>

</table>

<BR>
<center><a href="#" onclick="javascript:pwinnew();"><img src="/images/admin/l_bu15.gif" alt="인쇄" border=0></a>
<script language="JavaScript">
<!--
function pwinnew(){
	window.open("newwin.asp?gotopage=<%=request("gotopage")%>&searcha=<%=request("searcha")%>&searchb=<%=request("searchb")%>&searchc=<%=request("searchc")%>&searchd=<%=request("searchd")%>&carname=<%=request("carname")%>","AutoAddr","toolbar=no,menubar=no,scrollbars=1,resizable=no,width=670,height=700");
}
//-->
</script>

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