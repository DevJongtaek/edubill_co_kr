<%
	select case request("uid")
		case "gongi"
			imsibbstitle = "공지사항"
		case "news"
			imsibbstitle = "뉴스"
		case "faq"
			imsibbstitle = "FAQ "
		case "customer"
			imsibbstitle = "고객의소리"
		case "pds"
			imsibbstitle = "자료실"
		case "guestbbs"
			imsibbstitle = "자료실"
		case "agencyboard"
			imsibbstitle = "자료실"
	end select
	tablename = "tb_pds"
%>

<%if request("uid")="agencyboard" then%>
	<!-- #include virtual="/adminpage/incfile/sessionend2.asp"-->
	<!-- #include virtual="/adminpage/incfile/top2.asp"-->
<%else%>
	<!-- #include virtual="/adminpage/incfile/sessionend.asp"-->
	<!-- #include virtual="/adminpage/incfile/top.asp"-->
<%end if%>

<!-- #include virtual="/db/db.asp"-->

<table width="800" border=0 cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="27">
		<td> &nbsp; <font color=blue size=3><B>[ <%=imsibbstitle%> ]</td>
	</tr>
</table>

<table width="780" border=0 cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="27">
		<td>

		<table width="100%" border=0 cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="27">
				<td align=center>

