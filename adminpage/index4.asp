<!--#include virtual="/adminpage/incfile/top2.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
'response.write "���̵�-"&session("AAusercode")
'response.end

	gongi = request("gongi")
	searchc = request("searchc")
	searchd = request("searchd")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select brandflag,brandbox,isnull(com_notice,''),isnull(chk_gongi1,''),isnull(chk_gongi2,'') "
	SQL = SQL & " from tb_company "
	SQL = SQL & " where idx = '"& left(session("AAusercode"),5) &"' "
	rs.Open sql, db, 1
	imsibrandflag = rs(0)
	imsibrandbox  = rs(1)
	imsicom_notice= rs(2)
	imsicom_notice= Replace(imsicom_notice,chr(13),"<br>")
	imsichk_gongi1 = Replace(rs(3),chr(13),"<br>")
	imsichk_gongi2 = Replace(rs(4),chr(13),"<br>")
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select cbrandchoice,isnull(ch_gongi,''),orderflag "
	SQL = SQL & " from tb_company "
	SQL = SQL & " where idx = '"& right(session("AAusercode"),5) &"' "
	rs.Open sql, db, 1
	if not rs.eof then
	imsicbrandchoice = replace(rs(0)," ","")
	imsich_gongi = Replace(rs(1),chr(13),"<br>")
	flagorderflag = rs(2)
	rs.close
	End If 

	imsigtitle = "���� ��������"
	if flagorderflag="4" then
		imsich_gongi = imsichk_gongi1
		imsigtitle = "���1 �޼���"
		if imsich_gongi="" then
			imsich_gongi = "��� #1 �޼����� �����ϴ�."
		end if
	elseif flagorderflag="5" then
		imsich_gongi = imsichk_gongi2
		imsigtitle = "���2 �޼���"
		if imsich_gongi="" then
			imsich_gongi = "��� #2 �޼����� �����ϴ�."
		end if
	end if

	if imsicbrandchoice<>"" and imsicbrandchoice<>"00000" then
		arrayBrand = split(imsicbrandchoice,",")
		arrayBrandInt = ubound(arrayBrand)
	end if
	'imsicbrandchoicenum = "00000"

	imsicount = 0
	imsicount1 = 0
	imsicount2 = 0
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select isnull(count(pcode),0) "
	SQL = SQL & " from tb_product "
	SQL = SQL & " where usercode = '"& left(session("AAusercode"),5) &"' "


		if arrayBrandInt<>"" and imsicbrandchoice<>"00000" then
			SQL = sql & " and ( cbrandchoice = '' or cbrandchoice = '00000' "
			for i=0 to arrayBrandInt
				SQL = sql & " or cbrandchoice like '%"& arrayBrand(i) &"%' "
			next
			SQL = sql & " ) "
		end if

		'if imsibrandflag="y" then		'�귣��üũ
		'	if imsicbrandchoice="" then	'ü�����귣�尡 ���о����϶�
		'		SQL = SQL & " and (cbrandchoice like '%"& imsicbrandchoicenum &"%') "
		'	else				'ü�����귣�尡 ������
		'		SQL = SQL & " and (cbrandchoice like '%"& imsicbrandchoicenum &"%' or cbrandchoice like '%"& imsicbrandchoice &"%') "
		'	end if
		'end if

	if searchc<>"" and searchd<>"" then
		SQL = sql & " and "& searchc &" like '%"& searchd &"%' "
	else

	end if
	rs.Open sql, db, 1
	imsicount = rs(0)
	rs.close

	if imsicount>1 then
		imsicount1 = int(imsicount/2)
		imsicount2 = imsicount-imsicount1
	end if

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

function move_site2(form) {
	var myindex=form.family2.selectedIndex
	if (form.family2.options[myindex].value == "")
	{
		alert("�޴��� ������ �ֽʽÿ�. ");
	}
	else
	{
		//window.open(form.family.options[myindex].value, "", "");
		location.href = form.family2.options[myindex].value;
	}
}

function pop_win(){
	popWindow.style.display="none";
}
function pop_win2(){
	popWindow2.style.display="none";
}

function bwrite() {
	var imsicnt = 0;
	for(var i=0; i<document.form2.ordernum.length;i++) 	//üũ�ڽ� ����
	{
		if(document.form2.ordernum[i].value != ""){
			imsicnt = 1
		}
	}
	if (imsicnt<1) {
		alert("�ֹ������� �Է��� �ּ���.") ;
		return false ;
	}
	document.all("btn1").disabled = true;
	form2.submit() ;
}

function searchchb(form) {
	if (form.searchc.value=="") {
		alert("�˻������� ������ �ּ���.") ;
		return false ;
	}
	if (form.searchd.value=="") {
		alert("�˻�� �Է��� �ּ���.") ;
		return false ;
	}
	form.submit() ;
	return false ;
}

</script>
<script>//document.form.ordernum[0].focus(); </script> 

<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="25">
		<td width=40%><B>[ ü���� ��ǰ�� �ֹ���� ]</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
<form name=afrm method=post action="index4.asp">

	<tr height="20">
		<td width=50%>

		<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
			<tr>
				<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>��ǰ�˻�</td>
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
<form name=form>
		<td width=50% align=right>
			�ֹ�������� : <select name="family" onChange="move_site(this.form)">
				<option value="index3.asp">��ǰ�ڵ��ֹ�
				<option value="index4.asp" selected>��ǰ���ֹ�
			</select>
			<select name="family2" onChange="move_site2(this.form)">
				<option value="index4.asp?orderby=pname" <%if request("orderby")="pname" then%>selected<%end if%>>��ǰ������
				<option value="index4.asp?orderby=pcode" <%if request("orderby")="pcode" then%>selected<%end if%>>��ǰ�ڵ�����
			</select>
<!--
			<input type=button value="��ǰ������"   onclick="location.href='index4.asp?orderby=pname'">
			<input type=button value="��ǰ�ڵ�����" onclick="location.href='index4.asp?orderby=pcode'">
-->
		</td>
	</tr>
</form>
</table>

<table cellspacing=0 cellpadding=0 width="100%" border=0 onload="onLoadTest();">

<form action="orderok3.asp" name=form2 method=post>
<input type=hidden name=imsicount value="<%=imsicount%>">


	<tr>
		<td width=48% align=center valign=top>

		<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width=15%><B>�ڵ�</td>
				<td width=32%><B>��ǰ��</td>
				<td width=20%><B>�ֹ�����</td>
				<td width=20%><B>�԰�</td>
				<td width=13%><B>�ܰ�</td>
			</tr>

<%
	orderby = request("orderby")
	if orderby="" then
		orderby = "pcode"
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select top "& imsicount1 &" pcode,pname,pprice,ptitle,proout "
	SQL = SQL & " from tb_product "
	SQL = SQL & " where usercode = '"& left(session("AAusercode"),5) &"' "

		if arrayBrandInt<>"" and imsicbrandchoice<>"00000" then
			SQL = sql & " and ( cbrandchoice = '' or cbrandchoice = '00000' "
			for i=0 to arrayBrandInt
				SQL = sql & " or cbrandchoice like '%"& arrayBrand(i) &"%' "
			next
			SQL = sql & " ) "
		end if

	if searchc<>"" and searchd<>"" then
		SQL = sql & " and "& searchc &" like '%"& searchd &"%' "
	else
		'if imsibrandflag="y" then		'�귣��üũ
		'	if imsicbrandchoice="" then	'ü�����귣�尡 ���о����϶�
		'		SQL = SQL & " and (cbrandchoice like '%"& imsicbrandchoicenum &"%') "
		'	else				'ü�����귣�尡 ������
		'		SQL = SQL & " and (cbrandchoice like '%"& imsicbrandchoicenum &"%' or cbrandchoice like '%"& imsicbrandchoice &"%') "
		'	end if
		'end if
	end if

	SQL = SQL & " order by "& orderby &" asc "
	rs.Open sql, db, 1
	i=1
%>
		<%
		do until rs.eof
			imsinum = i mod 2
			if imsinum=1 then
				imsibgcolor="bgcolor='white'"
			else
				imsibgcolor="bgcolor='#FCE7D6'"
			end if
		%>
			<tr height=25 <%=imsibgcolor%> align=center>
				<td><input type="text" name="pcode" maxlength="4" size=4 class="box_write" style="color:blue;ime-mode:disabled;" OnKeypress="onlyNumber();" readonly value="<%=rs(0)%>"></td>
				<td align=left><%=rs(1)%></td>
				<%if rs(4)="y" then%>
					<td><input type="text" name="ordernum" maxlength="4" size=4 class="box_write" style="ime-mode:disabled;" OnKeypress="onlyNumber();" tabindex=<%=i%>></td>
				<%else%>
					<td><input type="hidden" name="ordernum" tabindex=<%=i%>><font color=red>ǰ��</td>
				<%end if%>
				<td><%=rs(3)%></td>
				<td align=right><%=mid(FormatCurrency(rs(2)),2)%></td>
			</tr>
		<%rs.movenext%>
		<%i=i+1%>
		<%loop%>
		<%rs.close%>
		<%imsiii = i%>
		</table>

		</td>
		<td width=4% align=center></td>
		<td width=48% align=center valign=top>

		<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width=15%><B>�ڵ�</td>
				<td width=32%><B>��ǰ��</td>
				<td width=20%><B>�ֹ�����</td>
				<td width=20%><B>�԰�</td>
				<td width=13%><B>�ܰ�</td>
			</tr>

<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select pcode,pname,pprice,ptitle,proout "
	SQL = SQL & " from tb_product "
	SQL = SQL & " where usercode = '"& left(session("AAusercode"),5) &"' "
	SQL = SQL & " and pcode not in ( "
		SQL = SQL & " select top "& imsicount1 &" pcode "
		SQL = SQL & " from tb_product "
		SQL = SQL & " where usercode = '"& left(session("AAusercode"),5) &"' "

		if arrayBrandInt<>"" and imsicbrandchoice<>"00000" then
			SQL = sql & " and ( cbrandchoice = '' or cbrandchoice = '00000' "
			for i=0 to arrayBrandInt
				SQL = sql & " or cbrandchoice like '%"& arrayBrand(i) &"%' "
			next
			SQL = sql & " ) "
		end if

		if searchc<>"" and searchd<>"" then
			SQL = sql & " and "& searchc &" like '%"& searchd &"%' "
		else
			'if imsibrandflag="y" then		'�귣��üũ
			'	if imsicbrandchoice="" then	'ü�����귣�尡 ���о����϶�
			'		SQL = SQL & " and (cbrandchoice like '%"& imsicbrandchoicenum &"%') "
			'	else				'ü�����귣�尡 ������
			'		SQL = SQL & " and (cbrandchoice like '%"& imsicbrandchoicenum &"%' or cbrandchoice like '%"& imsicbrandchoice &"%') "
			'	end if
			'end if
		end if

		SQL = SQL & " order by "& orderby &" asc "
	SQL = SQL & " ) "

		if arrayBrandInt<>"" and imsicbrandchoice<>"00000" then
			SQL = sql & " and ( cbrandchoice = '' or cbrandchoice = '00000' "
			for i=0 to arrayBrandInt
				SQL = sql & " or cbrandchoice like '%"& arrayBrand(i) &"%' "
			next
			SQL = sql & " ) "
		end if

	if searchc<>"" and searchd<>"" then
		SQL = sql & " and "& searchc &" like '%"& searchd &"%' "
	else
		'if imsibrandflag="y" then		'�귣��üũ
		'	if imsicbrandchoice="" then	'ü�����귣�尡 ���о����϶�
		'		SQL = SQL & " and (cbrandchoice like '%"& imsicbrandchoicenum &"%') "
		'	else				'ü�����귣�尡 ������
		'		SQL = SQL & " and (cbrandchoice like '%"& imsicbrandchoicenum &"%' or cbrandchoice like '%"& imsicbrandchoice &"%') "
		'	end if
		'end if
	end if
	SQL = SQL & " order by "& orderby &" asc "
	rs.Open sql, db, 1
	i=1
%>
		<%
		do until rs.eof
			imsinum = i mod 2
			if imsinum=1 then
				imsibgcolor="bgcolor='white'"
			else
				imsibgcolor="bgcolor='#FCE7D6'"
			end if
		%>
		<%imsiii = imsiii+i%>
			<tr height=25 <%=imsibgcolor%> align=center>
				<td><input type="text" name="pcode" maxlength="4" size=4 class="box_write" style="color:blue;ime-mode:disabled;" OnKeypress="onlyNumber();" readonly value="<%=rs(0)%>"></td>
				<td align=left><%=rs(1)%></td>
				<%if rs(4)="y" then%>
					<td><input type="text" name="ordernum" maxlength="4" size=4 class="box_write" style="ime-mode:disabled;" OnKeypress="onlyNumber();" tabindex=<%=imsiii%>></td>
				<%else%>
					<td><input type="hidden" name="ordernum" tabindex=<%=imsiii%>><font color=red>ǰ��</td>
				<%end if%>
				<td><%=rs(3)%></td>
				<td align=right><%=mid(FormatCurrency(rs(2)),2)%></td>
			</tr>
		<%rs.movenext%>
		<%i=i+1%>
		<%loop%>
		<%rs.close%>

		</table>

		</td>
	</tr>
</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>
			<input type="image" src="/images/admin/l_bu01.gif" border=0 tabindex=<%=imsiii+1%> name=btn1 onclick="return bwrite()">
			<a href="index4.asp"><img src="/images/admin/l_bu02.gif" border=0></a>
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

<%if gongi="1" and imsicom_notice<>"" then%>
<!--------���̾� �˾�---------->
<div id="popWindow" style="position:absolute; left:<%if imsich_gongi<>"" then%>30<%else%>80<%end if%>px; top:370px; z-index:0; visibility;" onSelectStart="return false" isInfoWin="true">
<table width="350" height=100 cellpadding="0" cellspacing="0" border="0" bgcolor=white>
	<tr>
		<td height=25 bgcolor=#2A75B6 width=70%>&nbsp; <font color=white><b>* ��ü ��������</td>
		<td height=25 bgcolor=#2A75B6 width=30% align=right><a href="#" onclick="pop_win()"><font color=white><B>[ â �� �� ]</a>&nbsp; </td>
	</tr>
	<tr>
		<td valign=top bgcolor=#F4FB9F align=center colspan=2>

		<table width="97%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td><font color=black><B><%=imsicom_notice%></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td colspan=2 height=20 bgcolor=#2A75B6 align=right></td>
	</tr>
</table>
</div>
<!--//�˾�-->
<%end if%>

<%if imsich_gongi<>"" then%>
<!--------���̾� �˾�---------->
<div id="popWindow2" style="position:absolute; left:390px; top:370px; z-index:0; visibility;" onSelectStart="return false" isInfoWin="true">
<table width="350" height=100 cellpadding="0" cellspacing="0" border="0" bgcolor=white>
	<tr>
		<td height=25 bgcolor=#2A75B6 width=70%>&nbsp; <font color=white><b>* <%=imsigtitle%></td>
		<td height=25 bgcolor=#2A75B6 width=30% align=right><a href="#" onclick="pop_win2()"><font color=white><B>[ â �� �� ]</a>&nbsp; </td>
	</tr>
	<tr>
		<td valign=top bgcolor=#F4FB9F align=center colspan=2>

		<table width="97%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td><font color=black><B><%=imsich_gongi%></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td colspan=2 height=20 bgcolor=#2A75B6 align=right></td>
	</tr>
</table>
</div>
<!--//�˾�-->
<%end if%>

<!--#include virtual="/adminpage/incfile/bottom2.asp"-->