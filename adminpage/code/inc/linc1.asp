<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=findkindform>
<input type=hidden name=flag value="<%=flag%>">

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25">&nbsp;<B>ȸ�������� �˻�</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="searcha" size="1" class="box_work">
          		<option value="">��ü����Ʈ</option>
          		<option value="tcode" <%if searcha = "tcode" then%>selected<%end if%>>ȸ�����ڵ�</option>
          		<option value="comname" <%if searcha = "comname" then%>selected<%end if%>>ȸ�����</option>
          		<option value="userid" <%if searcha = "userid" then%>selected<%end if%>>���̵�</option>
          		<option value="sdname" <%if searcha = "sdname" then%>selected<%end if%>>�����</option>
<!--
          		<option value="name" <%if searcha = "name" then%>selected<%end if%>>��ǥ�ڸ�</option>
          		<option value="tel3" <%if searcha = "tel3" then%>selected<%end if%>>��ȭ��ȣ</option>
-->
        	</select>
		<select name="searchc" size="1" class="box_work">
          		<option value="">��ü</option>
          		<option value="1" <%if searchc = "1" then%>selected<%end if%>>���</option>
          		<option value="2" <%if searchc = "2" then%>selected<%end if%>>����</option>
          		<option value="3" <%if searchc = "3" then%>selected<%end if%>>����</option>
          		<option value="4" <%if searchc = "4" then%>selected<%end if%>>����</option>
          		<option value="5" <%if searchc = "5" then%>selected<%end if%>>�̰�</option>
        	</select>
        	<input type="Text" name="searchb" size="20" maxlength="20" class="box_work" value="<%=searchb%>">
        	<input type="button" name="�� ��" value="�� �� " class="box_work"' onclick="javascript:kindsearchok(this.form);">
		<a href="excell4.asp?gotopage=<%=gotopage%>&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>"><img src="/images/admin/excel.gif" border=0></a>
		<a href="excell6.asp?gotopage=<%=gotopage%>&flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>"><img src="/images/admin/excel.gif" border=0></a>
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* ��ü <B><%=rslist.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.</td>
		<td width=30% align=right><%if session("Ausergubun")="1" then%><%if session("Auserwrite")="y" then%><a href="write.asp?flag=<%=flag%>"><img src="/images/admin/l_bu08.gif" border=0></a><%end if%><%end if%></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>��ȣ</td>
		<td width=7%>�ڵ�</td>
		<td width=6%>����</td>
		<td width=17%>ȸ�����</td>
		<td width=11%>��ǥ��</td>
		<td width=11%>�����</td>
		<td width=13%>��ȭ��ȣ</td>
		<td width=10%>�̿��</td>
		<td width=10%>ü������</td>
		<td width=10%>�������</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	imsirscount1 = 0
	imsirscount2 = 0
	imsiusername = ""

	set rscount = server.CreateObject("ADODB.Recordset")
	SQL = " select count(idx),(select count(idx) from tb_company where bidxsub = "& rslist("idx") &" and flag = '3') "
	SQL = sql & " from tb_company "
	SQL = sql & " where bidxsub = "& rslist("idx") &" and flag = '2' "
	rscount.Open sql, db, 1
	if not rscount.eof then
		imsirscount1 = rscount(0)
		imsirscount2 = rscount(1)
	else
		imsirscount1 = 0
		imsirscount2 = 0
	end if
	rscount.close

	set rscount = server.CreateObject("ADODB.Recordset")
	SQL = " select username"
	SQL = sql & " from tb_adminuser "
	SQL = sql & " where flag = '2' and usercode = '"& rslist("idx") &"' "
	rscount.Open sql, db, 1
	if not rscount.eof then
		imsiusername = rscount(0)
	end if
	rscount.close

	imsiserviceflag = rslist("serviceflag")
	if imsiserviceflag="1" then
		imsiserviceflag = "���"
	elseif imsiserviceflag="2" then
		imsiserviceflag = "����"
	elseif imsiserviceflag="3" then
		imsiserviceflag = "����"
	elseif imsiserviceflag="4" then
		imsiserviceflag = "����"
	elseif imsiserviceflag="5" then
		imsiserviceflag = "�̰�"
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("tcode")%></td>
		<td><%=imsiserviceflag%></td>
		<td align=left><a href="write.asp?gotopage=<%=gotopage%>&flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>"><b><%=rslist("comname")%></a></td>
		<td><%=rslist("name")%></td>
		<td align=left><%=imsiusername%></td>
		<td><%=rslist("tel1")%>-<%=rslist("tel2")%>-<%=rslist("tel3")%></td>
		<td><%=mid(FormatCurrency(rslist("usemoney")),2)%></td>
		<td><%=imsirscount2%></td>
		<td><%=left(rslist("startday"),4)%>/<%=mid(rslist("startday"),5,2)%>/<%=right(rslist("startday"),2)%></td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 
%>

</form>

</table>