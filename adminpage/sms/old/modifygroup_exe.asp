<%
if session("sessionid") = "" or isnull(session("sessionid")) = true then
	response.redirect("check.html")
end if
%>
<!-- #include file = "./DBConnect.inc"  -->
<%
officenum = session("sessionid")
strgname = request.form("gname")
strgpk = request.form("gpk")


sql1 = "select * from em_addr_group_person where groupPK='"& strgpk &"'"
set rs1 = DBConn.Execute(sql1)

do while not rs1.eof 
	qur1 = "delete em_addr_group_person where personPK='"& rs1("personPK") &"' and groupPK='"& strgpk &"'"
	set rs = DBconn.execute(qur1)
rs1.movenext 
loop

for i = 1 to request("sel_person[]").count
	qur = "insert into em_addr_group_person(groupPK, personPK) values ('"& strgpk &"', '"& request("sel_person[]")(i) &"')"
	set rs = DBconn.execute(qur)
next

sql = "update em_addr_group set groupName='"& strgname &"' where userId='" & officenum & "' and PK='"& strgpk &"'"
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