<!--#include virtual="/db/db.asp"-->
<%
	Response.Expires = 0 
	Response.AddHeader "Pragma","no-cache"   
	Response.AddHeader "Cache-Control","no-cache,must-revalidate"  

	call ordertimechb(left(session("AAusercode"),5))	'�ֹ����ܽð� üũ

	Function FunErrorMsg(errormsg)	'�����޼���
			FunErrorMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg &"');history.back(-1);</SCRIPT>"
			response.write FunErrorMsg
			response.end
	End Function

	busercode = left(session("AAusercode"),5)	'��������ڵ�
	jusercode = mid(session("AAusercode"),6,5)	'��������ڵ�
	cusercode = mid(session("AAusercode"),11,5)	'ü���������ڵ�
	usercode = session("AAusercode")			'ü���� ��ü�ڵ�

	pcode = trim(request("pcode"))			'��ǰ�ڵ�
	ordernum = trim(request("ordernum"))		'�ֹ�����

	order_cmt = replace(request("order_cmt"),"'","")

	d_requestday = request("d_requestday")	'y/n
	request_day1 = request("request_day1")
	request_day2 = request("request_day2")

	PMmoney = request("PMmoney")	'�ֹ��ݾ�+����
     YeMoney = request("YeMoney") '���űݾ�
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
	end if

	if request_day = "" then
		request_day = replace(mid(now()+1,6,5),"-","")
	end if

	array_pcode = split(pcode,",")
	array_ordernum = split(ordernum,",")
	loopcount = ubound(array_pcode)

	'�ֹ���ȣ''''''''''''''''''''''''''''''''''''''
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
	orderidx = o_yyy&ho2&mi2&se2&cusercode		'�ֹ���ȣ
	'�ֹ���ȣ''''''''''''''''''''''''''''''''''''''

	orderday = left(orderidx,8)			'�ֹ�����8�ڸ�

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag,smsflag,tcode,smsflagType ,vatflag,myflag_select"
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(busercode)
	rs.Open sql, db, 1
	rs_myflag = rs(0)	'�̼�üũ����
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
	jcomname = rs(0)	'�����
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname,dcarno,mi_money,ye_money,hp1,hp2,hp3,tcode,virtual_acnt_bank,virtual_acnt "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(cusercode)
	rs.Open sql, db, 1
	ccomname = rs(0)	'ü������
	dcarnoidx = rs(1)	'ȣ��idx��
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
	dcarno = rs(0)	'ȣ����ȣ
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
		pro_idx = ""		'������ǰ�ڵ�
		pro_pcode = ""		'�Է»�ǰ�ڵ�
		pro_pname = ""		'��ǰ��
		pro_pprice = ""		'��ǰ�ܰ�
		imsicount = 0
		pro_dcenterchoice = "0"

		if trim(array_pcode(i)) <> "" and trim(array_ordernum(i)) <> "" then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select idx,pcode,pname,pprice,dcenterchoice,gubun,case gubun when '����' then convert(int, pprice +  pprice*0.1) else convert(int, pprice) end as tprice "
			SQL = sql & " from tb_product "
			'SQL = sql & " where usercode = '"& busercode &"' and proout = 'y'"
			SQL = sql & " where usercode = '"& busercode &"' "
			SQL = sql & " and pcode = '"& trim(array_pcode(i)) &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				pro_idx = rs(0)		'������ǰ�ڵ�
				pro_pcode = rs(1)	'�Է»�ǰ�ڵ�
				pro_pname = rs(2)	'��ǰ��
				pro_pprice = rs(3)	'��ǰ�ܰ�
				pro_dcenterchoice=rs(4)

         tprice = rs(6)  '����/�����'
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
			'�ֹ���ǰ����
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
	'SQL = "delete tb_product_cart where usercode = '"& session("AAusercode") &"' "	'��ٱ��ϻ���
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
				alert("�ֹ������� ���������� �̷�������ϴ�.");
				//alert("�Ʒ� �ڵ�����ȣ�� �ֹ������� �뺸�մϴ�.\n\n<%=hp1&"-"&hp2&"-"&hp3%>");
			    //location.href = "sms.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>&smsBank=<%=smsBank%>&smsBankNum=<%=smsBankNum%>&smsMoney=<%=smsMoney%>&smsType=<%=smsType%>&smsMoney2=<%=smsMoney2%>";
				location.href = "/adminpage/Newsms.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>&smsBank=<%=smsBank%>&smsBankNum=<%=smsBankNum%>&smsMoney=<%=smsMoney%>&smsType=<%=smsType%>&smsMoney2=<%=smsMoney2%>&ordergubun=ok";
			</Script>
<%
		else
%>
			<Script language=javascript>
				alert("�ֹ������� ���������� �̷�������ϴ�.");
				location.href = "/adminpage/mobile/list.asp";
			</Script>
<%
		end if

	else	'���簡 �̼���üũ��
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
        if af_mi_money1 > af_ye_money1 then 'y:���翡�� �̼���üũ�� �ֹ��� �̼��� ���ź��� �������
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
		if af_mi_money > af_ye_money then 'y:���翡�� �̼���üũ�� �ֹ��� �̼��� ���ź��� �������
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
				alert("�ֹ������� ���������� �̷�������ϴ�.\n\n���� ���űݾ��� <%=imsihapmoney%>���� �����ֽ��ϴ�.");
				//alert("�Ʒ� �ڵ�����ȣ�� �ֹ������� �뺸�մϴ�.\n\n<%=hp1&"-"&hp2&"-"&hp3%>");
				//frames.smspage.location.href = "/adminpage/sms.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>";
				//location.href = "/adminpage/agency/list.asp";
			    //location.href = "sms.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>&smsBank=<%=smsBank%>&smsBankNum=<%=smsBankNum%>&smsMoney=<%=smsMoney%>&smsType=<%=smsType%>&smsMoney2=<%=smsMoney2%>";
				location.href = "Newsms.asp?smsflag=<%=smsflag%>&sms_pname=<%=sms_pname%>&sms_pnamecnt=<%=sms_pnamecnt%>&hp1=<%=hp1%>&hp2=<%=hp2%>&hp3=<%=hp3%>&smsttcode1=<%=smsttcode1%>&smsttcode2=<%=smsttcode2%>&smsBank=<%=smsBank%>&smsBankNum=<%=smsBankNum%>&smsMoney=<%=smsMoney%>&smsType=<%=smsType%>&smsMoney2=<%=smsMoney2%>&ordergubun=ok";
			</Script>
<%
		else
%>
			<Script language=javascript>
				alert("�ֹ������� ���������� �̷�������ϴ�.");
				location.href = "/adminpage/mobile/list.asp";
			</Script>
<%
		end if
	end If
%>
