<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	yyyymmdd = Trim(request.querystring("yyyymmdd"))

	h = hour(now)
	m = Minute(now)
	s = Second(now)
	
	if len(h) = "1" then
		h = "0" & h
	end if
	
	if len(m) = "1" then
		m = "0" & m
	end if
	
	if len(s) = "1" then
		s = "0" & s
	end if

	hms = h & m & s

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT B.idx, A.tcode, C.pcode, C.ordernum "
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"
	SQL = sql & " AND B.idx = C.idx"
	SQL = sql & " and A.bidxsub = "& left(session("Ausercode"),5) &" "
	SQL = sql & " and B.orderday = '" & yyyymmdd & "'"
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
	
		objFile.writeLine(Trim(rs("idx")) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum)
	
	rs.MoveNext
	Loop
	objFile.close

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
%>