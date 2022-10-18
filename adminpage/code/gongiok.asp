<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	flag = request("flag")
	hflag = request("hflag")
	content = replace(request("content"),"'","''")
	wsize = request("wsize")
	hsize = request("hsize")
	loginflag = request("loginflag")

	SQL = "update tb_gongi set "
	SQL = SQL & " flag = '"& flag &"' "
	SQL = SQL & " ,hflag = '"& hflag &"' "
	SQL = SQL & " ,wsize = '"& wsize &"' "
	SQL = SQL & " ,hsize = '"& hsize &"' "
	SQL = SQL & " ,loginflag = '"& loginflag &"' "
	SQL = SQL & " ,content = '"& content &"' "
	db.Execute SQL

	db.close
	set db=nothing

	response.redirect "gongi.asp"

%>
