<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->
<script language="JavaScript">
function insertform(search){
	form.action = "MentOutDelOk.asp?searcha=0&searchc="+ search.value
	form.submit() ;
}

function deleteform(val){
	form.action = "MentOutDelOk.asp?searcha=1&searchc=" + val;
	form.submit() ;
}
</script>
<%
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select userpwd,mentout"
	SQL = sql & " from tb_adminuser "
	SQL = sql & " where userid = 'root' "
	rslist.Open sql, db, 1
	imsipwd = rslist(0)
	imsimentout = rslist(1)
	rslist.close

	set rsmentout = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname, username from tb_company a "
	SQL = sql & " join tb_mentout b on a.tcode = b.clientcode "
	SQL = sql & "  join tb_adminuser c on CONVERT(VARCHAR(10),a.idx) = c.usercode "
	SQL = sql & " where a.flag = '1' "
	SQL = sql & " order by tcode "
	rsmentout.Open sql, db, 1

	imsimentout = Replace(imsimentout, ", ", "', '")

	set rstcode = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname from tb_company  "
	SQL = sql & " where flag = '1' "
	SQL = sql & " and tcode not in ('" + imsimentout + "') "
	SQL = sql & " order by tcode "
	rstcode.Open sql, db, 1

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select userpwd"
	SQL = sql & " from tb_adminuser "
	SQL = sql & " where userid = 'admin' "
	rslist.Open sql, db, 1
	imsipwd2 = rslist(0)
	rslist.close

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select ip,id,pwd,tbname,msg,dbname,cType,msg2,msg3,msg4 from tb_smsSetup "
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
    msg4 = rslist(9)
	rslist.close


	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select ServerIp,Id,Password"
	SQL = sql & " from tb_AdminDB "
	rslist.Open sql, db, 1
	ServerIp = rslist(0)
	DBId = rslist(1)
	Password = rslist(2)
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
            <BR>
            D Type : 
			<input type="text" name="msg4" size=75 class="box_write" value="<%=msg4%>">
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
		<td colspan=3><font color=blue size=3><B>[ 멘트제외 회원사코드 ]</td>
	</tr>
	<tr>
		<td> 
			<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
				<tr height=22 bgcolor=#F7F7FF align=center align=center >
				<td align=right width=20%><B>회원사 추가&nbsp;</td>
				<td  align=left bgcolor=white colspan = 2>
					<select name="qty">
						<option value="">선택하세요
							<%Do Until rstcode.eof %>
								<option value="<%=rstcode("tcode")%>">[<%=rstcode("tcode")%>]  <%=rstcode("comname")%>
							<%rstcode.Movenext 
							loop%>
						</select>
					<input type="button" name="add" value="추가"  class="box_work"' onclick="javascript:insertform(qty);"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br>

<div id="tempdiv" style="overflow:auto; height:219px;overflow-y:scroll;width:100%">
<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=20%>회원사코드</td>
		<td width=50%>회원사명</td>
		<td width=20%>담당자</td>
		<td width=10%></td>
	</tr>
	<% do until rsmentout.EOF %>
	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rsmentout("tcode")%></td>
		<td><%=rsmentout("comname")%></td>
		<td><%=rsmentout("username")%></td>
		<td><input type="button" name="del" value="삭제"  class="box_work"' onclick="javascript:deleteform('<%=rsmentout("tcode")%>');"></td>
	</tr>
	<%
	rsmentout.MoveNext 
	loop 
	%>
</table>
</div>
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 주문어플 접속계정 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="rootok.asp" name=form3 method=post>
<input type=hidden name=flag value="4">

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=20%><B>서버IP&nbsp;</td>
		<td bgcolor=white><input type="text" name="ServerIp" size=20 class="box_write" value="<%=ServerIp%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=20%><B>ID&nbsp;</td>
		<td bgcolor=white><input type="text" name="DBId" size=20 class="box_write" value="<%=DBId%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=20%><B>PASSWORD&nbsp;</td>
		<td bgcolor=white><input type="text" name="Password" size=20 class="box_write" value="<%=Password%>"></td>
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
<BR>


<BR><BR>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->