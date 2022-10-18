<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")

	'if searchc="" then
	'	searchc = "0"
	'end if
	if searchf="" then
		searchf = "0"
	end if
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	fclass1 = Request("fclass1")
	sclass2 = Request("sclass2")
	tclass3 = Request("tclass3")
	imsifclass1 = right(Request("fclass1"),5)
	imsisclass2 = right(Request("sclass2"),5)
	imsitclass3 = right(Request("tclass3"),5)

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select a.idx,a.usercode,a.userid,a.userpwd,a.username,a.alevel,b.comname,b.tcode,a.dcenteridx "
	SQL = sql & " from tb_adminuser a, tb_company b"

	if session("Ausergubun")="1" then	'슈퍼유저가 본사만봄
		SQL = sql & " where a.usercode=b.idx "
		SQL = sql & " and a.flag='2' "
		SQL = sql & " and b.flag='1' "

		if searchc<>"" then
			SQL = sql & " and b.serviceflag = '"& searchc &"' "
		end if

	elseif session("Ausergubun")="2" then	'본사가 지사만봄
		SQL = sql & " where substring(a.usercode,1,5)=convert(varchar,b.bidxsub) "
		SQL = sql & " and substring(a.usercode,6,5)=convert(varchar,b.idx) "
		SQL = sql & " and a.flag='3' and b.flag='2' "
		SQL = sql & " and substring(a.usercode,1,5) = '"& session("Ausercode") &"' "
	elseif session("Ausergubun")="3" then	'지사가 체인점만봄
		SQL = sql & " where substring(a.usercode,1,5)=convert(varchar,b.bidxsub) "
		SQL = sql & " and substring(a.usercode,6,5)=convert(varchar,b.idxsub) "
		SQL = sql & " and substring(a.usercode,11,5)=convert(varchar,b.idx) "
		SQL = sql & " and a.flag='4' and b.flag='3' "
		SQL = sql & " and substring(a.usercode,1,10) = '"& session("Ausercode") &"' "
	end if

	'if searcha <> "" then
	'	SQL = sql & " and "& searcha &" like '"& searchb &"%' "
	'end if

	if searcha <> "" then
		if searcha = "a.usercode" then
			SQL = sql & " and b.tcode like '"& searchb &"%' "
		else
			SQL = sql & " and "& searcha &" like '%"& searchb &"%' "
		end if
	end if





	SQL = sql & " order by a.wdate desc"
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,comname from tb_company where flag='1' order by comname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		bonsaarray = rs.GetRows
		bonsaarrayint = ubound(bonsaarray,2)
	else
		bonsaarray = ""
		bonsaarrayint = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
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
%>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td> &nbsp; <font color=blue size=3><B>[ 아이디 관리 ]</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="ulist.asp" method="POST" name=kindform>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>사용자정보 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="searcha" size="1" class="box_work">
          		<option value="">전체리스트</option>
		<%if session("Ausergubun")<>"3" then%>
          		<option value="a.usercode" <%if searcha = "a.usercode" then%>selected<%end if%>><%if session("Ausergubun")="1" then%>회원사코드<%elseif session("Ausergubun")="2" then%>지사(점)코드<%end if%></option>
		<%end if%>
		<%if session("Ausergubun")<>"3" then%>
          		<option value="b.comname" <%if searcha = "b.comname" then%>selected<%end if%>><%if session("Ausergubun")="1" then%>회원사명<%elseif session("Ausergubun")="2" then%>지사(점)명<%end if%></option>
		<%end if%>
          		<option value="a.username" <%if searcha = "a.username" then%>selected<%end if%>>담당자</option>
          		<option value="a.userid" <%if searcha = "a.userid" then%>selected<%end if%>>아이디</option>
        	</select>

	<%if session("Ausergubun")="1" then%>
		<select name="searchc" size="1" class="box_work">
          		<option value="">전체</option>
          		<option value="1" <%if searchc = "1" then%>selected<%end if%>>등록</option>
          		<option value="2" <%if searchc = "2" then%>selected<%end if%>>제공</option>
          		<option value="3" <%if searchc = "3" then%>selected<%end if%>>보류</option>
          		<option value="4" <%if searchc = "4" then%>selected<%end if%>>해지</option>
        	</select>
	<%end if%>

        	<input type="Text" name="searchb" size="20" maxlength="20" class="box_work" value="<%=searchb%>">
        	<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:kindsearchok(this.form);">
		<a href="ulistexcell.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>"><img src="/images/admin/excel.gif" border=0></a>
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right><a href="uwrite.asp?flag=<%=flag%>"><img src="/images/admin/l_bu12.gif" border=0></a></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=10%><%if session("Ausergubun")="1" then%>회원사<%elseif session("Ausergubun")="2" then%>지사(점)<%elseif session("Ausergubun")="3" then%>체인점<%end if%>코드</td>
		<td width=20%><%if session("Ausergubun")="1" then%>회원사명<%elseif session("Ausergubun")="2" then%>지사(점)명<%elseif session("Ausergubun")="3" then%>체인점명<%end if%></td>
		<td width=15%>물류센터명</td>
		<td width=15%>성명</td>
		<td width=10%>아이디</td>
		<td width=10%>비밀번호</td>
		<td width=7%>ROOT</td>
		<td width=8%>로그인</td>
	</tr>

<script language="JavaScript">
<!--
function frmget(mid,mpwd){
	form.mid.value=mid;
	form.mpwd.value=mpwd;
	form.action="/adminpage/loginok.asp";
	//form.target="_blank";
	form.submit() ;
}
//-->
</script>

<form name=form method=post>
<input type=hidden name=mid>
<input type=hidden name=mpwd>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	choiceDcenter = rslist("dcenteridx")
	if choiceDcenter="0" or choiceDcenter="" or isnull(choiceDcenter) or choiceDcenter = "10000" then
		choiceDcenter = ""
	else
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bname from tb_company_dcenter where bidx = "& choiceDcenter
		rs.Open sql, db, 1
		if not rs.eof then
			imsichoiceDcenter = rs(0)
		else
			imsichoiceDcenter = ""
		end if
		rs.close
		choiceDcenter = imsichoiceDcenter
	end if


%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("tcode")%></td>
		<td align=left>&nbsp;<%=rslist("comname")%></td>
		<td align=left>&nbsp;<%=choiceDcenter%></td>
		<td align=left>&nbsp;<a href="uwrite.asp?gotopage=<%=gotopage%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>&flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>"><b><%=rslist("username")%></a></td>
		<td><%=rslist("userid")%></td>
		<td><%=rslist("userpwd")%></td>
		<td><%=rslist("alevel")%></td>
		<td><a href="#" onclick="frmget('<%=rslist("userid")%>','<%=rslist("userpwd")%>')"><img src="/adminpage/images/22login.gif" border=0></td>
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

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="ulist.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">첫페이지</a>&nbsp;
				<a href="ulist.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="ulist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="ulist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">다음 10개</a>
				&nbsp;<a href="ulist.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">마지막</a>
		<% 	End If %>

		</td>
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