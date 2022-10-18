<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/account/dataup/fun.asp"-->

<%
	seq   = request("seq")
	stxt1 = request("stxt1")
	stxt2 = request("stxt2")

	SQL = "delete tAccountM where seq = "& seq
	db.Execute SQL
	db.close

	response.redirect "list2.asp?stxt1="&stxt1&"&stxt2="&stxt2
%>
