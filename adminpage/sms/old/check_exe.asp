<%
strpasswd = Request.form("passwd")
%>
<!-- #include file = "./DBConnect.inc"  -->
<%
sql = "select userId from em_b2c_client where userId='" & strpasswd & "'"
set rs = DBConn.Execute(sql)

if rs.eof or rs.bof then%>

<script language="javascript">
                alert("\n�������� �ʴ� ��� �Դϴ�.�ٽ� �õ��� �ּ���^^")
                history.back();
        </script>
		
<%else
session("sessionid") = strpasswd
response.redirect("send_msg.asp")
%>
<% end if %>

<%
rs.close
set rs=nothing
DBConn.close
set DBConn=nothing
%>
