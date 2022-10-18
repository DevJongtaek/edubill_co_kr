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

		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,usercode,ordermoney "
		SQL = sql & " from tb_order"

		if session("Ausergubun")="3" then
			SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if
		'SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "

		if searchc <> "" and searchc <> "0" then
			SQL = sql & " and substring(usercode,6,5) = '"& searchc &"' "
		end if

		if searchf <> "" and searchf <> "0" then
			SQL = sql & " and substring(usercode,11,5) = '"& searchf &"' "
		end if

		if searchd <> "" then
			SQL = sql & " and orderday >= '"& searchd &"' "
		end if

		if searche <> "" then
			SQL = sql & " and orderday <= '"& searche &"' "
		end if

		if searchg<>"0" then
			SQL = sql & " and  carname = '"& searchg &"' "
		end if

		SQL = sql & " and flag = 'n' and deflag = 'n' "
		rs.Open sql, db, 1

		do until rs.eof
			SQL = "update tb_order set "
			SQL = SQL & " flag = 'y' ,"
			SQL = SQL & " ordering = '9' ,"
			SQL = SQL & " rordermoney = "&rs(2)&" ,"
			SQL = SQL & " edate = '"& now() &"', "
			SQL = SQL & " euserid = '"& session("Auserid") &"' "
			SQL = SQL & " where idx = '"& rs(0) &"' "
			db.Execute SQL

			set rs2 = server.CreateObject("ADODB.Recordset")
			SQL = " select pidx,ordernum "
			SQL = sql & " from tb_order_product"
			SQL = sql & " where idx = '"& rs(0) &"' "
			rs2.Open sql, db, 1

			do until rs2.eof
				SQL = "update tb_order_product set "
				SQL = SQL & " rordernum = "& rs2(1) &" ,"
				SQL = SQL & " edate = '"& now() &"', "
				SQL = SQL & " euserid = '"& session("Auserid") &"' "
				SQL = SQL & " where pidx = "& rs2(0)
				db.Execute SQL
			rs2.movenext
			loop
			rs2.close
		rs.movenext
		loop
		rs.close

		response.redirect "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchc="&searchc&"&searchf="&searchf&"&searchh="&searchh
%>
