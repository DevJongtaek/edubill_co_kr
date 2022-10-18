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
	flag = request("flag")
	imsititlename = "브랜드"

	if searchc="" then
		searchc = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if
	if searchg="" then
		searchg = "0"
	end if
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	'if session("Ausergubun")="2" then
	'	searchc = session("Ausercode")
	'end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,tcode,flag,idxsub,comname,name,post,addr,addr2,companynum1,companynum2,companynum3,uptae,upjong,tel1,tel2,tel3,fax1,fax2,fax3,hp1,hp2,hp3,dcarno,startday "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '"& flag &"' "

	if session("Ausergubun")="2" then	'본사로그인
		if flag="1" then		'본사리스트
			SQL = sql & " and idx = "& int(left(session("Ausercode"),5)) &" "
		elseif flag="2" then		'지사리스트
			SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
		elseif flag="3" then		'체인점리스트
			SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
		end if
	elseif session("Ausergubun")="3" then	'지사
		if flag="2" then		'지사리스트
			SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
		elseif flag="3" then		'체인점리스트
			SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
			SQL = sql & " and idxsub = "& int(mid(session("Ausercode"),6,5)) &" "
		end if
	elseif session("Ausergubun")="4" then	'체인점
		SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
		SQL = sql & " and idxsub = "& int(mid(session("Ausercode"),6,5)) &" "
	end if

	if searcha <> "" then
		SQL = sql & " and "& searcha &" like '"& searchb &"%' "
	end if

	if searchc <> "0" and searchc <> "" then
		SQL = sql & " and idxsub = "& searchc &" "
	end if

	if searchd <> "" then
		SQL = sql & " and startday >= "& int(searchd) &" "
	end if

	if searche <> "" then
		SQL = sql & " and startday <= "& int(searche) &" "
	end if

	if searchf <> "0" then
		SQL = sql & " and idxsub = "& int(searchf) &" "
	end if

	if searchg <> "0" then
		SQL = sql & " and dcarno = "& int(searchg) &" "
	end if

	if session("Ausergubun")="1" then
		SQL = sql & " order by wdate desc"
	else
		SQL = sql & " order by tcode desc"
	end if

	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if

	if flag="3" then
		'지사(점)
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,comname from tb_company where flag='2' and bidxsub = "& left(session("Ausercode"),5) &" order by comname asc"
		rs.Open sql, db, 1
		if not rs.eof then
			jisaarray = rs.GetRows
			jisaarrayint = ubound(jisaarray,2)
		else
			jisaarray = ""
			jisaarrayint = ""
		end if
		rs.close
		if searchc="" then
			searchc = "0"
		end if
	end if

	'호차
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
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td> &nbsp; <font color=blue size=3><B>[ <%=imsititlename%> 관리 ]</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>
					<!--#include virtual="/adminpage/code/inc/blinc1.asp"-->
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width=800>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="blist.asp?GotoPage=1&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>">첫페이지</a>&nbsp;
				<a href="blist.asp?GotoPage=<%=blockPage-10%>&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="blist.asp?GotoPage=<%=blockPage%>&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="blist.asp?GotoPage=<%=blockPage%>&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>">다음 10개</a>
				&nbsp;<a href="blist.asp?GotoPage=<%=rslist.pagecount%>&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>">마지막</a>
		<% 	End If %>

		</td>
	</tr>
</table>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->