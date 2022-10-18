<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=Sheet1.xls"
%>

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

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select C.idx,C.tcode,C.comname,C.name,D.dname,C.post,C.addr,C.addr2 "
	SQL = sql & " from tb_company C join tb_dealer D on C.dcode = D.dcode "
	SQL = sql & " where C.flag = '"& flag &"' "

	if session("Ausergubun")="2" then	'본사로그인
		if flag="1" then		'본사리스트
			SQL = sql & " and C.idx = "& int(left(session("Ausercode"),5)) &" "
		elseif flag="2" then		'지사리스트
			SQL = sql & " and C.bidxsub = "& int(left(session("Ausercode"),5)) &" "
		elseif flag="3" then		'체인점리스트
			SQL = sql & " and C.bidxsub = "& int(left(session("Ausercode"),5)) &" "
		end if
	elseif session("Ausergubun")="3" then	'지사
		if flag="2" then		'지사리스트
			SQL = sql & " and C.bidxsub = "& int(left(session("Ausercode"),5)) &" "
		elseif flag="3" then		'체인점리스트
			SQL = sql & " and C.bidxsub = "& int(left(session("Ausercode"),5)) &" "
			SQL = sql & " and C.idxsub = "& int(mid(session("Ausercode"),6,5)) &" "
		end if
	elseif session("Ausergubun")="4" then	'체인점
		SQL = sql & " and C.bidxsub = "& int(left(session("Ausercode"),5)) &" "
		SQL = sql & " and C.idxsub = "& int(mid(session("Ausercode"),6,5)) &" "
	end if

	if searcha <> "" then
		if searcha = "sdname" then
			SQL = sql & " and C.idx in (select usercode from tb_adminuser where flag='2' and username like '%"& searchb &"%' ) "
		elseif searcha = "userid" then
			SQL = sql & " and C.idx in (select usercode from tb_adminuser where flag='2' and userid = '"& searchb &"' ) "
		else
			SQL = sql & " and "& searcha &" like '"& searchb &"%' "
		end if
	end if

	if session("Ausergubun")="1" then
		if searchc <> "0" and searchc <> "" then
			SQL = sql & " and C.serviceflag = '"& searchc &"' "
		end if
	else
		if searchc <> "0" and searchc <> "" then
			SQL = sql & " and C.idxsub = "& searchc &" "
		end if
	end if

	'if searchc <> "0" and searchc <> "" then
	'	SQL = sql & " and idxsub = "& searchc &" "
	'end if

	if searchd <> "" then
		SQL = sql & " and C.startday >= "& int(searchd) &" "
	end if

	if searche <> "" then
		SQL = sql & " and C.startday <= "& int(searche) &" "
	end if

	if searchf <> "0" then
		SQL = sql & " and C.idxsub = "& int(searchf) &" "
	end if

	if searchg <> "0" then
		SQL = sql & " and C.dcarno = "& int(searchg) &" "
	end if

	if session("Ausergubun")="1" then
		SQL = sql & " order by C.wdate desc"
	else
		SQL = sql & " order by C.tcode desc"
	end if

	rslist.Open sql, db, 1
		
%>

<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<style type="text/css">
<!--
td.accountnum
{mso-number-format:\@}
-->
</STYLE>
</head>

<table border="1">
	<tr height=28 align=center>
		<td>번호</td>
		<td>회원사코드</td>
		<td>회원사명</td>
		<td>대표자</td>
		<td>담당자</td>
		<td>우편번호</td>
		<td>주소</td>
	</tr>

<%
i=1
do until rslist.EOF
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td><%=rslist("tcode")%></td>
		<td align=left><%=rslist("comname")%></td>
		<td><%=rslist("name")%></td>
		<td><%=rslist("dname")%></td>
		<td><%=rslist("post")%></td>
		<td align="left"><%=rslist("addr")%> <%=rslist("addr2")%></td>
	</tr>

</form>

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

</body>
</html>