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
	flag = request("flag")

	ch_gongi      = replace(request("ch_gongi"),"'","")
	saveflag      = request("saveflag")	
	cbrandchoice2 = request("cbrandchoice2")
	if saveflag="d" then
		ch_gongi = ""
	end if

	SQL1 = " select idx from tb_company "
	SQL1 = sql1 & " where flag='3' "
	SQL1 = sql1 & " and bidxsub = "& left(session("Ausercode"),5) &" and idxsub = "& mid(session("Ausercode"),6,5) &" "
	if cbrandchoice2<>"" then
		SQL1 = sql1 & " and cbrandchoice = '"& cbrandchoice2 &"' "
	end if

	SQL = "update tb_company set "
	SQL = SQL & " ch_gongi = '"& ch_gongi &"' "
	SQL = SQL & " where idx in ("& sql1 &") "
	db.Execute SQL

	db.close
	set db=nothing
	response.redirect "write.asp?idx="&idx&"&flag="&flag&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg

%>