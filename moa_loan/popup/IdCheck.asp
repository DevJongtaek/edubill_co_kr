<!--#include virtual="/moa_loan/db/db.asp"-->
<html> 
<head> 
<title>���̵��ߺ�Ȯ��</title> 
<style type="text/css"> 
<!-- 
    BODY, table, tr, td, font,input, textarea, select 
    { 
        font-family: ����; 
        font-size: 9pt; 
    } 
--> 
</style> 
<script Language="JavaScript"> 
<!-- 
function confirm(idck) 
{ 
    var id = idck.id.value 
    opener.form.userid.value = id; 
    opener.form.userpwd.focus(); 
    self.close(); 
} 
//--> 
</script> 
</head> 

<body> 

<center> 
<font color=Green size=3>���̵� �ߺ� �˻�</font> 
<form method='POST' action="IdCheck.asp"> 
<hr size=0 width=300> 
<input type=text name=id size=15 maxlength=10 style='border:solid 1;'> 
<!--<input type=submit name="�ߺ�Ȯ��" value="�ߺ�Ȯ�� "  alt='�ߺ�Ȯ��'> -->
<input type=image src= "/images/admin/member_01.gif" alt='�ߺ�Ȯ��' align=absmiddle>
<hr size=0 width=300> 
</form> 

<% 
Dim id 
id = Request.form("id") 
if(id = "") then 
    Response.Write "<font>���Ͻô� ���̵�(ID)�� �Է��Ͻÿ� <br>(������ ���ڸ� �̿��� 4�� �̻� 10�� ����)</font>" 
elseif(Len(id) < 4 or Len(id) > 15) then 
    Response.Write "<font>4�� �̻��� ���̵� �����մϴ�.</font>" 
else 
  
    '�ߺ����̵�üũ 
    set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select count(*) from tb_LoanUser where userid = '" & id &"'"
		rs.Open sql, db, 1
		uid = rs(0)
		rs.close
    
    if uid = 0 then 
        Response.Write "�Է��Ͻ� ���̵� <font color=blue style='font-weight: bold'>" & id & "</font>�� ��밡���մϴ�.<br>" & _ 
            "�� ���̵� ����Ͻðڽ��ϱ�? <p>" &_ 
            "<form method='POST' name='check'>" & _ 
            "<input type=hidden name=id value='" & id & "'>" &_ 
            "<input type=image src='/images/admin/l_bu16.gif' BORDER=0 OnClick='confirm(document.check);' align=absmiddle>" & _ 
            "</form>" 
    else 
        Response.Write "�Է��Ͻ� ���̵� <font color=blue><b>" & _ 
            id & "</font></b>��(��) " & _ 
            "<font color=red>�����ϴ� ���̵�</font>�Դϴ�.<p>" & _ 
            "�ٸ� ���̵� �Է��ϼ���" 
    end if 

end if 
%> 
</center> 
<body> 
</html>