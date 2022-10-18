<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	imsifileflag = request("imsifileflag")
	cbrandchoice = request("cbrandchoice")
	searchc = request("searchc")
	searchd = request("searchd")

	if imsifileflag="7" then
		minmaxsql = "select max(C.pidx), min(C.pidx), max(C.idx), min(C.idx), count(DISTINCT C.idx)"
		minmaxsql = minmaxsql & " FROM tb_company A, tb_order B, tb_order_product C, tb_product D"
		minmaxsql = minmaxsql & " WHERE A.idx = right(B.usercode, 5)"
		minmaxsql = minmaxsql & " AND B.idx = C.idx"
		minmaxsql = minmaxsql & " AND c.pcode = d.pcode"

		if cbrandchoice<>"" then
			minmaxsql = minmaxsql & " AND a.cbrandchoice='"& cbrandchoice &"' "
			minmaxsql = minmaxsql & " AND (d.cbrandchoice='00000' "
			minmaxsql = minmaxsql & " or d.cbrandchoice like '%"& cbrandchoice &"%' )"
		end if

		minmaxsql = minmaxsql & " AND b.flag = 'y'"
		minmaxsql = minmaxsql & " AND b.deflag = 'n'"
		minmaxsql = minmaxsql & " AND C.flag = 'F'"
		minmaxsql = minmaxsql & " and A.bidxsub = '" & left(session("Ausercode"),5) & "'"

	'response.write minmaxsql
	'response.end
		Set mmrs = db.execute(minmaxsql)
	elseif imsifileflag="3" then
		minmaxsql = "select max(C.pidx), min(C.pidx), max(C.idx), min(C.idx), count(DISTINCT C.idx)"
		minmaxsql = minmaxsql & " FROM tb_company A, tb_order B, tb_order_product C"
		minmaxsql = minmaxsql & " WHERE A.idx = right(B.usercode, 5)"
		minmaxsql = minmaxsql & " AND B.idx = C.idx"
		minmaxsql = minmaxsql & " AND C.flag = 'F'"
		minmaxsql = minmaxsql & " AND b.flag = 'y'"
		minmaxsql = minmaxsql & " AND b.deflag = 'n'"
		minmaxsql = minmaxsql & " and A.bidxsub = '" & left(session("Ausercode"),5) & "'"
		Set mmrs = db.execute(minmaxsql)
	else
		minmaxsql = "select max(C.pidx), min(C.pidx), max(C.idx), min(C.idx), count(DISTINCT C.idx)"
		minmaxsql = minmaxsql & " FROM tb_company A, tb_order B, tb_order_product C"
		minmaxsql = minmaxsql & " WHERE A.idx = right(B.usercode, 5)"
		minmaxsql = minmaxsql & " AND B.idx = C.idx"
		minmaxsql = minmaxsql & " AND C.flag = 'F'"
		minmaxsql = minmaxsql & " and A.bidxsub = '" & left(session("Ausercode"),5) & "'"

		if session("Ausergubun")="3" then
			minmaxsql = minmaxsql & " AND substring(b.usercode,1,10) = '" & session("Ausercode") & "'" 
		end if

		Set mmrs = db.execute(minmaxsql)
	end if

	if isnull(Trim(mmrs(2))) then
		response.write "<SCRIPT language=javascript>"
		response.write "alert('해당하는 자료가 없습니다');"
		response.write "history.go(-1);"
		response.write "</SCRIPT>"
	else
		min = Trim(mmrs(1))
		max = Trim(mmrs(0))
		yyyymmdd = LEFT(Trim(mmrs(2)), 14)
		yyyymmdd1 = LEFT(Trim(mmrs(3)), 14)
		count_num = Trim(mmrs(4))
		mmrs.close

		if imsifileflag="7" then
			if cbrandchoice="" then
				yyyymmdd_file = "전체-" & yyyymmdd
			else
				sql = "select bname"
				sql = sql & " FROM tb_company_brand where bidx = "&cbrandchoice
				Set rs = db.execute(sql)
				if not rs.eof then
					yyyymmdd_file = left(rs(0),2)&"-"& yyyymmdd
				end if
				rs.close
			end if
		else
			yyyymmdd_file = yyyymmdd
		end if


if imsifileflag="3" then

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd_file & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd_file & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT max(substring(c.idx,1,8)) as idx, C.pcode, sum(C.rordernum) as rordernum,b.usercode,max(c.idx) as imsidx ,c.pidx"
	'SQL = "SELECT max(substring(c.idx,1,8)) as idx, C.pcode, sum(C.rordernum) as rordernum,b.usercode"
	SQL = sql & " FROM tb_order B, tb_order_product C"
	SQL = sql & " WHERE B.idx = C.idx AND C.flag = 'F' "
	SQL = sql & " AND b.flag = 'y' "
	SQL = sql & " AND b.deflag = 'n' "
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND substring(b.usercode,1,5) = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " group by C.pcode,substring(c.idx,1,8),b.usercode,c.pidx" 
	'SQL = sql & " group by C.pcode,substring(c.idx,1,8),b.usercode" 
	SQL = sql & " order by b.usercode asc, c.pcode asc"
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

		USql = "Update tb_order_product Set flag = 'T', flagidx = '"& yyyymmdd_file &"' "
		USql = Usql & " where pidx = "& rs("pidx")
		'USql = Usql & " where pidx between " & min & " and " & max
		db.execute(USql)

	rs.MoveNext
	Loop
	objFile.close

elseif imsifileflag="7" then

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd_file & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd_file & ".txt",8)

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag"
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C, tb_product d"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"
	SQL = sql & " AND B.idx = C.idx"
	SQL = sql & " AND c.pcode = d.pcode"

	if cbrandchoice<>"" then
		sql = sql & " AND a.cbrandchoice='"& cbrandchoice &"' "
		sql = sql & " AND (d.cbrandchoice='00000' "
		sql = sql & " or d.cbrandchoice like '%"& cbrandchoice &"%') "
	end if

	SQL = sql & " AND B.flag = 'y'"
	SQL = sql & " AND B.deflag = 'n'"
	SQL = sql & " AND C.flag = 'F'"
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " group by A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag"
	SQL = sql & " order by C.pidx"
	rs.Open sql, db, 1

	'imsiorderreg = rs(0)

	Do Until rs.EOF

		str = ""
		onlen = len(Trim(rs("rordernum")))
		onlen1 = 5-onlen
		for i = 1 to onlen1
			str = str & " "
		next
		ordernum = Trim(rs("rordernum")) & str

		objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum)

		USql = "Update tb_order_product Set flag = 'T'"
		USql = Usql & " where pidx = '" & Trim(rs("pidx")) & "'"

		db.execute(USql)
	
	rs.MoveNext
	Loop
	objFile.close

elseif imsifileflag="2" then

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd_file & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd_file & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT max(substring(c.idx,1,8)) as idx, C.pcode, sum(C.rordernum) as rordernum,b.usercode,max(c.idx) as imsidx ,c.pidx"
	SQL = sql & " FROM tb_order B, tb_order_product C"
	SQL = sql & " WHERE B.idx = C.idx AND C.flag = 'F' "
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND substring(b.usercode,1,5) = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " group by C.pcode,substring(c.idx,1,8),b.usercode,c.pidx" 
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

		USql = "Update tb_order_product Set flag = 'T'"
		USql = Usql & " where pidx = "& rs("pidx")
		db.execute(USql)

	rs.MoveNext
	Loop
	objFile.close

elseif imsifileflag="9" then

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd_file & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd_file & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT substring(c.idx,1,8) as idx, C.pcode, C.rordernum as rordernum,b.usercode,c.idx as imsidx ,c.pidx, isnull(b.request_day,'') as request_day"
	SQL = sql & " FROM tb_order B, tb_order_product C"
	SQL = sql & " WHERE B.idx = C.idx AND C.flag = 'F' "
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND substring(b.usercode,1,5) = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " order by b.usercode asc, c.pcode asc"
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

		str = ""
		if rs("request_day")<>"" then
			onlen = len(Trim(rs("request_day")))
			onlen1 = 4-onlen
			for i = 1 to onlen1
				str = str & "0"
			next
			request_day = Trim(rs("request_day")) & str
		else
			request_day = "0000"
		end if
		objFile.writeLine(LEFT(Trim(rs("idx")),8) & imsitab & fileregcode & imsitab & fileregcode2 & imsitab & trim(rs("rordernum")) & imsitab & "ZU01" & imsitab & request_day)

		USql = "Update tb_order_product Set flag = 'T'"
		USql = Usql & " where pidx = "& rs("pidx")
		db.execute(USql)

	rs.MoveNext
	Loop
	objFile.close

else

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd_file & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd_file & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag, isnull(b.request_day,'') as request_day "
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"
	SQL = sql & " AND B.idx = C.idx"
	SQL = sql & " AND C.flag = 'F'"
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 
	if session("Ausergubun")="3" then
		SQL = sql & " AND substring(b.usercode,1,10) = '" & session("Ausercode") & "'" 
	end if
	SQL = sql & " order by C.pidx"
'response.write sql
'response.end
	rs.Open sql, db, 1

	'imsiorderreg = rs(0)

	Do Until rs.EOF

		str = ""
		onlen = len(Trim(rs("rordernum")))
		onlen1 = 5-onlen
		for i = 1 to onlen1
			str = str & " "
		next
		ordernum = Trim(rs("rordernum")) & str

		if imsifileflag="8" then
			str = ""
			if rs("request_day")<>"" then
				onlen = len(Trim(rs("request_day")))
				onlen1 = 4-onlen
				for i = 1 to onlen1
					str = str & " "
				next
				request_day = Trim(rs("request_day")) & str
			else
				request_day = "    "
			end if
			objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum & request_day)
		else
			objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum)
		end if

		USql = "Update tb_order_product Set flag = 'T'"
		USql = Usql & " where pidx = '" & Trim(rs("pidx")) & "'"

		db.execute(USql)
	
	rs.MoveNext
	Loop
	objFile.close

end if


	Sql = "Insert into tb_download ("
	Sql = Sql & " bidxsub"
	Sql = Sql & ",start_date"
	Sql = Sql & ",start_time"
	Sql = Sql & ",end_date"
	Sql = Sql & ",end_time"
	Sql = Sql & ",start_idx"
	Sql = Sql & ",end_idx"
	Sql = Sql & ",count_num"
	Sql = Sql & ",usercode"
	Sql = Sql & ",filename"
	Sql = Sql & ") Values ("
	Sql = Sql & "'" & left(session("Ausercode"),5) & "',"
	Sql = Sql & "'" & left(yyyymmdd1, 8) & "',"
	Sql = Sql & "'" & right(yyyymmdd1, 6) & "',"
	Sql = Sql & "'" & left(yyyymmdd, 8) & "',"
	Sql = Sql & "'" & right(yyyymmdd, 6) & "',"
	Sql = Sql & "'" & min & "',"
	Sql = Sql & "'" & max & "',"
	Sql = Sql & "'" & count_num & "',"
	Sql = Sql & "'" & session("Ausercode") & "',"
	Sql = Sql & "'" & yyyymmdd_file & ".txt')"

	'RESPONSE.WRITE Sql

	db.execute(Sql)

	db.close
	set db=nothing

    	file = yyyymmdd_file & ".txt"  '//파일 이름

    	Response.ContentType = "application/unknown"
    	Response.AddHeader "Content-Disposition","attachment; filename=" & file

    	Set objStream = Server.CreateObject("ADODB.Stream")
    	objStream.Open
    	objStream.Type = 1
    	objStream.LoadFromFile "D:/Webhosting/2004VIVA/edubill_co_kr/fileupdown/" & file        '//경로 입니다.

    	download = objStream.Read
    	Response.BinaryWrite download
    	Set objstream = nothing

	end if
%>