<!--#include virtual="/adminpage/bbs/fileup.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	idx = upload("idx")
	dflag = upload("dflag")
	gotopage=upload("gotopage")

	if idx="" then
		SQL = "INSERT INTO tb_logo (filename,wdate) VALUES "
 		SQL = SQL & "('" & filename1 & "'"
 		SQL = SQL & ",'" & now() & "')"
	 	db.Execute SQL
	else
		if dflag = "" then
			SQL = "update tb_logo set "
 			SQL = SQL & " filename = '" & filename1 & "'"
 			SQL = SQL & " where idx = "& idx
		 	db.Execute SQL
		else
			SQL = "delete tb_logo "
 			SQL = SQL & " where idx = "& idx
		 	db.Execute SQL
		end if
	end if

	db.close
	set rs=nothing
	set db=nothing

	response.redirect "list.asp?gotopage="&gotopage

%>