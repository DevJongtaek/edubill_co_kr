<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
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
	' �˻� ���� �߰� 
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
	'��������
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
	noticeflag = rs(8)	'1:ü����2:����a:��ü
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
		SQL = sql & " and flag = 'n' and deflag = 'n' and ISNULL(Rgubun,0) != 1 "
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
		sql = " select aa.idx,aa.usercode,aa.comname1,aa.comname2,aa.orderday,aa.ordermoney,aa.carname,aa.ordering,aa.flag,aa.wdate,aa.rordermoney,aa.deflagday,aa.sendhpnum,aa.FtpFile,aa.order_cmt, aa.imsiflag,aa.tcode,aa.orderflag, aa.orderflag_m,aa.idxsubname, aa.mi_money, aa.ye_money, aa.chain_orderflag, aa.aaaaa, f.dcarname, aa.dcenterchoice, aa.admin_code, aa.soundfile "
	else
		sql = " select aa.idx,aa.usercode,aa.comname1,aa.comname2,aa.orderday,aa.ordermoney,aa.carname,aa.ordering,aa.flag,aa.wdate,aa.rordermoney,aa.deflagday,aa.sendhpnum,aa.FtpFile,aa.order_cmt, aa.imsiflag,aa.tcode,aa.orderflag, aa.orderflag_m,aa.idxsubname, aa.mi_money, aa.ye_money, aa.chain_orderflag, aa.aaaaa, f.dcarname, aa.admin_code, aa.soundfile "
	end if

	SQL = sql & " from ( "

	if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 and session("Ausergubun")="3" then
		SQL = sql & " select a.idx,a.usercode,a.comname1,a.comname2,a.orderday,a.ordermoney,a.carname,a.ordering,a.flag,a.wdate,a.rordermoney,a.deflagday,a.sendhpnum,a.FtpFile,isnull(a.order_cmt,'') as order_cmt, b.imsiflag,e.tcode,a.orderflag, a.orderflag_m,e.idxsubname, e.mi_money, e.ye_money, e.orderflag as chain_orderflag,b.aaaaa,b.dcenterchoice,e.admin_code,e.soundfile "
	else
		SQL = sql & " select a.idx,a.usercode,a.comname1,a.comname2,a.orderday,a.ordermoney,a.carname,a.ordering,a.flag,a.wdate,a.rordermoney,a.deflagday,a.sendhpnum,a.FtpFile,isnull(a.order_cmt,'') as order_cmt, b.imsiflag,e.tcode,a.orderflag, a.orderflag_m,e.idxsubname, e.mi_money, e.ye_money, e.orderflag as chain_orderflag,b.aaaaa,e.admin_code,e.soundfile "
	end if

	SQL = sql & " from "
	SQL = sql & " 	(select idx,usercode,comname1,comname2,orderday,ordermoney,carname,ordering,flag,wdate,rordermoney,deflagday,sendhpnum,FtpFile,isnull(order_cmt,'') as order_cmt,orderflag, orderflag_m, deflag "
	SQL = sql & " 	from tb_order "
	SQL = sql & " 	where  ISNULL(Rgubun,0) != 1  and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' and " 
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
			SQL = sql & " 	(select idx,imsiflag, sum(rordernum * case '10233' when '10233' then p.pprice else v.pprice end) as aaaaa,dcenterchoice from v_tb_order  v join (select pcode, pprice from tb_product where usercode = '77275') p on p.pcode = v.pcode where ISNULL(Rgubun,0) != 1 and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 and session("Ausergubun")="3" then
				'����α��ν� ���簡 ���������̿�� �ش繰�����͸� ��������07.01.12'''''''''''''''''''''''''
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
			SQL = sql & " 	(select idx,imsiflag, sum(rordernum*pprice) as aaaaa,dcenterchoice from v_tb_order where ISNULL(Rgubun,0) != 1 and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 and session("Ausergubun")="3" then
				'����α��ν� ���簡 ���������̿�� �ش繰�����͸� ��������07.01.12'''''''''''''''''''''''''
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
		SQL = sql & " 	(select idx,imsiflag, sum(rordermoney) as aaaaa       from v_tb_order where ISNULL(Rgubun,0) != 1 and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
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
	SQL = sql & " 	(select tb_company.idx,tb_company.tcode,tb_company.idxsubname, tb_company.mi_money, tb_company.ye_money, tb_company.orderflag, tb_company.comname, admin.tcode as admin_code, tb_company.soundfile from tb_company join tb_company admin on tb_company.bidxsub = admin.idx where tb_company.bidxsub = "& left(session("Ausercode"),5) &") e "
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

	if searchh = "1" then		'��
		SQL = sql & " and ((a.FtpFile <> '' and a.FtpFile is not null) or (a.order_cmt <> '' and a.order_cmt is not null))"
	elseif searchh = "2" then	'��
		SQL = sql & " and ((a.FtpFile = '' or a.FtpFile is null) and (a.order_cmt = '' or a.order_cmt is null))"
	end if

	if searchh = "3" then	'�̼�����
		SQL = sql & " and (a.orderflag = 'y' or (e.orderflag='1' or e.orderflag='2' or e.orderflag='3'))"
	end If
	
	if searchi = "chaincode" then	'ü���� �ڵ� �˻�
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
	rslist.PageSize=20
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

	if session("Ausergubun")="3" then	'����α��νø� ü���������� ������
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
	'�ߺ��ֹ� üũ
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx ,usercode, orderday, SUM(ordermoney) ordermoney from  "
	SQL = sql & " (select idx, usercode, orderday, SUM(pprice*rordernum) ordermoney from v_tb_order  "
	if session("Ausergubun")="3" then
		SQL = sql & " where ISNULL(Rgubun,0) != 1 and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " where ISNULL(Rgubun,0) != 1 and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
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
				SQL = sql & " where ISNULL(Rgubun,0) != 1 and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			else
				SQL = sql & " where ISNULL(Rgubun,0) != 1 and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
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
				SQL = sql & " where ISNULL(Rgubun,0) != 1 and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			else
				SQL = sql & " where ISNULL(Rgubun,0) != 1 and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
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

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ �ֹ����� ]</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>��.�ֹ����� : �ϰ�����('�ϰ��ֹ�' ��ư Ŭ��->�̹�� �� ��� ����), �Ǻ�����(�ֹ������� '�ֹ�Ȯ��' ��ư Ŭ��->�ش� �Ǹ� ����)</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>��.��޿Ϸ� : ���� ����� �Ϸ�Ǿ�����, '�ϰ����' ��ư�� Ŭ��, '�ֹ�Ȯ��'->'�������'(����)�� �ٲ� ��. </td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>��.������ : '������' ��ư Ŭ��->��ȸ�� �� ��, ��޿Ϸῡ�� �ֹ��������� ���� ('�������'->'�ֹ�Ȯ��') </td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=form>
	<tr>
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>�ֹ�����<BR> &nbsp;<B>�ֹ����� �˻�</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<%If searchordertime = "y" Then %><input type="Text" name="searchk" size="6" maxlength="6" class="box_work" value="<%=searchk%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;"><%End If %>
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<%If searchordertime = "y" Then %><input type="Text" name="searchl" size="6" maxlength="6" class="box_work" value="<%=searchl%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;"><%End If %>
			<input type="button" name="����" value="����" class="box_work"
			<%If searchordertime = "y" Then %>	
			onclick="javascript:serchtodaychecktime(document.form.searchd, document.form.searche, document.form.searchk, document.form.searchl);"
			<%else%>
			onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);"
			<%End If %>> ��)20040928 ~ 20041004
			<BR>


<%if session("Ausergubun")<>"3" then%>
			<!--#include virtual="/adminpage/order/kind.asp"-->
			<select name="searchc" size="1" class="box_work" onChange="Select_cate(this.form2,'');">
	          			<option value="0">������ü</option>
					<%if barrayint<>"" then%>
						<%for i=0 to barrayint%>
		        	  			<option value="<%=barray(0,i)%>"><%=barray(1,i)%>
						<%next%>
					<%end if%>
        		</select>
              		<select name=searchf class="f">
                		<option value=0>ü������ü</option>
              		</select>
			<script language="JavaScript">set_menu();</script>
<%else%>
              		<select name=searchf class="f">
                		<option value=0>ü������ü</option>
				<%if barrayint<>"" then%>
					<%for i=0 to barrayint%>
	        	  			<option value="<%=barray(0,i)%>"><%=barray(1,i)%>
					<%next%>
				<%end if%>
              		</select>
<%end if%>


			<select name="searchg" size="1" class="box_work">
				<%if hcararrayint<>"" then%>
	          			<option value="0" <%if searchg = "" then%>selected<%end if%>>ȣ����ü</option>
					<%for i=0 to hcararrayint%>
	        	  			<option value="<%=hcararray(1,i)%>" <%if searchg=hcararray(1,i) then%>selected<%end if%>><%=hcararray(1,i)%>ȣ��
					<%next%>
				<%else%>
	          			<option value="0" <%if searchg = "" then%>selected<%end if%>>ȣ����Ͼ���</option>
				<%end if%>
        		</select>
			<select name="searcha" size="1" class="box_work">
	          			<option value="" <%if searcha="" then%>selected<%end if%>>��ü</option>
        	  			<option value="1" <%if searcha="1" then%>selected<%end if%>>�ֹ�����
        	  			<option value="2" <%if searcha="2" then%>selected<%end if%>>�ֹ�Ȯ��
        	  			<option value="3" <%if searcha="3" then%>selected<%end if%>>��޿Ϸ�
        		</select>
			<select name="searchh" size="1" class="box_work">
	          			<option value="" <%if searchh="" then%>selected<%end if%>>��ü
        	  			<option value="1" <%if searchh="1" then%>selected<%end if%>>�޽���(��)
        	  			<option value="2" <%if searchh="2" then%>selected<%end if%>>�޽���(��)
        	  			<option value="3" <%if searchh="3" then%>selected<%end if%>>�̼�����
        	  			<!--<option value="4" <%if searchh="4" then%>selected<%end if%>>����ֹ�-->
        		</select>
					<br>
					<select name="searchi" size="1" class="box_work">
						<option value="a" <%if searchi="a" then%>selected<%end if%>>�˻����� ����
						<option value="chaincode" <%if searchi="chaincode" then%>selected<%end if%>>ü�����ڵ�
						<option value="chainname" <%if searchi="chainname" then%>selected<%end if%>>ü������
					</select>
					<input type="Text" name="searchj" size="20" maxlength="20" class="box_work" value="<%=searchj%>"><span style="width:22em"></span>
	        	<input type="button" name="�� ��" value="�� �� " class="box_work" onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work" onclick="javascript:frmzerocheck(this.form,'list.asp');">
		</td>
	</tr>

</form>

</table>

<table border=0 cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=60%>* ��ü <B><%=rslist.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.
<%if session("Ausergubun")="2" or session("Ausergubun")="3" then%>
	<%if session("Auserwrite")="y" or  (session("Auserwrite")="n" AND session("Buserwrite")="2") then%>

			<a href="allreg3.asp?searchc=<%=searchc%>&searchh=<%=searchh%>&searchf=<%=searchf%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>" onClick="CallJS('Demo()')"><img src="/images/admin/l_bu28.gif" border=0 alt="������"></a>
	<%end if%>
	<%if left(session("Ausercode"),5)="12629" and session("Ausergubun")="3" then%>
		<a href="#" onclick="posorderwin();"><img src="aaa.gif" border=0 alt="POS�ֹ�"></a>
	<%end if%>
    <%if (left(session("Ausercode"),5)="21909" OR left(session("Ausercode"),5)="27912") and session("Ausergubun")="2" then%>
	<a href ="excellLogis.asp?searche=<%=searche%>&searchd=<%=searchd%>">
        	<img src="../../images/admin/l_bu177.png" border=0></a>
	<%end if%>
<%end if%>
          
		</td>
		<td width=40% align=right>

		<%if kbnumAreg="y" then%><a href="#" onclick="mRegPop();"><img src="/images/admin/l_bu199.gif" border=0 alt="��Ȯ�� �Ա�"></a><%end if%>
<%if session("Ausergubun")="2" or session("Ausergubun")="3"   then%>
	<%if session("Auserwrite")="y" or  (session("Auserwrite")="n" AND session("Buserwrite")="2")then%>
		<a href ="Excell7.asp?searcha=<%=searcha%>&searchc=<%=searchc%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">
		<img src="/images/admin/excel.gif" border=0></a>
		<a href="allreg.asp?searchc=<%=searchc%>&searchf=<%=searchf%>&searchh=<%=searchh%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>&searchk=<%=searchk%>&searchl=<%=searchl%>&searchm=<%=searchordertime%>" onClick="CallJS('Demo()')"><img src="/images/admin/l_bu19.gif" border=0></a>
		<a href="allreg2.asp?searchc=<%=searchc%>&searchf=<%=searchf%>&searchh=<%=searchh%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>&searchk=<%=searchk%>&searchl=<%=searchl%>&searchm=<%=searchordertime%>" onClick="CallJS('Demo()')"><img src="/images/admin/l_bu21.gif" border=0></a>
	<%end if%>
<%end if%>

<!--<img src="/images/admin/excel.gif" border=0>
<a href="excell.asp?searcha=<%=searcha%>&searchh=<%=searchh%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a>-->

		</td>
       
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>��ȣ</td>
		<td width=7%>�ڵ�</td>
		<td width=16%>ü������</td>
		<td width=17%>�ֹ��Ͻ�</td>
		<td width=11%>�ݾ�</td>
		<td width=9%>ȣ��</td>
		<td width=9%>����</td>
		<!--<td width=13%>��������</td>-->
		<td width=11%>�������</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
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
	admin_code    = rslist("admin_code")
	soundfile    = rslist("soundfile")

	if orderflag="y" or corderflag="1" or corderflag="2" or corderflag="3" then	'�ֹ����̺� - �����ֹ�
		imsifontcolor = "<font color=red>"
	elseif corderflag="4" or corderflag="5" then		'��� 1,2
		imsifontcolor = "<font color=blue>"
	else
		if myflag="y" then	'���� �̼���üũ�Ѵ��϶�
			if corderflag="y" and orderflag_m="y" then	'ü�����ֹ��� & �̼��� ���ź��� ������
				imsifontcolor = "<font color=blue>"
			end if
		end if
	end if

	if isnull(imsimoney) then imsimoney=rslist("ordermoney")
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=imsifontcolor%><%=j%></td>
		<td><%=imsifontcolor%><%=imsitcode%></td>
		<td align=left><%=imsifontcolor%>&nbsp;<a href="write.asp?gotopage=<%=gotopage%>&flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><b><%=imsifontcolor%><%=rslist("comname2")%></a><%if imsiiconfile<>"" then%><a href="/fileupdown/wav/<%=imsiiconfile%>" target=_blank><img src="icon.gif" border=0></a><a href="#" onclick="javascript:newwinC('<%=imsitcode%>', '<%=admin_code%>', '<%=soundfile%>');"><img src="launch.png" border="0" style="margin-bottom: -4;"></a><%end if%><%if imsiorder_cmt<>"" then%><a href="#" onclick="window.open('order_cmt.asp?idx=<%=rslist("idx")%>' , 'blank<%=i%>','left=100, top=100, width=400, height=300, scrollbars=yes, toolbar=no');"><img src="/images/coment.gif" border=0></a><%end if%></td>
		<td><%=imsifontcolor%><%=imsidaytime%></td>

		<%if session("Ausergubun")="3" and session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then%>
			<td align=right><%=imsifontcolor%><%=FormatCurrency(aaaaa)%>&nbsp;</td>
		<%else%>
			<td align=right><%=imsifontcolor%><%=FormatCurrency(imsimoney)%>&nbsp;</td>
			<!--<td align=right><%=imsifontcolor%><%=FormatCurrency(aaaaa)%>&nbsp;</td>-->
		<%end if%>

		<td><%=imsifontcolor%><%=rslist("carname")%>ȣ��</td>
		<td><%=imsidcarname%></td>
		<!--<td><%=imsifontcolor%><%=rslist("idxsubname")%></td>-->
		<td><%=imsifontcolor%>
			<%if imsimarkflag="T" then%>*<%end if%>
			<%if rslist("flag")="n" then%>
			<%elseif rslist("flag")="y" then%>
				<%if rslist("deflagday")="" or isnull(rslist("deflagday")) then%>
					�ֹ�Ȯ��
				<%else%>
					<%=left(rslist("deflagday"),4)%>/<%=mid(rslist("deflagday"),5,2)%>/<%=right(rslist("deflagday"),2)%>
				<%end if%>
			<%end if%>
		</td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
%>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>����10��</font> [ "
			Else 
		%>
				<a href="list.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>&searchk=<%=searchk%>&searchl=<%=searchl%>">ù������</a>&nbsp;
				<a href="list.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>&searchk=<%=searchk%>&searchl=<%=searchl%>">���� 10��</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="list.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>&searchk=<%=searchk%>&searchl=<%=searchl%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>����10��</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="list.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>&searchk=<%=searchk%>&searchl=<%=searchl%>">���� 10��</a>
				&nbsp;<a href="list.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>&searchk=<%=searchk%>&searchl=<%=searchl%>">������</a>
		<% 	End If %>

		</td>
	</tr>
</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->

<%if gongi="1" and imsicom_notice<>"" and (noticeflag="2" or noticeflag="a") and session("Ausergubun")="3" then%>
<!--------���̾� �˾�---------->
<div id="popWindow" style="position:absolute; left:<%if imsich_gongi<>"" then%>30<%else%>80<%end if%>px; top:370px; z-index:0; visibility;" onSelectStart="return false" isInfoWin="true">
<table width="350" height=100 cellpadding="0" cellspacing="0" border="0" bgcolor=white>
	<tr>
		<td height=25 bgcolor=#2A75B6 width=70%>&nbsp; <font color=white><b>* ��ü ��������</td>
		<td height=25 bgcolor=#2A75B6 width=30% align=right><a href="#" onclick="pop_win()"><font color=white><B>[ â �� �� ]</a>&nbsp; </td>
	</tr>
	<tr>
		<td valign=top bgcolor=#F4FB9F align=center colspan=2>

		<table width="97%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td><font color=black><B><%=imsicom_notice%></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td colspan=2 height=20 bgcolor=#2A75B6 align=right></td>
	</tr>
</table>
</div>
<!--//�˾�-->
<%end if%>
<%If overlapcheckuse = "y" Then %>
<%If left(session("Ausercode"),5) = "49808" or left(session("Ausercode"),5) = "32447" or left(session("Ausercode"),5) = "12068" Then
  Else %>
<%If Trim(overlapIdx) <> "" Then %>
<div id="popup" style="position:absolute; left:80px; top:100px; z-index:0; width:620;height:300;background-color:white; border:2px solid hotpink; display:none;">
   <div id="pop1">
    <div id="popContent">
	<table width="500" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td colspan=2><font color=blue size=3pt><b>[�ߺ��ֹ� �� Ȯ��]</b></font></td>
	</tr>
	<tr>
		<td width=8%><img src="warning.png" width=50 height=50></td>
		<td><font color = red>���� ���ڿ� ������ �ݾ����� ���� ���� �ֹ��Ǿ����ϴ�. <br> �ߺ� �ֹ� �� ���θ� ���� Ȯ���Ͻñ� �ٶ��ϴ�.!!!</font></td>
	</tr>
	<tr>
		<td align=center colspan=2>
		<div id="tempdiv" style="overflow:auto; height:200px; width:600px;">
		<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7 id="searchlist">
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width="15%">ü�����ڵ�</td>
				<td>ü������</td>
				<td>�ֹ��Ͻ�</td>
				<td>�ֹ��ݾ�</td>
				<td>���</td>
			</tr>
			<% Do Until rsoverlist.eof 
				imsidaytime = left(rsoverlist("idx"),4)&"/"&mid(rsoverlist("idx"),5,2)&"/"&mid(rsoverlist("idx"),7,2)
				imsidaytime = imsidaytime&" "&mid(rsoverlist("idx"),9,2)&":"&mid(rsoverlist("idx"),11,2)&":"&mid(rsoverlist("idx"),13,2)
			%>
			<tr height=22 bgcolor=#FFFFFF align=center>
				<td><%=rsoverlist("tcode")%></td>
				<td><%=rsoverlist("comname")%></td>
				<td><%=imsidaytime%></td>
				<td><%=FormatCurrency(rsoverlist("ordermoney"))%></td>
				<td></td>
			</tr>
			<% rsoverlist.movenext 
			   Loop %>
		</table>
		</td>
	</tr>
</table>
    </div>
    <div id="popFooter">
     <div class="popChk"  style="position:absolute;">
      <input type="checkbox" name="popcheck" />���� �Ϸ� �׸� ���� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="javascript:closeWin();"><span>[�ݱ�]</span></a>
     </div>
    </div>
   </div>
  </div>
<%
		End If 
	End if	
End If 
if imsiflagpopup="y" Then %>
<div id="notice" style="position:absolute; left:80px; top:100px; z-index:0; width:620;height:300;background-color:white; border:2px solid hotpink; display:none;">
   <div id="pop2">
    <div id="popContent2">
	<table width="500" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td colspan=2 align=Center><font color=blue size=3pt><b>[ �� �� �� ��]</b></font></td>
	</tr>
	<tr>
		<td align=center colspan=2>
		<div id="tempdiv2" style="overflow:auto; height:250px; width:600px;">
		<font color=black><%=imsicontent%></font>
		</td>
	</tr>
</table>
    </div>
    <div id="popFooter2">
     <div class="popChk"  style="position:absolute;">
      <input type="checkbox" name="noticecheck" />���� �Ϸ� �׸� ���� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="javascript:noticecloseWin();"><span>[�ݱ�]</span></a>
     </div>
    </div>
   </div>
  </div>

<%
End If 
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

if(document.all['notice']){
 if ( cookiedata.indexOf("noticediv=done") < 0 ){ 
  document.all['notice'].style.display = "";
 } else {
  document.all['notice'].style.display = "none";
 }
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
  function newwinC(i1, i2, p) {
  	window.open('/adminpage/index.asp?i=' + i2 + i1 + '&p=' + p, 'CheckID', 'scrollbars=yes,width=800,height=' + screen.availHeight + '')
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
