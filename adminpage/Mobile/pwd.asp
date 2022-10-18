<!--#include virtual="/adminpage/incfile/mtop2.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select cyberNum from tb_company where flag=1 and idx = "& LEFT(session("AAusercode"),5)
	rs.Open sql, db, 1
	cyberNum = rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select soundfile,hp1,hp2,hp3,email,virtual_acnt,virtual_acnt_bank "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag=3 and idx = "& right(session("AAusercode"),5)
	rs.Open sql, db, 1
	soundfile = rs(0)
	hp1 = rs(1)
	hp2 = rs(2)
	hp3 = rs(3)
	email = rs(4)
	virtual_acnt = rs(5)
	virtual_acnt_bank = rs(6)
	rs.close
%>

<script Language="JavaScript">
<!-- 
function agencypwd(form) {
	form.submit() ;
	return false ;
}
//-->
</script>

<table width="310" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="310" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 비밀번호변경 ] <!--<a href="excell2.asp?idx=<%=idx%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a>--></td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action=pwdok.asp method=post name=form>

	<tr height="25">
		<td nowrap width="20%" bgcolor="#F7F7FF" align=center><B>비밀번호</td>
		<td nowrap width="80%" bgcolor="white">
			<input type=text name=soundfile value="<%=soundfile%>" OnKeypress="onlyNumber();" maxlength=2><br>
			<font color=red>* ARS 주문시 비밀번호로 공유</td>
	</tr>
	<tr height="25">
		<td nowrap width="20%" bgcolor="#F7F7FF" align=center><B>핸드폰번호</td>
		<td nowrap width="80%" bgcolor="white">
			<select name="hp1">
				<option value="010" <%if hp1 = "010" then%>selected<%end if%>>010
				<option value="011" <%if hp1 = "011" then%>selected<%end if%>>011
				<option value="016" <%if hp1 = "016" then%>selected<%end if%>>016
				<option value="017" <%if hp1 = "017" then%>selected<%end if%>>017
				<option value="018" <%if hp1 = "018" then%>selected<%end if%>>018
				<option value="019" <%if hp1 = "019" then%>selected<%end if%>>019
			</select>
			-
			<input type=text name=hp2 value="<%=hp2%>" OnKeypress="onlyNumber();" maxlength=4 size=4>
			-
			<input type=text name=hp3 value="<%=hp3%>" OnKeypress="onlyNumber();" maxlength=4 size=4>
		</td>
	</tr>
	<tr height="25">
		<td nowrap width="20%" bgcolor="#F7F7FF" align=center><B>이메일</td>
		<td nowrap width="80%" bgcolor="white">
			<input type=text name=email value="<%=email%>" size=30><br>
			<font color=red>* 전자세금계산서 수신용
		</td>
	</tr>

<%IF cyberNum="y" THEN%>
	<tr height="25">
		<td nowrap width="20%" bgcolor="#F7F7FF" align=center><B>가상계좌번호</td>
		<td nowrap width="80%" bgcolor="white">
			<%=virtual_acnt_bank%>은행 <%=virtual_acnt%><br>
			<font color=red>* 이 계좌로 입금 시 자동으로 주문허용
		</td>
	</tr>
<%END IF%>

</table>

<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr height="25">
		<td nowrap align=center><input type=button value="수정" onclick="return agencypwd(this.form)"></td>
	</tr>

</form>

</table>


				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/mbottom2.asp"-->