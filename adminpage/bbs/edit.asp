<!--#include virtual="/adminpage/bbs/top.asp" -->
<!--#include virtual="/db/noticedb.asp" -->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	GotoPage = Request("GotoPage")
	uid = request("uid")
	idx = request("idx")

	sql = "select title,content,name,email,pwd,hflag from tb_rhdwltkgkf where idx="&request("idx")
	set rs=noticedb.execute(sql)
%>

<!--#include virtual="/adminpage/bbs/edit_inc.asp" -->
<!--#include virtual="/adminpage/bbs/bottom.asp" -->
