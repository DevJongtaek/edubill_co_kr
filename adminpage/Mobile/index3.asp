<!--#include virtual="/adminpage/incfile/mtop2.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
orderidx = request("orderidx")	'������ �ֹ��Ҷ� �ֹ���ȣ�� ������ , ÷���� null
%>

<script language="javascript">
function move_site(form) {
	var myindex=form.family.selectedIndex
	if (form.family.options[myindex].value == "")
	{
		alert("�޴��� ������ �ֽʽÿ�. ");
	}
	else
	{
		//window.open(form.family.options[myindex].value, "", "");
		location.href = form.family.options[myindex].value;
	}
}
</script>
<script>//document.form.pcode[0].focus(); </script> 

<table width="310" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>


<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="25">
		<td width=40%><B>[ ü���� ��ǰ�ڵ� �ֹ��� ]</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
<form name=afrm method=post>
	<tr height="20">
		<td width=50%>

		<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
			<tr>
				<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>��ǰ�˻�</td>
			</tr>
			<tr>
				<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
					<select name="searchc">
						<option value="">�˻�����
						<option value="pname" <%if searchc="pname" then%>selected<%end if%>>��ǰ��
					<option value="pcode" <%if searchc="pcode" then%>selected<%end if%>>��ǰ�ڵ�
					</select> <input type=text name=searchd value="<%=searchd%>"> <input type=button value="�˻�" onclick="return searchchb(this.form);">
				</td>
			</tr>
		</table>

		</td>
</form>
<form name=form2>
</tr>
<tr>
		<td width=50% align=right>
			�ֹ�������� : <select name="family" onChange="move_site(this.form)">
				<option value="index3.asp" selected>��ǰ�ڵ��ֹ�
				<option value="index4.asp">��ǰ���ֹ�
			</select>
		</td>
	</tr>
</form>
</table>

<table cellspacing=0 cellpadding=0 width="100%" border=0>

<form action="orderok.asp" name=form method=post onsubmit="return orderwritetest();">

	<tr>
		<td width=45% align=center>

		<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width=20%><B>��ȣ</td>
				<td width=40%><B>��ǰ�ڵ�</td>
				<td width=40%><B>�ֹ�����</td>
			</tr>
		<%for i=1 to 60%>
			<tr height=25 bgcolor=white align=center>
				<td><%=i%></td>
				<td><input type="text" name="pcode" maxlength="4" size=4 class="box_write" style="ime-mode:disabled;" OnKeypress="onlyNumber();" onkeyup="return pcodecheck(form.pcode[<%=i-1%>].value,<%=i-1%>)"></td>
				<td><input type="text" name="ordernum" maxlength="4" size=4 class="box_write" style="ime-mode:disabled;" OnKeypress="onlyNumber();"></td>
			</tr>
		<%next%>

		</table>

		</td>
	</tr>
</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>
			<input type="image" src="/images/admin/l_bu01.gif" border=0>
			<a href="index3.asp"><img src="/images/admin/l_bu02.gif" border=0></a>
			<a href="indexback.asp"><img src="/images/admin/l_bu07.gif" border=0></a>
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

<!--#include virtual="/adminpage/incfile/mbottom2.asp"-->