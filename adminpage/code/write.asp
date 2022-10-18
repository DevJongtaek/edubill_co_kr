<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	GotoPage = Request("GotoPage")
	idx = Request("idx")
	flag = Request("flag")

	if idx <> "" then
		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,tcode,flag,idxsub,idxsubname,comname,name,post,addr,addr2,companynum1,companynum2,companynum3 "
		SQL = sql & " ,uptae,upjong,tel1,tel2,tel3,fax1,fax2,fax3,hp1,hp2,hp3,dcarno,startday,bidxsub,tcode,vatflag,taxtitle "
		SQL = sql & " ,juminno1,juminno2,homepage,usegubun,usemoney,orderreg,soundfile,sclose,dcode,fileflag, "
		SQL = sql & " telecom,hapday,jumin1,jumin2,jumincheck,telname,conetion,ctel1,ctel2,ctel3,orderflag,fileregcode,mregflag, "
		SQL = sql & " brandflag,brandbox,cbrandchoice,fileflaglevel,d_requestday,order_weekgubun,order_weekchoice,order_checkStime,order_checkEtime,maechulflag,myflag, "
		SQL = sql & " mi_money,ye_money,agencycheck2,ch_gongi,serviceflag,dcenterflag,djflag,smsflag,chk_gongi1,chk_gongi2,myflag_select,proflag1,proflag2,miorderflag, "
		SQL = sql & " virtual_acnt,noteflag,accountflag,misuprint,datadel,misubtn,cyberNum,rec_fax,cporg_cd,virtual_acnt_bank,fileflagchb,virtual_acnt2,virtual_acnt2_bank,"
		SQL = sql & " ipConFlag,choiceDcenter,jsusu,email,smsflagType,proflag2Pgubun,kbnumAreg,conSeeflag,adminProgram,myflagauth,sms_send,yesin_memo,productorderweek,"
		SQL = sql & "searchordertime,usesetmenu,isnull(UseDistributionTotal, 'n'),virtual_acnt3,virtual_acnt3_bank,virtual_name3 ,virtual_acnt4,virtual_acnt4_bank,virtual_acnt5,virtual_acnt5_bank,virtual_acnt6,virtual_acnt6_bank,premisuprint,preye_money,UseReturn,isnull(UseTax,'n'),isnull(MinOrderCheck,'n'),isnull(MinOrderAmt,0)"
		SQL = sql & " from tb_company "
		SQL = sql & " where idx = "& idx

		rslist.Open sql, db, 1
        
		imsitcode = rslist(1)
		imsiflag = rslist(2)
		imsiidxsub = rslist(3)
		imsiidxsubname = rslist(4)
		imsicomname = rslist(5)
		imsiname = rslist(6)
		imsipost = rslist(7)
		imsipost1 = left(imsipost,3)
		imsipost2 = right(imsipost,3)
		imsiaddr = rslist(8)
		imsiaddr2 = rslist(9)
		imsicompanynum1 = rslist(10)
		imsicompanynum2 = rslist(11)
		imsicompanynum3 = rslist(12)
		imsiuptae = rslist(13)
		imsiupjong = rslist(14)
		imsitel1 = rslist(15)
		imsitel2 = rslist(16)
		imsitel3 = rslist(17)
		imsifax1 = rslist(18)
		imsifax2 = rslist(19)
		imsifax3 = rslist(20)
		imsihp1 = rslist(21)
		imsihp2 = rslist(22)
		imsihp3 = rslist(23)
		imsidcarno = rslist(24)
		imsistartday = rslist(25)
		imsibidxsub = rslist(26)
		imsitcode = rslist(27)
		imsivatflag = rslist(28)
		imsitaxtitle = rslist(29)
		imsijuminno1 = rslist(30)
		imsijuminno2 = rslist(31)
		imsihomepage = rslist(32)
		imsiusegubun = rslist(33)
		imsiusemoney = rslist(34)
		imsiorderreg = rslist(35)
		imsisoundfile = rslist(36)
		imsihclose = rslist(37)
		imsidcode = rslist(38)
		imsifileflag = rslist(39)
		imsitelecom = rslist(40)
		imsihapday = rslist(41)
		imsijumin1 = rslist(42)
		imsijumin2 = rslist(43)
		imsijumincheck = rslist(44)
		imsitelname = rslist(45)
		imsiconetion = rslist(46)
		imsictel1 = rslist(47)
		imsictel2 = rslist(48)
		imsictel3 = rslist(49)
		orderflag = rslist(50)
		imsifileregcode = rslist(51)
		imsimregflag = rslist(52)
		imsibrandflag = rslist(53)
		imsibrandbox  = rslist(54)
		imsibrandboxarry = split(imsibrandbox,",")
		imsibrandboxarry_int = ubound(imsibrandboxarry)
		imsicbrandchoice = rslist(55)
		imsifileflaglevel = rslist(56)
		imsid_requestday = rslist(57)
		imsiorder_weekgubun = rslist(58)
		imsiorder_weekchoice = rslist(59)
		imsiorder_checkStime = rslist(60)
		imsiorder_checkEtime = rslist(61)
		imsimaechulflag = rslist(62)
		imsimyflag = rslist(63)
		imsimi_money = rslist(64)
		imsiye_money = rslist(65)
		imsiagencycheck2 = rslist(66)
		imsich_gongi = rslist(67)
		imsiserviceflag = rslist(68)
		imsidcenterflag = rslist(69)
		imsidjflag      = rslist(70)
		imsismsflag     = rslist(71)
		imsichk_gongi1  = rslist(72)
		imsichk_gongi2  = rslist(73)
		imsimyflag_select = rslist(74)
		imsiproflag1 = rslist(75)
		imsiproflag2 = rslist(76)
		imsimiorderflag = rslist(77)
		imsivirtual_acnt = rslist(78)
		imsinoteflag = rslist(79)
		imsiaccountflag = rslist(80)
		imsimisuprint = rslist(81)
		imsidatadel = rslist(82)

		imsimisubtn  = rslist(83)
		imsicyberNum = rslist(84)
		imsirec_fax  = rslist(85)
		imsicporg_cd = rslist(86)
		imsivirtual_acnt_bank = rslist(87)
		imsifileflagchb = rslist(88)

		imsivirtual_acnt2 = rslist(89)
		imsivirtual_acnt2_bank = rslist(90)
		imsiipConFlag = rslist(91)
		choiceDcenter = rslist(92)
		imsijsusu = rslist(93)
		imsiemail = rslist(94)
		imsismsflagType = rslist(95)
		imsiproflag2Pgubun = rslist(96)
		imsikbnumAreg = rslist(97)
		imsiconSeeflag = rslist(98)
		imsiadminProgram = rslist(99)
		imsimyflagauth = rslist(100)
		imsisms_send = rslist(101)
		imsiyesin_memo = rslist(102)
		imsiproductorderweek = rslist(103)
		imsisearchordertime = rslist(104)
		imsiusesetmenu = rslist(105)
		imsiUseDistributionTotal = rslist(106)

        imsivirtual_acnt3 = rslist(107)
		imsivirtual_acnt3_bank = rslist(108)
        imsivirtual_name3 = rslist(109)

        imsivirtual_acnt4 = rslist(110)
		imsivirtual_acnt4_bank = rslist(111)

        imsivirtual_acnt5 = rslist(112)
		imsivirtual_acnt5_bank = rslist(113)

        imsivirtual_acnt6 = rslist(114)
		imsivirtual_acnt6_bank = rslist(115)

        imsipremisuprint = rslist(116)
        imsipreye_money = rslist(117)
        imsiUseReturn  = rslist(118)
        imsiUseTax  = rslist(119)
        imsiMinOrderCheck = rslist(120)
        imsiMinOrderAmt = rslist(121)
		rslist.close

    
	end if

	if flag="1" then
		imsisessiontxt = idx
	else
		imsisessiontxt = left(session("Ausercode"),5)
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select brandflag,myflag,fileflag,fileflagchb,cyberNum,premisuprint "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = '"& imsisessiontxt &"'"
	rs.Open sql, db, 1
	if not rs.eof then
		imsibrandflag = rs(0)
		imsimyflag = rs(1)
		fileflag   = rs(2)
		fileflagchb= rs(3)
		bonsacyberNum = rs(4)
        imsipremisuprint = rs(5)
	else
		imsibrandflag = ""
		imsimyflag = "n"
		fileflag   = ""
         imsipremisuprint = "n"
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select bidx,bname "
	SQL = sql & " from tb_company_brand "
	SQL = sql & " where idx = '"& imsisessiontxt &"' order by bname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		imsibrandboxarry = rs.GetRows
		imsibrandboxarry_int = ubound(imsibrandboxarry,2)
	else
		imsibrandboxarry = ""
		imsibrandboxarry_int = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " order by dcarno asc"
	rs.Open sql, db, 1

	if imsiidxsub="" then
		imsiidxsub="0"
	end if

	if imsibidxsub="" then
		imsibidxsub="0"
	end if

	if imsistartday = "" then
		imsistartday = replace(left(now(),10),"-","/")
	else
		imsistartday = left(imsistartday,4)&"/"&mid(imsistartday,5,2)&"/"&right(imsistartday,2)
	end If
	
	If imsiusesetmenu = "" Then 
		imsiusesetmenu = "n"
	End If 

    If imsiUseReturn = "" Then 
		imsiUseReturn = "n"
	End If 

      If imsiUseTax = "" Then 
		imsiUseTax = "n"
	End If 

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select dcode,dname "
	SQL = sql & " from tb_dealer "
	SQL = sql & " order by dname asc"
	rs2.Open sql, db, 1
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>
					<%if flag="1" then%>
						<!--#include virtual="/adminpage/code/inc/writeinc1.asp"-->
					<%elseif flag="2" then%>
						<!--#include virtual="/adminpage/code/inc/writeinc2.asp"-->
					<%elseif flag="3" then%>
						<!--#include virtual="/adminpage/code/inc/writeinc3.asp"-->
					<%end if%>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR><BR>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->