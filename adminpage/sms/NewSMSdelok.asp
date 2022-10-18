<!--#include virtual="/db/db.asp"-->
<%
	idx = request("idx")
	gotopage = request("gotopage")

	SQL = "delete NewSMS "
	SQL = SQL & " where idx = "& idx
	db.Execute SQL

	response.redirect "NewSMS.asp"
%>