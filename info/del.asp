<!--#include virtual="/db/db.asp"-->
<%
	pagegubun = request("pagegubun")
	idx = request("idx")
	pwd = request("pwd")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select pwd from tb_info where idx = "& idx
	rs.Open sql, db, 1
	pwd2 = rs(0)
	rs.close

	if pwd = pwd2 then
		SQL = "delete tb_info where idx = "& idx
		db.Execute SQL
		db.close
%>

		<script language="javascript">
			alert("삭제되었습니다.");
			self.opener.location.href = "list.asp?pagegubun=<%=pagegubun%>";
			window.close();
		</script>

<%
	else
%>
		<script language="javascript">
			alert("비밀번호가 다릅니다.")
			history.go(-1);
		</script>
<%
	end if
%>