<!--#include virtual="/adminpage/bbs/top.asp" -->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	GotoPage = Request("GotoPage")
	uid = request("uid")
	idx = request("idx")

	if idx <> "" then
%>
		<!--#include virtual="/db/noticedb.asp" -->
<%
		sql = "select title,content,name from "& tablename &" where idx="&request("idx")
		set rs=db.execute(sql)
		title = "[Re]"&rs(0)
		content = chr(13)&chr(13)&chr(13)&"====================="&rs(2)&"´ÔÀÇ ±Û===================="&chr(13)&rs(1)&chr(13)&chr(13)
		rs.close
		db.close
	end if
%>

<!--#include virtual="/adminpage/bbs/write_inc.asp" -->
<!--#include virtual="/adminpage/bbs/bottom.asp" -->
