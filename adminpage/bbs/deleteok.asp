<!--#include virtual="/db/Noticedb.asp"-->

<%
	Function FunFileDelete(defaultFilepath,deletefilename)	'파일삭제
		Set fc = server.createobject("scripting.filesystemobject")
		If fc.fileexists(defaultFilepath & deletefilename) Then
			DelFile = defaultFilepath & deletefilename
			fc.deletefile(DelFile)
		End if
		Set fc = Nothing
	End Function

	pwd = replace(request("pwd"),"'","''")
	gotopage = request("gotopage")
	uid = request("uid")
	idx = request("idx")

  	tablename = " tb_rhdwltkgkf "

	searcha = request("searcha")
	searchb = request("searchb")

	imsimappath = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\pds\"

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT b_file1,b_file2 FROM "& tablename &" where idx = "& idx
	rs.Open sql, noticedb, 1
	if not rs.eof then
		imsifile1 = rs(0)
		imsifile2 = rs(1)
	end if
	rs.close

	if imsifile1<>"" then
		call FunFileDelete(imsimappath,imsifile1)
	end if
	if imsifile2<>"" then
		call FunFileDelete(imsimappath,imsifile2)
	end if

   	SQL = "delete "& tablename &" where idx = "&idx&" and pwd = '"& pwd &"' "
	noticedb.Execute SQL
	noticedb.close

	response.redirect "list.asp?gotopage="&gotopage&"&uid="&uid&"&searcha="&searcha&"&searchb="&searchb
%>