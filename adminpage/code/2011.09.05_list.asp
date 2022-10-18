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
	searchh = request("searchh")
	searchi = request("searchi")

	flag = request("flag")
	if flag="1" then
		imsititlename = "회원사"
	elseif flag="2" then
		imsititlename = "지사(점)"
	elseif flag="3" then
		imsititlename = "체인점"
	end if

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

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select bidx,bname from tb_company_brand "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" order by bname asc "
	rs.Open sql, db, 1
	if not rs.eof then
		brand_array    = rs.GetRows
		brand_arraynum = ubound(brand_array,2)
	else
		brand_array    = ""
		brand_arraynum = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag,cyberNum,misubtn from tb_company where idx = "& int(left(session("Ausercode"),5)) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsimyflag = rs(0)
		cyberNum = rs(1)
		misubtn  = rs(2)
	else
		imsimyflag = ""
		cyberNum = ""
		misubtn  = ""
	end if
	rs.close

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,tcode,flag,idxsub,comname,name,post,addr,addr2,companynum1,companynum2,companynum3, "
	SQL = sql & " uptae,upjong,tel1,tel2,tel3,fax1,fax2,fax3,hp1,hp2,hp3,dcarno,startday,cbrandchoice,usemoney, "
	SQL = sql & " mi_money,ye_money,isnull(ch_gongi,'') as ch_gongi,serviceflag,orderflag,orderflag,order_weekgubun, "
	SQL = sql & " com_notice,order_weekchoice,choiceDcenter "
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
		if searcha = "sdname" then
			SQL = sql & " and idx in (select usercode from tb_adminuser where flag='2' and username like '%"& searchb &"%' ) "
		elseif searcha = "userid" then
			SQL = sql & " and idx in (select usercode from tb_adminuser where flag='2' and userid = '"& searchb &"' ) "
		else
			SQL = sql & " and "& searcha &" like '%"& searchb &"%' "
		end if
	end if

	if session("Ausergubun")="1" then
		if searchc <> "0" and searchc <> "" then
			SQL = sql & " and serviceflag = '"& searchc &"' "
		end if
	else
		if searchc <> "0" and searchc <> "" then
			SQL = sql & " and idxsub = "& searchc &" "
		end if
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

	if searchh <> "" then
		SQL = sql & " and cbrandchoice = '"& searchh &"' "
	end if

	if flag="3" then
		if searchi = "1" then		'정상
			if imsimyflag = "y" then
				SQL = sql & " and (mi_money <= ye_money and (orderflag='y')) "
			else
				SQL = sql & " and (orderflag='y') "
			end if
		elseif searchi = "2" then	'경고
			SQL = sql & " and (orderflag='4' or orderflag='5') "
		elseif searchi = "3" then	'정지
			if imsimyflag = "y" then
				SQL = sql & " and ((orderflag='y' and mi_money > ye_money) or (orderflag='1' or orderflag='2' or orderflag='3')) "
			else
				SQL = sql & " and ((orderflag='1' or orderflag='2' or orderflag='3')) "
			end if
		end if
	end if

	if session("Ausergubun")="1" then
		SQL = sql & " order by wdate desc"
	else
		SQL = sql & " order by tcode desc"
	end if
'response.write sql
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
					<%if flag="1" then%>
						<!--#include virtual="/adminpage/code/inc/linc1.asp"-->
					<%elseif flag="2" then%>
						<!--#include virtual="/adminpage/code/inc/linc2.asp"-->
					<%elseif flag="3" then%>
						<!--#include virtual="/adminpage/code/inc/linc3.asp"-->
					<%end if%>


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
				<a href="list.asp?GotoPage=1&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>">첫페이지</a>&nbsp;
				<a href="list.asp?GotoPage=<%=blockPage-10%>&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="list.asp?GotoPage=<%=blockPage%>&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="list.asp?GotoPage=<%=blockPage%>&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>">다음 10개</a>
				&nbsp;<a href="list.asp?GotoPage=<%=rslist.pagecount%>&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>">마지막</a>
		<% 	End If %>

		</td>
	</tr>
</table>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->