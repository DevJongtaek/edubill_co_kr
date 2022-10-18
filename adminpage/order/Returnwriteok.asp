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

'response.write oogubun
'response.end

if oogubun="" then	'주문확인
	imsiarrary1    = split(pidx,",")
	imsiarrary2    = split(rordernum,",")
	imsiarraryint1 = ubound(imsiarrary1)
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	for i=0 to imsiarraryint1
		SQL = "update tb_order_product set "
		SQL = SQL & " rordernum = "& imsiarrary2(i) &" ,"
		SQL = SQL & " edate = '"& now() &"', "
		SQL = SQL & " euserid = '"& session("Auserid") &"' "
		SQL = SQL & " where pidx = "& imsiarrary1(i)
		db.Execute SQL
	next
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select rordermoney,usercode,ordermoney from tb_order where idx = '"& idx &"' "
	rs.Open sql, db, 1
	old_imsihapmoney = rs(0)	'예전주문금액
	usercode = rs(1)		'해당코드
	imsiordermoney = CDbl(rs(2))
	rs.close
	if isnull(old_imsihapmoney) then
		old_imsihapmoney=0
	else
		old_imsihapmoney=CDbl(old_imsihapmoney)
	end if
	if old_imsihapmoney=0 then old_imsihapmoney=imsiordermoney
'response.write old_imsihapmoney &" : "& imsiordermoney
'response.end
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag,myflag_select from tb_company where idx = "& left(usercode,5)
	rs.Open sql, db, 1
	rs_myflag        = rs(0)	'여신체크
	rs_myflag_select = rs(1)
	rs.close
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if rs_myflag="y" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select mi_money,ye_money from tb_company where idx = "& right(usercode,5)
		rs.Open sql, db, 1
		if not rs.eof then
			rs_mi_money = rs(0)	'기존미수금
			rs_ye_money = rs(1)	'기존여신
		else
			rs_mi_money = 0
			rs_ye_money = 0
		end if
		rs.close
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sum(rordernum*pprice) "
	SQL = sql & " from tb_order_product "
	SQL = sql & " where idx = '"& idx &"' "
	rs.Open sql, db, 1
	tothapmoney = CDbl(rs(0))
	rs.close
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "update tb_order set "
	SQL = SQL & " flag = 'y' ,"
	SQL = SQL & " rordermoney = "& tothapmoney &", "
	SQL = SQL & " okday = '"& replace(left(now(),10),"-","") &"', "
	SQL = SQL & " ordering = '9', "
	SQL = SQL & " edate = '"& now() &"', "
	SQL = SQL & " euserid = '"& session("Auserid") &"' "
	SQL = SQL & " where idx = '"& idx &"' "
	db.Execute SQL
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if rs_myflag="y" then
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		imsihapmoney  = tothapmoney	'신규주문금액
		pro_money_hap = imsihapmoney	'신규주문금액
		rs_mi_money2  = CDbl(rs_mi_money) - CDbl(old_imsihapmoney)	'미수-예전주문금액
		rs_mi_money3  = rs_mi_money2+pro_money_hap			'
'response.write rs_mi_money3
'response.end
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		sql = "update tb_company set mi_money = "& rs_mi_money3 &" "
		sql = sql & " where idx = "& right(usercode,5)
		db.execute sql
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
elseif oogubun="1" then		'주문확인취소

	SQL = "update tb_order set "
	SQL = SQL & " flag = 'n', "
	'SQL = SQL & " rordermoney = 0, "
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
	response.redirect "Returnlist.asp?gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg&"&searchh="&searchh&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3
%>























