<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if session("Ausergubun")="3" then
		codeFlagSql = " and substring(tb_order.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		codeFlagSql = " and substring(tb_order.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if session("Ausergubun")="3" then
		codeFlagSql2 = " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		codeFlagSql2 = " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " SELECT kbnumAreg "
	SQL = SQL & " FROM tb_company where flag='1' and idx = "& left(session("Ausercode"),5)
	rs.Open sql, db, 1
	if not rs.eof then
		kbnumAreg=rs(0)
	else
		kbnumAreg="n"
	end if
	rs.close
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if kbnumAreg="n" then
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = " update tb_order_product "
		SQL = SQL & " set tb_order_product.rordernum = tb_order_product.ordernum ,  "
		SQL = SQL & " tb_order_product.edate = '"& now() &"',  "
		SQL = SQL & " tb_order_product.euserid = '"& session("Auserid") &"' "
		SQL = SQL & " from tb_order , tb_order_product "
		SQL = SQL & " where "
		SQL = SQL & " tb_order.idx = tb_order_product.idx "
		SQL = SQL & codeFlagSql
		if searchc <> "" and searchc <> "0" then SQL = sql & " and substring(tb_order.usercode,6,5) = '"& searchc &"' "
		if searchf <> "" and searchf <> "0" then SQL = sql & " and substring(tb_order.usercode,11,5) = '"& searchf &"' "
		if searchd <> "" then SQL = sql & " and tb_order.orderday >= '"& searchd &"' "
		if searche <> "" then SQL = sql & " and tb_order.orderday <= '"& searche &"' "
		if searchg<>"0" then SQL = sql & " and tb_order.carname = '"& searchg &"' "
		SQL = sql & " and tb_order.flag = 'n' and tb_order.deflag = 'n' "
		db.Execute SQL
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = "update tb_order set "
		SQL = SQL & " flag = 'y' ,"
		SQL = SQL & " ordering = '9' ,"
		SQL = SQL & " rordermoney = ordermoney ,"
		SQL = SQL & " edate = '"& now() &"', "
		SQL = SQL & " euserid = '"& session("Auserid") &"' "
		SQL = SQL & codeFlagSql2
		if searchc <> "" and searchc <> "0" then SQL = sql & " and substring(usercode,6,5) = '"& searchc &"' "
		if searchf <> "" and searchf <> "0" then SQL = sql & " and substring(usercode,11,5) = '"& searchf &"' "
		if searchd <> "" then SQL = sql & " and orderday >= '"& searchd &"' "
		if searche <> "" then SQL = sql & " and orderday <= '"& searche &"' "
		if searchg<>"0" then SQL = sql & " and  carname = '"& searchg &"' "
		SQL = sql & " and flag = 'n' and deflag = 'n' "
		db.Execute SQL
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = " select a.idx as oSeq, c.idx as vSeq "
		SQL = sql & " from tb_order a, tb_company b , tb_virtual_acnt c "
		SQL = sql & " where substring(a.usercode,1,5)  = b.bidxsub "
		SQL = sql & " and   substring(a.usercode,6,5)  = b.idxsub "
		SQL = sql & " and   substring(a.usercode,11,5) = b.idx "

		SQL = sql & " and   b.virtual_acnt = c.va_no "
		SQL = sql & " and   c.tr_il >= '"& replace(left(now()-31,10),"-","") &"' "
		SQL = sql & " and   a.ordermoney = c.dep_amt "

		SQL = sql & " and   b.flag = '3' "
		SQL = sql & " and   c.orderCheck = 'n' "
		SQL = sql & " and   c.dep_st = '1' "

		if session("Ausergubun")="3" then
			SQL = sql & " and   b.bidxsub = "& mid(session("Ausercode"),1,5) &" "
			SQL = sql & " and   b.idxsub  = "& mid(session("Ausercode"),6,5) &" "
		else
			SQL = sql & " and   b.bidxsub = "& mid(session("Ausercode"),1,5) &" "
		end if

		SQL = sql & " and a.flag = 'n' and a.deflag = 'n' "
		if searchc <> "" and searchc <> "0" then SQL = sql & " and substring(a.usercode,6,5)  = '"& searchc &"' "
		if searchf <> "" and searchf <> "0" then SQL = sql & " and substring(a.usercode,11,5) = '"& searchf &"' "
		if searchd <> ""  then SQL = sql & " and a.orderday >= '"& searchd &"' "
		if searche <> ""  then SQL = sql & " and a.orderday <= '"& searche &"' "
		if searchg <> "0" then SQL = sql & " and a.carname   = '"& searchg &"' "

		SQL = sql & " order by a.idx asc "
'response.write sql
'response.end
		Set Rs = Db.Execute(SQL)
		if not rs.eof then
			imsiarr    = rs.GetRows
			imsiarrint = ubound(imsiarr,2)
		else
			imsiarr    = ""
			imsiarrint = ""
		end if
		rs.close
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if imsiarrint <> "" then
			for i=0 to imsiarrint
				oSeq = trim(imsiarr(0,i))
				vSeq = trim(imsiarr(1,i))
				if i=0 then
					oSeqVal = oSeq
					vSeqVal = vSeq
				else
					oSeqVal = oSeqVal &","& oSeq
					vSeqVal = vSeqVal &","& vSeq
				end if
			next
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if imsiarrint <> "" then
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			SQL = " update tb_order_product set "
			SQL = SQL & " rordernum = ordernum , edate = '"& now() &"', euserid = '"& session("Auserid") &"' "
			SQL = SQL & " where idx in ( "& oSeqVal &" ) "
			db.Execute SQL
			'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			SQL = "update tb_order set "
			SQL = SQL & " flag='y',ordering='9',rordermoney=ordermoney,edate='"& now() &"',euserid='"& session("Auserid") &"' "
			SQL = SQL & " where idx in ( "& oSeqVal &" ) "
			db.Execute SQL
			'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			SQL = "update tb_virtual_acnt set "
			SQL = SQL & " orderCheck ='y' "
			SQL = SQL & " where idx in ( "& vSeqVal &" ) "
			db.Execute SQL
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	response.redirect "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchc="&searchc&"&searchf="&searchf&"&searchh="&searchh
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>
