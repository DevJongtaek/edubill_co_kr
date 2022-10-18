<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>인증번호</title>
<%
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = "select tcode, comname, userID, CertNo from tb_badmi_cert"
	SQL = sql & " where username is null"
	rslist.Open sql, db, 1
%>

<script language="JavaScript">
function winResize()
{
    var Dwidth = parseInt(document.body.scrollWidth);
    var Dheight = parseInt(document.body.scrollHeight);
    var divEl = document.createElement("div");
    divEl.style.position = "absolute";
    divEl.style.left = "0px";
    divEl.style.top = "0px";
    divEl.style.width = "100%";
    divEl.style.height = "100%";

    document.body.appendChild(divEl);

    window.resizeBy(Dwidth - divEl.offsetWidth - 30, Dheight - divEl.offsetHeight);
    document.body.removeChild(divEl);
}


</script>
<body onload="winResize()">
<table cellspacing=1 cellpadding=1 width="400" border=0 bgcolor=#BDCBE7>
	<tr bgcolor=#F7F7FF height=22 align=center>
		<td width=20%>거래처코드</td>
		<td width=40%>거래처명</td>
		<td width=20%>사용자</td>
		<td width=20%>인증번호</td>
	</tr>
	<%do until rslist.EOF%>
	<tr bgcolor=white height=22 align=center>
		<td width=20%><B><%=rslist("tcode")%></td>
		<td align=left width=40%><%=rslist("comname")%></td>
		<td width=20%><%=rslist("userID")%></td>
		<td width=20%><%=rslist("CertNo")%></td>
	</tr>
<% rslist.MoveNext 
loop 
db.close
%>

</table>
<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>
			<input type="image" src="/images/admin/l_bu16.gif" border=0 onclick="window.close()">
		</td>
	</tr>
</table>
