<!--#include virtual="/adminpage/bbs/top.asp" -->
<!--#include virtual="/db/Noticedb.asp" -->

<%
	searcha = request("searcha")
	searchb = replace(request("searchb"),"'","")

	if searcha = "" then
		searcha = ""
	else
		imsisearcha_1 = InStrRev(searcha, "1")
		if imsisearcha_1 > 0 then
			imsisearcha_1 = "1"
		else
			imsisearcha_1 = "0"
		end if

		imsisearcha_2 = InStrRev(searcha, "2")
		if imsisearcha_2 > 0 then
			imsisearcha_2 = "2"
		else
			imsisearcha_2 = "0"
		end if

		imsisearcha_3 = InStrRev(searcha, "3")
		if imsisearcha_3 > 0 then
			imsisearcha_3 = "3"
		else
			imsisearcha_3 = "0"
		end if

		imsisearcha_tot = imsisearcha_1&imsisearcha_2&imsisearcha_3
		if (imsisearcha_tot = "123" and searchb <> "") then
			imsisqlgubun = 1
		elseif (imsisearcha_tot = "120" and searchb <> "") then
			imsisqlgubun = 2
		elseif (imsisearcha_tot = "103" and searchb <> "") then
			imsisqlgubun = 3
		elseif (imsisearcha_tot = "023" and searchb <> "") then
			imsisqlgubun = 4
		elseif (imsisearcha_tot = "100" and searchb <> "") then
			imsisqlgubun = 5
		elseif (imsisearcha_tot = "020" and searchb <> "") then
			imsisqlgubun = 6
		elseif (imsisearcha_tot = "003" and searchb <> "") then
			imsisqlgubun = 7
		end if

	end if


	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	uid = request("uid")
	If uid = "" Then 
		uid = "notice"
	End If 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT * FROM tb_rhdwltkgkf where uid = '"& uid &"' "
   
	'select case imsisqlgubun
	'	case 1
	'		SQL = SQL & " and ((name like '%"& searchb &"%') or (title like '%"& searchb &"%') or (content like '%"& searchb &"%')) "
	'	case 2
	'		SQL = SQL & " and ((name like '%"& searchb &"%') or (title like '%"& searchb &"%')) "
	'	case 3
	'		SQL = SQL & " and ((name like '%"& searchb &"%') or (content like '%"& searchb &"%')) "
	'	case 4
	'		SQL = SQL & " and ((title like '%"& searchb &"%') or (content like '%"& searchb &"%')) "
	'	case 5
	'		SQL = SQL & " and name like '%"& searchb &"%' "
	'	case 6
	'		SQL = SQL & " and title like '%"& searchb &"%' "
	'	case 7
	'		SQL = SQL & " and content like '%"& searchb &"%' "
	'end select

	if uid="agencyboard" then
		SQL = SQL & " and bkind = '"& left(session("AAusercode"),5) &"' "
	end if

	SQL = SQL & " ORDER BY ref desc, re_step asc, re_level asc"
	rs.PageSize=20
	rs.Open sql, noticedb, 1

	tot_n = rs.recordcount
	if not rs.EOF then
		rs.AbsolutePage=int(gotopage)
	end if	
%>
	<!--#include virtual="/adminpage/bbs/list_inc_root.asp" -->

<!--#include virtual="/adminpage/bbs/bottom.asp" -->
