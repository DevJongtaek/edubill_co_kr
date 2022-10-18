<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	idx = request("idx")
	sidx = request("sidx")
	sname = request("sname")
	dflag = request("dflag")

	if sidx="" then
		SQL = "INSERT INTO tb_product_submenu(idx,sname) VALUES "
		SQL = SQL & " ("& idx &","
		SQL = SQL & " '"& sname &"')"
		db.Execute SQL
	else
		if dflag="" then
			SQL = "update tb_product_submenu set "
			SQL = SQL & " sname = '"& sname &"' "
			SQL = SQL & " where sidx = "&sidx
			db.Execute SQL
		else
			SQL = "delete tb_product_submenu "
			SQL = SQL & " where sidx = "&sidx
			db.Execute SQL

			SQL = "update tb_product set "
			SQL = SQL & " prochoice = '' "
			SQL = SQL & " where usercode = "& idx &" and prochoice = '"& sidx &"' "
			db.Execute SQL
		end if
	end if

	response.redirect "swrite.asp?idx="&idx

%>