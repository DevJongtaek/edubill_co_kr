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
	name = replace(request("name"),"'","''")

	userpwd = replace(request("userpwd"),"'","''")

	companynum1 = replace(request("companynum1"),"'","''")
	companynum2 = replace(request("companynum2"),"'","''")
	companynum3 = replace(request("companynum3"),"'","''")

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
	startday = int(replace(left(now(),10),"-",""))

	bidxsub = left(session("Ausercode"),5)
	idxsub = mid(session("Ausercode"),6,5)
	if idxsub = "" then
		idxsub=0
	end if

	vatflag = replace(request("vatflag"),"'","''")
	taxtitle = replace(request("taxtitle"),"'","''")
	if taxtitle="" then
		taxtitle="½ÄÀÚÀç"
	end if

	myflag = request("myflag")

	juminno1 = replace(request("juminno1"),"'","''")
	juminno2 = replace(request("juminno2"),"'","''")
	homepage = replace(request("homepage"),"'","''")
	usegubun = replace(request("usegubun"),"'","''")
	usemoney = replace(request("usemoney"),"'","''")
	orderreg = replace(request("orderreg"),"'","''")
	if orderreg="" then
		orderreg="n"
	end if

	soundfile = replace(request("soundfile"),"'","''")
	com_notice = replace(request("com_notice"),"'","''")

	chk_gongi1 = replace(request("chk_gongi1"),"'","''")
	chk_gongi2 = replace(request("chk_gongi2"),"'","''")

	timecheck1_1 = request("timecheck1_1")
	timecheck1_2 = request("timecheck1_2")
	timecheck2_1 = request("timecheck2_1")
	timecheck2_2 = request("timecheck2_2")
	noticeflag   = request("noticeflag")
	myIp = request("userip")

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




					SQL = "update tb_company set "
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
					SQL = SQL & " tel1 = '"& tel1 &"' ,"
					SQL = SQL & " tel2 = '"& tel2 &"' ,"
					SQL = SQL & " tel3 = '"& tel3 &"' ,"
					SQL = SQL & " fax1 = '"& fax1 &"' ,"
					SQL = SQL & " fax2 = '"& fax2 &"' ,"
					SQL = SQL & " fax3 = '"& fax3 &"' ,"
					SQL = SQL & " hp1 = '"& hp1 &"' ,"
					SQL = SQL & " hp2 = '"& hp2 &"' ,"
					SQL = SQL & " hp3 = '"& hp3 &"' ,"
					SQL = SQL & " timecheck1 = '"& timecheck1 &"' ,"
					SQL = SQL & " timecheck2 = '"& timecheck2 &"' ,"
					SQL = SQL & " dcarno = "& dcarno &" ,"
					SQL = SQL & " vatflag = '"& vatflag &"', "
					SQL = SQL & " taxtitle = '"& taxtitle &"', "
					if myflag = "y" or myflag = "n" then
						SQL = SQL & " myflag = '"& myflag &"', "
					end if
					SQL = SQL & " juminno1 = '"& juminno1 &"', "
					SQL = SQL & " juminno2 = '"& juminno2 &"', "
					SQL = SQL & " homepage = '"& homepage &"', "
					SQL = SQL & " usegubun = '"& usegubun &"', "
					SQL = SQL & " usemoney = "& usemoney &", "
					SQL = SQL & " soundfile = '"& soundfile &"', "
					SQL = SQL & " com_notice = '"& com_notice &"', "

					SQL = SQL & " chk_gongi1 = '"& chk_gongi1 &"', "
					SQL = SQL & " chk_gongi2 = '"& chk_gongi2 &"', "
					SQL = SQL & " noticeflag = '"& noticeflag &"', "

					SQL = SQL & " edate = '"& now() &"', "
					SQL = SQL & " euserid = '"& session("Auserid") &"' "
					SQL = SQL & " where idx = "& idx
					db.Execute SQL

					SQL = "update tb_adminuser set "
					SQL = SQL & " userpwd = '"& userpwd &"', "
					SQL = SQL & " server_name = '"& myIp &"' "
					SQL = SQL & " where flag = '2' and usercode = '"& session("Ausercode") &"' "
					db.Execute SQL 

	db.close
	set db=nothing
	response.redirect "bonsa.asp"

%>