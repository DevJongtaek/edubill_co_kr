<%
	select case request("uid")
		case "gongi"
			imsibbstitle = "��������"
		case "news"
			imsibbstitle = "����"
		case "faq"
			imsibbstitle = "FAQ "
		case "customer"
			imsibbstitle = "���ǼҸ�"
		case "pds"
			imsibbstitle = "�ڷ��"
		case "guestbbs"
			imsibbstitle = "�ڷ��"
		case "agencyboard"
			imsibbstitle = "�ڷ��"
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

