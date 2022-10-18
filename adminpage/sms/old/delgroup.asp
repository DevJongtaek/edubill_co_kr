<%
if session("sessionid") = "" or isnull(session("sessionid")) = true then
	response.redirect("check.html")
end if
%>
<!-- #include file = "./DBConnect.inc"  -->
<%
strgpk = Request("gpk")
sql = "delete em_addr_group where PK='"&strgpk&"'"
DBConn.Execute(sql)
%>
<%
sql1 = "delete em_addr_group_person where groupPk='"&strgpk&"'"
DBConn.Execute(sql1)
%>
<%
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