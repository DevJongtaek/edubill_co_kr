<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,comname,tcode "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '1' "
	SQL = sql & " and usegubun = '2' "
	SQL = sql & " order by comname asc"
	rs.Open sql, db, 1
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

<form action="regfileok.asp" method="POST" name=kindform onsubmit="return kindsearchok3();">

	<tr> 
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>회원사명</td>
		<td nowrap width="30%" bgcolor="#FFFFFF">

			<select name=comname>
				<option value="">전체
				<%do until rs.eof%>
					<option value="<%=rs(0)%>"><%=rs(1)%>
				<%rs.movenext%>
				<%loop%>
				<%rs.close%>
			</select>
		</td>
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>청구년월</td>
		<td nowrap width="30%" bgcolor="#FFFFFF">
	        	<input type="Text" name="searcha" size="4" maxlength="4" class="box_work" value="<%=searcha%>" OnKeypress="onlyNumber();">년
	        	<input type="Text" name="searchb" size="2" maxlength="2" class="box_work" value="<%=searchb%>" OnKeypress="onlyNumber();">월
	        	<!--<input type="Text" name="searchc" size="2" maxlength="2" class="box_work" value="<%=searchc%>" OnKeypress="onlyNumber();">일-->
		</td>
		<td nowrap width="10%" bgcolor="#FFFFFF" height="25"><input type="image" src="/images/l_bu2222222.gif"></td>
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