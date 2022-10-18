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
	searchh = request("searchh")

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

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * from tb_company "
	SQL = sql & " where flag = '3' "

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

	if searchh <> "" then
		SQL = sql & " and cbrandchoice = '"& searchh &"' "
	end if

	SQL = sql & " order by tcode asc"
	rslist.Open sql, db, 1
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type="text/css">
<!--
td.accountnum
{mso-number-format:\@}
-->
</STYLE>
<body>

<table border=1>
	<tr>
		<td>체인점코드</td>
		<td>체인점명</td>
		<td>여신금액</td>
		<td>미수금액</td>
	</tr>

<%

i=1
do until rslist.EOF
%>

	<tr>
		<td class='accountnum'><%=rslist("tcode")%></td>
		<td><%=rslist("comname")%></td>
		<td class='accountnum'><%=formatnumber(rslist("ye_money"),0)%></td>
		<td class='accountnum'><%=formatnumber(rslist("mi_money"),0)%></td>
	</tr>

<%
rslist.MoveNext 
i=i+1
loop 

db.close
%>

</table>

</body>
</html>