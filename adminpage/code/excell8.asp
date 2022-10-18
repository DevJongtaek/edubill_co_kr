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
	SQL = " select idx,tcode,flag,idxsub,comname,name,post,addr,addr2,companynum1,companynum2,companynum3,uptae,upjong,tel1,tel2,tel3,fax1,fax2,fax3,hp1,hp2,hp3,dcarno,startday,bidxsub,fileregcode,soundfile,orderflag,myflag,ye_money,mi_money,virtual_acnt_bank,virtual_acnt,email,virtual_acnt4_bank,virtual_acnt4,virtual_acnt5_bank,virtual_acnt5,virtual_acnt6_bank,virtual_acnt6 "
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
	
   
    response.write sql
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

<table border="1">
	<tr height=28 align=center>
		<td bgcolor="yellow" align="center" width="140"><font color="blue">체인점코드</font></td>
		<td bgcolor="yellow" align="center" width="320"><font color="blue">체인점명</font></td>
		<td bgcolor="yellow" align="center" width="140"><font color="blue">은행1</font></td>
		<td bgcolor="yellow" align="center" width="180"><font color="blue">가상계좌1</font></td>
        <td bgcolor="yellow" align="center" width="140"><font color="blue">은행2</font></td>
		<td bgcolor="yellow" align="center" width="180"><font color="blue">가상계좌2</font></td>
        <td bgcolor="yellow" align="center" width="140"><font color="blue">은행3</font></td>
		<td bgcolor="yellow" align="center" width="180"><font color="blue">가상계좌3</font></td>
        <td bgcolor="yellow" align="center" width="140"><font color="blue">은행4</font></td>
		<td bgcolor="yellow" align="center" width="180"><font color="blue">가상계좌4</font></td>
	</tr>

<%
do until rslist.EOF

	  
   
	
	
	
	

	
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td class='accountnum'><%=rslist("tcode")%></td>
		<td class='accountnum' align="left"><%=rslist("comname")%></td>
        <td align="left"><%=rslist("virtual_acnt_bank")%></td>
		<td class='accountnum'><%=rslist("virtual_acnt")%></td>


		

        <td><%=rslist("virtual_acnt4_bank")%></td>
		<td class='accountnum'><%=rslist("virtual_acnt4")%></td>
        <td><%=rslist("virtual_acnt5_bank")%></td>
		<td class='accountnum'><%=rslist("virtual_acnt5")%></td>
        <td><%=rslist("virtual_acnt6_bank")%></td>
		<td class='accountnum'><%=rslist("virtual_acnt6")%></td>


	</tr>
	

</form>

<%

rslist.MoveNext 
loop 
%>

	
</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>