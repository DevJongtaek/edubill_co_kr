<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select userpwd,mentout"
	SQL = sql & " from tb_adminuser "
	SQL = sql & " where userid = 'root' "
	rslist.Open sql, db, 1
	imsipwd = rslist(0)
	imsimentout = rslist(1)
	rslist.close

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select userpwd"
	SQL = sql & " from tb_adminuser "
	SQL = sql & " where userid = 'admin' "
	rslist.Open sql, db, 1
	imsipwd2 = rslist(0)
	rslist.close

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select ip,id,pwd,tbname,msg,dbname,cType,msg2,msg3 from tb_smsSetup "
	rslist.Open sql, db, 1
	ip = rslist(0)
	id = rslist(1)
	pwd = rslist(2)
	tbname = rslist(3)
	msg = rslist(4)
	dbname = rslist(5)
	cType = rslist(6)
	msg2 = rslist(7)
	msg3 = rslist(8)
	rslist.close

%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ ROOT 비밀번호 변경 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="rootok.asp" name=form method=post onsubmit="return rootedit();">
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=20%><B>비밀번호&nbsp;</td>
		<td bgcolor=white width=80%>
			<input type="text" name="userpwd" maxlength="10" size=13 class="box_write" value="<%=imsipwd%>">
			<input type="image" src="/images/admin/l_bu03.gif" border=0>
		</td>
	</tr>

</form>

</table>

<BR>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ ADMIN 비밀번호 변경 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="rootok.asp" name=form2 method=post onsubmit="return rootedit2();">
<input type=hidden name=flag value="1">

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=20%><B>비밀번호&nbsp;</td>
		<td bgcolor=white width=80%>
			<input type="text" name="userpwd" maxlength="10" size=13 class="box_write" value="<%=imsipwd2%>">
			<input type="image" src="/images/admin/l_bu03.gif" border=0>
		</td>
	</tr>

</form>

</table>

<BR>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 주문완료 SMS 전송 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="rootok.asp" name=form3 method=post>
<input type=hidden name=flag value="2">

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=15%><B>서버IP&nbsp;</td>
		<td bgcolor=white colspan=3><input type="text" name="ip" size=20 class="box_write" value="<%=ip%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=15%><B>DB이름&nbsp;</td>
		<td bgcolor=white width=35%><input type="text" name="dbname" size=20 class="box_write" value="<%=dbname%>"></td>
		<td align=right width=15%><B>테이블이름&nbsp;</td>
		<td bgcolor=white width=35%><input type="text" name="tbname" size=20 class="box_write" value="<%=tbname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=15%><B>ID&nbsp;</td>
		<td bgcolor=white width=35%><input type="text" name="id" size=20 class="box_write" value="<%=id%>"></td>
		<td align=right width=15%><B>PASSWORD&nbsp;</td>
		<td bgcolor=white width=35%><input type="text" name="pwd" size=20 class="box_write" value="<%=pwd%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=15%><B>메세지&nbsp;</td>
		<td bgcolor=white colspan=3>
			A Type : 
			<input type="text" name="msg" size=75 class="box_write" value="<%=msg%>">
			<BR>
			B Type : 
			<input type="text" name="msg2" size=75 class="box_write" value="<%=msg2%>">
			<BR>
			C Type : 
			<input type="text" name="msg3" size=75 class="box_write" value="<%=msg3%>">
		</td>
	</tr>
</table>
<table cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
		<td align=center><input type="image" src="/images/admin/l_bu03.gif" border=0></td>
	</tr>

</form>

</table>

<BR>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 멘트제외 회원사코드 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="rootok.asp" name=form4 method=post>
<input type=hidden name=flag value="3">

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td bgcolor=white><input type="text" name="mentout" style="width:100%" class="box_write" value="<%=imsimentout%>"></td>
	</tr>
</table>
<table cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
		<td align=center><input type="image" src="/images/admin/l_bu03.gif" border=0></td>
	</tr>

</form>

</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR><BR>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->