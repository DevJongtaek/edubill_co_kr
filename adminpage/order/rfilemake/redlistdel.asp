<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	idx = request("idx")
	gotopage = request("gotopage")

	Sql = "delete tb_download where idx = "& idx
	db.execute(Sql)
	db.close
	set db=nothing

	response.redirect "dlist.asp?gotopage="&gotopage
%>