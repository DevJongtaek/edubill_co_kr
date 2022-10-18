<!--#include virtual="/db/db.asp"-->

<%
	idx=request("idx")
	username=replace(request("name"),"'","''")
	pwd=replace(request("pwd"),"'","''")
	mcontent=replace(request("mcontent"),"'","''")
	gotopage=request("gotopage")
	uid=request("uid")
	searcha = request("searcha")
	searchb = request("searchb")
	userid=session("userid")

	SQL = "INSERT INTO tb_ment (idx,userid,username,wdate,mcontent,pwd) VALUES "
 	SQL = SQL & "(" & idx & " "
 	SQL = SQL & ",'" & userid & "'"
 	SQL = SQL & ",'" & username & "'"
 	SQL = SQL & ",'" & now() & "'"
 	SQL = SQL & ",'" & mcontent & "' "
 	SQL = SQL & ",'" & pwd & "')"
 	db.Execute SQL

	db.close
	set rs=nothing
	set db=nothing

	response.redirect "content.asp?idx="&idx&"&gotopage="&gotopage&"&uid="&uid&"&searcha="&searcha&"&searchb="&searchb
%>

