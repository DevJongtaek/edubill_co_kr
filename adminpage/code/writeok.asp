<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	gotopage = request("gotopage")
	idx = request("idx")
	dflag = request("dflag")
	flag = request("flag")

	comname = replace(request("comname"),"'","''")
	old_comname = replace(request("old_comname"),"'","''")
	name = replace(request("name"),"'","''")

	companynum1 = replace(request("companynum1"),"'","''")
	companynum2 = replace(request("companynum2"),"'","''")
	companynum3 = replace(request("companynum3"),"'","''")

    companynum1_before = replace(request("companynum1_before"),"'","''")
	companynum2_before = replace(request("companynum2_before"),"'","''")
	companynum3_before = replace(request("companynum3_before"),"'","''")

	post = request("m_post1")&"-"&request("m_post2")
	addr = replace(request("m_addr1"),"'","''")
	addr2 = replace(request("m_addr2"),"'","''")

	uptae = replace(request("uptae"),"'","''")
	upjong = replace(request("upjong"),"'","''")
	tel = replace(request("tel"),"'","''")
	tel1 = replace(request("tel1"),"'","''")
	tel2 = replace(request("tel2"),"'","''")
	tel3 = replace(request("tel3"),"'","''")
	fax1 = replace(request("fax1"),"'","''")
	fax2 = replace(request("fax2"),"'","''")
	fax3 = replace(request("fax3"),"'","''")
	hp1 = replace(request("hp1"),"'","''")
	hp2 = replace(request("hp2"),"'","''")
	hp3 = replace(request("hp3"),"'","''")

	tcode = replace(request("tcode"),"'","''")
	idxsub = request("idxsub")
	if idxsub="" then
		idxsub=0
	end if
	idxsubname = replace(request("idxsubname"),"'","''")
	dcarno = replace(request("dcarno"),"'","''")
	if dcarno="" then
		dcarno=0
	end if

	startday = request("startday")
	if startday="" then
		startday = int(replace(left(now(),10),"-",""))
	end if

	bidxsub = left(session("Ausercode"),5)
	idxsub = mid(session("Ausercode"),6,5)
	if idxsub = "" then
		idxsub=0
	end if

	vatflag = replace(request("vatflag"),"'","''")
	taxtitle = replace(request("taxtitle"),"'","''")
	if taxtitle="" then
		taxtitle="식자재"
	end if

	juminno1 = replace(request("juminno1"),"'","''")
	juminno2 = replace(request("juminno2"),"'","''")
	homepage = replace(request("homepage"),"'","''")
	usegubun = replace(request("usegubun"),"'","''")
	usemoney = replace(request("usemoney"),"'","''")
	if usemoney="" then
		usemoney=0
	end if
	orderreg = replace(request("orderreg"),"'","''")
	if orderreg="" then
		orderreg = "n"
	end if

	soundfile = replace(request("soundfile"),"'","''")
	hclose = request("hclose")

	dcode = request("dcode")
	fileflag = request("fileflag")

	telecom = request("telecom")
	ctel1 = replace(request("ctel1"),"'","''")
	ctel2 = replace(request("ctel2"),"'","''")
	ctel3 = replace(request("ctel3"),"'","''")
	hapday = request("hapday")
	jumin1 = request("jumin1")
	jumin2 = request("jumin2")
	jumincheck = request("jumincheck")
	if jumincheck="" then
		jumincheck="n"
	end if
	telname = request("telname")
	conetion = request("conetion")
	orderflag = request("orderflag")
	fileregcode = request("fileregcode")
	mregflag = request("mregflag")
	if mregflag="" then
		mregflag = "n"
	end if

	serviceflag = request("serviceflag")
	if serviceflag="" then
		serviceflag="1"
	end if

	brandflag = request("brandflag")
	if brandflag="" then
		brandflag="n"
	end if
	brandbox = replace(request("brandbox")," ","")
	if brandbox="" then
		brandbox = ",,,,,,,,,"
	end if
	cbrandchoice = replace(request("cbrandchoice")," ","")

	dcenterflag = request("dcenterflag")
	if dcenterflag="" then
		dcenterflag="n"
	end if

	fileflaglevel = request("fileflaglevel")

    preye_money = request("preye_money")
	ye_money = request("ye_money")
	mi_money = request("mi_money")
    if preye_money="" then
		preye_money = 0
	end if
	if ye_money="" then
		ye_money = 0
	end if
	if mi_money="" then
		mi_money = 0
	end if

	d_requestday = request("d_requestday")
	myflag = request("myflag")
	if myflag="" then
		myflag = "n"
	end if
	
		myflagauth = request("myflagauth")
	if myflagauth="" then
		myflagauth = "n"
	end if

	agencycheck2 = request("agencycheck2")
	if agencycheck2="" then
		agencycheck2 = "n"
	end if

	djflag = request("djflag")
	if djflag="" then
		djflag = "n"
	end if

	smsflag = request("smsflag")
	if smsflag="" then
		smsflag = "n"
	end If
	
	'2011.04.12 sms보내기, 여신 초과 메모 visible
	sms_send = request("sms_send")
	if sms_send="" then
		sms_send = "n"
	end If
	
	yesin_memo = request("yesin_memo")
	if yesin_memo="" then
		yesin_memo = "n"
	end if

	productorderweek = request("productorderweek")
	If productorderweek = "" Then 
		productorderweek = "n"
	End If 

	misuprint = request("misuprint")
	if misuprint="" then
		misuprint = "n"
	end if

    '2014-04-03 오종택 추가
    premisuprint = request("premisuprint")
	if premisuprint="" then
		premisuprint = "n"
	end if

     
    UseReturn = request("UseReturn")
	if UseReturn="" then
		UseReturn = "n"
	end if

     UseTax = request("UseTax")
	if UseTax="" then
		UseTax = "n"
	end if


     MinOrderCheck = request("MinOrderCheck")
	if MinOrderCheck="" then
		MinOrderCheck = "n"
	end if

    MinOrderAmt = request("MinOrderAmt")
    if MinOrderAmt="" then
		MinOrderAmt = 0
	end if


	ch_gongi = replace(request("ch_gongi"),"'","")
	chk_gongi1 = replace(request("chk_gongi1"),"'","")
	chk_gongi2 = replace(request("chk_gongi2"),"'","")

	myflag_select = request("myflag_select")
	proflag1 = request("proflag1")
	proflag2 = request("proflag2")
	miorderflag = request("miorderflag")
	virtual_acnt = request("virtual_acnt")
	noteflag = request("noteflag")
	accountflag = request("accountflag")
	datadel = request("datadel")
	cyberNum = request("cyberNum")
	misubtn = request("misubtn")
	rec_fax = request("rec_fax")
	cporg_cd = request("cporg_cd")
	virtual_acnt_bank = request("virtual_acnt_bank")
	fileflagchb = request("fileflagchb")
	fileflagchb2 = request("fileflagchb2")

	virtual_acnt2 = request("virtual_acnt2")
	virtual_acnt2_bank = request("virtual_acnt2_bank")

    virtual_acnt3 = request("virtual_acnt3")
	virtual_acnt3_bank = request("virtual_acnt3_bank")
	virtual_name3 = request("virtual_name3")

    virtual_acnt4 = request("virtual_acnt4")
	virtual_acnt4_bank = request("virtual_acnt4_bank")

    virtual_acnt5 = request("virtual_acnt5")
	virtual_acnt5_bank = request("virtual_acnt5_bank")

    virtual_acnt6 = request("virtual_acnt6")
	virtual_acnt6_bank = request("virtual_acnt6_bank")


	ipConFlag = request("ipConFlag")
	choiceDcenter = request("choiceDcenter")
	if choiceDcenter="" or isnull(choiceDcenter) then choiceDcenter=0
	jsusu = request("jsusu")
	email = request("email")
	smsflagType = request("smsflagType")
	proflag2Pgubun = request("proflag2Pgubun")
	kbnumAreg = request("kbnumAreg")
	conSeeflag = request("conSeeflag")
	searchordertime = request("searchordertime")
	adminProgram = request("adminProgram")
	
	usesetmenu = request("usesetmenu")
	UseDistributionTotal = request("UseDistributionTotal")
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	order_weekgubun   = request("order_weekgubun")	'1:매일주문 2:요일주문
	order_weekchoice1 = request("order_weekchoice1")
	order_weekchoice2 = request("order_weekchoice2")
	order_weekchoice3 = request("order_weekchoice3")
	order_weekchoice4 = request("order_weekchoice4")
	order_weekchoice5 = request("order_weekchoice5")
	order_weekchoice6 = request("order_weekchoice6")
	order_weekchoice7 = request("order_weekchoice7")
	order_weekchoice = order_weekchoice1&order_weekchoice2&order_weekchoice3&order_weekchoice4&order_weekchoice5&order_weekchoice6&order_weekchoice7

	order_checkStime1 = request("order_checkStime1")
	order_checkStime2 = request("order_checkStime2")
	order_checkEtime1 = request("order_checkEtime1")
	order_checkEtime2 = request("order_checkEtime2")

	maechulflag = request("maechulflag")

	timecheck1_1 = order_checkStime1
	timecheck1_2 = order_checkStime2
	timecheck2_1 = order_checkEtime1
	timecheck2_2 = order_checkEtime2
	if timecheck1_1<>"" and timecheck1_2<>"" and timecheck2_1<>"" and timecheck2_2<>"" then
		if len(timecheck1_1)=1 then
			timecheck1_1 = "0"&timecheck1_1
		elseif int(timecheck1_1) >= 24 then
			timecheck1_1 = "00"
		end if
		if len(timecheck1_2)=1 or left(timecheck1_2,1)="0" or int(timecheck1_2) >= 60 then
			timecheck1_2 = "00"
		else
			timecheck1_2 = timecheck1_2 - (timecheck1_2 mod 10)
		end if

		if len(timecheck2_1)=1 then
			timecheck2_1 = "0"&timecheck2_1
		elseif int(timecheck2_1) >= 24 then
			timecheck2_1 = "00"
		end if
		if len(timecheck2_2)=1 or left(timecheck2_2,1)="0" or int(timecheck2_2) >= 60 then
			timecheck2_2 = "00"
		else
			timecheck2_2 = timecheck2_2 - (timecheck2_2 mod 10)
		end if

		timecheck1 = timecheck1_1&timecheck1_2
		timecheck2 = timecheck2_1&timecheck2_2

		if len(timecheck1)<4 or len(timecheck2)<4 then
			timecheck1=""
			timecheck2=""
		else
			if (timecheck1 >= 2460) or (timecheck2 >= 2460) then
				timecheck1=""
				timecheck2=""
			end if
		end if
	else
		timecheck1=""
		timecheck2=""
	end if

	order_checkStime = timecheck1
	order_checkEtime = timecheck2

	if order_weekgubun="1" then
		order_weekchoice = ""
		order_checkStime = ""
		order_checkEtime = ""
	end if

	if order_checkStime="" or order_checkEtime="" or order_weekchoice="" then
		order_weekchoice = ""
		order_checkStime = ""
		order_checkEtime = ""
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	old_fileregcode = replace(request("old_fileregcode"),"'","''")
	fileflag = request("fileflag")
	if fileflag="a" and flag="3" and fileflagchb2="y" then
		if idx="" then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select isnull(count(idx),0) from tb_company where bidxsub = "& left(session("Ausercode"),5) &" and fileregcode = '"& fileregcode &"' "
			rs.Open sql, db, 1
			errorcnt = rs(0)
			rs.close
		else
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select isnull(count(a.idx),0) from (select * from tb_company where idx <> "& idx &") a where bidxsub = "& left(session("Ausercode"),5) &" and a.fileregcode = '"& fileregcode &"' "
			rs.Open sql, db, 1
			errorcnt = rs(0)
			rs.close
		end if
		if errorcnt>0 then
%>
			<script language="javascript">
				alert("파일생성코드가 중복됩니다.\n\n다른 파일생성코드를 입력해 주시기 바랍니다.")
				history.go(-1);
			</script>
<%
			response.end
		end if
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if virtual_acnt<>""  And  virtual_acnt <> "0000000000" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select isnull(count(virtual_acnt),0) from tb_company where virtual_acnt = '"& virtual_acnt &"' "

		if idx<>"" then
			SQL = SQL & " and idx <> "& idx '&" and virtual_acnt
		end if

		rs.Open sql, db, 1
		errorcount = rs(0)
		rs.close
		if errorcount >0 then
%>
			<script language="javascript">
				alert("가상계좌번호가 중복됩니다.\n\n가상계좌를 올바르게 입력해 주시기 바랍니다.")
				history.go(-1);
			</script>
<%
			response.end
		end if
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	select case idx
		case ""

			if flag="1" then	'슈퍼유져-본사코드 같은걸 찾아봄
				set rs = server.CreateObject("ADODB.Recordset")
				SQL = " select count(idx) "
				SQL = sql & " from tb_company "
				SQL = sql & " where flag='1' and tcode = '"& tcode &"' "
				rs.Open sql, db, 1
				imsicount = rs(0)
				rs.close
			elseif flag="2" or flag="3" then	'본사-지사코드 같은걸 찾아봄 / 지사-체인점코드 찾아봄
				set rs = server.CreateObject("ADODB.Recordset")
				SQL = " select count(idx) "
				SQL = sql & " from tb_company "
				SQL = sql & " where ((bidxsub = '"& left(session("Ausercode"),5) &"') or (idx = '"& left(session("Ausercode"),5) &"')) "
				SQL = sql & " and tcode = '"& tcode &"' "
				rs.Open sql, db, 1
				imsicount = rs(0)
				rs.close
			end if

			if imsicount=0 then
				SQL = "INSERT INTO tb_company(idx,tcode,flag,bidxsub,idxsub,idxsubname,comname,name,post,addr,addr2,companynum1,companynum2,companynum3,uptae,upjong,orderreg,fileflaglevel,"
				SQL = SQL & " tel1,tel2,tel3,fax1,fax2,fax3,hp1,hp2,hp3,dcarno,startday,vatflag,taxtitle,juminno1,juminno2,homepage,usegubun,usemoney,soundfile,sclose, "
				SQL = SQL & " dcode,fileflag,telecom,hapday,jumin1,jumin2,jumincheck,telname,conetion,ctel1,ctel2,ctel3,wdate,wuserid,orderflag,fileregcode,mregflag,brandflag,brandbox,maechulflag,"
				SQL = SQL & " cbrandchoice,d_requestday,order_weekgubun,order_weekchoice,order_checkStime,order_checkEtime,myflag,ye_money,preye_money,mi_money,agencycheck2,ch_gongi,chk_gongi1,chk_gongi2, "
				SQL = SQL & " serviceflag,dcenterflag,djflag,smsflag,myflag_select,proflag1,proflag2,miorderflag,virtual_acnt,noteflag,accountflag,premisuprint,misuprint,datadel,cyberNum,misubtn,"
				SQL = SQL & " rec_fax,cporg_cd,virtual_acnt_bank,fileflagchb,virtual_acnt2,virtual_acnt2_bank,ipConFlag,choiceDcenter,jsusu,email,smsflagType,proflag2Pgubun,kbnumAreg,conSeeflag,adminProgram,myflagauth,sms_send,yesin_memo,productorderweek,searchordertime,usesetmenu,UseDistributionTotal,virtual_acnt3,virtual_acnt3_bank,virtual_name3,virtual_acnt4,virtual_acnt4_bank,virtual_acnt5,virtual_acnt5_bank,virtual_acnt6,virtual_acnt6_bank,UseReturn,UseTax,MinOrderCheck,MinOrderAmt) VALUES "
				SQL = SQL & " (dbo.getIDXfromTB_Company(),'"& tcode &"',"
				SQL = SQL & " '"& flag &"',"
				SQL = SQL & " "& bidxsub &","
				SQL = SQL & " "& idxsub &","
				SQL = SQL & " '"& idxsubname &"',"
				SQL = SQL & " '"& comname &"',"
				SQL = SQL & " '"& name &"',"
				SQL = SQL & " '"& post &"', "
				SQL = SQL & " '"& addr &"', "
				SQL = SQL & " '"& addr2 &"', "
				SQL = SQL & " '"& companynum1 &"', "
				SQL = SQL & " '"& companynum2 &"', "
				SQL = SQL & " '"& companynum3 &"', "
				SQL = SQL & " '"& uptae &"', "
				SQL = SQL & " '"& upjong &"', "
				SQL = SQL & " '"& orderreg &"', "
				SQL = SQL & " '"& fileflaglevel &"', "

				SQL = SQL & " '"& tel1 &"', "
				SQL = SQL & " '"& tel2 &"', "
				SQL = SQL & " '"& tel3 &"', "
				SQL = SQL & " '"& fax1 &"', "
				SQL = SQL & " '"& fax2 &"', "
				SQL = SQL & " '"& fax3 &"', "
				SQL = SQL & " '"& hp1 &"', "
				SQL = SQL & " '"& hp2 &"', "
				SQL = SQL & " '"& hp3 &"', "
				SQL = SQL & " "& dcarno &", "
				SQL = SQL & " "& startday &", "
				SQL = SQL & " '"& vatflag &"', "
				SQL = SQL & " '"& taxtitle &"', "
				SQL = SQL & " '"& juminno1 &"', "
				SQL = SQL & " '"& juminno2 &"', "
				SQL = SQL & " '"& homepage &"', "
				SQL = SQL & " '"& usegubun &"', "
				SQL = SQL & " "& usemoney &", "
				SQL = SQL & " '"& soundfile &"', "
				SQL = SQL & " '"& hclose &"', "
				SQL = SQL & " '"& dcode &"', "
				SQL = SQL & " '"& fileflag &"', "
				SQL = SQL & " '"& telecom &"', "
				SQL = SQL & " '"& hapday &"', "
				SQL = SQL & " '"& jumin1 &"', "
				SQL = SQL & " '"& jumin2 &"', "
				SQL = SQL & " '"& jumincheck &"', "
				SQL = SQL & " '"& telname &"', "
				SQL = SQL & " '"& conetion &"', "
				SQL = SQL & " '"& ctel1 &"', "
				SQL = SQL & " '"& ctel2 &"', "
				SQL = SQL & " '"& ctel3 &"', "
				SQL = SQL & " '"& now() &"', "
				SQL = SQL & " '"& session("Auserid") &"', "
				SQL = SQL & " '"& orderflag &"',"
				SQL = SQL & " '"& fileregcode &"',"
				SQL = SQL & " '"& mregflag &"',"
				SQL = SQL & " '"& brandflag &"',"
				SQL = SQL & " '"& brandbox &"',"
				SQL = SQL & " '"& maechulflag &"',"

				SQL = SQL & " '"& cbrandchoice &"',"
				SQL = SQL & " '"& d_requestday &"',"
				SQL = SQL & " '"& order_weekgubun &"',"
				SQL = SQL & " '"& order_weekchoice &"',"
				SQL = SQL & " '"& order_checkStime &"',"
				SQL = SQL & " '"& order_checkEtime &"',"
				SQL = SQL & " '"& myflag &"',"
				SQL = SQL & " "& ye_money &","
                SQL = SQL & " "& preye_money &","
				SQL = SQL & " "& mi_money &","
				SQL = SQL & " '"& agencycheck2 &"',"
				SQL = SQL & " '"& ch_gongi &"',"
				SQL = SQL & " '"& chk_gongi1 &"',"
				SQL = SQL & " '"& chk_gongi2 &"',"
				SQL = SQL & " '"& serviceflag &"', "
				SQL = SQL & " '"& dcenterflag &"',"
				SQL = SQL & " '"& djflag &"',"
				SQL = SQL & " '"& smsflag &"',"
				SQL = SQL & " '"& myflag_select &"',"
				SQL = SQL & " '"& proflag1 &"',"
				SQL = SQL & " '"& proflag2 &"',"
				SQL = SQL & " '"& miorderflag &"',"
				SQL = SQL & " '"& virtual_acnt &"',"
				SQL = SQL & " '"& noteflag &"',"
				SQL = SQL & " '"& accountflag &"' ,"
                '2014-04-03 오종택 추가 직전미수금
                SQL = SQL & " '"& premisuprint &"' ,"
				SQL = SQL & " '"& misuprint &"' ,"
				SQL = SQL & " '"& datadel &"',"
				SQL = SQL & " '"& cyberNum &"',"
				SQL = SQL & " '"& misubtn &"',"
				SQL = SQL & " '"& rec_fax &"',"
				SQL = SQL & " '"& cporg_cd &"',"
				SQL = SQL & " '"& virtual_acnt_bank &"',"
				SQL = SQL & " '"& fileflagchb &"',"

				SQL = SQL & " '"& virtual_acnt2 &"',"
				SQL = SQL & " '"& virtual_acnt2_bank &"',"
				SQL = SQL & " '"& ipConFlag &"',"
				SQL = SQL & "  "& choiceDcenter &", "
				SQL = SQL & " '"& jsusu &"' ,"
				SQL = SQL & " '"& email &"' ,"
				SQL = SQL & " '"& smsflagType &"' ,"
				SQL = SQL & " '"& proflag2Pgubun &"' ,"
				SQL = SQL & " '"& kbnumAreg &"' ,"
				SQL = SQL & " '"& conSeeflag &"' ,"
				SQL = SQL & " '"& adminProgram &"', "
				SQL = SQL & " '"& myflagauth &"', "
				SQL = SQL & " '"& sms_send &"', "
				SQL = SQL & " '"& yesin_memo &"', "
				SQL = SQL & " '"& productorderweek &"', "
				SQL = SQL & " '"& searchordertime &"', "
				SQL = SQL & " '"& usesetmenu &"', "
				SQL = SQL & " '"& UseDistributionTotal&"', "
                SQL = SQL & " '"& virtual_acnt3 &"',"
				SQL = SQL & " '"& virtual_acnt3_bank &"', "
                SQL = SQL & " '"& virtual_name3 & "',"
                SQL = SQL & " '"& virtual_acnt4 &"',"
				SQL = SQL & " '"& virtual_acnt4_bank &"', "
      SQL = SQL & " '"& virtual_acnt5 &"',"
				SQL = SQL & " '"& virtual_acnt5_bank &"', "
      SQL = SQL & " '"& virtual_acnt6 &"',"
				SQL = SQL & " '"& virtual_acnt6_bank &"', "
    SQL = SQL & " '"& UseReturn &"', "
    SQL = SQL & " '"& UseTax &"',"
    SQL = SQL & " '"& MinOrderCheck &"',"
    SQL = SQL & " '"& MinOrderAmt &"' "
    

				SQL = SQL & ")"
				'response.write SQL
				db.Execute SQL

				'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				if flag = "3" then
					eumflag = "체인"
					eumgubun = "추가"
					eumcode = tcode
					eumcontent = comname
					SQL = "INSERT INTO tb_log(wdate,userid,usercode,flag,gubun,code,content) VALUES "
					SQL = SQL & " ('"& now() &"',"
					SQL = SQL & " '"& session("Auserid") &"',"
					SQL = SQL & " '"& session("Ausercode") &"',"
					SQL = SQL & " '"& eumflag &"', "
					SQL = SQL & " '"& eumgubun &"', "
					SQL = SQL & " '"& eumcode &"', "
					SQL = SQL & " '"& eumcontent &"') "
					db.Execute SQL
				end if
				'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			else
%>
				<script language="javascript">
					alert("해당코드가 중복됩니다.\n\n코드를 올바르게 입력해 주시기 바랍니다.1")
					history.go(-1);
				</script>
<%
				response.end
			end if

		case else
			select case dflag
				case ""
					SQL = "update tb_company set "
					SQL = SQL & " tcode = '"& tcode &"' ,"
					SQL = SQL & " flag = '"& flag &"' ,"
					'SQL = SQL & " bidxsub = "& bidxsub &" ,"
					'SQL = SQL & " idxsub = "& idxsub &" ,"
					'SQL = SQL & " idxsubname = '"& idxsubname &"' ,"
					SQL = SQL & " comname = '"& comname &"' ,"
					SQL = SQL & " name = '"& name &"' ,"
					SQL = SQL & " post = '"& post &"' ,"
					SQL = SQL & " addr = '"& addr &"' ,"
					SQL = SQL & " addr2 = '"& addr2 &"' ,"
					SQL = SQL & " companynum1 = '"& companynum1 &"' ,"
					SQL = SQL & " companynum2 = '"& companynum2 &"' ,"
					SQL = SQL & " companynum3 = '"& companynum3 &"' ,"
					SQL = SQL & " uptae = '"& uptae &"' ,"
					SQL = SQL & " upjong = '"& upjong &"' ,"
					SQL = SQL & " orderreg = '"& orderreg &"' ,"
					SQL = SQL & " fileregcode = '"& fileregcode &"' ,"
					SQL = SQL & " fileflaglevel = '"& fileflaglevel &"' ,"

					SQL = SQL & " tel1 = '"& tel1 &"' ,"
					SQL = SQL & " tel2 = '"& tel2 &"' ,"
					SQL = SQL & " tel3 = '"& tel3 &"' ,"
					SQL = SQL & " fax1 = '"& fax1 &"' ,"
					SQL = SQL & " fax2 = '"& fax2 &"' ,"
					SQL = SQL & " fax3 = '"& fax3 &"' ,"
					SQL = SQL & " hp1 = '"& hp1 &"' ,"
					SQL = SQL & " hp2 = '"& hp2 &"' ,"
					SQL = SQL & " hp3 = '"& hp3 &"' ,"

					SQL = SQL & " startday = '"& startday &"' ,"
					SQL = SQL & " email = '"& email &"' ,"
					SQL = SQL & " smsflagType = '"& smsflagType &"' ,"
					SQL = SQL & " proflag2Pgubun = '"& proflag2Pgubun &"' ,"
					SQL = SQL & " kbnumAreg = '"& kbnumAreg &"' ,"
					SQL = SQL & " conSeeflag = '"& conSeeflag &"' ,"
					SQL = SQL & " adminProgram = '"& adminProgram &"' ,"

					SQL = SQL & " dcarno = "& dcarno &" ,"
					SQL = SQL & " vatflag = '"& vatflag &"', "
					SQL = SQL & " taxtitle = '"& taxtitle &"', "
					SQL = SQL & " juminno1 = '"& juminno1 &"', "
					SQL = SQL & " juminno2 = '"& juminno2 &"', "
					SQL = SQL & " homepage = '"& homepage &"', "
					SQL = SQL & " usegubun = '"& usegubun &"', "
					SQL = SQL & " usemoney = "& usemoney &", "
					SQL = SQL & " soundfile = '"& soundfile &"', "
					SQL = SQL & " sclose = '"& hclose &"', "
					SQL = SQL & " dcode = '"& dcode &"', "
					SQL = SQL & " fileflag = '"& fileflag &"', "
					SQL = SQL & " telecom = '"& telecom &"', "
					SQL = SQL & " hapday = '"& hapday &"', "
					SQL = SQL & " jumin1 = '"& jumin1 &"', "
					SQL = SQL & " jumin2 = '"& jumin2 &"', "
					SQL = SQL & " jumincheck = '"& jumincheck &"', "
					SQL = SQL & " telname = '"& telname &"', "
					SQL = SQL & " conetion = '"& conetion &"', "
					SQL = SQL & " ctel1 = '"& ctel1 &"', "
					SQL = SQL & " ctel2 = '"& ctel2 &"', "
					SQL = SQL & " ctel3 = '"& ctel3 &"', "
					SQL = SQL & " mregflag = '"& mregflag &"', "
					SQL = SQL & " edate = '"& now() &"', "
					SQL = SQL & " euserid = '"& session("Auserid") &"', "
					SQL = SQL & " brandflag = '"& brandflag &"', "
					SQL = SQL & " cbrandchoice = '"& cbrandchoice &"', "
					SQL = SQL & " d_requestday = '"& d_requestday &"', "
					SQL = SQL & " order_weekgubun  = '"& order_weekgubun  &"', "
					SQL = SQL & " order_weekchoice = '"& order_weekchoice &"', "
					SQL = SQL & " order_checkStime = '"& order_checkStime &"', "
					SQL = SQL & " order_checkEtime = '"& order_checkEtime &"', "
					SQL = SQL & " agencycheck2 = '"& agencycheck2 &"', "
					SQL = SQL & " dcenterflag = '"& dcenterflag &"', "
					SQL = SQL & " misubtn = '"& misubtn &"', "
					SQL = SQL & " cyberNum = '"& cyberNum &"', "

					SQL = SQL & " serviceflag = '"& serviceflag &"', "
					SQL = SQL & " maechulflag = '"& maechulflag &"', "
					SQL = SQL & " myflag = '"& myflag &"', "
					SQL = SQL & " myflagauth = '"& myflagauth &"', "
					SQL = SQL & " myflag_select = '"& myflag_select &"', "

					SQL = SQL & " ye_money = "& ye_money &", "
                    SQL = SQL & " preye_money = "& preye_money &", "
					SQL = SQL & " mi_money = "& mi_money &", "

					if brandbox<>",,,,,,,,," then
						SQL = SQL & " brandbox = '"& brandbox &"', "
					end if

					SQL = SQL & " ch_gongi = '"& ch_gongi &"', "
					SQL = SQL & " chk_gongi1 = '"& chk_gongi1 &"', "
					SQL = SQL & " chk_gongi2 = '"& chk_gongi2 &"', "
					SQL = SQL & " orderflag = '"& orderflag &"', "
					SQL = SQL & " smsflag = '"& smsflag &"', "

					SQL = SQL & " proflag1 = '"& proflag1 &"', "
					SQL = SQL & " proflag2 = '"& proflag2 &"', "
					SQL = SQL & " miorderflag = '"& miorderflag &"', "
					SQL = SQL & " virtual_acnt = '"& virtual_acnt &"', "
					SQL = SQL & " noteflag = '"& noteflag &"', "
					SQL = SQL & " accountflag = '"& accountflag &"', "
                    SQL = SQL & " premisuprint = '"& premisuprint &"', "
					SQL = SQL & " misuprint = '"& misuprint &"', "
					SQL = SQL & " datadel = '"& datadel &"', "

					SQL = SQL & " rec_fax = '"& rec_fax &"', "
					SQL = SQL & " cporg_cd = '"& cporg_cd &"', "
					SQL = SQL & " virtual_acnt_bank = '"& virtual_acnt_bank &"', "

					SQL = SQL & " fileflagchb = '"& fileflagchb &"', "

					SQL = SQL & " virtual_acnt2 = '"& virtual_acnt2 &"', "
					SQL = SQL & " virtual_acnt2_bank = '"& virtual_acnt2_bank &"', "
                    SQL = SQL & " virtual_acnt3 = '"& virtual_acnt3 &"', "
					SQL = SQL & " virtual_acnt3_bank = '"& virtual_acnt3_bank &"', "
                     SQL = SQL & " virtual_name3 = '"& virtual_name3 &"', "

                    SQL = SQL & " virtual_acnt4 = '"& virtual_acnt4 &"', "
					SQL = SQL & " virtual_acnt4_bank = '"& virtual_acnt4_bank &"', "
                    
                    SQL = SQL & " virtual_acnt5 = '"& virtual_acnt5 &"', "
					SQL = SQL & " virtual_acnt5_bank = '"& virtual_acnt5_bank &"', "
                    
                    SQL = SQL & " virtual_acnt6 = '"& virtual_acnt6 &"', "
					SQL = SQL & " virtual_acnt6_bank = '"& virtual_acnt6_bank &"', "

					SQL = SQL & " ipConFlag = '"& ipConFlag &"', "
					SQL = SQL & " choiceDcenter = "& choiceDcenter &", "
					SQL = SQL & " jsusu = '"& jsusu &"', "

					'2011.04.12 sms보내기, 여신한도 visible
					SQL = SQL & " sms_send = '"& sms_send &"', "
					SQL = SQL & " yesin_memo = '"& yesin_memo &"', "
					SQL = SQL & " productorderweek = '"& productorderweek &"', "
					SQL = SQL & " searchordertime = '"& searchordertime &"', "

					'2012.08.06 세트메뉴 사용
					SQL = SQL & " usesetmenu = '"& usesetmenu &"', "
					SQL = SQL & " UseDistributionTotal ='"& UseDistributionTotal &"', "
                    SQL = SQL & " UseReturn ='"& UseReturn &"', "
                    SQL = SQL & " UseTax ='"& UseTax &"', "
                    SQL = SQL & " MinOrderCheck ='"& MinOrderCheck &"', "
                    SQL = SQL & " MinOrderAmt ='"& MinOrderAmt &"', "

					SQL = SQL & " djflag = '"& djflag &"' "
					SQL = SQL & " where idx = "& idx
					'response.write sql
					'response.end
					db.Execute SQL
                     if companynum1_before +"-"+ companynum2_before +"-"+ companynum3_before <> companynum1 +"-"+ companynum2 +"-"+ companynum3 then

                    SQL = "update tb_adminuser "
                    SQL = SQL & " set mentout = replace(mentout,'"& tcode &", ','') "
					SQL = SQL & " where userid = 'root'"
	'response.write sql				
    
                      db.Execute SQL

                         SQL = " delete tb_mentout where clientcode = '" & tcode & "'"
			            db.Execute(SQL)
                    end if

					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					if flag = "3" then
						eumflag = "체인"
						eumgubun = "수정"
						eumcode = tcode
						eumcontent = comname
						'''''''''''''''''''''''''''''''''''''''''
						if flag="3" and old_comname<>comname then
							eumgubun = "추가"
						end if
						'''''''''''''''''''''''''''''''''''''''''
						SQL = "INSERT INTO tb_log(wdate,userid,usercode,flag,gubun,code,content) VALUES "
						SQL = SQL & " ('"& now() &"',"
						SQL = SQL & " '"& session("Auserid") &"',"
						SQL = SQL & " '"& session("Ausercode") &"',"
						SQL = SQL & " '"& eumflag &"', "
						SQL = SQL & " '"& eumgubun &"', "
						SQL = SQL & " '"& eumcode &"', "
						SQL = SQL & " '"& eumcontent &"') "
						db.Execute SQL
					end if
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

				case "1"

					errorcount = 0
					if session("Ausergubun")="1" then	'루트가 본사 삭제
						set rs = server.CreateObject("ADODB.Recordset")
						SQL = " select count(idx) "
						SQL = sql & " from tb_company "
						SQL = sql & " where bidxsub = "& idx
						rs.Open sql, db, 1
						errorcount = rs(0)
						javamsg = "하위 지사정보 삭제후에 본사정보를 삭제하세요."
						rs.close
					elseif session("Ausergubun")="2" then	'본사가 지사 삭제
						set rs = server.CreateObject("ADODB.Recordset")
						SQL = " select count(idx) "
						SQL = sql & " from tb_company "
						SQL = sql & " where idxsub = "& idx
						rs.Open sql, db, 1
						errorcount = rs(0)
						javamsg = "하위 체인점정보 삭제후에 지사정보를 삭제하세요."
						rs.close
					end if

					if errorcount > 0 then
						response.write "<Script language=javascript>"
						response.write "	alert("""& javamsg &""");"
						response.write "	history.go(-1);"
						response.write "</Script>"
						response.end
					end if

					SQL = "delete tb_taxlog "
					SQL = SQL & " where substring(usercode,1,5) = '"& idx &"' "
					db.Execute SQL

					'주문내역
					set rs = server.CreateObject("ADODB.Recordset")
					SQL = " select idx from tb_order "
					SQL = sql & " where substring(usercode,1,5) = '"& idx &"' "
					rs.Open sql, db, 1
					do until rs.eof

						SQL = "delete tb_order_product "
						SQL = SQL & " where idx = '"& rs(0) &"' "
						db.Execute SQL

					rs.movenext
					loop
					rs.close

					SQL = "delete tb_order "
					SQL = SQL & " where substring(usercode,1,5) = '"& idx &"' "
					db.Execute SQL

					'호차
					SQL = "delete tb_car "
					SQL = SQL & " where usercode = '"& idx &"' "
					db.Execute SQL

					'상품
					SQL = "delete tb_product "
					SQL = SQL & " where usercode = '"& idx &"' "
					db.Execute SQL


					'체인점/지사/본사/사용자
					SQL = "delete tb_company "
					SQL = SQL & " where bidxsub = "& idx
					db.Execute SQL

					SQL = "delete tb_company "
					SQL = SQL & " where idx = "& idx
					db.Execute SQL

					SQL = "delete tb_adminuser "
					SQL = SQL & " where substring(usercode,1,5) = '"& idx &"' "
					db.Execute SQL
                    

                    '멘트제외 삭제
                    SQL = " delete tb_mentout where clientcode = '" & tcode & "'"
			        db.Execute(SQL)
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					if flag = "3" then
						eumflag = "체인"
						eumgubun = "삭제"
						eumcode = tcode
						eumcontent = comname
						SQL = "INSERT INTO tb_log(wdate,userid,usercode,flag,gubun,code,content) VALUES "
						SQL = SQL & " ('"& now() &"',"
						SQL = SQL & " '"& session("Auserid") &"',"
						SQL = SQL & " '"& session("Ausercode") &"',"
						SQL = SQL & " '"& eumflag &"', "
						SQL = SQL & " '"& eumgubun &"', "
						SQL = SQL & " '"& eumcode &"', "
						SQL = SQL & " '"& eumcontent &"') "
						db.Execute SQL
					end if
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			end select

	end select

	db.close
	set db=nothing
	response.redirect "list.asp?flag="&flag&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg

%>