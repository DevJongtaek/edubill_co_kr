<!--#include virtual="/moa_loan/db/db.asp"-->
 <%
t_id=request("userid")

set rslist = server.CreateObject("ADODB.Recordset")
        sql = " select count(*) from tb_LoanUser"
        sql=sql +" where userid = '"& t_id &"'"
       
 %>

<html>
 <head>
 <title>ID �ߺ�Ȯ��</title>
 <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 <script language="JavaScript">
 <!-- -->
function id_submit(arg){
 if(arg != ""){
 id_check.submit();
 }
 else
 {
 alert("���̵� ���� �Է��Ͽ� �ֽʽÿ�.");
id_check.userid.focus();
 return false;
 }
 }

function set_id(id) {
 opener.document.forms[0].userid.value=id;
 self.close();
 }
 // -->

function id_submit(arg){
 if(arg != ""){
 id_check.submit();
 }
 else
 {
 alert("���̵� ���� �Է��Ͽ� �ֽʽÿ�.");
id_check.userid.focus();
 return false;
 }
 }

function set_id(id) {
 opener.document.forms[0].userid.value=id;
 self.close();
 }

</script>

</head>

<body bgcolor="#FFFFFF" omLoad="this.document.id_check.userid.focus();">
 <table width="300" border="0" cellspacing="0" cellpadding="0">
 <tr>
 <td>
 <table width="95%" border="1" cellspacing="0" cellpadding="5" align="center" height="150" bordercolorlight="#FF9900" bordercolordark="#FFFFFF">
 <tr bgcolor="#FFCC33">
 <td colspan="2" height="41">
 <div align="center"><font size="4" color="#0000FF"><b>ID �ߺ�Ȯ��</b></font></div>
 </td>
 </tr>
 <form method="post" name="id_check" action="id_check.asp" omsubmit='return id_submit(id_check.userid.value)'>
 <tr bgcolor="#F6F6F6">
 <td colspan="2" height="41">
 <div align="center">
 <input type="text" name="userid" size="10" maxlength="10" value="<%=t_id%>" >
 <input type="button" name="Submit" value="�˻�" omclick='id_submit(id_check.userid.value)' >
 </div>
 </td>
 </tr>
 </form>
 <tr bgcolor="#F6F6F6">
 <td colspan="2" align="center">

<%
 if rs.eof then
 %>

<font size="2">�Է��Ͻ� ���̵� [<font face="����" color="#FF0000"><%=t_id%></font>]
��<br>
 <br>
��밡���մϴ�.</font>
 <p>
 <input type="button" name="Submit2" value="���̵� ���" omclick="set_id('<%=t_id%>');" >
 <br>
 </p>


 <%
 else
 %>

<font size="2">�Է��Ͻ� ���̵� [<font face="����" color="#FF0000"><%=t_id%></font>]
��<br>
 <br>
�̹� �ٸ����� ������Դϴ�.</font><br>


 <%
 end if
 %>

</td>
 </tr>
 </table>
 </td>
 </tr>
 </table>
 </body>
 </html>

<%
 rs.close
 Conn.close
 set rs=nothing
 set Conn=nothing
 %>