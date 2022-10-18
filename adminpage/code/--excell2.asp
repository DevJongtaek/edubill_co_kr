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

	'if session("Ausergubun")="2" then
	'	searchc = session("Ausercode")
	'end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,tcode,flag,idxsub,comname,name,post,addr,addr2,companynum1,companynum2,companynum3,uptae,upjong,tel1,tel2,tel3,fax1,fax2,fax3,hp1,hp2,hp3,dcarno,startday,bidxsub,fileregcode,soundfile,orderflag,myflag,ye_money,mi_money,virtual_acnt_bank,virtual_acnt "
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
		<td>점코드</td>
		<td>비밀번호</td>
		<td>체인점명</td>
		<td>대표자</td>
		<td>사업자등록번호</td>
		<td>우편번호</td>
		<td>주소1</td>
		<td>주소2</td>

		<td>가상계좌은행</td>
		<td>가상계좌번호</td>

		<td>업태</td>
		<td>업종</td>
		<td>전화번호</td>
		<td>핸드폰번호</td>
		<td>호차</td>
		<td>파일생성코드</td>
		<td>관할지사</td>
		<td>주문여부</td>
	</tr>

<%
set rs = server.CreateObject("ADODB.Recordset")
SQL = " select myflag from tb_company where idx = "& int(left(session("Ausercode"),5)) &" "
rs.Open sql, db, 1
if not rs.eof then
	imsimyflag = rs(0)
else
	imsimyflag = ""
end if
rs.close

i=1
do until rslist.EOF

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	orderflag22 = ""
	orderflag = rslist("orderflag")
	myflag    = rslist("myflag")
	ye_money  = rslist("ye_money")
	mi_money  = rslist("mi_money")

	if (imsimyflag = "y") and (ye_money < mi_money) then
		orderflag = "66"
	end if

	select case orderflag
		case "1"
			orderflag22 = "미수금(정지)"
		case "2"
			orderflag22 = "폐업(정지)"
		case "3"
			orderflag22 = "휴업(정비)"
		case "4"
			orderflag22 = "경고1(주문)"
		case "5"
			orderflag22 = "경고2(주문)"
		case "y"
			orderflag22 = "주문중"
		case "66"
			orderflag22 = "자동차단"
	end select

	select case orderflag
		case "y", "4", "5"
			orderflag22 = "<font color=black>" & orderflag22 & "</font>"
		case "1", "2", "3", "66"
			orderflag22 = "<font color=red>" & orderflag22 & "</font>"
	end select
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	imsidcarno = ""
	imsicomname = ""
	imsiusername = ""

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarno from tb_car where idx = "& rslist("dcarno") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsidcarno = rs(0)
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode from tb_company where idx = "& rslist("bidxsub") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsittcode = rs(0)
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname from tb_company where idx = "& rslist("idxsub") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsittcodename = rs(0)
	end if
	rs.close

	imsiuserpwd = rslist("soundfile")
%>

	<tr>
		<td class='accountnum'><%=imsittcode%><%=rslist("tcode")%></td>
		<td class='accountnum'><%=rslist("tcode")%></td>
		<td><%=imsiuserpwd%></td>
		<td><%=rslist("comname")%></td>
		<td><%=rslist("name")%></td>
		<td><%=rslist("companynum1")%>-<%=rslist("companynum2")%>-<%=rslist("companynum3")%></td>
		<td><%=rslist("post")%></td>
		<td><%=rslist("addr")%></td>
		<td><%=rslist("addr2")%></td>

		<td><%=rslist("virtual_acnt_bank")%></td>
		<td class='accountnum'><%=rslist("virtual_acnt")%></td>

		<td><%=rslist("uptae")%></td>
		<td><%=rslist("upjong")%></td>
		<td><%=rslist("tel1")%>-<%=rslist("tel2")%>-<%=rslist("tel3")%></td>
		<td><%=rslist("hp1")%>-<%=rslist("hp2")%>-<%=rslist("hp3")%></td>
		<td class='accountnum'><%=imsidcarno%></td>
		<td><%=rslist("fileregcode")%></td>
		<td><%=imsittcodename%></td>
		<td><%=orderflag22%></td>
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