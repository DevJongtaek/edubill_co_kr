<!--#include virtual="/db/db.asp"-->

<%
	Function FunErrorMsg(errormsg)	'에러메세지
			FunErrorMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg &"');history.back(-1);</SCRIPT>"
			response.write FunErrorMsg
			response.end
	End Function

	busercode = left(session("AAusercode"),5)	'본사실제코드
	jusercode = mid(session("AAusercode"),6,5)	'지사실제코드
	cusercode = mid(session("AAusercode"),11,5)	'체인점실제코드
	usercode = session("AAusercode")		'체인점 전체코드

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select top 1 idx,pcode,pname,pprice,ptitle,bigo "
	SQL = sql & " from tb_product "
	SQL = sql & " where usercode = '"& busercode &"' "
	SQL = sql & " order by pcode asc "
	rs.Open sql, db, 1
	rs_idx = rs(0)
	rs_pcode = rs(1)
	rs_pname = rs(2)
	rs_pprice = rs(3)
	rs_ptitle = rs(4)
	rs_bigo = rs(5)
	rs.close

	pcode = rs_pcode	'상품코드
	ordernum = 0		'주문수량
	order_cmt = replace(request("order_cmt"),"'","")

	d_requestday = "n"
	request_day1 = ""
	request_day2 = ""

	array_pcode = split(pcode,",")
	array_ordernum = split(ordernum,",")
	loopcount = ubound(array_pcode)

	'주문번호''''''''''''''''''''''''''''''''''''''
	o_yyy = replace(left(now(),10),"-","")
	ho = cstr(hour(time))
	if len(ho) = 1 then
		ho2 = "0"&ho
	else
		ho2 = ho
	end if
	mi = cstr(minute(time))
	if len(mi) = 1 then
		mi2 = "0"&mi
	else
		mi2 = mi
	end if
	se = cstr(second(time))
	if len(se) = 1 then
		se2 = "0"&se
	else
		se2 = se
	end if
	orderidx = o_yyy&ho2&mi2&se2&cusercode		'주문번호
	'주문번호''''''''''''''''''''''''''''''''''''''

	orderday = left(orderidx,8)			'주문일자8자리

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(jusercode)
	rs.Open sql, db, 1
	jcomname = rs(0)	'지사명
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname,dcarno "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(cusercode)
	rs.Open sql, db, 1
	ccomname = rs(0)	'체인점명
	dcarnoidx = rs(1)	'호차idx값
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where idx = "& int(dcarnoidx)
	rs.Open sql, db, 1
	dcarno = rs(0)	'호차번호
	rs.close

	pro_money_hap = 0

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sql = "insert into tb_order(idx,usercode,comname1,comname2,orderday,okday,ordermoney,rordermoney,carname,ordering,flag,wdate,wuserid,order_cmt,request_day,orderflag) values "
	sql = sql & " ('"& orderidx &"' "
	sql = sql & " ,'"& usercode &"' "
	sql = sql & " ,'"& jcomname &"' "
	sql = sql & " ,'"& ccomname &"' "
	sql = sql & " ,'"& orderday &"' "
	sql = sql & " ,'' "
	sql = sql & " ,"& pro_money_hap &" "
	sql = sql & " ,0 "
	sql = sql & " ,'"& dcarno &"' "
	sql = sql & " ,'0' "
	sql = sql & " ,'n' "
	sql = sql & " ,'"& now() &"' "
	sql = sql & " ,'"& session("AAuserid") &"' "
	sql = sql & " ,'"& order_cmt &"' "
	sql = sql & " ,'"& request_day &"' "
	sql = sql & " ,'y') "
	db.execute sql
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	for i=0 to loopcount
		pro_idx = ""		'실제상품코드
		pro_pcode = ""		'입력상품코드
		pro_pname = ""		'상품명
		pro_pprice = ""		'상품단가
		imsicount = 0

		if trim(array_pcode(i)) <> "" and trim(array_ordernum(i)) <> "" then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select idx,pcode,pname,pprice "
			SQL = sql & " from tb_product "
			SQL = sql & " where usercode = '"& busercode &"' and proout = 'y'"
			SQL = sql & " and pcode = '"& trim(array_pcode(i)) &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				pro_idx = rs(0)		'실제상품코드
				pro_pcode = rs(1)	'입력상품코드
				pro_pname = rs(2)	'상품명
				pro_pprice = 0	'상품단가
				imsicount = 1
				pro_money_hap = 0
			else
				imsicount = 0
			end if
			rs.close
		end if

		if imsicount = 1 then
			'주문상품저장
			sql = "insert into tb_order_product(idx,pcodeidx,pcode,pname,pprice,ordernum,rordernum,wdate,wuserid) values "
			sql = sql & " ('"& orderidx &"' "
			sql = sql & " ,'"& pro_idx &"' "
			sql = sql & " ,'"& pro_pcode &"' "
			sql = sql & " ,'"& pro_pname &"' "
			sql = sql & " ,"& pro_pprice &" "
			sql = sql & " ,"& trim(array_ordernum(i)) &" "
			sql = sql & " ,"& trim(array_ordernum(i)) &" "
			sql = sql & " ,'"& now() &"' "
			sql = sql & " ,'"& session("AAuserid") &"') "
			db.execute sql
		end if
	next
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sql = "update tb_order set ordermoney = 0 "
	sql = sql & " where idx='"& orderidx &"' "
	db.execute sql
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	response.redirect "commentokend.asp"
%>


