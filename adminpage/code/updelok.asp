<!--#include virtual="/db/db.asp"-->
<%
	idx = request("idx")
	gotopage = request("gotopage")

	SQL = "delete tb_log "
	SQL = SQL & " where idx = "& idx
	db.Execute SQL

	response.redirect "updel.asp?gotopage="&gotopage
%>