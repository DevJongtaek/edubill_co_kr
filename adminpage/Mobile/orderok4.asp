<!--#include virtual="/db/db.asp"-->
<%
	Response.Expires = 0 
	Response.AddHeader "Pragma","no-cache"   
	Response.AddHeader "Cache-Control","no-cache,must-revalidate"  

	call ordertimechb(left(session("AAusercode"),5))	'주문차단시간 체크

	Function FunErrorMsg(errormsg)	'에러메세지
			FunErrorMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg &"');history.back(-1);</SCRIPT>"
			response.write FunErrorMsg
			response.end
	End Function

	busercode = left(session("AAusercode"),5)	'본사실제코드
	jusercode = mid(session("AAusercode"),6,5)	'지사실제코드
	cusercode = mid(session("AAusercode"),11,5)	'체인점실제코드
	usercode = session("AAusercode")			'체인점 전체코드

	pcode = trim(request("pcode"))			'상품코드
	ordernum = trim(request("ordernum"))		'주문수량

	order_cmt = replace(request("order_cmt"),"'","")

	d_requestday = request("d_requestday")	'y/n
	request_day1 = request("request_day1")
	request_day2 = request("request_day2")

	PMmoney = request("PMmoney")	'주문금액+세액
     YeMoney = request("YeMoney") '여신금액
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
	end if

	if request_day = "" then
		request_day = replace(mid(now()+1,6,5),"-","")
	end if

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
	SQL = " select myflag,smsflag,tcode,smsflagType ,vatflag,myflag_select"
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(busercode)
	rs.Open sql, db, 1
	rs_myflag = rs(0)	'미수체크여부
	smsflag = rs(1)
	smsttcode1 = rs(2)
	smsflagType = rs(3)
      vatflag = rs(4)
     rs_myflag_select = rs(5)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(jusercode)
	rs.Open sql, db, 1
	jcomname = rs(0)	'지사명
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname,dcarno,mi_money,ye_money,hp1,hp2,hp3,tcode,virtual_acnt_bank,virtual_acnt "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(cusercode)
	rs.Open sql, db, 1
	ccomname = rs(0)	'체인점명
	dcarnoidx = rs(1)	'호차idx값
	rs_mi_money = rs(2)
	rs_ye_money = rs(3)

	hp1 = rs(4)
	hp2 = rs(5)
	hp3 = rs(6)
	smsttcode2 = rs(7)
	virtual_acnt_bank = rs(8)
	virtual_acnt = rs(9)
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
	sql = "insert into tb_order(idx,usercode,comname1,comname2,orderday,okday,ordermoney,rordermoney,carname,ordering,flag,wdate,wuserid,order_cmt,request_day) values "
	sql = sql & " ('"& orderidx &"' "
	sql = sql & " ,'"& usercode &"' "
	sql = sql & " ,'"& jcomname &"' "
	sql = sql & " ,'"& ccomname &"' "
	sql = sql & " ,'"& orderday &"' "
	sql = sql & " ,'' "
	sql = sql & " ,"& pro_money_hap &" "
	sql = sql & " ,"& pro_money_hap &" "
	'sql = sql & " ,0 "
	sql = sql & " ,'"& dcarno &"' "
	sql = sql & " ,'0' "
	sql = sql & " ,'n' "
	sql = sql & " ,'"& now() &"' "
	sql = sql & " ,'"& session("AAuserid") &"' "
	sql = sql & " ,'"& order_cmt &"' "
	sql = sql & " ,'"& request_day &"') "
	db.execute sql
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sms_pname = ""
	sms_pnamecnt = 0
	for i=0 to loopcount
		pro_idx = ""		'실제상품코드
		pro_pcode = ""		'입력상품코드
		pro_pname = ""		'상품명
		pro_pprice = ""		'상품단가
		imsicount = 0
		pro_dcenterchoice = "0"

		if trim(array_pcode(i)) <> "" and trim(array_ordernum(i)) <> "" then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select idx,pcode,pname,pprice,dcenterchoice,gubun,case gubun when '과세' then convert(int, pprice +  pprice*0.1) else convert(int, pprice) end as tprice "
			SQL = sql & " from tb_product "
			'SQL = sql & " where usercode = '"& busercode &"' and proout = 'y'"
			SQL = sql & " where usercode = '"& busercode &"' "
			SQL = sql & " and pcode = '"& trim(array_pcode(i)) &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				pro_idx = rs(0)		'실제상품코드
				pro_pcode = rs(1)	'입력상품코드
				pro_pname = rs(2)	'상품명
				pro_pprice = rs(3)	'상품단가
				pro_dcenterchoice=rs(4)

         tprice = rs(6)  '과세/비과세'
				imsicount = 1
				pro_money_hap = pro_money_hap+(pro_pprice*array_ordernum(i))
    
                 if vatflag = "y"  or vatflag = "a" then
                pro_money_sum = pro_money_sum + (pro_pprice*array_ordernum(i))
                end if

                 if vatflag = "n" then
                pro_money_sum = pro_money_sum + (tprice*array_ordernum(i))
                end if
               ' pro_money_sum = pro_money_sum

			else
				imsicount = 0
			end if
			rs.close
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'if imsicount = 1 and int(trim(array_ordernum(i)))>0 then
		imsiccnt = trim(array_ordernum(i))
		if isnull(imsiccnt) or imsiccnt="" then imsiccnt=0
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if imsicount = 1 and imsiccnt>0 then
			'주문상품저장
			sql = "insert into tb_order_product(idx,pcodeidx,pcode,pname,pprice,ordernum,rordernum,wdate,dcenterchoice) values "
			sql = sql & " ('"& orderidx &"' "
			sql = sql & " ,'"& pro_idx &"' "
			sql = sql & " ,'"& pro_pcode &"' "
			sql = sql & " ,'"& pro_pname &"' "
			sql = sql & " ,"& pro_pprice &" "
			sql = sql & " ,"& trim(array_ordernum(i)) &" "
			sql = sql & " ,"& trim(array_ordernum(i)) &" "
			sql = sql & " ,'"& now() &"' "
			sql = sql & " ,'"& pro_dcenterchoice &"') "
			db.execute sql

			'''''''''''''''''''''''''''''''
			sms_pnamecnt = sms_pnamecnt+1
			if sms_pname="" then
				sms_pname = pro_pname
			end if
			'''''''''''''''''''''''''''''''
		end if
	next

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sql = "update tb_order set ordermoney = "& pro_money_hap &", rordermoney = "& pro_money_hap &" "
	sql = sql & " where idx='"& orderidx &"' "
	db.execute sql
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select ip,id,pwd,tbname,msg,dbname from tb_smsSetup "
	rslist.Open sql, db, 1
	ip = rslist(0)
	id = rslist(1)
	pwd = rslist(2)
	tbname = rslist(3)
	msg = rslist(4)
	dbname = rslist(5)
	rslist.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'SQL = "delete tb_product_cart where usercode = '"& session("AAusercode") &"' "	'장바구니삭제
	'db.Execute SQL
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	smsBank    = virtual_acnt_bank
	smsBankNum = virtual_acnt
	smsMoney   = pro_money_hap
	smsType    = smsflagType
    smsMoney2 = pro_money_sum
 '   response.Write pro_money_sum
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if rs_myflag="n" then
		db.close
		set db=nothing

		if smsflag="y" then
%>
			<Script language=javascript>
				alert("주문접수가 성공적으로 이루어졌습니다.");
				//alert("아래 핸드폰번호로 주문내역을 통보합니다.\n\n<%=hp1&"-"&hp2&"-"&hp3%>");
			    //location.href = "sms.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>&smsBank=<%=smsBank%>&smsBankNum=<%=smsBankNum%>&smsMoney=<%=smsMoney%>&smsType=<%=smsType%>&smsMoney2=<%=smsMoney2%>";
				location.href = "/adminpage/Newsms.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>&smsBank=<%=smsBank%>&smsBankNum=<%=smsBankNum%>&smsMoney=<%=smsMoney%>&smsType=<%=smsType%>&smsMoney2=<%=smsMoney2%>&ordergubun=ok";
			</Script>
<%
		else
%>
			<Script language=javascript>
				alert("주문접수가 성공적으로 이루어졌습니다.");
				location.href = "/adminpage/mobile/list.asp";
			</Script>
<%
		end if

	else	'본사가 미수금체크시
		imsihapmoney = rs_mi_money + pro_money_hap
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'sql = "update tb_company set mi_money = mi_money+"& pro_money_hap &" "
		sql = "update tb_company set mi_money = mi_money+"& PMmoney &" "
		sql = sql & " where idx = "& int(cusercode) &" "
		db.execute sql
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		imsihapmoney = rs_ye_money-imsihapmoney
		imsihapmoney = formatnumber(imsihapmoney,0)

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    	set rsa = server.CreateObject("ADODB.Recordset")
		SQL = " select mi_money,ye_money from tb_company where idx = "& int(cusercode) &" "
		rsa.Open sql, db, 1
		af_mi_money1 = rsa(0)
		af_ye_money1 = rsa(1)
		rsa.close

        if rs_myflag_select = "4" then
        if af_mi_money1 > af_ye_money1 then 'y:본사에서 미수금체크시 주문후 미수가 여신보다 많을경우
            multi_ye_money = YeMoney * 2

          
                  sql = "update tb_company set ye_money = "& multi_ye_money &" "
		          sql = sql & " where idx = "& int(cusercode) &" "
		          db.execute sql
            end if
        
         imsihapmoney = multi_ye_money - af_mi_money1
         imsihapmoney = formatnumber(imsihapmoney,0)



        end if
		set rsm = server.CreateObject("ADODB.Recordset")
		SQL = " select mi_money,ye_money from tb_company where idx = "& int(cusercode) &" "
		rsm.Open sql, db, 1
		af_mi_money = rsm(0)
		af_ye_money = rsm(1)
		rsm.close
		if af_mi_money > af_ye_money then 'y:본사에서 미수금체크시 주문후 미수가 여신보다 많을경우
			sql = "update tb_order set orderflag_m = 'y' where idx='"& orderidx &"' "
			session("ymflag") = "y"
			db.execute sql
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		db.close
		set db=nothing

		if smsflag="y" then
%>
			<Script language=javascript>
				alert("주문접수가 성공적으로 이루어졌습니다.\n\n현재 여신금액은 <%=imsihapmoney%>원이 남아있습니다.");
				//alert("아래 핸드폰번호로 주문내역을 통보합니다.\n\n<%=hp1&"-"&hp2&"-"&hp3%>");
				//frames.smspage.location.href = "/adminpage/sms.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>";
				//location.href = "/adminpage/agency/list.asp";
			    //location.href = "sms.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>&smsBank=<%=smsBank%>&smsBankNum=<%=smsBankNum%>&smsMoney=<%=smsMoney%>&smsType=<%=smsType%>&smsMoney2=<%=smsMoney2%>";
				location.href = "Newsms.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>&smsBank=<%=smsBank%>&smsBankNum=<%=smsBankNum%>&smsMoney=<%=smsMoney%>&smsType=<%=smsType%>&smsMoney2=<%=smsMoney2%>&ordergubun=ok";
			</Script>
<%
		else
%>
			<Script language=javascript>
				alert("주문접수가 성공적으로 이루어졌습니다.");
				location.href = "/adminpage/mobile/list.asp";
			</Script>
<%
		end if
	end If
%>
