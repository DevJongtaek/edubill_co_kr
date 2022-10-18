<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	idx=request("idx")
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select usercode,isnull(order_cmt,'') as order_cmt from tb_order where idx = "& idx
	rs.Open sql, db, 1
	if not rs.eof then
		usercode = rs(0)
		imsiorder_cmt = rs(1)
		imsiorder_cmt = Replace(imsiorder_cmt,chr(13),"<br>")
	end if
	rs.close

	imsiusercode1 = right(usercode,5)	'체인점키값
	if imsiusercode1<>"" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select tcode,comname from tb_company where idx = "& imsiusercode1
		rs.Open sql, db, 1
		if not rs.eof then
		imsitcode = rs(0)
		imsicomname = rs(1)
		end if
	end if
%>

<html>
<head>
<title>::: Comment :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
</head>

<body leftmargin="0" topmargin="0" bgcolor=#F1F8FC>

<table width="100%" height="100%" border="0" cellspacing="4" cellpadding="4">
	<tr height=25 bgcolor=#2A75B6>
		<td width="83%"><font color=white><B>체인점코드 : <%=imsitcode%> &nbsp; 체인점명 : <%=imsicomname%></td>
		<td width="17%" align=right><a href="#" onclick="window.close();"><font color=white><B>[창닫기]</a></td>
	</tr>
	<tr>
		<td colspan=2 valign="top"><%=imsiorder_cmt%></td>
	</tr>
</table>

</body>
</html>