<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	soundfile = replace(replace(request("soundfile")," ",""),"'","")
	hp1 = replace(replace(request("hp1")," ",""),"'","")
	hp2 = replace(replace(request("hp2")," ",""),"'","")
	hp3 = replace(replace(request("hp3")," ",""),"'","")
	email = replace(replace(request("email")," ",""),"'","")

	SQL = "update tb_company set "
	SQL = SQL & " soundfile = '"& soundfile &"' "
	SQL = SQL & " , email = '"& email &"' "
	SQL = SQL & " , hp1 = '"& hp1 &"' "
	SQL = SQL & " , hp2 = '"& hp2 &"' "
	SQL = SQL & " , hp3 = '"& hp3 &"' "
	SQL = SQL & " where idx = "& right(session("AAusercode"),5)
	db.Execute SQL
	db.close
	set db=nothing

	response.redirect "pwd.asp"
%>
