<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=Sheet1.xls"
%>
<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	userid = session("Auserid")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname, orderflag from tb_company " 
	SQL = SQL & " where bidxsub = (select left(usercode, 5) "
    SQL = SQL & " from tb_adminuser "
    SQL = SQL & " where dbo.tb_adminuser.userid = '" & userid & "') "
	SQL = SQL & " and flag = '3' "
	SQL = SQL & " order by tcode "
'response.write  sql
	rs.Open sql, db, 1
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
		<td bgcolor="yellow" align="center" width="140"><font color="blue">주문여부</font></td>
		<td bgcolor="yellow" align="center" width="180"><font color="blue">비고</font></td>
	</tr>

<%
do until rs.EOF

	If (IsNull(rs("tcode"))) Then
		tcode = ""
		rs.MoveNext 
	Else
    	tcode = rs("tcode")
	End If

	If (IsNull(rs("comname"))) Then
		comname = ""
		rs.MoveNext 
	Else
		comname = rs("comname")
	End If

	If (IsNull(rs("orderflag"))) Then
		orderflag = ""
	Else
		orderflag = rs("orderflag")
	End If	
	
	If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then 
		'misugum = "미수금1"
    misugum = "주문차단"
	Else
		misugum = "미수금"
	End if 

	Select Case orderflag
		Case "y"
			bigo = "주문중"
		Case "1"
			bigo =  misugum & "(정지)"
		Case "2"
			bigo = "폐업(정지)"
		Case "3"
			bigo = "휴업(정지)"
		Case "4"
			bigo = "경고1(주문)"
		Case "5"
			bigo = "경고2(주문)"
    	Case "6"
			bigo = "시즈닝차단(정지)"
		Case Else 
			bigo = ""
	End Select 

	If tcode = "" Then
	Else
	
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td class='accountnum'><%=tcode%></td>
		<td class='accountnum' align="left"><%=comname%></td>
		<td class='accountnum'><%=orderflag%></td>
		<td align="left"><%=bigo%></td>
	</tr>

</form>

<%
End If 
rs.MoveNext 
loop 
%>

	<!--tr>
	<td colspan = "4" >주문여부 : y -> 주문중, 1 -> 미수금(정지), 2 -> 폐업(정지), 3 -> 휴업(정지), 4 -> 경고1(주문), 5 -> 경고2(주문)</td>
	</tr-->
</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>