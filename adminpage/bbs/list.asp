<!--#include virtual="/adminpage/bbs/top.asp" -->
<!--#include virtual="/db/Noticedb.asp" -->

<%
	searcha = request("searcha")
	searchb = replace(request("searchb"),"'","")

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	uid = request("uid")

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
	If uid = "news" Then 
%>
	<!--#include virtual="/adminpage/bbs/list_inc_news.asp" -->
	<%Else %>
	<!--#include virtual="/adminpage/bbs/list_inc.asp" -->
	<%End If %>

<!--#include virtual="/adminpage/bbs/bottom.asp" -->
