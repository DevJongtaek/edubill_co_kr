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

	oogubun = Request("oogubun")

	gotopage = request("gotopage")
	idx = request("idx")
	pidx = replace(request("pidx")," ","")
	rordernum = replace(request("rordernum")," ","")

if oogubun="" then

	imsiarrary1 = split(pidx,",")
	imsiarrary2 = split(rordernum,",")
	imsiarraryint1 = ubound(imsiarrary1)

	for i=0 to imsiarraryint1
		SQL = "update tb_order_product set "
		SQL = SQL & " rordernum = "& imsiarrary2(i) &" ,"
		SQL = SQL & " edate = '"& now() &"', "
		SQL = SQL & " euserid = '"& session("Auserid") &"' "
		SQL = SQL & " where pidx = "& imsiarrary1(i)
		db.Execute SQL
	next

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sum(rordernum*pprice) "
	SQL = sql & " from tb_order_product "
	SQL = sql & " where idx = '"& idx &"' "
	rs.Open sql, db, 1
	tothapmoney = int(rs(0))
	rs.close

	SQL = "update tb_order set "
	SQL = SQL & " flag = 'y' ,"
	SQL = SQL & " rordermoney = "& tothapmoney &", "
	SQL = SQL & " okday = '"& replace(left(now(),10),"-","") &"', "
	SQL = SQL & " ordering = '9', "
	SQL = SQL & " edate = '"& now() &"', "
	SQL = SQL & " euserid = '"& session("Auserid") &"' "
	SQL = SQL & " where idx = '"& idx &"' "
	db.Execute SQL

elseif oogubun="1" then

	SQL = "update tb_order set "
	SQL = SQL & " flag = 'n', "
	SQL = SQL & " rordermoney = 0, "
	SQL = SQL & " edate = '"& now() &"', "
	SQL = SQL & " euserid = '"& session("Auserid") &"' "
	SQL = SQL & " where idx = '"& idx &"' "
	db.Execute SQL

	SQL = "update tb_order_product set "
	'SQL = SQL & " rordernum = 0 "
	SQL = SQL & " edate = '"& now() &"', "
	SQL = SQL & " euserid = '"& session("Auserid") &"' "
	SQL = SQL & " where idx = '"& idx &"' "
	db.Execute SQL

elseif oogubun="2" then

	SQL = "update tb_order set "
	SQL = SQL & " deflag = 'n', "
	SQL = SQL & " deflagday = '', "
	SQL = SQL & " edate = '"& now() &"', "
	SQL = SQL & " euserid = '"& session("Auserid") &"' "
	SQL = SQL & " where idx = '"& idx &"' "
	db.Execute SQL

end if

	db.close
	set db=nothing
	'response.redirect "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3
	response.redirect "list.asp?gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg&"&searchh="&searchh&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3
%>























