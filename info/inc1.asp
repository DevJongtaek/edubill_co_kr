<%
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select a.*, b.username, c.dname "
	SQL = sql & " from tb_company a, tb_adminuser b, tb_dealer c"
	SQL = sql & " where convert(varchar,a.idx) = b.usercode "
	SQL = sql & " and a.dcode = c.dcode "
	SQL = sql & " and a.flag='1' and a.serviceflag='2' "

	if searcha<>"" then
		SQL = sql & " and a.dcode = '"& searcha &"' "
	end if
	if searchb<>"" then
		SQL = sql & " and a.comname like '%"& searchb &"%' "
	end if
	if searchc<>"" then
		SQL = sql & " and b.username like '%"& searchc &"%' "
	end if

	SQL = sql & " order by a.comname asc"
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if
%>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%" valign=top>

<script language="JavaScript">
<!--
function searchchok(form) {
	form.submit() ;
	return false ;
}
//-->
</script>
<form action="list.asp" method="POST" name=form>
<input type=hidden name="pagegubun" value="<%=pagegubun%>">

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> 정보검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		관리자 : <select name="searcha" size="1" class="box_work">
			 	<option value="">전체</option>
				<%if dealerarry_int<>"" then%>
					<%for i=0 to dealerarry_int%>
						<option value="<%=dealerarry(0,i)%>" <%if searcha=dealerarry(0,i) then%>selected<%end if%>><%=dealerarry(1,i)%>
					<%next%>
				<%end if%>
			 </select>
		회사명 :   <input type="Text" name="searchb" size="20" class="box_work" value="<%=searchb%>">
		프렌차이즈명 : <input type="Text" name="searchc" size="20" class="box_work" value="<%=searchc%>">
        	<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:searchchok(this.form);">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right>
			<a href="excel1.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchf=<%=searchf%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>"><img src="/images/admin/excel.gif" border=0></a>
		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>번호</td>
		<td width=20%>회사명</td>
		<td width=20%>프렌차이즈명</td>
		<td width=20%>관리자</td>
		<td width=30%>소재지</td>
	</tr>

<%
i=1
'j=(gotopage*10)-9
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
	addrarray = rslist("addr")
	if addrarray<>"" then
		addrarray = split(addrarray," ")
		addrarrayint = ubound(addrarray)
		if addrarrayint >= 1 then
			imsiaddrname1 = addrarray(0)
			imsiaddrname2 = addrarray(1)
			imsiaddrname = imsiaddrname1 &" "&imsiaddrname2
			if right(replace(imsiaddrname2," ",""),1)="시" then
				if addrarrayint >= 2 then
					imsiaddrname3 = addrarray(2)
					imsiaddrname = imsiaddrname &" "&imsiaddrname3
				end if
			end if
		end if
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("comname")%></td>
		<td><%=rslist("username")%></td>
		<td><%=rslist("dname")%></td>
		<td align=left>&nbsp;<%=imsiaddrname%></td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 
%>

</form>

</table>