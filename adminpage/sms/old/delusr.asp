<%
if session("sessionid") = "" or isnull(session("sessionid")) = true then
	response.redirect("check.html")
end if
%>
<!-- #include file = "./DBConnect.inc"  -->
<%
strpk = Request("pk")
sql = "delete em_addr_person where PK='"&strpk&"'"
DBConn.Execute(sql)
%>
<%
sql1 = "delete em_addr_group_person where personPK='"&strpk&"'"
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