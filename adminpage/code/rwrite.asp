<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	idx = request("idx")
	if idx<>"" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bidx,idx,bname "
		SQL = sql & " from tb_company_Retrurn "
		SQL = sql & " where idx = "& idx
		rs.Open sql, db, 1
	end if

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>��ǰ��������</title>

<script language="JavaScript">
<!--
function bkindwrite(frm) {
	if (frm.bname.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		frm.bname.focus() ;
		return false ;
	}
	frm.submit() ;
}

function bkindwrite2(form) {
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}
//-->
</script>
    <style type="text/css">
        .auto-style1 {
            width: 25%;
        }
    </style>
</head>

<body leftmargin="0" topmargin="0">

<table width="470" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ ��ǰ�������� ]</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td class="auto-style1"><B>�ڵ��ȣ</td>
		<td width=30%><B>��ǰ����</td>
		<td width=50%><B>����</td>
	</tr>
<%
if idx<>"" then
do until rs.EOF
%>

<form action="rwriteok.asp" method=post name=form>
<input type=hidden name=bidx value="<%=rs("bidx")%>">
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=dflag>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td class="auto-style1"><%=rs("bidx")%></td>
		<td><input type=text name=bname value="<%=rs("bname")%>" size=13></td>
		<td><input type="button" value="�� ��" style='background-color:#C1C184;' style="width:49%;" onclick="return bkindwrite(this.form);"> <input type="button" value="�� ��" style='background-color:#C1C184;' style="width:49%;" onclick="return bkindwrite2(this.form);"></td>
	</tr>

</form>

<%
rs.MoveNext 
loop 
end if
%>

<form action="rwriteok.asp" method=post name=form2>
<input type=hidden name=idx value="<%=idx%>">

	<tr height=22 bgcolor=#F7F7FF align=center align=center>
		<td class="auto-style1">�űԹ�ǰ�����Է�</td>
		<td><input type=text name=bname size=13></td>
		<td><input type="button" value="�� ��" style='background-color:#C1C184;' style="width:49%;" onclick="return bkindwrite(this.form);"></td>
	</tr>

</form>

</table>


				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>