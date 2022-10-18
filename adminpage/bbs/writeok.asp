<!--#include virtual="/adminpage/bbs/fileup.asp"-->
<!--#include virtual="/db/noticedb.asp"-->

<%
	username=replace(upload("name"),"'","''")
	email=replace(upload("email"),"'","''")
    uid=replace(upload("uid"),"'","''")
    '  response.Write uid
	if uid="agencyboard" then
		pwd=upload("pwd")
	else
		pwd="farm"
	end if
 ' response.Write pwd
	userid=session("userid")
	title=replace(upload("title"),"'","''")
	content=replace(upload("content"),"'","''")
	hflag=upload("hflag")
	if hflag="" then
		hflag = "0"
	end if

	gotopage=upload("gotopage")
	uid=upload("uid")

	tablename = "tb_pds"

	searcha = upload("searcha")
	searchb = upload("searchb")

	sql="select max(idx) from tb_rhdwltkgkf "
	set rs = server.CreateObject("ADODB.Recordset")
	rs.Open sql, noticedb
	if isnull(rs(0)) then
		number=1
	else
		number=rs(0)+1
	end if
	rs.close


	if upload("idx") <> "" then

		ref = Cint(upload("ref"))
		re_step = Cint(upload("re_step"))
		re_level = Cint(upload("re_level"))

		if re_level = 0 then
			sqlRe1 = " select max(re_step) from tb_rhdwltkgkf where ref = " & ref
			set rsRe = noticedb.Execute(sqlRe1)
			re_step = rsRe(0) + 1
			rsRe.close
			set rsRe = nothing
			re_level = 1
		else
			sqlRe2 = " select count(idx) from tb_rhdwltkgkf where ref = " & ref & " and re_step >= " & re_step & " and re_level = 1 + " & re_level
			set rsRe = noticedb.Execute(sqlRe2)
			tmp = Cint(rsRe(0))
			if tmp = 0 then
				rsRe.close
				set rsRe = nothing
				re_step = re_step
			else
				rsRe.close
				set rsRe = nothing
				sqlRe3 = " update tb_rhdwltkgkf set re_step = re_step + 1 where ref = " & ref & " and re_step >= " & re_step + tmp
				noticedb.Execute(sqlRe3)
				re_step = re_step + tmp
			end if
			re_level = re_level + 1
		end if

	else
		ref = number
		re_step = 0
		re_level = 0
	end if

if uid="agencyboard" then
	imsiimsiimsi = left(session("AAusercode"),5)
else
	imsiimsiimsi = ""
end if

	SQL = "INSERT INTO tb_rhdwltkgkf (name,email,pwd,title,ref,re_level,re_step,b_file1,b_file1_width,b_file2,b_file2_width,content,readnum,uid,hflag,nows,userid,areaddate,bkind) VALUES "
 	SQL = SQL & "('" & username & "'"
 	SQL = SQL & ",'" & email & "'"
 	SQL = SQL & ",'" & pwd & "'"
 	SQL = SQL & ",'" & title & "'"
 	sql = sql & ","& ref
 	sql = sql & ","& re_level
 	sql = sql & ","& re_step
 	sql = sql & ",'"& filename1 &"' "
 	sql = sql & ",'"& file_width1 &"' "
 	sql = sql & ",'"& filename2 &"' "
 	sql = sql & ",'"& file_width2 &"' "
 	SQL = SQL & ",'" & content & "'"
 	SQL = SQL & ", 0 "
 	SQL = SQL & ",'" & uid & "'"
 	SQL = SQL & ",'" & hflag & "'"
 	sql = sql & ",'" & now() & "'"
 	sql = sql & ",'" & userid & "'"
 	sql = sql & ",'"& now() &"'"
 	sql = sql & ",'"& imsiimsiimsi &"')"

   ' response.Write sql
 	noticedb.Execute SQL

	noticedb.close
	set rs=nothing
	set noticedb=nothing
    if uid="agencyboard" then
    response.redirect "list_root.asp?gotopage="&gotopage&"&uid="&uid&"&searcha="&searcha&"&searchb="&searchb
    else
	response.redirect "list.asp?gotopage="&gotopage&"&uid="&uid&"&searcha="&searcha&"&searchb="&searchb
    end if
%>