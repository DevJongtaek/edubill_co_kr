<!--#include virtual="/db/db.asp" -->
<%

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select ip,id,pwd,tbname,msg,dbname,cType,msg2,msg3,msg4 from tb_smsSetup "
	rslist.Open sql, db, 1
	ip = rslist(0)
	id = rslist(1)
	pwd = rslist(2)
	tbname = rslist(3)
	msg = rslist(4)
	dbname = rslist(5)
	cType = rslist(6)
	msg2 = rslist(7)
	msg3 = rslist(8)
    msg4 = rslist(9)
	rslist.close
	db.close
'response.write cType
'response.end
	smsflag = request("smsflag")
	sms_pname = request("sms_pname")
	sms_pnamecnt = request("sms_pnamecnt")
	hp1 = request("hp1")
	hp2 = request("hp2")
	hp3 = request("hp3")
	smsttcode1 = request("smsttcode1")
	smsttcode2 = request("smsttcode2")
	smsType    = request("smsType")

	smsBank    = request("smsBank")
	smsBankNum = request("smsBankNum")
	smsMoney   = request("smsMoney")
	smsMoney   = formatnumber(smsMoney,0)

    smsMoney2   = request("smsMoney2")
	smsMoney2   = formatnumber(smsMoney2,0)


	cType = smsType

if smsflag="y" then

	if hp1="010" or hp1="011" or hp1="016" or hp1="017" or hp1="018" or hp1="019" then
		hp111 = hp1
	else
		hp111 = ""
	end if

	hpnum = hp111&hp2&hp3
	hpnum = replace(hpnum," ","")
	hpnum = replace(hpnum,"-","")

	if len(hpnum)=10 or len(hpnum)=11 then

		Set db = Server.CreateObject("ADODB.Connection")
		'220.73.136.21, 2101,	agentsms,	total_sms_21,	SC_TRAN	LGUplusSMS			
		'dbstr = "provider=sqloledb;server=61.98.130.213;database=handypay;uid=handypay;pwd=handypay;"	'db�� ����
		dbstr = "provider=sqloledb;server="&ip&";database="&dbname&";uid="&id&";pwd="&pwd&";"	'db�� ����
		db.Open dbstr

		comname = session("AAcomname")
    comname3 = session("AAcomname3")
		imsitel = session("AAtel")

		'A type[ü������]�� [��ǰ��] �� [X]���� �ֹ� �Ϸ� �Ǿ����ϴ�.
		'B type[ü������]���� �ֹ��Ϸ�, �Աݾ�:[�ݾ�]��, ���¹�ȣ:[����], �����:[����] 
        'D type[ü������]�� [��ǰ��] �� [X]�� 000000�� �ֹ� �Ϸ� �Ǿ����ϴ�.
		sms_pnamecnt = sms_pnamecnt-1

		if cType="A" then
			hpmsg = msg
			hpmsg = replace(hpmsg,"[ü������]",comname)
			hpmsg = replace(hpmsg,"[��ǰ��]",sms_pname)
			hpmsg = replace(hpmsg,"[X]",sms_pnamecnt)
		elseif cType="B" then
			hpmsg = msg2
			hpmsg = replace(hpmsg,"[ü������]",comname)
			hpmsg = replace(hpmsg,"[�ݾ�]",smsMoney)
			hpmsg = replace(hpmsg,"[����]",smsBankNum)
			hpmsg = replace(hpmsg,"[����]",smsBank)
        elseif cType="D" then
			hpmsg = msg4
			hpmsg = replace(hpmsg,"[ü������]",comname3)
			hpmsg = replace(hpmsg,"[��ǰ��]",sms_pname)
			hpmsg = replace(hpmsg,"[X]",sms_pnamecnt)
    	    hpmsg = replace(hpmsg,"[�ݾ�]",smsMoney2)
		end if
		
		'LGUplus
		'sqltxt1 = "INSERT INTO [dbo].[SC_TRAN] ([TR_SENDDATE], [TR_SENDSTAT], [TR_RSLTSTAT], [TR_MSGTYPE], [TR_PHONE], [TR_CALLBACK],[TR_MSG],[TR_ETC1],[TR_ETC2]) "
	    'sqltxt2 = " VALUES(getdate(), '0', '00', '0', '" & hpnum & "', '"& imsitel &"', '"& hpmsg &"', '"& smsttcode1 &"', '"& smsttcode2 &"' ) "
		'sql = sqltxt1 & sqltxt2
		
		'Infobank
		sqltxt1 = "tran_phone, tran_callback, tran_status, tran_date, tran_msg,tran_etc2,tran_etc3,tran_etc4"
		sqltxt2 = "'"& hpnum &"','"& imsitel &"','1',getdate(),'"& hpmsg &"' ,'"& smsttcode1 &"' ,'"& smsttcode2 &"', '12' "
		sql = " insert into em_tran ( "& sqltxt1 &" ) values ( "& sqltxt2 &" ) "

        
		db.execute sql
		db.close
	end if
end if

response.redirect "/adminpage/agency/list.asp"
%>