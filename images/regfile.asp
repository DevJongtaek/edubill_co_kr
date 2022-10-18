<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
%>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td> &nbsp; <font color=blue size=3><B>[ 청구화일 생성 ]</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="regfileok.asp" method="POST" name=kindform>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>사용자정보 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF">
	        	<input type="Text" name="searcha" size="4" maxlength="4" class="box_work" value="<%=searcha%>">년
	        	<input type="Text" name="searchb" size="4" maxlength="4" class="box_work" value="<%=searchb%>">월
			<input type="image" src="/images/l_bu2222222.gif" onclick="javascript:kindsearchok(this.form);">
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

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->