<%
if session("sessionid") = "" or isnull(session("sessionid")) = true then
	response.redirect("check.html")
end if
%>
<!-- #include file = "./DBConnect.inc"  -->
<%
officenum = session("sessionid")
strname = request.form("name")
strpphone = request.form("pphone")
strpk = request.form("pk")

sql1 = "select * from em_addr_group_person where personPK='"& strpk &"'"
set rs1 = DBConn.Execute(sql1)

do while not rs1.eof 
	qur1 = "delete em_addr_group_person where groupPK='"& rs1("groupPK") &"' and personPK='"& strpk &"'"
	set rs = DBconn.execute(qur1)
rs1.movenext 
loop

for i = 1 to request("sel_group[]").count
	qur = "insert into em_addr_group_person(groupPK, personPK) values ('"& request("sel_group[]")(i) &"', '"& strpk &"')"
	set rs = DBconn.execute(qur)
next

sql = "update em_addr_person set personName='"& strname &"', phone='"& strpphone &"' where userId='" & officenum & "' and PK='"& strpk &"'"
set rs = DBConn.Execute(sql)

DBConn.close
set DBConn=nothing
%>
<script Language="JavaScript">
<!-- 
function init()
{
	window.opener.location.reload();
	window.close();	
}
//-->
</script>
<html>
<body onLoad="init()">
</body>
</html>