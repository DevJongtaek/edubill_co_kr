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
	searchk = request("searchk")
	searchl = request("searchl")
	searchm = request("searchm")

	'response.write searchm

	startdate = searchd & searchk
	enddate = searche & searchl
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
		SQL = " update tb_order_product set "
		'SQL = SQL & " tb_order_product.rordernum = tb_order_product.ordernum ,  "
		SQL = SQL & " tb_order_product.edate = '"& now() &"',  "
		SQL = SQL & " tb_order_product.euserid = '"& session("Auserid") &"' "
		SQL = SQL & " from tb_order , tb_order_product "
		SQL = SQL & " where "
		SQL = SQL & " tb_order.idx = tb_order_product.idx "
		SQL = SQL & codeFlagSql
		if searchc <> "" and searchc <> "0" then SQL = sql & " and substring(tb_order.usercode,6,5) = '"& searchc &"' "
		if searchf <> "" and searchf <> "0" then SQL = sql & " and substring(tb_order.usercode,11,5) = '"& searchf &"' "
		If Len(startdate) = 14 And searchm = "y" Then 
			SQL = sql & " and convert(datetime, left(tb_order.idx, 4) + '-' + substring(tb_order.idx, 5, 2) + '-' + substring(tb_order.idx, 7, 2) + ' ' + substring(tb_order.idx, 9, 2) + ':' + substring(tb_order.idx, 11, 2) + ':' + substring(tb_order.idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
		Else 
			if searchd <> "" Then  SQL = sql & " and tb_order.orderday >= '"& searchd &"' "
		End If
		If Len(enddate) = 14  And searchm = "y" Then 
			SQL = sql & " and convert(datetime, left(tb_order.idx, 4) + '-' + substring(tb_order.idx, 5, 2) + '-' + substring(tb_order.idx, 7, 2) + ' ' + substring(tb_order.idx, 9, 2) + ':' + substring(tb_order.idx, 11, 2) + ':' + substring(tb_order.idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) "			
		Else
			 if searche <> "" then SQL = sql & " and tb_order.orderday <= '"& searche &"' "
		End If 
		if searchg<>"0" then SQL = sql & " and tb_order.carname = '"& searchg &"' "
		SQL = sql & " and tb_order.flag = 'n' and tb_order.deflag = 'n' "
		response.write SQL
		'db.Execute SQL
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = "update tb_order set "
		SQL = SQL & " flag = 'y' ,"
		SQL = SQL & " ordering = '9' ,"
		'SQL = SQL & " rordermoney = ordermoney ,"
		SQL = SQL & " edate = '"& now() &"', "
		SQL = SQL & " euserid = '"& session("Auserid") &"' "
		SQL = SQL & codeFlagSql2
		if searchc <> "" and searchc <> "0" then SQL = sql & " and substring(usercode,6,5) = '"& searchc &"' "
		if searchf <> "" and searchf <> "0" then SQL = sql & " and substring(usercode,11,5) = '"& searchf &"' "
		If Len(enddate) = 14  And searchm = "y" Then 
			SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "			
		Else
			 if searchd <> "" then SQL = sql & " and orderday >= '"& searchd &"' "
		End If 
		If Len(enddate) = 14  And searchm = "y" Then 
			SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) "			
		Else
			if searche <> "" then SQL = sql & " and orderday <= '"& searche &"' "
		End If 
		if searchg<>"0" then SQL = sql & " and  carname = '"& searchg &"' "
		SQL = sql & " and flag = 'n' and deflag = 'n' "
		db.Execute SQL
		response.write SQL
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = " select a.idx as oSeq, c.idx as vSeq, c.dep_amt "
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
		If Len(enddate) = 14  And searchm = "y" Then 
			SQL = sql & " and convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "			
		Else
			 if searchd <> ""  then SQL = sql & " and a.orderday >= '"& searchd &"' "
		End If 
		If Len(enddate) = 14  And searchm = "y" Then 
			SQL = sql & " and convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) "			
		Else
			if searche <> ""  then SQL = sql & " and a.orderday <= '"& searche &"' "
		End If 
		
		if searchg <> "0" then SQL = sql & " and a.carname   = '"& searchg &"' "

		'SQL = sql & " order by a.idx asc "
		SQL = sql & " order by c.dep_amt asc, a.idx asc, c.idx desc "
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
				vAmt = trim(imsiarr(2,i))
				'''''''''''''''''''''''''''''''''''''''''''''
				n_vAmt = vAmt
				if i=0 then o_vAmt = vAmt
				'''''''''''''''''''''''''''''''''''''''''''''
					if i=0 then
						oSeqVal = oSeq
						vSeqVal = vSeq
				'''''''''''''''''''''''''''''''''''''''''''''
					elseif i>0 and n_vAmt<>o_vAmt then
				'''''''''''''''''''''''''''''''''''''''''''''
						oSeqVal = oSeqVal &","& oSeq
						vSeqVal = vSeqVal &","& vSeq
					end if
				'''''''''''''''''''''''''''''''''''''''''''''
				o_vAmt = n_vAmt
				'''''''''''''''''''''''''''''''''''''''''''''
			next
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if imsiarrint <> "" then
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			SQL = " update tb_order_product set "
			'SQL = SQL & " rordernum = ordernum , edate = '"& now() &"', euserid = '"& session("Auserid") &"' "
			SQL = SQL & " edate = '"& now() &"', euserid = '"& session("Auserid") &"' "
			SQL = SQL & " where idx in ( "& oSeqVal &" ) "
			db.Execute SQL
			'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			SQL = "update tb_order set "
			'SQL = SQL & " flag='y',ordering='9',rordermoney=ordermoney,edate='"& now() &"',euserid='"& session("Auserid") &"' "
			SQL = SQL & " flag='y',ordering='9',edate='"& now() &"',euserid='"& session("Auserid") &"' "
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
	response.redirect "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchc="&searchc&"&searchf="&searchf&"&searchh="&searchh&"&searchk="&searchk&"&searchl="&searchl
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>
