<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	if searcha = "" then
		searcha = replace(left(now()-1,10),"-","")
	end if
	if searchb = "" then
		searchb = replace(left(now(),10),"-","")
	end if

	'������-����
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select vatflag "
	SQL = sql & " from tb_company"
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	vatflag = rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select flag,usercode,sday1,sday2,regday,title,tnum,tprice,tprice2,tprice_vat,"
	SQL = SQL & " gcompany,gcompanyno,gcompanyname,gcompanyaddr,guptae,gupjong, "
	SQL = SQL & " scompany,scompanyno,scompanyname,scompanyaddr,suptae,supjong,wdate,oldmoneyhap,oldmoneyhap_vat "
	SQL = sql & " from tb_taxlog "
	SQL = sql & " where regday >= '"& searcha &"' "
	SQL = sql & " and regday <= '"& searchb &"' "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	if searchc<>"" then
		SQL = sql & " and flag = '"& searchc &"' "
	end if

	SQL = sql & " order by idx desc"
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
		<td><font color=blue size=3><B>[ ��ǥ��³��� ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list4.asp" method="POST" name=kindform>
	<tr>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>��������</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searcha" size="8" maxlength="8" class="box_work" value="<%=searcha%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searchb" size="8" maxlength="8" class="box_work" value="<%=searchb%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
		</td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>����</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25">
			<select name="searchc" size="1" class="box_work">
          			<option value="" <%if searchc = "" then%>selected<%end if%>>��ü</option>
          			<option value="1" <%if searchc = "1" then%>selected<%end if%>>����</option>
          			<option value="2" <%if searchc = "2" then%>selected<%end if%>>�鼼</option>
	       		</select>
		</td>

		<td nowrap width="15%" bgcolor="#FFFFFF" height="25">
	        	<input type="button" name="�� ��" value="�� �� " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work"' onclick="javascript:frmzerocheck(this.form,'list4.asp');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* ��ü <B><%=rs.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.</td>
		<td width=30% align=right><a href="excell2.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>"><img src="/images/admin/excel.gif" border=0></a></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>������</td>
		<td width=20%>�ŷ��Ⱓ</td>
		<td width=10%>ü������</td>
		<td width=15%>�ŷ��ݾ�</td>
		<td width=10%>�ŷ�����</td>
		<td width=10%>û���ݾ�</td>
		<td width=10%>û������</td>
		<td width=10%>û���հ�</td>
		<td width=5%>����</td>
	</tr>

<form name=form2 method=post>

<%
i=1
do until rs.EOF

	if rs("flag")="1" then
		imsiflag = "����"
	else
		imsiflag = "�鼼"
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=left(rs("regday"),4)%>/<%=mid(rs("regday"),5,2)%>/<%=right(rs("regday"),2)%></td>
		<td><%=left(rs("sday1"),4)%>/<%=mid(rs("sday1"),5,2)%>/<%=right(rs("sday1"),2)%>~<%=left(rs("sday2"),4)%>/<%=mid(rs("sday2"),5,2)%>/<%=right(rs("sday2"),2)%></td>
		<td><%=rs("scompany")%></td>
		<td align=right><%=FormatCurrency(rs("oldmoneyhap"),0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(rs("oldmoneyhap_vat"),0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(rs("tprice2"),0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(rs("tprice_vat"),0)%> &nbsp; </td>
		<td align=right><%=FormatCurrency(rs("tprice2")+rs("tprice_vat"),0)%> &nbsp; </td>
		<td><%=imsiflag%></td>
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