<!--#include virtual="/adminpage/incfile/top2.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sidx,sname "
	SQL = sql & " from tb_product_submenu "
	SQL = sql & " where idx = '"& left(session("AAusercode"),5) &"' order by sidx asc"
	rs.Open sql, db, 1
	if not rs.eof then
		proFlagArray = rs.GetRows
		proFlagArrayInt = ubound(proFlagArray,2)
	else
		proFlagArray    = ""
		proFlagArrayInt = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select ye_money,mi_money from tb_company where idx = "& right(session("AAusercode"),5) &" "
	rs.Open sql, db, 1
	ye_money = rs("ye_money")
	mi_money = rs("mi_money")
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sum(pprice*pcnt) from tb_product_cart where usercode = '"& session("AAusercode") &"' "
	rs.Open sql, db, 1
	imsihap = rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.*, b.pprice as cartpprice, b.pcnt, b.idx as cartidx "
	SQL = sql & " from tb_product a, tb_product_cart b"
	SQL = sql & " where a.pcode = b.pcode "
	SQL = sql & " and a.usercode = substring(b.usercode,1,5) "
	SQL = sql & " and b.usercode = '"& session("AAusercode") &"' "
	SQL = sql & " order by a.pcode asc"
	rs.Open sql, db, 1
%>

<script language="javascript">
function radiochbsubmit() {
	form2.action="AgencyOrderFRM.asp";
	form2.submit() ;
	return false ;
}

function cartchbok() {
	var imsicnt = 0;
	for(var i=0; i<document.form.pcnt.length;i++) 	//üũ�ڽ� ����
	{
		if(document.form.pcnt[i].value != ""){
			imsicnt = 1
		}
	}
	if (imsicnt<1) {
		alert("�ֹ������� �Է��� �ּ���.") ;
		return false ;
	}
	form.submit() ;
	return false ;
}

</script>

<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="20">
		<td>
			<font color=red>��.�ֹ���� : ��޴����â� ���ֹ������Է¢� ����ٱ��ϴ�⢺ ����ٱ��Ϻ��⢺ ����(����)�� ���ֹ��ϱ⢺ ��Ϸ�޽���(��)
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="20">
		<td>
			<%if proFlagArrayInt<>"" then%>
				<%for i=0 to proFlagArrayInt%>
					<a href="AgencyOrderFRM.asp?popnot=1&searcha=<%=proFlagArray(1,i)%>&searchb=<%=searchb%>"><font size=2><%if proFlagArray(1,i)=searcha then%><B><%else%><font color=blue><%end if%><%=proFlagArray(1,i)%><%if proFlagArray(1,i)=searcha then%></B><%end if%></a><%if i<proFlagArrayInt then%>&nbsp;|&nbsp;<%end if%>
				<%next%>
				&nbsp;|&nbsp;<a href="AgencyOrderFRM.asp?popnot=1&searcha=0&searchb=<%=searchb%>"><font size=2><%if searcha="0" then%><B><%else%><font color=blue><%end if%>��ü����</a>
			<%end if%>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">

<form name=form2 method=post>
<input type=hidden name=searcha value="<%=searcha%>">

	<tr height="27">
		<td width=30%><font size=2><B>[ ��ٱ��� ���� ]</td>
		<td width=70% align=right>
			<!--���ļ��� : 
			<input type=radio name="searchb" value="pcode" onclick="radiochbsubmit()" <%if searchb="pcode" or searchb="" then%>checked<%end if%>>��ǰ�ڵ�
			<input type=radio name="searchb" value="pname" onclick="radiochbsubmit()" <%if searchb="pname" then%>checked<%end if%>>��ǰ��
			<input type=radio name="searchb" value="sname" onclick="radiochbsubmit()" <%if searchb="sname" then%>checked<%end if%>>����޴�
			<input type=button value="��ٱ��Ϻ���"  onclick="javascript:location.href='AgencyOrderCartFRM.asp?btnsee=y';">-->
		</td>
	</tr>
</form>
</table>

<table cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
		<td align=center>

		<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width=5%><B>��ȣ</td>
				<td width=9%><B>��ǰ�ڵ�</td>
				<td width=24%><B>��ǰ��</td>
				<td width=21%><B>�԰�</td>
				<td width=8%><B>�ܰ�</td>
				<td width=8%><B>����</td>
				<td width=12%><B>�ݾ�</td>
				<td width=13%><B>����</td>
			</tr>

			<%
			i=1
			tothap = 0
			do until rs.eof
				tothap = tothap + (rs("cartpprice")*rs("pcnt"))

				if i=1 then
					pcode = rs("pcode")
					ordernum = rs("pcnt")
				else
					pcode = pcode &","& rs("pcode")
					ordernum = ordernum &","& rs("pcnt")
				end if
			%>

				<form action="AgencyOrderCartDel.asp" name=form<%=i%> method=post>
				<input type=hidden name=idx value="<%=rs("cartidx")%>">

				<tr height=25 bgcolor=white align=center>
					<td><%=i%></td>
					<td><%=rs("pcode")%></td>
					<td align=left>&nbsp;<B><%=rs("pname")%></td>
					<td align=left>&nbsp;<%=rs("ptitle")%></td>
					<td align=right><%=formatnumber(rs("cartpprice"),0)%>&nbsp;</td>
					<td><input type=text name=pcnt size=4 value="<%=rs("pcnt")%>" style="ime-mode:disabled;" OnKeypress="onlyNumber();" maxlength=4></td>
					<td align=right><%=formatnumber(rs("cartpprice")*rs("pcnt"),0)%>&nbsp;</td>
					<td>
						<input type=submit value="����" name=btnname>
						<input type=submit value="����" name=btnname>
					</td>
				</tr>

				</form>

			<%
			rs.movenext
			i=i+1
			loop
			rs.close
			%>

				<tr height=25 bgcolor=white align=center>
					<td colspan=2><B>��</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td align=right><B><%=formatnumber(tothap,0)%>&nbsp;</td>
					<td></td>
				</tr>
		</table>

		</td>
		</table>

		</td>
	</tr>
</table>

<BR>

<table align=center>

<form action="/adminpage/orderok3.asp" name=frm method=post>
<input type=hidden name="pcode" value="<%=pcode%>">
<input type=hidden name="ordernum" value="<%=ordernum%>">

	<tr> 
		<td height=30 align=center>
			<input type="image" src="/images/admin/l_bu01.gif" border=0>
			<a href="AgencyOrderCartDel.asp"><img src="cartdel.gif" border=0></a>
			<a href="AgencyOrderFRM.asp?popnot=1&searcha=<%=searcha%>&searchb=<%=searchb%>"><img src="/images/admin/l_bu07.gif" border=0></a>
		</td>
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

<!--#include virtual="/adminpage/incfile/bottom2.asp"-->