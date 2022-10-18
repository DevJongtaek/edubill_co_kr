<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/account/dataup/fun.asp"-->

<%
	wdate = request("wdate")
	imsipath = server.MapPath("/") & "\fileupdown\account\"

	SQL = " select distinct filename from tAccountM where wdate = '"& wdate &"' "
	Set Rs = Db.Execute(SQL)
	if not rs.eof then
		imsifname = rs(0)
		if imsifname<>"" then
			call FunFileDelete(imsipath,imsifname)
		end if
	end if
	rs.close

	SQL = "delete tAccountM where wdate = '"& wdate &"' "
	db.Execute SQL
	db.close

	response.redirect "list.asp"
%>
