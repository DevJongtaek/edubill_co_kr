<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ ����Ÿ���� ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="alldelok.asp" method="POST" name=findkindform>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> ����Ÿ����</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="searcha" size="1" class="box_work">
          		<option value="">����</option>
          		<option value="1">���ñ��� 1������ ���� ����Ÿ����</option>
          		<option value="5">���ñ��� 2������ ���� ����Ÿ����</option>
          		<option value="2">���ñ��� 3������ ���� ����Ÿ����</option>
          		<option value="6">���ñ��� 4������ ���� ����Ÿ����</option>
          		<option value="3">���ñ��� 1������ ���� ����Ÿ����</option>
          		<option value="4">���ñ��� 2������ ���� ����Ÿ����</option>
        	</select>
        	<input type="button" value="�� ��" class="box_work"' onclick="javascript:alldelok44(this.form);">
		</td>
	</tr>

</form>

</table>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->