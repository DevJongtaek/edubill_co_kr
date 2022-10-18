<%
if session("sessionid") = "" or isnull(session("sessionid")) = true then
	response.redirect("check.html")
end if
%>
<!-- #include file = "./DBConnect.inc"  -->
<%
officenum = session("sessionid")
strgname = request.form("gname")

sql2 = "select PK from em_addr_group where userId = '"& officenum &"' and groupName = '"& strgname &"'"
set rs1 = DBConn.Execute(sql2)

if rs1.eof or rs1.bof then

	sql = "insert into em_addr_group(userId, groupName) values ('"&officenum&"' , '"&strgname&"')" 
	DBConn.Execute(sql)

	sql1 = "select PK from em_addr_group where userId='" & officenum & "' and groupName = '"&strgname&"'"
	set rs = DBConn.Execute(sql1)
	groupPK = rs("PK")

	for i = 1 to request("sel_person[]").count
		qur = " insert into em_addr_group_person(groupPK, personpk) values ('"&groupPK&"', '"&request("sel_person[]")(i)&"')"
		DBconn.execute(qur)
	next
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
<%
else
	call PrintMsg ("이미 등록되어있는 그룹 입니다.")

	Sub PrintMsg (text)
		Response.Write "<html><head>" & vbCRLF
		Response.Write "<SCRIPT LANGUAGE=""JavaScript"">" & vbCRLF
		Response.Write "<!--" & vbCRLF
		Response.Write "function Go()" & vbCRLF
		Response.Write "{" & vbCRLF
		Response.Write "setTimeout(""location.href = 'group.asp'"",700)" & vbCRLF
		Response.Write "}" & vbCRLF
		Response.Write "//-->" & vbCRLF
		Response.Write "</SCRIPT>" & vbCRLF
		Response.Write "</head>" & vbCRLF
		Response.Write "<body onLoad=""Go();"">" & vbCRLF
		Response.Write "<table width=100% height=80% >"
		Response.Write "<tr><td align=center>" & vbCRLF
		Response.Write "<font size=2 color=blue face=""돋움"">" & vbCRLF
		Response.Write text & vbCRLF
		Response.Write "</font></center>" & vbCRLF
		Response.Write "</td></tr></table>" & vbCRLF
		Response.Write "</body></html>" & vbCRLF
		Response.End
	End Sub
end if

DBConn.close
set DBConn=nothing
%>
