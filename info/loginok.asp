<!--#include virtual="/db/db.asp" -->
<%
	'���̵�/��� ����''''''''''''''''''''''''''
	real_id  = "admin"
	real_pwd = "6070"
	'''''''''''''''''''''''''''
	imsi_userid = request("mid")
	imsi_userpwd = request("mpwd")

	if real_id=imsi_userid and real_pwd=imsi_userpwd then
		session("info") = "y"
		response.redirect "list.asp"
	else
%>
		<script language="javascript">
			alert("���̵� �Ǵ� ��й�ȣ�� Ʋ���ϴ�.\n�ٽ� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.")
			history.go(-1);
		</script>
<%
	end if

%>