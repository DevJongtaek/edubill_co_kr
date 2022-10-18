<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")

	fclass1 = Request("fclass1")
	sclass2 = Request("sclass2")
	tclass3 = Request("tclass3")

	gotopage = request("gotopage")
	idx = request("idx")
	pidx = replace(request("pidx")," ","")

	imsicarno = replace(request("imsicarno")," ","")
	
	SQL = "update tb_order set "
	SQL = SQL & " carname = '"& imsicarno &"' "
	SQL = SQL & " where idx = '"& idx &"' "
	db.Execute SQL

	db.close
	set db=nothing
	'response.redirect "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3
	response.redirect "write.asp?idx="&idx&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg&"&searchh="&searchh&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3
%>
