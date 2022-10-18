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
		<td><font color=blue size=3><B>[ 데이타삭제 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="alldelok.asp" method="POST" name=findkindform>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> 데이타삭제</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="searcha" size="1" class="box_work">
          		<option value="">선택</option>
          		<option value="1">오늘기준 1주일전 이전 데이타삭제</option>
          		<option value="5">오늘기준 2주일전 이전 데이타삭제</option>
          		<option value="2">오늘기준 3주일전 이전 데이타삭제</option>
          		<option value="6">오늘기준 4주일전 이전 데이타삭제</option>
          		<option value="3">오늘기준 1개월전 이전 데이타삭제</option>
          		<option value="4">오늘기준 2개월전 이전 데이타삭제</option>
        	</select>
        	<input type="button" value="삭 제" class="box_work"' onclick="javascript:alldelok44(this.form);">
		</td>
	</tr>

</form>

</table>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->