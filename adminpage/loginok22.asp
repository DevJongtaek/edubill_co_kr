<!--#include virtual="/db/db.asp" -->
<%
	imsi_userid = request("mid")
	imsi_userpwd = request("mpwd")

	pwd = request("pwd")
	'bccode = replace(request("bccode")," ","")
	bccode = "22019174"

	bcode = left(bccode,4)	'본사입력코드
	ccode = right(bccode,4)	'체인점입력코드

	'체인점정보	tcode = 관리자입력한코드값
	set rs = server.CreateObject("ADODB.Recordset")	
'	SQL = "select (select comname from tb_company where flag='1' and tcode = '"& bcode &"'),comname,bidxsub,idxsub,idx"
'	SQL = SQL & " from tb_company "
'	SQL = SQL & " where flag = '3' "
'	SQL = SQL & " and bidxsub in ( "
'	SQL = SQL & " 			select idx from tb_company where flag='1' and tcode = '"& bcode &"' "
'	SQL = SQL & " 		     ) "
'	SQL = SQL & " and tcode = '"& ccode &"' "

	SQL = "select a.comname,b.comname,b.bidxsub,b.idxsub,b.idx,b.soundfile,b.orderflag,a.timecheck1,a.timecheck2,"
	SQL = SQL & " b.order_weekgubun,b.order_weekchoice,b.order_checkStime,b.order_checkEtime "
	SQL = SQL & " from tb_company a, tb_company b "
	SQL = SQL & " where a.idx=b.bidxsub "
	SQL = SQL & " and a.flag = '1' and b.flag='3' "
	SQL = SQL & " and a.tcode = '"& bcode &"' "
	SQL = SQL & " and b.tcode = '"& ccode &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		username1 = rs(0)	'회원사명
		username2 = rs(1)	'체인점명
		username = username1&" "&username2

		bcode = rs(2)		'실제 본사코드로 변환
		jcode = rs(3)		'실제 지사코드로 변환
		ccode = rs(4)		'실제 체인점코드로 변환
		soundfile = rs(5)	'비밀번호
		orderflag = rs(6)	'사용중지여부y/n
		imsinum = 1
		timecheck1 = rs(7)
		timecheck2 = rs(8)

		rs_order_weekgubun  = rs(9)
		rs_order_weekchoice = rs(10)
		rs_order_checkStime = rs(11)
		rs_order_checkEtime = rs(12)
	else
		imsinum = 0
	end if
	rs.close

	if orderflag<>"y" then
		response.write "<Script language=javascript>"

		'y:정상주문, 1:미수금(정지), 2:폐업(정지), 3,휴점(정지) 
		if orderflag="1" then
			response.write "	alert(""현재 미수금정지 상태입니다.\n\n체인본부로 문의 바랍니다.!"");"
		elseif orderflag="2" then
			response.write "	alert(""현재 폐업정지 상태입니다.\n\n체인본부로 문의 바랍니다.!"");"
		elseif orderflag="3" then
			response.write "	alert(""현재 휴점정지 상태입니다.\n\n체인본부로 문의 바랍니다.!"");"
		end if

		response.write "	history.go(-1);"
		response.write "</Script>"
		response.end
	end if

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if timecheck1<>"" or timecheck2<>"" then
		ho = cstr(hour(time))
		if len(ho) = 1 then
			ho2 = "0"&ho
		else
			ho2 = ho
		end if
		mi = cstr(minute(time))
		if len(mi) = 1 then
			mi2 = "0"&mi
		else
			mi2 = mi
		end if
		now_time   = "1"&ho2&mi2	'현재시간
		gijun_time1 = 12400		'기준시간1
		gijun_time2 = 10000		'기준시간2
		timecheck1 = "1"&timecheck1	'설정시간1
		timecheck2 = "1"&timecheck2	'설정시간2

		if timecheck1 < timecheck2 then
			if now_time >= timecheck1 and now_time <= timecheck2 then
				response.write "<Script language=javascript>"
				response.write "	alert(""현재 주문차단 시간입니다.\n\n체인본부로 문의 바랍니다.!"");"
				response.write "	history.go(-1);"
				response.write "</Script>"
				response.end
			end if
		else
			if (now_time >= timecheck1 and now_time <= gijun_time1) or (now_time >= gijun_time2 and now_time <= timecheck2) then
				response.write "<Script language=javascript>"
				response.write "	alert(""현재 주문차단 시간입니다.\n\n체인본부로 문의 바랍니다.!"");"
				response.write "	history.go(-1);"
				response.write "</Script>"
				response.end
			end if
		end if

	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	Function Funloginok(fundata,funtime1,funtime2)
		ho = cstr(hour(time))
		if len(ho) = 1 then
			ho2 = "0"&ho
		else
			ho2 = ho
		end if
		mi = cstr(minute(time))
		if len(mi) = 1 then
			mi2 = "0"&mi
		else
			mi2 = mi
		end if
		now_time   = int("1"&ho2&mi2)		'현재시간
		timecheck1 = int("1"&funtime1)		'설정시간1
		timecheck2 = int("1"&funtime2)		'설정시간2
		today_week = int(WeekDay(Now()))	'오늘요일
		fundata    = int(fundata)

		if fundata=1 then
			if today_week=7 or today_week=1 then
				if today_week = 7 then
					if now_time >= timecheck1 then
						loginokynflag = "y"
					else
						loginokynflag = "n"
					end if
				else
					if now_time <= timecheck2 then
						loginokynflag = "y"
					else
						loginokynflag = "n"
					end if
				end if
			else
				loginokynflag = "n"
			end if
		else
			if today_week=fundata-1 then
				if now_time >= timecheck1 then
					loginokynflag = "y"
				else
					loginokynflag = "n"
				end if
			elseif today_week=fundata then
				if now_time <= timecheck2 then
					loginokynflag = "y"
				else
					loginokynflag = "n"
				end if
			else
				loginokynflag = "n"
			end if
		end if

		Funloginok = loginokynflag

	End Function

	'rs_order_weekchoice- 1일 ~ 7토
	'rs_order_checkStime
	'rs_order_checkEtime

	if rs_order_weekgubun = "2" then	'요일주문
		if rs_order_weekchoice<>"" and rs_order_checkStime<>"" and rs_order_checkEtime<>"" then

			for i=1 to len(rs_order_weekchoice)
				if i=1 then
					rs_order_weekchoice1 = mid(rs_order_weekchoice,1,1)
				elseif i=2 then
					rs_order_weekchoice2 = mid(rs_order_weekchoice,2,1)
				elseif i=3 then
					rs_order_weekchoice3 = mid(rs_order_weekchoice,3,1)
				elseif i=4 then
					rs_order_weekchoice4 = mid(rs_order_weekchoice,4,1)
				elseif i=5 then
					rs_order_weekchoice5 = mid(rs_order_weekchoice,5,1)
				elseif i=6 then
					rs_order_weekchoice6 = mid(rs_order_weekchoice,6,1)
				elseif i=7 then
					rs_order_weekchoice7 = mid(rs_order_weekchoice,7,1)
				end if
			next

			if rs_order_weekchoice1<>"" then
				imsiloginok1 = Funloginok(rs_order_weekchoice1,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok1 = "n"
			end if
			if rs_order_weekchoice2<>"" then
				imsiloginok2 = Funloginok(rs_order_weekchoice2,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok2 = "n"
			end if
			if rs_order_weekchoice3<>"" then
				imsiloginok3 = Funloginok(rs_order_weekchoice3,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok3 = "n"
			end if
			if rs_order_weekchoice4<>"" then
				imsiloginok4 = Funloginok(rs_order_weekchoice4,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok4 = "n"
			end if
			if rs_order_weekchoice5<>"" then
				imsiloginok5 = Funloginok(rs_order_weekchoice5,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok5 = "n"
			end if
			if rs_order_weekchoice6<>"" then
				imsiloginok6 = Funloginok(rs_order_weekchoice6,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok6 = "n"
			end if
			if rs_order_weekchoice7<>"" then
				imsiloginok7 = Funloginok(rs_order_weekchoice7,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok7 = "n"
			end if
		end if

		if imsiloginok1="n" and imsiloginok2="n" and imsiloginok3="n" and imsiloginok4="n" and imsiloginok5="n" and imsiloginok6="n" and imsiloginok7="n" then

			response.write imsiloginok1&"<BR>"&imsiloginok2&"<BR>"&imsiloginok3&"<BR>"&imsiloginok4&"<BR>"&imsiloginok5&"<BR>"&imsiloginok6&"<BR>"&imsiloginok7&"<BR>"
			response.write "login no"
			response.end

		end if

	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select filename from tb_adminuser where flag= '2' and usercode = '"& bcode &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		filename = rs(0)
	end if
	rs.close

	'imsiusercodeimsi = trim(bcode&jcode&ccode)
	'set rs = server.CreateObject("ADODB.Recordset")
	'SQL = "select userpwd from tb_adminuser where flag= '4' and usercode = '"& imsiusercodeimsi &"' "
	'rs.Open sql, db, 1
	'if not rs.eof then
	'	imsipwd = rs(0)
	'end if
	'rs.close
	imsipwd = soundfile

	if imsipwd <> "" then
		if imsipwd <> pwd then
			response.write "<Script language=javascript>"
			response.write "	alert(""비밀번호가 틀립니다.\n다시 입력하여 주시기 바랍니다."");"
			response.write "	history.go(-1);"
			response.write "</Script>"
			response.end
		end if
	end if

	db.close

	select case imsinum
		case 0

			response.write "<Script language=javascript>"
			response.write "	alert(""본사코드 또는 체인점코드가 틀립니다.\n다시 입력하여 주시기 바랍니다."");"
			response.write "	history.go(-1);"
			response.write "</Script>"

		case else

			session("AAcomname") = username			'회원사+체인점명
			session("AAusercode") = bcode&jcode&ccode	'본사+지점+체인점코드
			session("AAfilename") = filename

			response.write "<Script language=javascript>"
			response.write "	alert("" "&session("AAcomname")&"에서 로그인 하셨습니다."");"
			response.write "	location.href = ""/adminpage/index4.asp?gongi=1"";"
			response.write "</Script>"
	
	end select
%>