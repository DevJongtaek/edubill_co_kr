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

	SQL = "update tb_company set "
	SQL = SQL & " name = '"& name &"' ,"
	SQL = SQL & " post = '"& post &"' ,"
	SQL = SQL & " addr = '"& addr &"' ,"
	SQL = SQL & " addr2 = '"& addr2 &"' ,"
	SQL = SQL & " companynum1 = '"& companynum1 &"' ,"
	SQL = SQL & " companynum2 = '"& companynum2 &"' ,"
	SQL = SQL & " companynum3 = '"& companynum3 &"' ,"
	SQL = SQL & " uptae = '"& uptae &"' ,"
	SQL = SQL & " upjong = '"& upjong &"' ,"
	SQL = SQL & " tel1 = '"& tel1 &"' ,"
	SQL = SQL & " tel2 = '"& tel2 &"' ,"
	SQL = SQL & " tel3 = '"& tel3 &"' ,"
	SQL = SQL & " fax1 = '"& fax1 &"' ,"
	SQL = SQL & " fax2 = '"& fax2 &"' ,"
	SQL = SQL & " fax3 = '"& fax3 &"' ,"
	SQL = SQL & " hp1 = '"& hp1 &"' ,"
	SQL = SQL & " hp2 = '"& hp2 &"' ,"
	SQL = SQL & " hp3 = '"& hp3 &"' ,"
	SQL = SQL & " dcarno = "& dcarno &" ,"
	SQL = SQL & " edate = '"& now() &"', "
	SQL = SQL & " euserid = '"& session("Auserid") &"' "
	SQL = SQL & " where idx = "& request("idx")
	db.Execute SQL

	SQL = "update tb_adminuser set "
	SQL = SQL & " userpwd = '"& userpwd &"' "
	SQL = SQL & " where flag = '3' and usercode = '"& session("Ausercode") &"' and userid = '"& session("Auserid") &"' "
	db.Execute SQL

	db.close
	set db=nothing
	response.redirect "jisa.asp"

%>