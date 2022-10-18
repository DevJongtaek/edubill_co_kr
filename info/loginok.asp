<!--#include virtual="/db/db.asp" -->
<%
	'아이디/비번 셋팅''''''''''''''''''''''''''
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
			alert("아이디 또는 비밀번호가 틀립니다.\n다시 입력하여 주시기 바랍니다.")
			history.go(-1);
		</script>
<%
	end if

%>