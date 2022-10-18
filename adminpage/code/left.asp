<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=euc-kr">

<link rel="stylesheet" href="/css/jin.css">
<style TYPE="TEXT/CSS">
  #menu {display:none}
</style>
</head>

<body topmargin="0" leftmargin="0">

<table cellpadding="0" cellspacing="0" width="100%" height=100% border="0" bgcolor=#F9F9F9>
	<tr> 
		<td align=center width=100% valign=top>

		<table cellpadding="0" cellspacing="0" width="100%" border="0" bgcolor=white>
			<tr height=50 align=center> 
				<td></td>
			</tr>
		</table>

		<table cellpadding=1 cellspacing=1 width="100%" border="0" bgcolor=#CCCCCC>
			<tr height=3> 
				<td></td>
			</tr>
			<tr height=30 bgcolor=#DDDEDC align=center>
				<td><B>코드관리</b></td>
			</tr>

<%if session("Ausergubun")="1" or session("Ausergubun")="2"  or session("Ausergubun")="3" then %>
	<%if session("Ausergubun")="2" or session("Ausergubun")="3" then %>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="plist.asp" target="smain">상품관리</a></td>
			</tr>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="clist.asp" target="smain">호차관리</a></td>
			</tr>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="list.asp?flag=2" target="smain">지사(지점)관리</a></td>
			</tr>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="list.asp?flag=3" target="smain">체인점관리</a></td>
			</tr>
	<%end if%>
	<%if session("Ausergubun")="1" or session("Ausergubun")="2" then %>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="list.asp?flag=1" target="smain">본사관리</a></td>
			</tr>
	<%end if%>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="ulist.asp" target="smain">사용자관리</a></td>
			</tr>
<%end if%>

<%if session("Ausergubun")="1" then %>
			<tr height=30 bgcolor=#DDDEDC align=center>
				<td><B>홈페이지관리</b></td>
			</tr>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="../bbs/list.asp?uid=faq" target="smain">FAQ</a></td>
			</tr>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="../bbs/list.asp?uid=customer" target="smain">고객의소리</a></td>
			</tr>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="../bbs/list.asp?uid=gongi" target="smain">공지사항</a></td>
			</tr>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="../bbs/list.asp?uid=news" target="smain">소식/뉴스</a></td>
			</tr>
			<tr height=25 bgcolor=#F9F9F9 align=center>
				<td><A href="../bbs/list.asp?uid=pds" target="smain">자료실</a></td>
			</tr>
<%end if%>

		</table>

		</td>
	</tr>
</table>

</body>
</html>
