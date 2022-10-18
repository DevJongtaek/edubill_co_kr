<!--#include virtual="/adminpage/bbs/top.asp" -->
<!--#include virtual="/db/Noticedb.asp" -->

<%
	searcha = Replace(request("searcha"), "'", "")
	searchb = Replace(request("searchb"), "'", "")
	GotoPage = Replace(Request("GotoPage"), "'", "")
	uid = Replace(request("uid"), "'", "")
	idx = Replace(request("idx"), "'", "")

  	tablename = " tb_rhdwltkgkf "

	updatesql="update "& tablename &" set readnum=readnum+1 , areaddate = '"& now() &"' where idx="&idx
	noticedb.Execute(updatesql)

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT * FROM "& tablename &" where idx = "& idx
	rs.Open sql, noticedb, 1

	ref=rs("ref")
	re_step=rs("re_step")
	re_level=rs("re_level")

	imsinows = rs("nows")
	imsireadnum = rs("readnum")
	tottitlef = "("&imsinows&", Hit "&imsireadnum&")"
	tottitlef2 = imsinows&", Hit "&imsireadnum
	imsititle = rs("title")
	imsiname = rs("name")
	imsihflag = rs("hflag")
	imsicontent = rs("content")
	if imsihflag="0" then
		imsicontent = Replace(imsicontent,chr(13),"<br>")
	end if
	imsib_file1 = rs("b_file1")
	imsib_file1_width = rs("b_file1_width")
	imsib_file2 = rs("b_file2")
	imsib_file2_width = rs("b_file2_width")
	userid = rs("userid")

	rs.close
%>

<!--#include virtual="/adminpage/bbs/content_inc.asp" -->



<!--#include virtual="/adminpage/bbs/bottom.asp" -->
