<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	minmaxsql = "select max(C.pidx), min(C.pidx), max(C.idx), min(C.idx), count(DISTINCT C.idx)"
	minmaxsql = minmaxsql & " FROM tb_company A, tb_order B, tb_order_product C"
	minmaxsql = minmaxsql & " WHERE A.idx = right(B.usercode, 5)"
	minmaxsql = minmaxsql & " AND B.idx = C.idx"
	minmaxsql = minmaxsql & " AND C.flag = 'F'"
	minmaxsql = minmaxsql & " and A.bidxsub = '" & left(session("Ausercode"),5) & "'"
	'response.write minmaxsql
	Set mmrs = db.execute(minmaxsql)

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

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.ordernum, C.flag"
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"
	SQL = sql & " AND B.idx = C.idx"
	SQL = sql & " AND C.flag = 'F'"
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " order by C.pidx"

	rs.Open sql, db, 1
	imsiorderreg = rs(0)

	Do Until rs.EOF

		str = ""
		onlen = len(Trim(rs("ordernum")))
		onlen1 = 5-onlen
		for i = 1 to onlen1
			str = str & " "
		next
		ordernum = Trim(rs("ordernum")) & str
	
		objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum)

		USql = "Update tb_order_product Set flag = 'T'"
		USql = Usql & " where pidx = '" & Trim(rs("pidx")) & "'"

		db.execute(USql)
	
	rs.MoveNext
	Loop
	objFile.close


	Sql = "Insert into tb_download ("
	Sql = Sql & " bidxsub"
	Sql = Sql & ",start_date"
	Sql = Sql & ",start_time"
	Sql = Sql & ",end_date"
	Sql = Sql & ",end_time"
	Sql = Sql & ",start_idx"
	Sql = Sql & ",end_idx"
	Sql = Sql & ",count_num"
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
	Sql = Sql & "'" & yyyymmdd & ".txt')"

	'RESPONSE.WRITE Sql

	db.execute(Sql)

	db.close
	set db=nothing

    	file = yyyymmdd & ".txt"  '//파일 이름

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