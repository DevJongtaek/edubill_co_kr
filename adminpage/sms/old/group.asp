<html>
<head>
<title>�׷� �����</title>

<%
if session("sessionid") = "" or isnull(session("sessionid")) = true then
	response.redirect("check.html")
end if
%>
<%
officenum = session("sessionid")
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<LINK REL="StyleSheet" TYPE="text/css" HREF="../common/StyleSheet.css">
<title>���� �����</title>
<SCRIPT LANGUAGE="JavaScript" SRC="formValid.js"></SCRIPT>
<script language="javascript">
<!--
function valid(form)
{
	var nRight = form.elements['sel_person[]'].length;
	var nCur = 0;
	for (i = 0; i < nRight; i++)
	{
		form.elements['sel_person[]'].options[nCur].selected = true ;
	}
	
	
	for (i=0; i < form.elements['sel_person[]'].length; i++) 
		form.elements['sel_person[]'].options[i].selected = true;		
	return true;
}

function to_right(form)
{
	var i;
	var isthere = 0;
	
	for(i = 0; i < form.total_group.length; i++){
		if (form.total_group.options[i].selected) {
			isthere = 1;
			if (!findInSelect(form.elements['sel_person[]'], 
form.total_group.options[i].value)) {
				myOption = new Option(form.total_group.options[i].text, 
form.total_group.options[i].value);
				form.elements['sel_person[]'][form.elements['sel_person[]'].length] = 
myOption;
			}
		}
	}
	
	if (isthere == 0) 
		alert("�����Ͽ��� �ϳ��̻� �����ϼž� �մϴ�");
}

function to_left(form){
	var i;
	var isthere = 0;
   
	var nRight = form.elements['sel_person[]'].length;
	var nCur = 0;
	for (i = 0; i < nRight; i++)
	{
		if (form.elements['sel_person[]'].options[nCur].selected) {
			isthere = 1;
			form.elements['sel_person[]'][nCur] = null;
		}
		else
			nCur++;
	}
	
	if (isthere == 0) 
		alert("�����Ͽ��� �ϳ��̻� �����ϼž� �մϴ�");
}

function findInSelect (sel, txt)
{
	var i;
	for (i = 0; i < sel.length; i++) {
		if (sel.options[i].value == txt)
			return true;
	}
	
	return false;
}

//-->
</script>
</head>

<body>
<center>
<form method="post" name="form" action="group_exe.asp" onSubmit="return valid(this)">
<table border=0 cellpadding=0 cellspacing=0 width="300">
<tr>
<td align="center"><font face="����" size="3"><b>�׷� �����</b></font></td>
</tr>
</table><br><br>
<!-------------�׷� �̸� �Է� ����----------->
<table border=0 cellpadding=0 cellspacing=0 width="300">
<tr>
<td colspan="2" colspan="2"><font face="����"size="2"><b>�׷� ���� �Է�</b></font></td>
</tr>
<tr>
<td bgcolor="#aa8c9b" width="70"><font face="����" size="2" color="#FFFFFF"><b>�׷� �̸�</b></font></td>
<td>&nbsp;<input type=text name="gname" size="10" maxlength="16"><font size="2"><strong><font color="#FF0000">*</font></strong></font></td>
</tr>
</table><br><br>
<!--------------�׷� �̸� �Է� ��----------->
<!--------------������ ���� ����------------>
<table cellpadding=2 cellspacing=1 border="0" align="center" width="300">
<tr>
<td colspan="3" height="26"><font face="����" size="2"><b>������ ����</b></font></td>
</tr>

	<tr>
	  <td bgcolor="#aa8c9b" width="130" align="center"><font face="����" size="2" color="#FFFFFF"><b>��� ���</b></font></td>
	  <td width="40"> </td>
	  <td bgcolor="#aa8c9b" width="130" align="center"><font face="����" size="2" color="#FFFFFF"><b>�� �׷��� ������</b></font></td>
	</tr>
	<tr>
	  <td class="tblZero" align=center>
<select name="total_group" size="6" multiple onDblClick="to_right(this.form)">
<!-- #include file = "./DBConnect.inc"  -->
<%
officenum = session("sessionid")
sql = "select PK, personName from em_addr_person where userId = '"&officenum&"'"
set rs = DBConn.Execute(sql)
%>
<% while not rs.eof %>
<option value="<%=rs("PK")%>"><%=rs("personName")%> </option>
<% 
rs.movenext 
wend
%>
</select>
	</td>
	<td align=center>
	
	<input type="button" name="toright" 
		value="&nbsp;&gt;&gt;&nbsp;" onClick="to_right(this.form)"> <br>
	    <input type="button" name="toleft" 
	    value="&nbsp;&lt;&lt;&nbsp;" onClick="to_left(this.form)">
	
		
	</td>
	<td class="tblZero" align=center>
		<select multiple name="sel_person[]" size="6"
		      	onDblClick="to_left(this.form)">	
		</select>
	</td>
	</tr>

    <tr>
      <td class="tblNoColor" colspan="3">
      <font face="����" size="2" color="#FF0000">*</font><font face="����" size="2">�� ���� ����</font>
      </td>
    </tr>
    <tr>
    <td align="center" colspan=3>
    	<input type="submit" value="Ȯ ��"> 
    	<input type="reset" value="�� ��">
    	<input type="button" value="â�ݱ�" onClick="window.close();">
    </td>
</tr>
</table>
<!--------------������ ���� ��-------------->
</form>
</center>
</body>
</html>