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
	searchh = request("searchh")

	gotopage = request("gotopage")
	idx = request("idx")
	flag = request("flag")

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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

	SQL = "update tb_company set "
	SQL = SQL & " order_weekgubun  = '"& order_weekgubun  &"', "
	SQL = SQL & " order_weekchoice = '"& order_weekchoice &"', "
	SQL = SQL & " order_checkStime = '"& order_checkStime &"', "
	SQL = SQL & " order_checkEtime = '"& order_checkEtime &"' "
	SQL = SQL & " where bidxsub = '"& left(session("Ausercode"),5) &"' "
	SQL = SQL & " and idxsub = '"& mid(session("Ausercode"),6,5) &"' "
	SQL = SQL & " and flag = '3' "
'response.write sql
'response.end
	db.Execute SQL
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	linksql = "idx="&idx&"&flag="&flag&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg
	'response.redirect "list.asp?flag="&flag&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg
%>

<Script language=javascript>
	alert("해당 체인점 모두에 적용 하였습니다.");
	location.href = "write.asp?<%=linksql%>";
</Script>
