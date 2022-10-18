<%
filename=request("filename")
%>

<html>
<head>
<title>제품사진 확대보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/css/dog.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">

<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
	<tr> 
		<td align=center>
			<%if filename <> "" then%>
				<img src="/fileupdown/productimg/bigimg/<%=filename%>" width=400>
			<%end if%>
		</td>
	</tr>
</table>