<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")

	if searcha = "" then
		searcha = replace(left(now,10),"-","")
	end if
	if searchb="" then
		searchb="0"
	end if
	if searchc="" then
		searchc="1"
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " order by dcarno asc"
	rs.Open sql, db, 1
	if not rs.eof then
		hcararray = rs.GetRows
		hcararrayint = ubound(hcararray,2)
	else
		hcararray = ""
		hcararrayint = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select okday,comname2,carname,rordermoney,idx "
	SQL = sql & " from tb_order "
	SQL = sql & " where flag='y' "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	SQL = sql & " and okday = '"& searcha &"' "

	if searchb<>"0" then
		SQL = sql & " and carname = '"& searchb &"' "
	end if

	SQL = sql & " order by carname asc"
	rs.Open sql, db, 1

%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ <%if searchc = "1" then%>���ݰ�꼭<%else%>�ŷ�����<%end if%> �μ� ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=kindform>
	<tr>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>�ֹ�����</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searcha" size="8" maxlength="8" class="box_work" value="<%=searcha%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
		</td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>ȣ��</td>
		<td nowrap width="15%" bgcolor="#FFFFFF" height="25">
			<select name="searchb" size="1" class="box_work">
				<%if hcararrayint<>"" then%>
	          			<option value="0" <%if searchg = "" then%>selected<%end if%>>ȣ����ü</option>
					<%for i=0 to hcararrayint%>
	        	  			<option value="<%=hcararray(1,i)%>" <%if int(searchg)=int(hcararray(1,i)) then%>selected<%end if%>><%=hcararray(1,i)%>ȣ��
					<%next%>
				<%else%>
	          			<option value="0" <%if searchg = "" then%>selected<%end if%>>ȣ����Ͼ���</option>
				<%end if%>
        		</select>
		</td>

		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>����</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25">
			<select name="searchc" size="1" class="box_work">
          			<option value="1" <%if searchc = "1" then%>selected<%end if%>>���ݰ�꼭</option>
          			<option value="2" <%if searchc = "2" then%>selected<%end if%>>�ŷ�����</option>
	       		</select>
		</td>

		<td nowrap width="15%" bgcolor="#FFFFFF" height="25">
	        	<input type="button" name="�� ��" value="�� �� " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work"' onclick="javascript:frmzerocheck(this.form,'list.asp');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* ��ü <B><%=rs.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>��ȣ</td>
		<td width=15%>�ֹ�����</td>
		<td width=20%>ü������</td>
		<td width=10%>ȣ��</td>
		<td width=20%>���ݱݾ�</td>
		<td width=20%><%if searchc="1" then%>���ݰ�꼭<%else%>�ŷ�����<%end if%></td>
	</tr>

<form name=form2 method=post>

<%
i=1
do until rs.EOF
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><%=left(rs(0),4)%>/<%=mid(rs(0),5,2)%>/<%=right(rs(0),2)%></td>
		<td><%=rs(1)%></td>
		<td><%=rs(2)%>ȣ��</td>
		<td align=right><%=FormatCurrency(rs(3))%> &nbsp; </td>
		<td><input type=button value="<%if searchc="1" then%>���ݰ�꼭<%else%>�ŷ�����<%end if%>" onclick="javascript:nwinopen('<%=rs(4)%>','<%=searchc%>')"></td>
	</tr>

<%
rs.MoveNext 
i=i+1
loop 
%>

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