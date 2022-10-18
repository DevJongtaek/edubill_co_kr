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
	searchk = request("searchk")
	searchl = request("searchl")
	searchm = request("searchm")

	''''''''''''''''''''''''''''''''''''
	startdate = searchd & searchk
	enddate = searche & searchl

	'response.write startdate & "<br>"

		'set rs = server.CreateObject("ADODB.Recordset")
		'SQL = " select idx,usercode,rordermoney "
		SQL = " select idx "
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

		If Len(startdate) = 14  And searchm = "y" Then 
			SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "			
		Else
			if searchd <> "" then
			SQL = sql & " and orderday >= '"& searchd &"' "
		end if

		End If 
		If Len(enddate) = 14  And searchm = "y" Then 
			SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) "			
		Else
			if searche <> "" then
				SQL = sql & " and orderday <= '"& searche &"' "
			end if
		End If 

		if searchg<>"0" then
			SQL = sql & " and  carname = '"& searchg &"' "
		end if

		SQL = sql & " and flag = 'y' and deflag = 'n' "
		'rs.Open sql, db, 1
		imsisql=sql

		'do until rs.eof
			SQL = "update tb_order set "
			SQL = SQL & " flag = 'y' ,"
			SQL = SQL & " deflag = 'y' ,"
			SQL = SQL & " ordering = '9' ,"
			SQL = SQL & " okday = '"& replace(left(now(),10),"-","") &"' ,"
			SQL = SQL & " deflagday = '"& replace(left(now(),10),"-","") &"' ,"
			'SQL = SQL & " rordermoney = "&rs(2)&" ,"
			SQL = SQL & " edate = '"& now() &"', "
			SQL = SQL & " euserid = '"& session("Auserid") &"' "
			'SQL = SQL & " where idx = '"& rs(0) &"' "
			SQL = SQL & " where idx in ("& imsisql &") "
			db.Execute SQL
			response.write SQL 
			'set rs2 = server.CreateObject("ADODB.Recordset")
			'SQL = " select pidx,rordernum "
			'SQL = sql & " from tb_order_product"
			'SQL = sql & " where idx = '"& rs(0) &"' "
			'rs2.Open sql, db, 1

			'do until rs2.eof
				'SQL = "update tb_order_product set "
				'SQL = SQL & " rordernum = "& rs2(1) &" ,"
				'SQL = SQL & " edate = '"& now() &"', "
				'SQL = SQL & " euserid = '"& session("Auserid") &"' "
				'SQL = SQL & " where idx = '"& rs(0) &"' "
				'db.Execute SQL
			'rs2.movenext
			'loop
			'rs2.close
		'rs.movenext
		'loop
		'rs.close

		response.redirect "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchc="&searchc&"&searchf="&searchf&"&searchh="&searchh&"&searchk="&searchk&"&searchl="&searchl
%>
