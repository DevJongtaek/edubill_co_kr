<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	seq = request("seq")

set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,accountflag,homepage,comname from tb_company where flag='1' "
	SQL = sql & " and idx="&seq
	rs.Open sql, db, 1
	idx   = rs(0)
	wdate = rs(1)
	homepage = rs(2)
	c_comname    = rs(3)
	rs.close
	

%>

<html>
<head>
<title>���ݰ�꼭</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/adminpage/tax/stylefont_document.css" type="text/css">

<script language="javascript" src="/adminpage/incfile/javascript_data.js"></script>
<object id="factory" style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" 
codebase="/adminpage/account/smsx.cab#Version=6,2,433,70">
</object>
<script>
function printWindow() {
factory.printing.header        = "";   // Header�� �� ����
factory.printing.footer        = "";   // Footer�� �� ����
factory.printing.portrait      = true	// true ������� , false �������
factory.printing.leftMargin    = 10   // ���� ���� ������
factory.printing.topMargin     = 10   // �� ���� ������
factory.printing.rightMargin   = 10   // ������ ���� ������
factory.printing.bottomMargin  = 10   // �Ʒ� ���� ������

//factory.printing.SetMarginMeasure(2); // �׵θ� ���� ������ ������ ��ġ�� �����մϴ�.
//factory.printing.printer = "HP DeskJet 870C";  // ����Ʈ �� ������ �̸�
//factory.printing.paperSource = "Manual feed";   // ���� Feed ���
//factory.printing.collate = true;   //  ������� ����ϱ�
//factory.printing.copies = 2;   // �μ��� �ż�
//factory.printing.SetPageRange(false, 1, 3); // True�� �����ϰ� 1, 3�̸� 1���������� 3���������� ���
//factory.printing.paperSize = "A4";   // ���� ������
factory.printing.Print(false, window)	 // ��ȭ���� ǥ�ÿ��� / ��µ� �����Ӹ�
}

 function click() {
      if ((event.button==2) || (event.button==3)) {
         alert('����Ͻ÷��� F5(���ΰ�ħ)�� �Ͽ� �μ��Ͻñ� �ٶ��ϴ�!');
      }
   }
   document.onmousedown=click;

</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<table width="650" border="0" cellspacing="0" cellpadding="0">
  <tr height=5>
	<td>&nbsp;</td>
	</tr>
	<tr>
	 <td width="20px"></td><td>���ο��� 2014�� 7�� 1�Ϻ��� ���ڼ��ݰ�꼭 �ǹ� ������ Ȯ�� �����Կ� ����<td>
	</tr>
	<tr height=5>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>�� �翡���� �̺� �߸��� 2014�� 7���� ���� �Ʒ��� ���� ���ڼ��ݰ�꼭��<td>
	</tr>
	<tr height=5>
	<td>&nbsp;</td>
	</tr>
	<tr>
	 <td width="20px"></td><td>�����ϰ� �ֽ��ϴ�. ������ ���� ������ ���� �ٶ��ϴ�.<td>
	</tr>
	<tr height=10>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>�� �ŷ����� ���� : �� �� 20�� (�� �� Ȩ���������� Ȯ�� ���� )</td>
	</tr>
	<tr height=10>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>�� ���ڼ��ݰ�꼭 ���� : �� �� 25��</td>
	</tr>
	<tr height=10>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>�� ���ڼ��ݰ�꼭 ���� : �� �� 26�� (ȸ���簡 ������ e-���Ϸ� Ȯ�� ���� )</td>
	</tr>
	<tr height=10>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>�� e-���� : <font color="#0100FF"><%=homepage%> ( <%=c_comname%> )</font></td>
	</tr>
	<tr height=10>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td width="20px"></td><td>�� �� �� : 02-853-5111</td>
	</tr>
</table>


<br>
<br>




</body>
</html>

