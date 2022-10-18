<!--#include virtual="/db/db.asp" -->
<%

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select  ip, id, pwd, tbname,msg, dbname  from tb_smsSetup3 "
	rslist.Open sql, db, 1
	ip = rslist(0)
	id = rslist(1)
	pwd = rslist(2)
	tbname = rslist(3)
	msg = rslist(4)
	dbname = rslist(5)
	
	rslist.close
	db.close


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

     ordergubun =request("ordergubun")

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
		'dbstr = "provider=sqloledb;server=61.98.130.213;database=handypay;uid=handypay;pwd=handypay;"	'db를 연다
		dbstr = "provider=sqloledb;server="&ip&";database="&dbname&";uid="&id&";pwd="&pwd&";"	'db를 연다
		db.Open dbstr

        bonsaname =  session("AAcomname2")
		comname = session("AAcomname")
        comname3 = session("AAcomname3")
		imsitel = session("AAtel")

		'A type[체인점명]에 [상품명] 외 [X]건이 주문 완료 되었습니다.
		'B type[체인점명]에서 주문완료, 입금액:[금액]원, 계좌번호:[계좌], 은행명:[은행] 
        'D type[체인점명]에 [상품명] 외 [X]건 000000원 주문 완료 되었습니다.
		sms_pnamecnt = sms_pnamecnt-1
        
    if ordergubun ="ok" then
        hpmsg = ""&bonsaname&" "&comname3&"에서    "
        'hpmsg = hpmsg &"&nbsp;&nbsp;&nbsp;"
        hpmsg = hpmsg & ""&sms_pname&" 외 "&sms_pnamecnt&" 건    "
       'hpmsg = hpmsg &"&nbsp;&nbsp;&nbsp;"
        hpmsg = hpmsg &"주문이 완료 되었습니다."
    elseif ordergubun ="no" then
        hpmsg = ""&bonsaname&" "&comname3&"에서    "
        hpmsg = hpmsg &""
        hpmsg = hpmsg & ""&sms_pname&" 외 "&sms_pnamecnt&" 건    "
       ' hpmsg = hpmsg &"&nbsp;&nbsp;&nbsp;"
        hpmsg = hpmsg &"주문이 취소 되었습니다"
    end if
		
		'Infobank
        if ordergubun ="ok" then

		sqltxt1 = "SENDER_KEY, PHONE,TMPL_CD, SEND_MSG, REQ_DATE, CUR_STATE,SMS_TYPE,ATTACHMENT_TYPE ,ATTACHMENT_NAME,ATTACHMENT_URL"
		sqltxt2 = "'be0d331c9435c31abeecf524cde2a32bb6a9bf65','"& hpnum &"','K18-0021','"& hpmsg &"' ,getdate(),'0' ,'N',NULL,NULL,NULL "
		
        elseif ordergubun ="no" then
        sqltxt1 = "SENDER_KEY, PHONE,TMPL_CD, SEND_MSG, REQ_DATE, CUR_STATE,SMS_TYPE,ATTACHMENT_TYPE ,ATTACHMENT_NAME,ATTACHMENT_URL"
		sqltxt2 = "'be0d331c9435c31abeecf524cde2a32bb6a9bf65','"& hpnum &"','K18-0022','"& hpmsg &"' ,getdate(),'0' ,'N',NULL,NULL,NULL "
		
        end if

        sql = " insert into MSG_DATA ( "& sqltxt1 &" ) values ( "& sqltxt2 &" ) "
        'response.Write sql
        
		db.execute sql
		db.close
	end if
end if

response.redirect "/adminpage/agency/list.asp"
%>