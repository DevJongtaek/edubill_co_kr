<%
	busercode = left(bcscode,5)	'��������ڵ�
	jusercode = mid(bcscode,6,5)	'��������ڵ�
	cusercode = mid(bcscode,11,5)	'ü���������ڵ�
	usercode  = bcscode		'ü���� ��ü�ڵ�

	if request_day = "" then
		request_day = replace(mid(now()+1,6,5),"-","")
	end if

	array_pcode = split(real_pcode,",")
	array_ordernum = split(real_qty,",")
	loopcount = ubound(array_pcode)

	orderidx = real_idx	'�ֹ���ȣ
	orderday = OD_DATE	'�ֹ�����8�ڸ�

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx "
	SQL = sql & " from tb_order "
	SQL = sql & " where idx = '"& orderidx &"' or posSeq = '"& OD_NO &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		ordercnt = 1	'�Է�Ȯ��
	else
		ordercnt = 0	'�Է�Ȯ��
	end if
	rs.close
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

if ordercnt=0 then
	db_insert_cnt = db_insert_cnt+1

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(busercode)
	rs.Open sql, db, 1
	rs_myflag = rs(0)	'�̼�üũ����
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(jusercode)
	rs.Open sql, db, 1
	jcomname = rs(0)	'�����
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname,dcarno,mi_money,ye_money "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& int(cusercode)
	rs.Open sql, db, 1
	ccomname = rs(0)	'ü������
	dcarnoidx = rs(1)	'ȣ��idx��
	rs_mi_money = rs(2)
	rs_ye_money = rs(3)
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
	sql = "insert into tb_order(idx,usercode,comname1,comname2,orderday,okday,ordermoney,rordermoney,carname,ordering,flag,wdate,wuserid,order_cmt,request_day,posSeq) values "
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
	sql = sql & " ,'"& OD_NO &"') "
'response.write sql
	db.execute sql
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	for ii=0 to loopcount
		pro_idx = ""		'������ǰ�ڵ�
		pro_pcode = ""		'�Է»�ǰ�ڵ�
		pro_pname = ""		'��ǰ��
		pro_pprice = ""		'��ǰ�ܰ�
		imsicount = 0
		pro_dcenterchoice = "0"

		if trim(array_pcode(ii)) <> "" and trim(array_ordernum(ii)) <> "" then
			aaaa = int(trim(array_ordernum(ii)))
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select idx,pcode,pname,pprice,dcenterchoice "
			SQL = sql & " from tb_product "
			SQL = sql & " where usercode = '"& busercode &"' and proout = 'y'"
			SQL = sql & " and pcode = '"& trim(array_pcode(ii)) &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				pro_idx = rs(0)		'������ǰ�ڵ�
				pro_pcode = rs(1)	'�Է»�ǰ�ڵ�
				pro_pname = rs(2)	'��ǰ��
				pro_pprice = rs(3)	'��ǰ�ܰ�
				pro_dcenterchoice=rs(4)
				imsicount = 1
				pro_money_hap = pro_money_hap+(pro_pprice*aaaa)
			else
				imsicount = 0
			end if
			rs.close
		end if

		if imsicount = 1 then
			db_insert_cnt2 = db_insert_cnt2+1
			'�ֹ���ǰ����
			sql = "insert into tb_order_product(idx,pcodeidx,pcode,pname,pprice,ordernum,rordernum,wdate,dcenterchoice) values "
			sql = sql & " ('"& orderidx &"' "
			sql = sql & " ,'"& pro_idx &"' "
			sql = sql & " ,'"& pro_pcode &"' "
			sql = sql & " ,'"& pro_pname &"' "
			sql = sql & " ,"& pro_pprice &" "
			sql = sql & " ,"& trim(array_ordernum(ii)) &" "
			sql = sql & " ,"& trim(array_ordernum(ii)) &" "
			sql = sql & " ,'"& now() &"' "
			sql = sql & " ,'"& pro_dcenterchoice &"') "
			db.execute sql
		end if
	next

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sql = "update tb_order set ordermoney = "& pro_money_hap &" "
	sql = sql & " where idx='"& orderidx &"' "
	db.execute sql
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if rs_myflag="y" then
		imsihapmoney = rs_mi_money + pro_money_hap
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		sql = "update tb_company set mi_money = mi_money+"& pro_money_hap &" "
		sql = sql & " where idx = "& int(cusercode) &" "
		db.execute sql
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	end if
end if
%>