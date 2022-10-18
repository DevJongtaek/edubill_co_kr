<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	idx = Trim(Request.QueryString("idx"))

	sql = "select idx, start_idx, end_idx, filename, start_date, start_time, end_date, end_time"
	sql = sql & " FROM tb_download"
	sql = sql & " WHERE idx = " & idx
	Set mrs = db.execute(sql)

	min = Trim(mrs("start_idx"))
	max = Trim(mrs("end_idx"))
	yyyymmdd = left(Trim(mrs("filename")), 14)
	yyyymmdd_file = mrs("filename")

	start_date = mrs(4)
	start_time = mrs(5)
	end_date = mrs(6)
	end_time = mrs(7)

	start_date = trim(start_date)&trim(start_time)
	end_date = trim(end_date)&trim(end_time)

	mrs.close
	imsifileflag = request("imsifileflag")

if imsifileflag<>"7" then

if imsifileflag="3" then

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT max(substring(c.idx,1,8)) as idx, C.pcode, sum(C.rordernum) as rordernum,b.usercode"
	SQL = sql & " FROM tb_order B, tb_order_product C"
	SQL = sql & " WHERE B.idx = C.idx AND C.flag = 'T' "
	SQL = sql & " AND b.flag = 'y' "
	'SQL = sql & " AND b.deflag = 'n' "
	SQL = sql & " AND c.flagidx = '"& yyyymmdd &"' "
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND substring(b.usercode,1,5) = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " group by C.pcode,substring(c.idx,1,8),b.usercode" 
	SQL = sql & " order by b.usercode asc, c.pcode asc"
'response.write sql
'response.end
	rs.Open sql, db, 1

	imsitab = chr(9)

	Do Until rs.EOF

		fileregcode = ""
		fileregcode2 = ""

		set rs2 = server.CreateObject("ADODB.Recordset")
		SQL = "SELECT fileregcode from tb_company where bidxsub = '"& left(rs("usercode"),5) &"' and idx = '"& right(rs("usercode"),5) &"' "
		rs2.Open sql, db, 1
		if not rs2.eof then
			fileregcode = rs2("fileregcode")
		end if
		rs2.close

		set rs2 = server.CreateObject("ADODB.Recordset")
		SQL = "SELECT fileregcode from tb_product where usercode = '"& left(session("Ausercode"),5) &"' and pcode = '"& rs("pcode") &"' "
		rs2.Open sql, db, 1
		if not rs2.eof then
			fileregcode2 = rs2("fileregcode")
		end if
		rs2.close

		imsipday = LEFT(Trim(rs("idx")),8)
		imsipday = LEFT(imsipday,4)&"-"&mid(imsipday,5,2)&"-"&right(imsipday,2)
		imsipday = cdate(imsipday)+1
		imsipday2 = Weekday(imsipday)
		'1:일요일 ~ 7:토요일
		if imsipday2="1" then
			imsipday = cdate(imsipday)+1
		end if
		imsipday = replace(imsipday,"-","")

		objFile.writeLine(imsipday & imsitab & fileregcode & imsitab & fileregcode2 & imsitab & trim(rs("rordernum")) & imsitab &"ZU01")

	rs.MoveNext
	Loop
	objFile.close

elseif imsifileflag="2" then

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT max(substring(c.idx,1,8)) as idx, C.pcode, sum(C.rordernum) as rordernum,b.usercode"
	SQL = sql & " FROM tb_order B, tb_order_product C"
	SQL = sql & " WHERE B.idx = C.idx AND C.flag = 'T' "
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND substring(b.usercode,1,5) = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " group by C.pcode,substring(c.idx,1,8),b.usercode" 
	SQL = sql & " order by b.usercode asc, c.pcode asc"
'response.write sql
'response.end
	rs.Open sql, db, 1

	imsitab = chr(9)

	Do Until rs.EOF

		fileregcode = ""
		fileregcode2 = ""

		set rs2 = server.CreateObject("ADODB.Recordset")
		SQL = "SELECT fileregcode from tb_company where bidxsub = '"& left(rs("usercode"),5) &"' and idx = '"& right(rs("usercode"),5) &"' "
		rs2.Open sql, db, 1
		if not rs2.eof then
			fileregcode = rs2("fileregcode")
		end if
		rs2.close

		set rs2 = server.CreateObject("ADODB.Recordset")
		SQL = "SELECT fileregcode from tb_product where usercode = '"& left(session("Ausercode"),5) &"' and pcode = '"& rs("pcode") &"' "
		rs2.Open sql, db, 1
		if not rs2.eof then
			fileregcode2 = rs2("fileregcode")
		end if
		rs2.close

		objFile.writeLine(LEFT(Trim(rs("idx")),8) & imsitab & fileregcode & imsitab & fileregcode2 & imsitab & trim(rs("rordernum")) & imsitab &"ZU01")

	rs.MoveNext
	Loop
	objFile.close

elseif imsifileflag="7" then

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag"
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"
	SQL = sql & " AND B.idx = C.idx"
	SQL = sql & " AND B.flag = 'y'"
	SQL = sql & " AND C.flag = 'T'"
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " order by C.pidx"

	rs.Open sql, db, 1
	'imsiorderreg = rs(0)

	'response.write SQL

	Do Until rs.EOF

		str = ""
		onlen = len(Trim(rs("rordernum")))
		onlen1 = 5-onlen
		for i = 1 to onlen1
			str = str & " "
		next
		ordernum = Trim(rs("rordernum")) & str
	
		objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum)

	rs.MoveNext
	Loop
	objFile.close

else

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag"
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"
	SQL = sql & " AND B.idx = C.idx"
	SQL = sql & " AND C.flag = 'T'"
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " order by C.pidx"

	rs.Open sql, db, 1
	'imsiorderreg = rs(0)

	'response.write SQL

	Do Until rs.EOF

		str = ""
		onlen = len(Trim(rs("rordernum")))
		onlen1 = 5-onlen
		for i = 1 to onlen1
			str = str & " "
		next
		ordernum = Trim(rs("rordernum")) & str
	
		objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum)

	rs.MoveNext
	Loop
	objFile.close

end if




	db.close
	set db=nothing


end if

	if imsifileflag="7" then
	    	file = yyyymmdd_file
	else
	    	file = yyyymmdd & ".txt"  '//파일 이름
	end if

    	Response.ContentType = "application/unknown"
    	Response.AddHeader "Content-Disposition","attachment; filename=" & file

    	Set objStream = Server.CreateObject("ADODB.Stream")
    	objStream.Open
    	objStream.Type = 1
    	objStream.LoadFromFile "D:/Webhosting/2004VIVA/edubill_co_kr/fileupdown/" & file        '//경로 입니다.

    	download = objStream.Read
    	Response.BinaryWrite download
    	Set objstream = nothing
%>