<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	imsititlename = "���ݰ�꼭 ����"
	stxt1 = request("stxt1")
	stxt2 = request("stxt2")
	seq   = request("seq")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tAccountM "
	SQL = sql & " where seq = "& seq
	rs.Open sql, db, 1

	imsitcode  = rs("tcode")
	imsijtcode = rs("jtcode")
	imsiwdate  = rs("wdate")

	idate  = rs("idate")
	imoney = rs("imoney")
	if idate<>"" and imoney>0 then btnSee = "n"

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select count(seq) from tAccountM "
	SQL = SQL & " where flag = '0' and tcode = '"& imsitcode &"' "
	if imsijtcode<>"" then
		SQL = SQL & " and jtcode = '"& imsijtcode &"' "
	end if
	SQL = SQL & " and wdate = '"& imsiwdate &"' "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsinum = rs2(0)
	end if
	rs2.close

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select isnull(sum(Anum),0),isnull(sum(kmoney),0),isnull(sum(smoney),0),isnull(sum(hmoney),0) "
	SQL = sql & " from tAccountM "
	SQL = sql & " where wdate = '"& rs("wdate") &"' and flag='0' and tcode = '"& imsitcode &"' "
	if imsijtcode<>"" then
		SQL = SQL & " and jtcode = '"& imsijtcode &"' "
	end if
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsiAnum   = rs2(0)
		imsikmoney = rs2(1)
		imsismoney = rs2(2)
		imsihmoney = rs2(3)
	else
		imsiAnum   = 0
		imsikmoney = 0
		imsismoney = 0
		imsihmoney = 0
	end if
	rs2.close

%>

<script language="JavaScript">
<!--
function onlyNumber()
{
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}

function excell_up()
{
	window.open ('dataup/excell_up.asp','ExcellID','width=450,height=120,left=100,top=100')
	return false ;
}

function checkValue() {
	if (form.textName.value=="") {
		alert("ȸ������� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.textName.focus() ;
		return false ;
	}
	if (form.companynum.value=="") {
		alert("����ڹ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum.focus() ;
		return false ;
	}
	if (form.companyAddr.value=="") {
		alert("�ּҸ� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companyAddr.focus() ;
		return false ;
	}
	if (form.companyName.value=="") {
		alert("��ǥ�ڸ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companyName.focus() ;
		return false ;
	}
	if (form.companyUptae.value=="") {
		alert("���¸� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companyUptae.focus() ;
		return false ;
	}

	if (form.companyUpjong.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companyUpjong.focus() ;
		return false ;
	}
	if (form.Aymd.value=="") {
		alert("û�����ڸ� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.Aymd.focus() ;
		return false ;
	}
	if (form.textPname.value=="") {
		alert("ǰ��(��)�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.textPname.focus() ;
		return false ;
	}
	if (form.textPname2.value=="") {
		alert("ǰ��(��)�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.textPname2.focus() ;
		return false ;
	}
	if (form.Anum.value=="") {
		alert("ü������(����)�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.Anum.focus() ;
		return false ;
	}
	if (form.umoney.value=="") {
		alert("�̿��(�ܰ�)�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.umoney.focus() ;
		return false ;
	}

<%if imsinum>0 then%>
	var imsicnt = 0;
	for(var i=0; i<document.form.textPname2A.length;i++){
		if(document.form.textPname2A[i].value == ""){
			imsicnt = 1
		}
	}
	if (imsicnt>0) {
		alert("ǰ��(��)�� ��� �ִ°��� �ֽ��ϴ�.") ;
		return false ;
	}

	var imsicnt = 0;
	for(var i=0; i<document.form.AnumA.length;i++){
		if(document.form.AnumA[i].value == ""){
			imsicnt = 1
		}
	}
	if (imsicnt>0) {
		alert("ü������(����)�� ��� �ִ°��� �ֽ��ϴ�.") ;
		return false ;
	}

	var imsicnt = 0;
	for(var i=0; i<document.form.umoneyA.length;i++){
		if(document.form.umoneyA[i].value == ""){
			imsicnt = 1
		}
	}
	if (imsicnt>0) {
		alert("�̿��(�ܰ�)�� ��� �ִ°��� �ֽ��ϴ�.") ;
		return false ;
	}
<%end if%>

	form.submit() ;
	return false ;
}

function delchb() {
	var msg;
	msg=confirm("���� �����Ͻðڽ��ϱ�?");
	if(msg) {
		location.href = "contentdel.asp?seq=<%=seq%>&stxt1=<%=stxt1%>&stxt2=<%=stxt2%>";
		return false ;
	}
}

//-->
</script>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td> &nbsp; <font color=blue size=3><B>[ <%=imsititlename%> ]</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">

<form action="editok.asp" method="POST" name=form>
<input type=hidden name="stxt1" value="<%=stxt1%>">
<input type=hidden name="stxt2" value="<%=stxt2%>">
<input type=hidden name="seq" value="<%=seq%>">

			<tr height="47">
				<td align=center>




<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=25 bgcolor=#F7F7FF align=center>
		<td width=15%>�ڵ�</td>
		<td width=35% bgcolor=white align=left>&nbsp;<%=rs("tcode")%><%if imsijtcode<>"" then%>&nbsp;(<%=imsijtcode%>)<%end if%></td>
		<td>û�����</td>
		<td bgcolor=white align=left>&nbsp;<%=left(rs("Aym"),4)%>/<%=right(rs("Aym"),2)%></td>
	</tr>
	<tr height=25 bgcolor=#F7F7FF align=center>
		<td>����Ͻ�</td>
		<td bgcolor=white align=left>&nbsp;<%=mid(rs("wdate"),1,4) &"/"& mid(rs("wdate"),5,2) &"/"& mid(rs("wdate"),7,2) &" "& mid(rs("wdate"),9,2) &":"& mid(rs("wdate"),11,2) &":"& mid(rs("wdate"),13,2)%></td>
		<td>ü������</td>
		<td bgcolor=white align=left>&nbsp;<%=formatnumber(rs("Anum")+imsiAnum,0)%></td>
	</tr>
	<tr height=25 bgcolor=#F7F7FF align=center>
		<td>���ް���</td>
		<td bgcolor=white align=left>&nbsp;<%=formatnumber(rs("kmoney")+imsikmoney,0)%></td>
		<td>�̿��</td>
		<td bgcolor=white align=left>&nbsp;<%=formatnumber(rs("umoney"),0)%></td>
	</tr>
	<tr height=25 bgcolor=#F7F7FF align=center>
		<td>����</td>
		<td bgcolor=white align=left>&nbsp;<%=formatnumber(rs("smoney")+imsismoney,0)%></td>
		<td>�հ�ݾ�</td>
		<td bgcolor=white align=left>&nbsp;<%=formatnumber(rs("hmoney")+imsihmoney,0)%></td>
	</tr>


	<tr height=25 bgcolor=#F7F7FF align=center>
		<td width=15%>ȸ�����</td>
		<td width=35% bgcolor=white align=left><input type=text name=hname value="<%=rs("hname")%>" style="width:100%"></td>
		<td>����ڹ�ȣ</td>
		<td bgcolor=white align=left><input type=text name=companynum value="<%=rs("companynum")%>" size=15 maxlength=15></td>
	</tr>
	<tr height=25 bgcolor=#F7F7FF align=center>
		<td width=15%>�� ��</td>
		<td colspan=3 bgcolor=white align=left><input type=text name=companyAddr value="<%=rs("companyAddr")%>" style="width:100%;"></td>
	</tr>
	<tr height=25 bgcolor=#F7F7FF align=center>
		<td>��ǥ�ڸ�</td>
		<td bgcolor=white align=left><input type=text name=companyName value="<%=rs("companyName")%>" style="width:100%"></td>
		<td>����</td>
		<td bgcolor=white align=left><input type=text name=companyUptae value="<%=rs("companyUptae")%>" style="width:100%"></td>
	</tr>
	<tr height=25 bgcolor=#F7F7FF align=center>
		<td>����</td>
		<td bgcolor=white align=left><input type=text name=companyUpjong value="<%=rs("companyUpjong")%>" style="width:100%"></td>
		<td>û������</td>
		<td bgcolor=white align=left><input type=text name=Aymd value="<%=rs("Aymd")%>" size=8 maxlength=8 onkeypress="onlyNumber()"></td>
	</tr>
	<tr height=25 bgcolor=#F7F7FF align=center>
		<td>ǰ��(��)</td>
		<td bgcolor=white align=left><input type=text name=textPname value="<%=rs("textPname")%>" style="width:100%"></td>
		<td>���</td>
		<td bgcolor=white align=left><input type=text name=textBigo value="<%=rs("textBigo")%>" style="width:100%"></td>
	</tr>




</table>

<BR>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=25 bgcolor=#F7F7FF align=center>
		<td width=10%>��ȣ</td>
		<td width=60%>ǰ��(��)</td>
		<td width=15%>ü������(����)</td>
		<td width=15%>�̿��(�ܰ�)</td>
	</tr>
	<tr height=25 bgcolor=white align=center>
		<td>1</td>
		<td><input type=text name=textPname2 value="<%=rs("textPname2")%>" style="width:100%"></td>
		<td><input type=text name=Anum value="<%=rs("Anum")%>" style="width:100%" onkeypress="onlyNumber()" maxlength=4></td>
		<td><input type=text name=umoney value="<%=rs("umoney")%>" style="width:100%" onkeypress="onlyNumber()" maxlength=7></td>
	</tr>

<%
	rs.close
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select * from tAccountM where flag = '0' and tcode = '"& imsitcode &"' and wdate = '"& imsiwdate &"' "
	if imsijtcode<>"" then
		SQL = SQL & " and jtcode = '"& imsijtcode &"' "
	end if
	SQL = SQL & " order by seq asc "
	rs.Open sql, db, 1
	if not rs.eof then
		i=2
		do until rs.eof
%>

			<input type=hidden name="seqA" value="<%=rs("seq")%>">
			<tr height=25 bgcolor=white align=center>
				<td><%=i%></td>
				<td><input type=text name=textPname2A value="<%=rs("textPname2")%>" style="width:100%"></td>
				<td><input type=text name=AnumA     value="<%=rs("Anum")%>"     style="width:100%" onkeypress="onlyNumber()" maxlength=4></td>
				<td><input type=text name=umoneyA   value="<%=rs("umoney")%>"   style="width:100%" onkeypress="onlyNumber()" maxlength=7></td>
			</tr>

<%
		rs.movenext
		i=i+1
		loop
	end if
	rs.close
%>

</table>

<table align=center>
	<tr> 
		<td height=30 align=center>
			<%if btnSee = "" then  %>
				<input type="image" src="/images/admin/l_bu03.gif" border=0 onclick="return checkValue();">
			<%end If
			'2011.04.06 ����,������ư ���̰�    %>
				<a href="#" onclick="delchb();"><img src="/images/admin/l_bu04.gif" border=0></a>
				<!--<a href="#" onclick="javascript:history.back();"><img src="/images/admin/l_bu07.gif" border=0></a>-->
			<a href="list2.asp?gotopag=<%=gotopage%>&stxt1=<%=stxt1%>&stxt2=<%=stxt2%>"><img src="/images/admin/l_bu07.gif" border=0></a>
		</td>
	</tr>

</form>

</table>

<BR><BR>
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