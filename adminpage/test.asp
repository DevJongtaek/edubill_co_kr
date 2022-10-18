<%

		Set db = Server.CreateObject("ADODB.Connection")
		dbstr = "provider=sqloledb;server=61.98.130.213;database=handypay;uid=handypay;pwd=handypay;"	'db를 연다
		db.Open dbstr

		comname = session("AAcomname")
		imsitel = session("AAtel")

		hpmsg = replace(msg,"{체인본부명}",comname)
		hpmsg = replace(msg,"{첫번째상품명}",sms_pname)
		hpmsg = replace(msg,"{X}",sms_pnamecnt)

		sqltxt1 = "tran_phone, tran_callback, tran_status, tran_date, tran_msg, tran_type"
		sqltxt2 = "'01028906713','0222140833','1',getdate(),'test', '5' "
		sql = " insert into em_tran ( "& sqltxt1 &" ) values ( "& sqltxt2 &" ) "
		db.execute sql
		db.close
%>