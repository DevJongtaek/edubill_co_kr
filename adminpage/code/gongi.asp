<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select content,flag,hflag,wsize,hsize,loginflag"
	SQL = sql & " from tb_gongi "
	rslist.Open sql, db, 1
	imsicontent = rslist(0)
	imsiflag = rslist(1)
	imsihflag = rslist(2)
	imsiwsize = rslist(3)
	imsihsize = rslist(4)
	imsiloginflag = rslist(5)
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
		<td><font color=blue size=3><B>[ ȸ���� �������� ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="gongiok.asp" name=form method=post onsubmit="return rootedit();">

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=20%><B>��뱸��&nbsp;</td>
		<td bgcolor=white width=80%>
			<input type="radio" name="loginflag" value="1" <%if imsiloginflag="1" then%>checked<%end if%>>�α�����
			<input type="radio" name="loginflag" value="2" <%if imsiloginflag="2" then%>checked<%end if%>>�α�����
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=20%><B>��뱸��&nbsp;</td>
		<td bgcolor=white width=80%>
			<input type="radio" name="flag" value="y" <%if imsiflag="y" then%>checked<%end if%>>���
			<input type="radio" name="flag" value="n" <%if imsiflag="n" then%>checked<%end if%>>������
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=20%><B>HTML���&nbsp;</td>
		<td bgcolor=white width=80%>
			<input type="radio" name="hflag" value="y" <%if imsihflag="y" then%>checked<%end if%>>HTML ���
			<input type="radio" name="hflag" value="n" <%if imsihflag="n" then%>checked<%end if%>>HTML ������
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=20%><B>����/���� ũ��&nbsp;</td>
		<td bgcolor=white width=80%><input type="text" name="wsize" value="<%=imsiwsize%>" size=3>/<input type="text" name="hsize" value="<%=imsihsize%>" size=3></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right width=20%><B>����&nbsp;</td>
		<td bgcolor=white width=80%>
			<textarea name="content" cols="75" rows="15" style="border:1 solid #C7C7C7;back-color :black;"><%=imsicontent%></textarea>
		</td>
	</tr>
</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>
			<input type="image" src="/images/admin/l_bu03.gif" border=0>
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

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->