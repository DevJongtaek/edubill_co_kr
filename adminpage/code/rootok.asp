<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	flag = request("flag")
	userpwd = request("userpwd")
	userid = session("Auserid")
	mentout = request("mentout")

	if flag="" then
		SQL = "update tb_adminuser set "
		SQL = SQL & " userpwd = '"& userpwd &"' "
		SQL = SQL & " where userid = 'root' "
		db.Execute SQL
	elseif flag="1" then
		SQL = "update tb_adminuser set "
		SQL = SQL & " userpwd = '"& userpwd &"' "
		SQL = SQL & " where userid = 'admin' "
		db.Execute SQL
	elseif flag="2" then
		ip = request("ip")
		id = request("id")
		pwd = request("pwd")
		tbname = request("tbname")
		dbname = request("dbname")
		msg = request("msg")
		msg2 = request("msg2")
		msg3 = request("msg3")
        msg4 = request("msg4")
		cType = request("cType")

		SQL = "update tb_smsSetup set "
		SQL = SQL & " ip = '"& ip &"', "
		SQL = SQL & " id = '"& id &"', "
		SQL = SQL & " pwd = '"& pwd &"', "
		SQL = SQL & " tbname = '"& tbname &"', "
		SQL = SQL & " dbname = '"& dbname &"', "
		SQL = SQL & " msg = '"& msg &"', "
		SQL = SQL & " msg2 = '"& msg2 &"', "
		SQL = SQL & " msg3 = '"& msg3 &"', "
		SQL = SQL & " cType = '"& cType &"', "
        SQL = SQL & " msg4 = '"& msg4 &"' "
		db.Execute SQL
	elseif flag="3" then
		SQL = "update tb_adminuser set "
		SQL = SQL & " mentout = '"& mentout &"' "
		SQL = SQL & " where userid = 'root' "
		db.Execute SQL
		
		elseif flag="4" then
		
		ServerIp = request("ServerIp")
		DBid = request("DBid")
		Password = request("Password")
		
		
		SQL = "update tb_AdminDB set "
		SQL = SQL & " ServerIp = '"& ServerIp &"', "
		SQL = SQL & " id = '"& DBid &"', "
		SQL = SQL & " Password = '"& Password &"' "
	
		db.Execute SQL
		
		
	end if

	db.close
	set db=nothing
	response.redirect "root.asp"

%>
