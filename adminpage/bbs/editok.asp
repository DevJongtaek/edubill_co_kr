<!--#include virtual="/adminpage/bbs/fileup.asp"-->
<!--#include virtual="/db/noticedb.asp"-->

<%
	uid=upload("uid")
	username=replace(upload("name"),"'","''")
	email=replace(upload("email"),"'","''")
    pwd=replace(upload("email"),"'","''")
	if uid="agencyboard" then
		pwd=upload("pwd")
	else
	pwd="farm"
	end if

	title=replace(upload("title"),"'","''")
	content=replace(upload("content"),"'","''")
	hflag=upload("hflag")
	if hflag="" then
		hflag = "0"
	end if
	gotopage=upload("gotopage")

	idx=upload("idx")

	tablename = " tb_rhdwltkgkf "

	searcha = upload("searcha")
	searchb = upload("searchb")

	sql="select pwd from "& tablename &" where idx = "& idx
	set rs = server.CreateObject("ADODB.Recordset")
	rs.Open sql, noticedb
	imsicount = rs(0)
	rs.close

	if imsicount = pwd then

	   	SQL = "Update "& tablename &" set name = '"& username &"' ,email = '"& email &"' ,title = '" & title & "'"
		SQL = SQL & ", content = '" & content & "', hflag = '"& hflag &"' "

		if filename1 <> "" then 
			SQL = SQL & ", b_file1 = '" & filename1 & "'"
			SQL = SQL & ", b_file1_width = '" & file_width1 & "'"
		end if

		if filename2 <> "" then 
			SQL = SQL & ", b_file2 = '" & filename2 & "'"
			SQL = SQL & ", b_file2_width = '" & file_width2 & "'"
		end if

	   	SQL = SQL & " where idx = "&idx
		noticedb.Execute SQL

		noticedb.close
		set rs=nothing
		set noticedb=nothing

		 response.redirect "list_root.asp?gotopage="&gotopage&"&uid="&uid&"&searcha="&searcha&"&searchb="&searchb

	else
%>

		<script language="javascript">
			alert("비밀번호가 틀립니다.\n다시 입력하여 주시기 바랍니다.")
			history.go(-1);
		</script>

<%
	end if
%>