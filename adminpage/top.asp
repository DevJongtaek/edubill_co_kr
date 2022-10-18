<!--#include virtual="/adminpage/incfile/sessionend.asp"-->

<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=euc-kr">
<link rel="stylesheet" href="/css/jin.css">

<script language="javascript">
function levelno() {
	alert("사용권한이 없습니다.\n\n관리자에 문의하세요!");
}

</script>
</head>
<body bgcolor="#ffffff" topmargin="0" leftmargin="0">

<table width="100%" height=100% border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td height="28" colspan=2 valign=top>

		<table border="0" cellspacing="0" cellpadding="0" width=100% bgcolor=#CCCCCC height="28">
        		<tr> 
          			<td>&nbsp;<font size="3" color="#FFFFFF" face="굵은돋움체"><B>EDUBILL INTRANET PAGE</font></td>
		        </tr>
      		</table>

		</td>
	</tr>
	<tr bgcolor=white>
		<td width=160 align=center>[ID : <font color=#804E17><%=session("Auserid")%></font>] &nbsp; <a href="logout.asp" target="_top">[Logout]</a></td>
		<td valign=top>

		<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor=#CCCCCC height=30 valign=top>
			<tr bgcolor="#FFFFFF" align=center> 

<%if session("Ausergubun")="1" then%>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="code/" target="main">코드관리</a></td>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="#" onclick="javascript:levelno();">주문관리</a></td>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="#" onclick="javascript:levelno();">배달관리</a></td>
	<td width="31%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="#" onclick="javascript:levelno();">세금계산서/거래명세서 관리</a></td>
<%else%>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="code/" target="main">코드관리</a></td>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="order/" target="main">주문관리</a></td>
	<td width="23%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="delivery/" target="main">배달관리</a></td>
	<td width="31%"><img src="images/n_b67.gif" width="16" height="16" hspace="2" align="absmiddle"><a href="tax/" target="main">세금계산서/거래명세서 관리</a></td>
<%end if%>

                    </tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>
