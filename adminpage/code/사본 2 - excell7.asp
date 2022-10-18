<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=Sheet1.xls"
%>
<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	userid = session("Auserid")
	bidxsub = left(session("Ausercode"),5)

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname, orderflag,cbrandchoice from tb_company " 
	SQL = SQL & " where bidxsub = (select left(usercode, 5) "
    SQL = SQL & " from tb_adminuser "
    SQL = SQL & " where dbo.tb_adminuser.userid = '" & userid & "') "
	SQL = SQL & " and flag = '3' "
	SQL = SQL & " order by tcode "
'response.write  sql
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
		<td bgcolor="yellow" align="center" width="140"><font color="blue">브랜드코드</font></td>
		<td bgcolor="yellow" align="center" width="180"><font color="blue">브랜드명</font></td>
	</tr>

<%
do until rslist.EOF

	  
    if rslist("cbrandchoice")<>"" then
		
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bname from tb_company_brand "
		SQL = sql & " where bidx = "& rslist("cbrandchoice") &" "
		rs.Open sql, db, 1
		
		if not rs.eof then
           
			imsibname = rs(0)
		end if
		rs.close
		
	  else
	  
		imsibname = ""
		
	  end if
	  
	  if rslist("cbrandchoice")<>"" then
		
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bidx,bname from tb_company_brand "
		SQL = sql & " where idx = "& bidxsub &" "
		rs.Open sql, db, 1
		
		if not rs.eof then
           
			imsibidx = rs(0)
			imsibname2 = rs(1)
		end if
		rs.close
		
	  else
	  
		imsibname = ""
		
	  end if
	
	
	
	

	
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td class='accountnum'><%=rslist("tcode")%></td>
		<td class='accountnum' align="left"><%=rslist("comname")%></td>
		<td class='accountnum'><%=rslist("cbrandchoice")%></td>
		<td align="left"><%=imsibname%></td>
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