<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	searcha1 = replace(left(now(),10),"-","")
	searcha2 = replace(left(now(),10),"-","")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,comname,tcode,datadel,datadelday "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '1' and serviceflag='2' "
	SQL = sql & " order by comname asc"
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
		<td><font color=blue size=3><B>[ ����Ÿ���� ]</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>�� ü������  �����ֱ� ���� �� 9085 �ż�Ǫ�� / 9224 �׶� (���ñ��� 1���� ����)</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>�� ���ñ��� 2���� �������� �� ���� ���� ��, ���� ( ������ ü�κ��� ��� )</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="alldelok2.asp" method="POST" name=findkindform>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> �ֹ�����Ÿ ����</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" valign=top> 
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
			<tr>
				<td colspan=2>
					<select name="searcha" size="1" class="box_work">
			          		<option value="">����</option>
          					<option value="1">���ñ��� 1������ ���� ����Ÿ����</option>
			          		<option value="2">���ñ��� 2������ ���� ����Ÿ����</option>
			          		<option value="3">���ñ��� 3������ ���� ����Ÿ����</option>
          					<option value="4">���ñ��� 1������ ���� ����Ÿ����</option>
			          		<option value="5">���ñ��� 2������ ���� ����Ÿ����</option>
			          		<option value="6" selected>ü������ �����ֱ� ����</option>
			        	</select>
				</td>
			</tr>
			<tr>
				<td width=1>
					<select name="companycode" size="30" class="box_work" multiple >
          					<!--<option value="">ȸ���� ����</option>-->
						<%
						i=0
						do until rs.eof
							datadel    = rs(3)
							datadelday = rs(4)
							if isnull(datadelday) then
								datadelday = ""
							end if
							if left(datadelday,10)<>left(now(),10) then
						%>
	          						<option value="<%=rs(0)%>" <%if i=0 then%>selected<%end if%>><%=rs(2)%>&nbsp;<%=rs(1)%><%if datadelday<>"" then%>&nbsp;(��������:<%=left(datadelday,10)%>)<%end if%>
								<%i=1%>
							<%end if%>
						<%rs.movenext%>
						<%loop%>
						<%rs.close%>
			        	</select>
				</td>
				<td valign=top align=left>&nbsp; <input type="button" value="�� ��" class="box_work"' onclick="javascript:alldelok3(this.form);"></td>
			</tr>
		</table>		        	
		</td>
	</tr>

</form>

<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,comname,tcode "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '1'"
	SQL = sql & " order by comname asc"
	rs.Open sql, db, 1
%>

<form action="alldelok3.asp" method="POST" name=findkindform2>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> ��ǰ/ü���� ����</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="bcode" size="1" class="box_work">
          		<option value="">ȸ���� ����</option>
			<%do until rs.eof%>
	          		<option value="<%=rs(0)%>"><%=rs(2)%>&nbsp;<%=rs(1)%>
			<%rs.movenext%>
			<%loop%>
			<%rs.close%>
        	</select>
		<select name="gubun" size="1" class="box_work">
          		<option value="">��������</option>
          		<option value="1">��ǰ����Ÿ
          		<option value="2">ü��������Ÿ
        	</select>
        	<input type="button" value="�� ��" class="box_work"' onclick="javascript:alldelok2(this.form);">
		</td>
	</tr>

</form>

<script>
function alldelokCh1(form){
	if (form.dflag.value=="") {
		alert("���������� ������ �ֽñ� �ٶ��ϴ�.") ;
		form.dflag.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.submit() ;
		return false ;
	}
//	form.submit() ;
}

function alldelokCh2(form){
	if (form.dflag.value=="") {
		alert("���������� ������ �ֽñ� �ٶ��ϴ�.") ;
		form.dflag.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.submit() ;
		return false ;
	}
//	form.submit() ;
}
</script>
<form action="alldelokS.asp" method="POST" name=findkindform3>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> ���ݰ�꼭 ����</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="dflag" size="1" class="box_work">
          		<option value="">����</option>
          		<option value="1">�ֱ� 6���� ���� ������ ����
          		<option value="2">�ֱ� 1�� ���� ������ ����
          		<option value="3">�ֱ� 2�� ���� ������ ����
        	</select>
        	<input type="button" value="�� ��" class="box_work"' onclick="javascript:alldelokCh1(this.form);">
		</td>
	</tr>

</form>

<form action="alldelokI.asp" method="POST" name=findkindform4>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> �Աݳ��� ����</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="dflag" size="1" class="box_work">
          		<option value="">����</option>
          		<option value="1">�ֱ� 6���� ���� ������ ����
          		<option value="2">�ֱ� 1�� ���� ������ ����
          		<option value="3">�ֱ� 2�� ���� ������ ����
        	</select>
        	<input type="button" value="�� ��" class="box_work"' onclick="javascript:alldelokCh2(this.form);">
		</td>
	</tr>

</form>

</table>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->