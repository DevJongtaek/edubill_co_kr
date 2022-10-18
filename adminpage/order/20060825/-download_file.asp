<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	idx = Trim(Request.QueryString("idx"))

	sql = "select idx, start_idx, end_idx, filename"
	sql = sql & " FROM tb_download"
	sql = sql & " WHERE idx = " & idx
	Set mrs = db.execute(sql)

	min = Trim(mrs("start_idx"))
	max = Trim(mrs("end_idx"))
	yyyymmdd = left(Trim(mrs("filename")), 14)

	mrs.close

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\" & yyyymmdd & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.ordernum, C.flag"
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"
	SQL = sql & " AND B.idx = C.idx"
	SQL = sql & " AND C.flag = 'T'"
	SQL = sql & " AND C.pidx between " & min & " and " & max
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " order by C.pidx"

	rs.Open sql, db, 1
	imsiorderreg = rs(0)

	'response.write SQL

	Do Until rs.EOF

		str = ""
		onlen = len(Trim(rs("ordernum")))
		onlen1 = 5-onlen
		for i = 1 to onlen1
			str = str & " "
		next
		ordernum = Trim(rs("ordernum")) & str
	
		objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum)

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