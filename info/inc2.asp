<%
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tb_info"

	if searcha<>"" then
		SQL = sql & " where dname = '"& searcha &"' "
	end if

	SQL = sql & " order by idx desc"
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

function searchchok2(form) {
	if (form.dname.value=="") {
		alert("관리자를 선택하여 주시기바랍니다.") ;
		form.dname.focus() ;
		return false ;
	}
	if (form.comname.value=="") {
		alert("회사명을 입력하여 주시기바랍니다.") ;
		form.comname.focus() ;
		return false ;
	}
	if (form.fname.value=="") {
		alert("프렌차이즈명을 입력하여 주시기바랍니다.") ;
		form.fname.focus() ;
		return false ;
	}
	if (form.addr.value=="") {
		alert("소재지를 입력하여 주시기바랍니다.") ;
		form.addr.focus() ;
		return false ;
	}
	if (form.pwd.value=="") {
		alert("비밀번호를 입력하여 주시기바랍니다.") ;
		form.pwd.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
}

function delpwd(val1,val2){
	window.open ('delpwd.asp?idx='+val1+'&pagegubun='+val2,'CheckID','top=100,left=100,width=250,height=40')
	return false ;
}
//-->
</script>

<form action="listok.asp" method="POST" name=form>
<input type=hidden name="pagegubun" value="<%=pagegubun%>">
<input type=hidden name="regnum" value="<%=regnum%>">

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> 정보등록</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		관리자 : <select name="dname" size="1" class="box_work">
			 	<option value="">전체</option>
				<%if dealerarry_int<>"" then%>
					<%for i=0 to dealerarry_int%>
						<option value="<%=dealerarry(1,i)%>"><%=dealerarry(1,i)%>
					<%next%>
				<%end if%>
			 </select>
		회사명 :   <input type="Text" name="comname" size="20" class="box_work">
		프렌차이즈명 : <input type="Text" name="fname" size="20" class="box_work">
		<BR>
		소재지 :   <input type="Text" name="addr" size="30" class="box_work">
		비밀번호 :   <input type="Text" name="pwd" size="5" maxlength=4 class="box_work">
		* 관리자별 등록건수 제한: <%=regnum%>건 &nbsp;
	        	<input type="button" value="등 록" class="box_work"' onclick="javascript:searchchok2(this.form);">
		</td>
	</tr>

</form>

<form action="list.asp" method="POST" name=form>
<input type=hidden name="pagegubun" value="<%=pagegubun%>">

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> 정보검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		관리자 : <select name="searcha" size="1" class="box_work">
			 	<option value="">전체</option>
				<%if dealerarry_int<>"" then%>
					<%for i=0 to dealerarry_int%>
						<option value="<%=dealerarry(1,i)%>" <%if searcha=dealerarry(1,i) then%>selected<%end if%>><%=dealerarry(1,i)%>
					<%next%>
				<%end if%>
			 </select>
	        	<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:searchchok(this.form);">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right>
			<a href="excel2.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchf=<%=searchf%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>"><img src="/images/admin/excel.gif" border=0></a>
		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=6%>번호</td>
		<td width=20%>회사명</td>
		<td width=20%>프렌차이즈명</td>
		<td width=12%>관리자</td>
		<td width=24%>소재지</td>
		<td width=13%>등록일자</td>
		<td width=5%>삭제</td>
	</tr>

<%
i=1
'j=(gotopage*10)-9
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("comname")%></td>
		<td><%=rslist("fname")%></td>
		<td><%=rslist("dname")%></td>
		<td align=left>&nbsp;<%=rslist("addr")%></td>
		<td><%=replace(left(rslist("wdate"),10),"-","/")%></td>
		<td><a href="del.asp?idx=<%=rslist("idx")%>&pagegubun=<%=pagegubun%>" onClick="return delpwd('<%=rslist("idx")%>','<%=pagegubun%>')">삭제</a></td>
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