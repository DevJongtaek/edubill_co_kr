<!--#include virtual="/adminpage/incfile/sessionend2.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	Function FunErrorMsg(errormsg)	'에러메세지
		FunErrorMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg &"');history.back(-1);</SCRIPT>"
		response.write FunErrorMsg
		response.end
	End Function

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

	d_requestday = request("d_requestday")
	request_day1 = request("request_day1")
	request_day2 = request("request_day2")

	pidx = replace(request("pidx")," ","")
	pidxarray = split(pidx,",")
	pidxarray_int = ubound(pidxarray)

	ordernum = replace(request("ordernum")," ","")
	ordernumarray = split(ordernum,",")

	in_kmoney = request("in_kmoney")
	in_smoney = request("in_smoney")
	in_kmoney = split(in_kmoney,",")
	in_smoney = split(in_smoney,",")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select ordermoney,usercode from tb_order where idx = '"& idx &"' "
	rs.Open sql, db, 1
	old_imsihapmoney = rs(0)
	usercode = rs(1)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag,myflag_select from tb_company where idx = "& left(usercode,5)
	rs.Open sql, db, 1
	rs_myflag        = rs(0)
	rs_myflag_select = rs(1)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select mi_money,ye_money from tb_company where idx = "& right(usercode,5)
	rs.Open sql, db, 1
	if not rs.eof then
		rs_mi_money = rs(0)
		rs_ye_money = rs(1)
	else
		rs_mi_money = 0
		rs_ye_money = 0
	end if
	rs.close
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if rs_myflag="y" and rs_myflag_select="2" then

		'old_imsihapmoney 원래주문금액 rs_pro_money_hap 신규주문금액
		if pidxarray_int<>"" then
			rs_pro_money_hap = 0
			for i=0 to pidxarray_int
				set rs = server.CreateObject("ADODB.Recordset")
				SQL = " select pprice from tb_order_product where pidx = "& int(trim(pidxarray(i)))
				rs.Open sql, db, 1
'response.write rs(0)
				if not rs.eof then
					rs_pro_money_hap = rs_pro_money_hap + (CDbl(rs(0)) * CDbl(ordernumarray(i)))
				end if
				rs.close
			next
		end if

		rs_imsimi_money = CDbl(rs_mi_money)-CDbl(old_imsihapmoney)
		if rs_imsimi_money < 0 then rs_imsimi_money=0
		rs_OrderMoney = rs_ye_money - rs_imsimi_money
		CutOrderMoney = rs_OrderMoney - rs_pro_money_hap
		if CutOrderMoney<0 then
			JavaOrderOkMoney  = formatnumber(rs_OrderMoney,0)
			JavaOrderMoney    = formatnumber(rs_pro_money_hap,0)
			JavaOrderNotMoney = formatnumber(CutOrderMoney,0)
			JavaTxt = "여신한도가 초과되어 주문을 하실 수 없습니다.\n\n"
			JavaTxt = JavaTxt & "주문내역을 조정하여 다시 주문 바랍니다.!!!\n\n"
			JavaTxt = JavaTxt & "▶ 주문가능 금액 : "& JavaOrderOkMoney  &" 원\n\n"
			JavaTxt = JavaTxt & "▶ 주문하신 금액 : "& JavaOrderMoney    &" 원\n\n"
			JavaTxt = JavaTxt & "▶ 초과 금액     : "& JavaOrderNotMoney &" 원"
			call FunErrorMsg(JavaTxt)
		end if
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if d_requestday="y" and (len(request_day1)>0 or len(request_day2)>0) then
		if len(request_day1)=1 then
			request_day1 = "0"&request_day1
		elseif len(request_day1)=2 then
			if int(request_day1) > 12 then
				request_day1 = ""
			else
				request_day1 = request_day1
			end if
		elseif request_day1="" then
			request_day1 = ""
		end if	
		if len(request_day2)=1 then
			request_day2 = "0"&request_day2
		elseif len(request_day2)=2 then
			if int(request_day2) > 31 then
				request_day2 = ""
			else
				request_day2 = request_day2
			end if
		elseif request_day2="" then
			request_day2 = ""
		end if
		if request_day1<>"" and request_day2<>"" then
			request_day = request_day1&request_day2
		else
			'request_day = ""
			call FunErrorMsg("배달요청일자를 월은 01~12, 일자는 01~31 범위로 입력해 주십시요.")
		end if
	elseif d_requestday="n" or d_requestday="" then
		request_day = ""
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select top 1 b.flag "
	SQL = sql & " from tb_order a ,tb_order_product b"
	SQL = sql & " where a.idx = b.idx "
	SQL = sql & " and a.idx = '"& idx &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		wflag = rs(0)
	else
		wflag = "F"
	end if
	rs.close

	if wflag="F" then
		if pidxarray_int<>"" then
			for i=0 to pidxarray_int
				SQL = "update tb_order_product set "
				SQL = SQL & " ordernum = "& trim(ordernumarray(i)) &" ,"
				SQL = SQL & " rordernum = "& trim(ordernumarray(i)) &" ,"
				SQL = SQL & " edate = '"& now() &"', "
				SQL = SQL & " euserid = '"& session("Auserid") &"' "
				SQL = SQL & " where pidx = "& trim(pidxarray(i))
				db.Execute SQL
			next
		end if

		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select pprice,ordernum "
		SQL = sql & " from tb_order_product "
		SQL = sql & " where idx = '"& idx &"' "
		rs.Open sql, db, 1
		if not rs.eof then
			imsihapmoney = 0
			do until rs.eof
				imsihapmoney = imsihapmoney+(CDbl(rs(0))*rs(1))
			rs.movenext
			loop
		end if
		rs.close

		SQL = "update tb_order set "
		SQL = SQL & " request_day = '"& request_day &"', "
		SQL = SQL & " ordermoney = "& imsihapmoney &", "
		SQL = SQL & " edate = '"& now() &"', "
		SQL = SQL & " euserid = '"& session("Auserid") &"' "
		SQL = SQL & " where idx = '"& idx &"' "
		db.Execute SQL

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if rs_myflag="y" then
			'rs_mi_money : 기존미수금 pro_money_hap	: 주문금액 imsihapmoney:신규주문금액 old_imsihapmoney:예전주문금액

			imsitaxmoney = 0
			for i=0 to ubound(ordernumarray)
				in_smoneyVal = trim(in_smoney(i))
				in_cnt       = trim(ordernumarray(i))
				imsitaxmoney = imsitaxmoney + (CDbl(in_smoneyVal)*CDbl(in_cnt))
			next
'response.write imsihapmoney &"a<BR>"
'response.write imsitaxmoney &"b<BR>"

			'pro_money_hap = imsihapmoney			'신규주문금액
			pro_money_hap = imsihapmoney+imsitaxmoney	'신규주문금액+세액


			rs_mi_money2  = rs_mi_money - CDbl(old_imsihapmoney)
			rs_mi_money3  = rs_mi_money2+pro_money_hap
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			sql = "update tb_company set mi_money = "& rs_mi_money3 &" "
			sql = sql & " where idx = "& right(usercode,5)
			db.execute sql
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if

	db.close
	set db=nothing
	response.redirect "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchh="&searchh
%>
