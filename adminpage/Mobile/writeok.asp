<!--#include virtual="/adminpage/incfile/sessionend2.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	Function FunErrorMsg(errormsg)	'�����޼���
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

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	pidx        = replace(request("pidx")," ","")
	taxGubun    = request("taxGubun")
	imsivatflag = request("imsivatflag")
	in_kmoney   = request("in_kmoney")
	in_smoney   = request("in_smoney")
	ordernum    = replace(request("ordernum")," ","")

'response.write in_kmoney &" - "& in_smoney &"<BR>"

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	pidxarray     = split(pidx,",")
	pidxarray_int = ubound(pidxarray)
	ordernumarray = split(ordernum,",")
	in_kmoney     = split(in_kmoney,",")
	in_smoney     = split(in_smoney,",")
	taxGubun      = split(taxGubun,",")
	imsivatflag   = split(imsivatflag,",")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select rordermoney,usercode from tb_order where idx = '"& idx &"' "
	rs.Open sql, db, 1
	'old_imsihapmoney = rs(0)
	usercode = rs(1)
	rs.close
	old_imsihapmoney = request("old_imsihapmoney")


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
	rs_pro_money_hap = 0
	if pidxarray_int<>"" then
		ksHmoney = 0
		kHmoney  = 0
		for i=0 to ubound(ordernumarray)
			in_kmoneyVal = trim(in_kmoney(i))
			in_smoneyVal = trim(in_smoney(i))
			in_cnt       = trim(ordernumarray(i))
			in_taxGubun  = trim(taxGubun(i))
			in_vatflag   = trim(imsivatflag(i))
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			if in_taxGubun="����" then
				if in_vatflag = "y" then	'����
					ksHmoney = ksHmoney + (CDbl(CDbl(in_kmoneyVal)+CDbl(in_smoneyVal))*CDbl(in_cnt))
					kHmoney  = ksHmoney
				elseif in_vatflag = "n" then	'����
					ksHmoney = ksHmoney + (CDbl(CDbl(in_kmoneyVal)+CDbl(in_smoneyVal))*CDbl(in_cnt))
					kHmoney  = kHmoney  + (CDbl(in_kmoneyVal)*CDbl(in_cnt))
'response.write in_kmoneyVal &" + "& in_smoneyVal &" * "& in_cnt &" = "& (CDbl(CDbl(in_kmoneyVal)+CDbl(in_smoneyVal))*CDbl(in_cnt)) &"<BR>"

				elseif in_vatflag = "a" then	'�����
					ksHmoney = ksHmoney + (CDbl(in_kmoneyVal)*CDbl(in_cnt))
					kHmoney  = kHmoney  + (CDbl(in_kmoneyVal)*CDbl(in_cnt))
				end if
			else
				ksHmoney = ksHmoney + (CDbl(in_kmoneyVal)*CDbl(in_cnt))
				kHmoney  = kHmoney  + (CDbl(in_kmoneyVal)*CDbl(in_cnt))
'response.write in_kmoneyVal &" + "& in_smoneyVal &" * "& in_cnt &" = "& (CDbl(in_kmoneyVal)*CDbl(in_cnt)) &"<BR>"
			end if
			
			'imsitaxmoney = CDbl(CDbl(in_kmoneyVal)+CDbl(in_smoneyVal))*CDbl(in_cnt)
			'rs_pro_money_hap = rs_pro_money_hap + (CDbl(in_kmoneyVal)*CDbl(in_cnt))
		next
		rs_pro_money_hap = ksHmoney


'response.write rs_pro_money_hap
'response.end

	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if rs_myflag="y" and rs_myflag_select="2" then

		'old_imsihapmoney �����ֹ��ݾ� rs_pro_money_hap �ű��ֹ��ݾ�
		'if pidxarray_int<>"" then
			'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'rs_pro_money_hap = 0
			'for i=0 to pidxarray_int
			'	set rs = server.CreateObject("ADODB.Recordset")
			'	SQL = " select pprice from tb_order_product where pidx = "& int(trim(pidxarray(i)))
			'	rs.Open sql, db, 1
			'	if not rs.eof then
			'		rs_pro_money_hap = rs_pro_money_hap + (CDbl(rs(0)) * CDbl(ordernumarray(i)))
			'	end if
			'	rs.close
			'next
			'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'end if

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' 2012-02-10 �̼��� �Ի� ���� 
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'����
		'rs_imsimi_money = CDbl(rs_mi_money)-CDbl(old_imsihapmoney)	'�̼���-�����ֹ��հ�
		'if rs_imsimi_money < 0 then rs_imsimi_money=0
		'rs_OrderMoney = rs_ye_money - rs_imsimi_money
		'CutOrderMoney = rs_OrderMoney - rs_pro_money_hap
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'����
		OrderMoney    = rs_ye_money-(rs_mi_money-old_imsihapmoney)
		'call FunErrorMsg("OrderMoney =" & OrderMoney & " rs_ye_money=" & rs_ye_money & " rs_mi_money=" & rs_mi_money & " old_imsihapmoney=" & old_imsihapmoney & " rs_pro_money_hap=" & rs_pro_money_hap)
		CutOrderMoney = OrderMoney-rs_pro_money_hap
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if CutOrderMoney<0 then
			JavaOrderOkMoney  = formatnumber(rs_OrderMoney,0)
			JavaOrderMoney    = formatnumber(rs_pro_money_hap,0)
			JavaOrderNotMoney = formatnumber(CutOrderMoney,0)
			JavaTxt = "�����ѵ��� �ʰ��Ǿ� �ֹ��� �Ͻ� �� �����ϴ�.\n\n"
			JavaTxt = JavaTxt & "�ֹ������� �����Ͽ� �ٽ� �ֹ� �ٶ��ϴ�.!!!\n\n"
			JavaTxt = JavaTxt & "�� �ֹ����� �ݾ� : "& JavaOrderOkMoney  &" ��\n\n"
			JavaTxt = JavaTxt & "�� �ֹ��Ͻ� �ݾ� : "& JavaOrderMoney    &" ��\n\n"
			JavaTxt = JavaTxt & "�� �ʰ� �ݾ�     : "& JavaOrderNotMoney &" ��"
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
			call FunErrorMsg("��޿�û���ڸ� ���� 01~12, ���ڴ� 01~31 ������ �Է��� �ֽʽÿ�.")
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
				'SQL = SQL & " ordernum = "& trim(ordernumarray(i)) &" ,"
				SQL = SQL & " rordernum = "& trim(ordernumarray(i)) &" ,"
				SQL = SQL & " edate = '"& now() &"', "
				SQL = SQL & " euserid = '"& session("Auserid") &"' "
				SQL = SQL & " where pidx = "& trim(pidxarray(i))
				db.Execute SQL
			next
		end if
		'imsihapmoney = rs_pro_money_hap
		'imsihapmoney = kHmoney
		'set rs = server.CreateObject("ADODB.Recordset")
		'SQL = " select pprice,ordernum "
		'SQL = sql & " from tb_order_product "
		'SQL = sql & " where idx = '"& idx &"' "
		'rs.Open sql, db, 1
		'if not rs.eof then
		'	imsihapmoney = 0
		'	do until rs.eof
		'		imsihapmoney = imsihapmoney+(CDbl(rs(0))*rs(1))
		'	rs.movenext
		'	loop
		'end if
		'rs.close

		SQL = "update tb_order set "
		SQL = SQL & " request_day = '"& request_day &"', "
		'SQL = SQL & " ordermoney = "& imsihapmoney &", "
		SQL = SQL & " rordermoney = "& kHmoney &", "
		SQL = SQL & " edate = '"& now() &"', "
		SQL = SQL & " euserid = '"& session("Auserid") &"' "
		SQL = SQL & " where idx = '"& idx &"' "
		db.Execute SQL
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if rs_myflag="y" then
			'rs_mi_money : �����̼��� pro_money_hap	: �ֹ��ݾ� imsihapmoney:�ű��ֹ��ݾ� old_imsihapmoney:�����ֹ��ݾ�
			'pro_money_hap = imsihapmoney	'�ű��ֹ��ݾ�
			'pro_money_hap = imsihapmoney	'�ű��ֹ��ݾ�+����
			'rs_mi_money2  = rs_mi_money - CDbl(old_imsihapmoney)
			'rs_mi_money3  = rs_mi_money2+pro_money_hap
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			pro_money_hap = rs_pro_money_hap			'�ű��ֹ��ݾ�+����
			rs_mi_money2  = rs_mi_money  - CDbl(old_imsihapmoney)	'���� �����հ踦 ����
			rs_mi_money3  = rs_mi_money2 + pro_money_hap		'�����հ踦 ������

'response.write old_imsihapmoney &"<BR>"
'response.write pro_money_hap &"<BR>"
'response.write rs_mi_money2 &"<BR>"
'response.write rs_mi_money3 &"<BR>"
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			sql = "update tb_company set mi_money = "& rs_mi_money3 &" "
			sql = sql & " where idx = "& right(usercode,5)
			db.execute sql
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if

	db.close
	set db=nothing
	'response.redirect "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchh="&searchh
	jsmsg =  "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchh="&searchh
%>
			<Script language=javascript>
				alert("�ֹ����� ������ ���������� �̷�������ϴ�.");
				location.href = "<%=jsmsg%>";
			</Script>