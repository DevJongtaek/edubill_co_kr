<!--#include virtual="/db/db.asp"-->
<%
	pagegubun = request("pagegubun")
	dname = request("dname")
	comname = request("comname")
	fname = request("fname")
	addr = request("addr")
	pwd = request("pwd")
	regnum = request("regnum")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select isnull(count(idx),0) from tb_info where dname = '"& dname &"' "
	rs.Open sql, db, 1
	imsicnt = rs(0)
	rs.close

	if imsicnt >= int(regnum) then
%>
		<script language="javascript">
			alert("�����ں� ��ϰǼ��� <%=regnum%>�Ǳ��� �Դϴ�.\n\n�����ڿ��� ���� �ϼ���.")
			history.go(-1);
		</script>
<%
	else

		SQL = "INSERT INTO tb_info(dname,comname,fname,addr,pwd,wdate) VALUES "
		SQL = SQL & " ('"& dname &"', '"& comname &"', '"& fname &"', '"& addr &"', '"& pwd &"', '"& now() &"' )"
		db.Execute SQL
		db.close

		response.redirect "list.asp?pagegubun="&pagegubun
	end if
%>