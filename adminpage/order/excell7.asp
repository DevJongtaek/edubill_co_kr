<% @  codepage="949" language="VBScript" %>
<%
 Session.CodePage = 949
 Response.ChaRset = "EUC-KR"
%>
<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=주문메모(체인)"&replace(left(now(),10),"-","")&".xls"
%>

<!--#include virtual="/db/db.asp"-->
<%
	gongi = request("gongi")
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	' 검색 조건 추가 
	searchi = request("searchi")
	searchj = request("searchj")
	searchk = request("searchk")
	searchl = request("searchl")

	if searchg="" then
		searchg = "0"
	end if
	if searchc="" then
		searchc = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if

	if searchd="" then
		searchd = replace(left(now()-1,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end If
	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'공지사항
		set rsnotice = server.CreateObject("ADODB.Recordset")
	SQL = " select content,flag,hflag,wsize,hsize"
	SQL = sql & " from tb_gongi "
	rsnotice.Open sql, db, 1
	imsicontent = rsnotice(0)
	imsiflag = rsnotice(1)
	imsihflag = rsnotice(2)
	imsiwsize = rsnotice(3)
	imsihsize = rsnotice(4)
	rsnotice.close

	if imsihflag="n" then
		imsicontent = Replace(imsicontent,chr(13),"<br>")
	end if


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select orderreg,myflag, brandflag,brandbox,isnull(com_notice,''),isnull(chk_gongi1,''),isnull(chk_gongi2,''),proflag2,noticeflag,kbnumAreg,searchordertime,SearchStartTime,SearchEndTime,overlapcheckuse "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag='1' "
	SQL = sql & " and idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	imsiorderreg = rs(0)
	myflag = rs(1)

	imsibrandflag = rs(2)
	imsibrandbox  = rs(3)
	imsicom_notice= rs(4)
	imsicom_notice= Replace(imsicom_notice,chr(13),"<br>")
	imsichk_gongi1 = Replace(rs(5),chr(13),"<br>")
	imsichk_gongi2 = Replace(rs(6),chr(13),"<br>")
	proflag2 = rs(7)
	noticeflag = rs(8)	'1:체인점2:지사a:전체
	kbnumAreg = rs(9)
	searchordertime = rs(10)
	SearchStrartTime = rs(11)
	SearchEndTime = rs(12)
	overlapcheckuse = rs(13)
	rs.close

	If searchk = "" and SearchStrartTime = "" Then 
		searchk = "000000"
	Else 
		If Len(SearchStrartTime) = 4 Then 
			searchk = SearchStrartTime & "00"
		Else
			searchk = "000000"
		End If 
	End If 

	If searchl = "" and SearchEndTime = ""Then 
		searchl = "235959"
	Else 
		If Len(SearchEndTime) = 4 Then 
			searchl = SearchEndTime & "59"
		Else
			searchl = "235959"
		End If 
	End if

	startdate = searchd + searchk
	enddate = searche + searchl

	if imsiorderreg="y" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,usercode,ordermoney "
		SQL = sql & " from tb_order"
		SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		SQL = sql & " and substring(idx,1,8) = '"& replace(left(now(),10),"-","") &"' "
		SQL = sql & " and flag = 'n' and deflag = 'n' "
		rs.Open sql, db, 1

		do until rs.eof
			SQL = "update tb_order set "
			SQL = SQL & " flag = 'y' ,"
			SQL = SQL & " ordering = '9' ,"
			SQL = SQL & " rordermoney = "&rs(2)&" ,"
			SQL = SQL & " edate = '"& now() &"', "
			SQL = SQL & " euserid = '"& session("Auserid") &"' "
			SQL = SQL & " where idx = '"& rs(0) &"' "
			db.Execute SQL

			set rs2 = server.CreateObject("ADODB.Recordset")
			SQL = " select pidx,ordernum "
			SQL = sql & " from tb_order_product"
			SQL = sql & " where idx = '"& rs(0) &"' "
			rs2.Open sql, db, 1

			do until rs2.eof
				SQL = "update tb_order_product set "
				SQL = SQL & " rordernum = "& rs2(1) &" ,"
				SQL = SQL & " edate = '"& now() &"', "
				SQL = SQL & " euserid = '"& session("Auserid") &"' "
				SQL = SQL & " where pidx = "& rs2(0)
				db.Execute SQL
			rs2.movenext
			loop
			rs2.close
		rs.movenext
		loop
		rs.close

	end if
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	fclass1 = Request("fclass1")
	sclass2 = Request("sclass2")
	tclass3 = Request("tclass3")
	imsifclass1 = right(Request("fclass1"),5)
	imsisclass2 = right(Request("sclass2"),5)
	imsitclass3 = right(Request("tclass3"),5)

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")

	if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 and session("Ausergubun")="3" then
		sql = " select aa.idx,aa.usercode,aa.comname1,aa.comname2,aa.orderday,aa.ordermoney,aa.carname,aa.ordering,aa.flag,aa.wdate,aa.rordermoney,aa.deflagday,aa.sendhpnum,aa.FtpFile,aa.order_cmt, aa.imsiflag,aa.tcode,aa.orderflag, aa.orderflag_m,aa.idxsubname, aa.mi_money, aa.ye_money, aa.chain_orderflag, aa.aaaaa, f.dcarname,aa.dcenterchoice "
	else
		sql = " select aa.idx,aa.usercode,aa.comname1,aa.comname2,aa.orderday,aa.ordermoney,aa.carname,aa.ordering,aa.flag,aa.wdate,aa.rordermoney,aa.deflagday,aa.sendhpnum,aa.FtpFile,aa.order_cmt, aa.imsiflag,aa.tcode,aa.orderflag, aa.orderflag_m,aa.idxsubname, aa.mi_money, aa.ye_money, aa.chain_orderflag, aa.aaaaa, f.dcarname "
	end if

	SQL = sql & " from ( "

	if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 and session("Ausergubun")="3" then
		SQL = sql & " select a.idx,a.usercode,a.comname1,a.comname2,a.orderday,a.ordermoney,a.carname,a.ordering,a.flag,a.wdate,a.rordermoney,a.deflagday,a.sendhpnum,a.FtpFile,isnull(a.order_cmt,'') as order_cmt, b.imsiflag,e.tcode,a.orderflag, a.orderflag_m,e.idxsubname, e.mi_money, e.ye_money, e.orderflag as chain_orderflag, b.aaaaa, b.dcenterchoice "
	else
		SQL = sql & " select a.idx,a.usercode,a.comname1,a.comname2,a.orderday,a.ordermoney,a.carname,a.ordering,a.flag,a.wdate,a.rordermoney,a.deflagday,a.sendhpnum,a.FtpFile,isnull(a.order_cmt,'') as order_cmt, b.imsiflag,e.tcode,a.orderflag, a.orderflag_m,e.idxsubname, e.mi_money, e.ye_money, e.orderflag as chain_orderflag, b.aaaaa "
	end if

	SQL = sql & " from "
	SQL = sql & " 	(select idx,usercode,comname1,comname2,orderday,ordermoney,carname,ordering,flag,wdate,rordermoney,deflagday,sendhpnum,FtpFile,isnull(order_cmt,'') as order_cmt,orderflag, orderflag_m, deflag "
	SQL = sql & " 	from tb_order "
	SQL = sql & " 	where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' and " 
		If searchordertime = "n" Or searchordertime ="" Then 
		SQL = sql & " 	(orderday >= '"& searchd &"' and orderday <= '"& searche &"')) a "
	Else 
		SQL = sql & "  (convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
		SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) )) a "
	End If 

	SQL = sql & " 	left outer join "

	if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 and session("Ausergubun")="3" then
		'SQL = sql & " 	(select idx,imsiflag, sum(ordermoney) as aaaaa,dcenterchoice from v_tb_order where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		If trim(session("Adcenteridx")) = "10234" then
			SQL = sql & " 	(select idx,imsiflag, sum(rordernum * case '10233' when '10233' then p.pprice else v.pprice end) as aaaaa,dcenterchoice from v_tb_order  v join (select pcode, pprice from tb_product where usercode = '77275') p on p.pcode = v.pcode where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 and session("Ausergubun")="3" then
				'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
				SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
			end if
			If searchordertime = "n" Or searchordertime ="" Then 
				SQL = sql & " 	and (orderday >= '"& searchd &"' and orderday <= '"& searche &"') " 
			Else 
				SQL = sql & "  and  (convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
				SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) ) "
			End If 
			SQL = sql & "  group by idx,imsiflag,dcenterchoice) b "
		Else
			SQL = sql & " 	(select idx,imsiflag, sum(rordernum*pprice) as aaaaa,dcenterchoice from v_tb_order where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 and session("Ausergubun")="3" then
				'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
				SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
			end if
			If searchordertime = "n" Or searchordertime ="" Then 
				SQL = sql & " 	and (orderday >= '"& searchd &"' and orderday <= '"& searche &"') "
			Else
				SQL = sql & "  and (convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
				SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) )"
			End If 
			SQL = sql & "  group by idx,imsiflag,dcenterchoice) b "
		End If 
	else
		SQL = sql & " 	(select idx,imsiflag, sum(rordermoney) as aaaaa       from v_tb_order where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		'SQL = sql & " 	(select idx,imsiflag, sum(isnull(rordernum,0)*isnull(pprice,0)) as aaaaa from v_tb_order where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		If searchordertime = "n" Or searchordertime ="" Then 
			SQL = sql & " 	and (orderday >= '"& searchd &"' and orderday <= '"& searche &"') "
		Else
			SQL = sql & "  and (convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
			SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) )"
		End If 
		SQL = sql & "  group by idx,imsiflag) b "
	end if

	SQL = sql & " 	on a.idx=b.idx "
	SQL = sql & " 	left outer join "
	SQL = sql & " 	(select idx,tcode,idxsubname, mi_money, ye_money, orderflag, comname from tb_company where bidxsub = "& left(session("Ausercode"),5) &") e "
	SQL = sql & " 	on substring(a.usercode,11,5) = e.idx "

	if session("Ausergubun")="3" then
		SQL = sql & " where substring(a.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " where substring(a.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	if searcha="1" then
		SQL = sql & " and a.flag = 'n' "
	elseif searcha="2" then
		SQL = sql & " and a.flag = 'y' and a.deflag='n' "
	elseif searcha="3" then
		SQL = sql & " and a.flag = 'y' and a.deflag='y' "
	end if

	if searchc <> "" and searchc <> "0" then
		SQL = sql & " and substring(a.usercode,6,5) = '"& searchc &"' "
	end if

	if searchf <> "" and searchf <> "0" then
		SQL = sql & " and substring(a.usercode,11,5) = '"& searchf &"' "
	end if

	if searchd <> "" then
		If searchordertime = "n" Or searchordertime ="" Then 
			SQL = sql & " and a.orderday >= '"& searchd &"' "
		Else
			SQL = sql & "  and convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
		End If 
	end if

	if searche <> "" then
		If searchordertime = "n" Or searchordertime ="" Then 
			SQL = sql & " and a.orderday <= '"& searche &"' "
		Else
			SQL = sql & " and convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2))"
		End If 
	end if

	if searchg<>"0" then
		SQL = sql & " and  a.carname = '"& searchg &"' "
	end if

	if imsifclass1<>"" then
		SQL = sql & " and  substring(a.usercode,1,5) = '"& imsifclass1 &"' "
	end if

	if imsisclass2<>"" then
		SQL = sql & " and  substring(a.usercode,6,5) = '"& imsisclass2 &"' "
	end if

	if imsitclass3<>"" then
		SQL = sql & " and  substring(a.usercode,11,5) = '"& imsitclass3 &"' "
	end if

	if searchh = "1" then		'유
		SQL = sql & " and ((a.FtpFile <> '' and a.FtpFile is not null) or (a.order_cmt <> '' and a.order_cmt is not null))"
	elseif searchh = "2" then	'무
		SQL = sql & " and ((a.FtpFile = '' or a.FtpFile is null) and (a.order_cmt = '' or a.order_cmt is null))"
	end if

	if searchh = "3" then	'미수정지
		SQL = sql & " and (a.orderflag = 'y' or (e.orderflag='1' or e.orderflag='2' or e.orderflag='3'))"
	end If
	
	if searchi = "chaincode" then	'체인점 코드 검색
		SQL = sql & " and tcode = '" & searchj & "' "
	ElseIf searchi = "chainname" Then 
		SQL = sql & " and comname like '%" & searchj & "%' "
	end If	

	if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 and session("Ausergubun")="3" then
		SQL = sql & " and b.dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
	end if

	SQL = sql & " 	) aa "

	SQL = sql & " 	left outer join "
	SQL = sql & "	(select dcarname,dcarno from tb_car where usercode = '"& left(session("Ausercode"),5) &"') f "
	SQL = sql & " 	on f.dcarno = aa.carname "

	SQL = sql & " order by aa.idx desc "
'response.write sql
'response.end
	rslist.PageSize=10000
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " order by dcarno asc"
	rs.Open sql, db, 1
	if not rs.eof then
		hcararray = rs.GetRows
		hcararrayint = ubound(hcararray,2)
	else
		hcararray = ""
		hcararrayint = ""
	end if
	rs.close

	if session("Ausergubun")="3" then	'지사로그인시만 체인점정보를 가져옴
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,comname "
		SQL = sql & " from tb_company "
		SQL = sql & " where flag = '3' "
		SQL = sql & " and bidxsub = '"& left(session("Ausercode"),5) &"' "
		SQL = sql & " and idxsub  = '"& mid(session("Ausercode"),6,5) &"' "
		SQL = sql & " order by comname asc"
		rs.Open sql, db, 1
		if not rs.eof then
			barray = rs.GetRows
			barrayint = ubound(barray,2)
		else
			barray = ""
			barrayint = ""
		end if
		rs.close
	end if
	'중복주문 체크
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx ,usercode, orderday, SUM(ordermoney) ordermoney from  "
	SQL = sql & " (select idx, usercode, orderday, SUM(pprice*rordernum) ordermoney from v_tb_order  "
	if session("Ausergubun")="3" then
		SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end If
	If searchordertime = "n" Or searchordertime ="" Then 
		SQL = sql & " and orderday >= '" & searchd & "'"
		SQL = sql & " and orderday <= '" & searche & "'"
	Else
		SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
		SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) "
	End If 
	SQL = sql & " group by idx, usercode , orderday) a "
	SQL = sql & " group by idx, usercode, orderday "
	SQL = sql & " order by usercode, orderday, ordermoney"
	'If left(session("Ausercode"),5) = "10339" Then  response.write SQL & "<br>" End If 
	rs.Open sql, db, 1
		imsiIdx = ""
		imsiUsercode = ""
		imsiOrderday = ""
		imsiOrdermoney = ""
		overlapIdx = ""

	Do Until rs.eof
		imIdx = rs("idx")
		imUsercode = rs("usercode")
		imOrderday = rs("orderday")
		imOrdermoney = rs("ordermoney")
		'If left(session("Ausercode"),5) = "10339" Then 
		'response.write "imUsercode:"& imUsercode & "=" & imsiUsercode&"<br>imOrderday:"&imOrderday& "=" &imsiOrderday& "<br>imOrdermoney:" &imOrdermoney &"=" &imsiOrdermoney
		'response.write "<br><br>"
		'End If 
		If imsiUsercode = imUsercode And CStr(imsiOrdermoney) = CStr(imOrdermoney) Then
			If overlapIdx = "" Then 
				overlapIdx = "'" & imsiIdx & "''" & rs("idx") & "'"
			Else 
				overlapIdx = overlapIdx & "'" & imIdx & "''" & imsiIdx & "'"
			End If 
		End If 
		imsiIdx = rs("idx")
		imsiUsercode = rs("usercode")
		imsiOrderday = rs("orderday")
		imsiOrdermoney = rs("ordermoney")
	rs.movenext
	Loop
	rs.close

	overlapIdx = Replace(overlapIdx, "''", "','")
	'If left(session("Ausercode"),5) = "10339" Then response.write "overlapIdx" &overlapIdx End If 
	If Trim(overlapIdx) <> "" then
		If trim(session("Adcenteridx")) = "10233" Then 
			set rsoverlist = server.CreateObject("ADODB.Recordset")
			SQL = " select c.tcode, c.comname, v.idx, SUM(p.pprice*rordernum) ordermoney from v_tb_order v join tb_company c  "
			SQL = sql & " on RIGHT(v.usercode, 5) = c.idx "
			SQL = sql & " join (select pcode, pprice from tb_product where usercode = '77275') p "
			SQL = sql & " on p.pcode = v.pcode "
			if session("Ausergubun")="3" then
				SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			else
				SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			end if
			SQL = sql & " and v.idx in(" & overlapIdx & ") "
			SQL = sql & " group by v.idx,c.tcode, c.comname "
			'response.write SQL & "<br>"
			rsoverlist.Open sql, db, 1
		Else
			set rsoverlist = server.CreateObject("ADODB.Recordset")
			SQL = " select c.tcode, c.comname, v.idx, SUM(pprice*rordernum) ordermoney from v_tb_order v join tb_company c  "
			SQL = sql & " on RIGHT(v.usercode, 5) = c.idx   "
			if session("Ausergubun")="3" then
				SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			else
				SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			end if
			SQL = sql & " and v.idx in(" & overlapIdx & ") "
			SQL = sql & " group by v.idx,c.tcode, c.comname "
			'If left(session("Ausercode"),5) = "10339" Then  response.write SQL & "<br>" End If 
			rsoverlist.Open sql, db, 1
		End If 
	End If 
%>
<script language="JavaScript">
<!--
function onlyNumber(){
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}
function posorderwin(){
	window.open ('posDatatorder.asp','dssdsd','width=300,height=180,left=100,top=100');
	return false ;
}

function mRegPop(){
	window.open ('mRegPop.asp','mRegPop1','toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=670,height=300,left=100,top=100');
	return false ;
}

function pop_win(){
	popWindow.style.display="none";
}
//-->
</script>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table border=0 cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=60%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.

		</td>
		<td width=40% align=right>

		<%if kbnumAreg="y" then%><a href="#" onclick="mRegPop();"><img src="/images/admin/l_bu199.gif" border=0 alt="미확인 입금"></a><%end if%>
<%if session("Ausergubun")="2" or session("Ausergubun")="3" then%>
	<%if session("Auserwrite")="y" then%>
	<%end if%>
<%end if%>

<!--<img src="/images/admin/excel.gif" border=0>
<a href="excell.asp?searcha=<%=searcha%>&searchh=<%=searchh%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a>-->

		</td>
	</tr>
	<tr>
		<td width=60%>* 기간  : <B><%=searchd%> ~ <%=searche%></b>
	</tr>
</table>
<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=7%>코드</td>
		<td width=16%>체인점명</td>
		<td width=17%>주문일시</td>
		<td width=11%>금액</td>
		<td width=9%>호차</td>
		<td width=9%>기사명</td>
		<!--<td width=13%>관할지사</td>-->
		<td width=11%>배달일자</td>
		<td width=20%>전화메모</td>
		<td width=25%>인터넷 주문 메모 내용</td>
	</tr>

<%
i=1
j=((gotopage-1)*10000)+gotopage
do until rslist.EOF or rslist.PageSize<i

	imsidaytime = left(rslist("idx"),4)&"/"&mid(rslist("idx"),5,2)&"/"&mid(rslist("idx"),7,2)
	imsidaytime = imsidaytime&" "&mid(rslist("idx"),9,2)&":"&mid(rslist("idx"),11,2)&":"&mid(rslist("idx"),13,2)

	imsimoney=0
	'if rslist("flag")="y" then
		imsimoney=rslist("rordermoney")
	'else
	'	imsimoney=rslist("ordermoney")
	'end if

	aaaaa = rslist("aaaaa")
	if isnull(aaaaa) or aaaaa="" then
		aaaaa = 0
	end if


'	imsidcarname = ""
'	set rs = server.CreateObject("ADODB.Recordset")
'	SQL = " select dcarname "
'	SQL = sql & " from tb_car "
'	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
'	SQL = sql & " and dcarno = '"& rslist("carname") &"' "
'	rs.Open sql, db, 1
'	if not rs.eof then
'	imsidcarname = rslist("dcarname")
'	end if
'	rs.close

	imsimarkflag = ""
	imsimarkflag = rslist("imsiflag")

	imsitcode = rslist("tcode")

	imsiiconfile=""
	if rslist("FtpFile")="" or isnull(rslist("FtpFile"))then
	else
		imsiiconfile = rslist("FtpFile")
	end if

	imsiorder_cmt = ""
	imsiorder_cmt = rslist("order_cmt")

	imsidcarname = rslist("dcarname")
	imsifontcolor = ""
	corderflag  = rslist("chain_orderflag")
	orderflag   = rslist("orderflag")
	orderflag_m = rslist("orderflag_m")
	mi_money    = rslist("mi_money")
	ye_money    = rslist("ye_money")

	if orderflag="y" or corderflag="1" or corderflag="2" or corderflag="3" then	'주문테이블 - 가상주문
		imsifontcolor = "<font color=red>"
	elseif corderflag="4" or corderflag="5" then		'경고 1,2
		imsifontcolor = "<font color=blue>"
	else
		if myflag="y" then	'본사 미수금체크한다일때
			if corderflag="y" and orderflag_m="y" then	'체인점주문후 & 미수가 여신보다 많을때
				imsifontcolor = "<font color=blue>"
			end if
		end if
	end if

	if isnull(imsimoney) then imsimoney=rslist("ordermoney")
%>
	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=imsifontcolor%><%=j%></td>
		<td><%=imsifontcolor%><%=imsitcode%></td>
		<td align=left><%=imsifontcolor%>&nbsp;<%=imsifontcolor%><%=rslist("comname2")%></td>
		<td><%=imsifontcolor%><%=imsidaytime%></td>

		<%if session("Ausergubun")="3" and session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then%>
			<td align=right><%=imsifontcolor%><%=FormatCurrency(aaaaa)%>&nbsp;</td>
		<%else%>
			<td align=right><%=imsifontcolor%><%=FormatCurrency(imsimoney)%>&nbsp;</td>
			<!--<td align=right><%=imsifontcolor%><%=FormatCurrency(aaaaa)%>&nbsp;</td>-->
		<%end if%>
		<td><%=imsifontcolor%><%=rslist("carname")%>호차</td>
		<td><%=imsidcarname%></td>
		<!--<td><%=imsifontcolor%><%=rslist("idxsubname")%></td>-->
		<td><%=imsifontcolor%>
			<%if imsimarkflag="T" then%>*<%end if%>
			<%if rslist("flag")="n" then%>
			<%elseif rslist("flag")="y" then%>
				<%if rslist("deflagday")="" or isnull(rslist("deflagday")) then%>
					주문확인
				<%else%>
					<%=left(rslist("deflagday"),4)%>/<%=mid(rslist("deflagday"),5,2)%>/<%=right(rslist("deflagday"),2)%>
				<%end if%>
			<%end if%>
		</td>
		<td><%if imsiiconfile<>"" then%>Y<%end if%></td>
		<td align=left><%if imsiiconfile<>"" then%>
		<%end if%>
		<%if imsiorder_cmt<>"" then%><%=rslist("order_cmt")%>
		<%end if%></td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
%>

<%
	rslist.close
	Set rsoverlist=Nothing 
'response.write "overlapIdx" &overlapIdx
	db.close
	set rs=nothing
	set rslist=Nothing
	set db=nothing
%>


<script type="text/javascript">

 cookiedata = document.cookie; 

 if ( cookiedata.indexOf("noticediv=done") < 0 ){ 
  document.all['notice'].style.display = "";
 } else {
  document.all['notice'].style.display = "none";
 }

 function noticestartTime() {
  var time = new Date();
  hours = time.getHours();
  mins = time.getMinutes();
  secs = time.getSeconds();
  closeTime = hours*3600+mins*60+secs;
  noticeTimer();
 }

 function noticeTimer() {
  var time = new Date();
  hours = time.getHours();
  mins = time.getMinutes();
  secs = time.getSeconds();
  curTime = hours*3600+mins*60+secs
  closeTime += 60;
 
  if (curTime >= closeTime) {
   document.all['notice'].style.display = "none";
  } else {
   window.setTimeout("noticeTimer()",1000);
  }
 }

 function noticesetCookie( name, value, expiredays ) { 
  var todayDate = new Date(); 
  todayDate.setDate( todayDate.getDate() + expiredays ); 
  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
 } 

 function noticecloseWin() { 
  if ( document.all.noticecheck.checked ) { 
   noticesetCookie( "noticediv", "done" , 1 ); 
  }
  
  document.all['notice'].style.display = "none";
 }
</script>

<script type="text/javascript">

 cookiedata = document.cookie; 

 if ( cookiedata.indexOf("maindiv=done") < 0 ){ 
  document.all['popup'].style.display = "";
 } else {
  document.all['popup'].style.display = "none";
 }

 function startTime() {
  var time = new Date();
  hours = time.getHours();
  mins = time.getMinutes();
  secs = time.getSeconds();
  closeTime = hours*3600+mins*60+secs;
  Timer();
 }

 function Timer() {
  var time = new Date();
  hours = time.getHours();
  mins = time.getMinutes();
  secs = time.getSeconds();
  curTime = hours*3600+mins*60+secs
  closeTime += 60;
 
  if (curTime >= closeTime) {
   document.all['popup'].style.display = "none";
  } else {
   window.setTimeout("Timer()",1000);
  }
 }

 function setCookie( name, value, expiredays ) { 
  var todayDate = new Date(); 
  todayDate.setDate( todayDate.getDate() + expiredays ); 
  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
 } 

 function closeWin() { 
  if ( document.all.popcheck.checked ) { 
   setCookie( "maindiv", "done" , 1 ); 
  }
  
  document.all['popup'].style.display = "none";
 }
</script>