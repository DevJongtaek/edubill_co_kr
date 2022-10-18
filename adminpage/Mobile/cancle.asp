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
	cancleMoney = Request("cancleMoney")
	if cancleMoney="" or isnull(cancleMoney) then cancleMoney=0

	gotopage = request("gotopage")
	idx = request("idx")
	pidx = request("pidx")
	ordernum = request("ordernum")
	if ordernum="" then
		ordernum=1
	end if

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select ordermoney,usercode from tb_order where idx = '"& idx &"' "
	rs.Open sql, db, 1
	old_imsihapmoney = rs(0)
	usercode = rs(1)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag from tb_company where idx = "& left(usercode,5)
	rs.Open sql, db, 1
	rs_myflag = rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select mi_money from tb_company where idx = "& right(usercode,5)
	rs.Open sql, db, 1
	rs_mi_money = rs(0)
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select flag,ordermoney "
	SQL = sql & " from tb_order "
	SQL = sql & " where idx = '"& idx &"' "
	rs.Open sql, db, 1
	wflag1 = rs(0)
	rs_ordermoney = rs(1)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select top 1 flag "
	SQL = sql & " from tb_order_product "
	SQL = sql & " where idx = '"& idx &"' "
	rs.Open sql, db, 1
	wflag2 = rs(0)
	rs.close

	if wflag1="n" and wflag2="F" then

		SQL = "update tb_order_product set "
		'SQL = SQL & " ordernum = 0 ,"
		SQL = SQL & " rordernum = 0 ,"
		SQL = SQL & " edate = '"& now() &"', "
		SQL = SQL & " euserid = '"& session("Auserid") &"' "
		SQL = SQL & " where idx = '"& idx &"' "
		db.Execute SQL

		SQL = "update tb_order set "
		'SQL = SQL & " ordermoney = 0, "
		SQL = SQL & " rordermoney = 0, "
		SQL = SQL & " edate = '"& now() &"', "
		SQL = SQL & " euserid = '"& session("Auserid") &"' "
		SQL = SQL & " where idx = '"& idx &"' "
		db.Execute SQL


		sql = "update tb_company set mi_money = mi_money-"& CDbl(cancleMoney) &" "
		sql = sql & " where idx = "& int(right(session("AAusercode"),5)) &" "
		db.execute sql

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'if rs_myflag="y" then
		'	rs_mi_money2  = rs_mi_money - CDbl(cancleMoney)
		'	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'	sql = "update tb_company set mi_money = "& rs_mi_money2 &" "
		'	sql = sql & " where idx = "& right(usercode,5)
		'	db.execute sql
		'end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	end if

	db.close
	set db=nothing
	'response.redirect "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchh="&searchh
	jsmsg =  "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchh="&searchh
%>
			<Script language=javascript>
				alert("주문정보 취소가 성공적으로 이루어졌습니다.");
				location.href = "<%=jsmsg%>";
			</Script>