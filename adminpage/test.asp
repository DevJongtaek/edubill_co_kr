<%

		Set db = Server.CreateObject("ADODB.Connection")
		dbstr = "provider=sqloledb;server=61.98.130.213;database=handypay;uid=handypay;pwd=handypay;"	'db�� ����
		db.Open dbstr

		comname = session("AAcomname")
		imsitel = session("AAtel")

		hpmsg = replace(msg,"{ü�κ��θ�}",comname)
		hpmsg = replace(msg,"{ù��°��ǰ��}",sms_pname)
		hpmsg = replace(msg,"{X}",sms_pnamecnt)

		sqltxt1 = "tran_phone, tran_callback, tran_status, tran_date, tran_msg, tran_type"
		sqltxt2 = "'01028906713','0222140833','1',getdate(),'test', '5' "
		sql = " insert into em_tran ( "& sqltxt1 &" ) values ( "& sqltxt2 &" ) "
		db.execute sql
		db.close
%>