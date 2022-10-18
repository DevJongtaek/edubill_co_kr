<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	snum = request("snum")
	if snum<>"" then
		SQL = "update tb_virtual_acnt set "
		SQL = SQL & " orderCheck = 'y' "
		SQL = SQL & " where idx in ( "& snum &" ) "
		db.Execute SQL
	end if
	db.close
	set db=nothing

	response.write "<SCRIPT LANGUAGE=JavaScript>parent.location.reload();</SCRIPT>"
%>
