<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=IDlist.xls"
%>

<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
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
	SQL = " select a.idx,a.usercode,a.userid,a.userpwd,a.username,a.alevel,b.comname,b.tcode,a.dcenteridx,b.dcode "
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

	if searcha <> "" then
		if searcha = "a.usercode" then
			SQL = sql & " and b.tcode like '"& searchb &"%' "
		else
			SQL = sql & " and "& searcha &" like '%"& searchb &"%' "
		end if
	end if

	SQL = sql & " order by a.wdate desc"
	rslist.Open sql, db, 1

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




<table border=1>
	<tr height=28 align=center>
		<td>번호</td>
		<td><%if session("Ausergubun")="1" then%>회원사<%elseif session("Ausergubun")="2" then%>지사(점)<%elseif session("Ausergubun")="3" then%>체인점<%end if%>코드</td>
		<td><%if session("Ausergubun")="1" then%>회원사명<%elseif session("Ausergubun")="2" then%>지사(점)명<%elseif session("Ausergubun")="3" then%>체인점명<%end if%></td>
		<td>성명</td>
		<td>아이디</td>
		<td>비밀번호</td>
		<td>ROOT</td>
		<td>담당자</td>
	</tr>

<%
i=1
do until rslist.EOF

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dname from tb_dealer where dcode = '"& rslist("dcode") &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		dname = rs(0)
	else
		dname = ""
	end if
	rs.close
%>

	<tr height=25 align=center>
		<td><%=i%></td>
		<td><%=rslist("tcode")%></td>
		<td align=left><%=rslist("comname")%></td>
		<td align=left><b><%=rslist("username")%></td>
		<td><%=rslist("userid")%></td>
		<td><%=rslist("userpwd")%></td>
		<td><%=rslist("alevel")%></td>
		<td><%=dname%></td>
	</tr>

<%
rslist.MoveNext 
i=i+1
loop 
%>

</table>

<%
	db.close
	set db=nothing
%>

