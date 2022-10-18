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


  busercode = left(session("AAusercode"),5)	'본사실제코드
	jusercode = mid(session("AAusercode"),6,5)	'지사실제코드
	cusercode = mid(session("AAusercode"),11,5)	'체인점실제코드
	usercode = session("AAusercode")			'체인점 전체코드
	
'response.write busercode
   
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag,smsflag,tcode,smsflagType "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(busercode)
	rs.Open sql, db, 1
	rs_myflag = rs(0)	'미수체크여부
	smsflag = rs(1)
	smsttcode1 = rs(2)
	smsflagType = rs(3)
    
	rs.close
	

set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select count(*) as cnt,min(pname) as pname  "
	SQL = sql & " from tb_order_product "
	SQL = SQL & " where idx = '"& idx &"' "
	SQL  = SQL & " group by idx "
	rs.Open sql, db, 1
	sms_pnamecnt = rs(0)	
	sms_pname = rs(1)

    
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


		'sql = "update tb_company set mi_money = mi_money-"& CDbl(cancleMoney) &" "
		'sql = sql & " where idx = "& int(right(session("AAusercode"),5)) &" "
		'db.execute sql

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
	jsmsg =  "Returnlist.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchh="&searchh

pro_money_hap = 0
smsBank    = virtual_acnt_bank
	smsBankNum = virtual_acnt
	smsMoney   = pro_money_hap
	smsType    = smsflagType
	
	
if smsflag="y" then
%>
			<Script language=javascript>
				

			 
				alert("반품정보 취소가 성공적으로 이루어졌습니다.");
				
			
				//location.href = "/adminpage/sms2.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>&smsBank=<%=smsBank%>&smsBankNum=<%=smsBankNum%>&smsMoney=<%=smsMoney%>&smsType=<%=smsType%>&jsmsg=<%=jsmsg%>";

                
				location.href = "<%=jsmsg%>";
			</Script>
			<%
			else
			%>
				<Script language=javascript>
				

			 
				    alert("반품정보 취소가 성공적으로 이루어졌습니다.");
				
			
				//location.href = "/adminpage/sms2.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>&smsBank=<%=smsBank%>&smsBankNum=<%=smsBankNum%>&smsMoney=<%=smsMoney%>&smsType=<%=smsType%>&jsmsg=<%=jsmsg%>";

                
				location.href = "<%=jsmsg%>";
			</Script>
				<%
		end if
		%>
