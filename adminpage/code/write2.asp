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
		SQL = sql & " telecom,hapday,jumin1,jumin2,jumincheck,telname,conetion "
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
		rslist.close
	end if

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
	end if

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
						<!--#include virtual="/adminpage/code/inc/writeinc33.asp"-->
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