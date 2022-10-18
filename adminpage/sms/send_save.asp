<!--#include virtual="/db/db.asp"-->
<%
'dir = server.MapPath("upfile")
'response.write dir
'response.end

	Set upload = Server.CreateObject("DEXT.FileUpload") 
	upload.DefaultPath = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown"

	'1'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''1
	if upload("bfile1") <> "" then

		filename = upload("bfile1").FileName
		filepath = upload.DefaultPath & "\" & filename

		If upload.FileExists(filepath) Then

			If InStrRev(filename, ".") <> 0 Then 
      				filenameonly = Left(filename, InStrRev(filename, ".") - 1) 
      				fileext = Mid(filename, InStrRev(filename, ".")) 
			Else 
      				filenameonly = filename 
      				fileext = "" 
   			End If

			i = 2
   			Do While (1)

      				filepath =  upload.DefaultPath & "\" & filenameonly & "[" & i & "]" & fileext

      				If Not upload.FileExists(filepath) Then Exit Do 
					i = i + 1
			Loop 

		End If

		upload("bfile1").SaveAs filepath
		Filename1 = Mid(filepath,instrRev(filepath,"\")+1)
		file_width1 = upload("bfile1").ImageWidth 

	end if

	if xSheetName = "" then 
    		xSheetName = "sms"
	end if
	
	'// working vars
	dim uploadRoot, uploadPath, srcFile
	uploadRoot = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown"
	uploadPath = Filename1
	'response.write uploadPath

	set xConn = createObject("ADODB.connection")
	set xRs = createObject("ADODB.recordset")
	
	With xConn
		.Provider = "Microsoft.Jet.OLEDB.4.0"
		.ConnectionString = _
			"Data Source=" & uploadRoot & "\" & uploadPath & ";" & _
			"Extended Properties=Excel 8.0;" 
	'//		"HDR=YES;"
	'	.CursorLocation = adUseClient
		.Open
	End With
	
	xSql = "SELECT [체인점코드],[체인점명],[핸드폰번호],[이통사] FROM [" & xSheetName & "$]" 
	'xSql = xSql & " ORDER BY 1 " 
	
	xRs.open(xSql),xConn
	
	if Err.number <> 0 then
	    response.write "엑셀파일 연결 실패! " & Err.description
	    xRs.close: set xRs=nothing
	    xConn.close : set xConn =nothing
	    response.end
	end if
	
	' Title Line
	'for each xFld in xRs.Fields
	'    response.write xFld.Name & "|"
	'next

	orderday = date
	yy = left(orderday, 4)
	mm = mid(orderday, 6, 2)
	dd = right(orderday, 2)
	h = hour(now)
	m = Minute(now)
	s = Second(now)
	
	if len(yy) = "1" then
		yy = "0" & yy
	end if

	if len(mm) = "1" then
		mm = "0" & mm
	end if
	
	if len(dd) = "1" then
		dd = "0" & dd
	end if
	
	if len(h) = "1" then
		h = "0" & h
	end if
	
	if len(m) = "1" then
		m = "0" & m
	end if
	
	if len(s) = "1" then
		s = "0" & s
	end if

	set rs = createObject("ADODB.recordset")

	sms_date = yy & "-" & mm & "-" & dd
	sms_time = h & ":" & m & ":" & s
	comp_id = "10273"
	i = 1

	sql = "SELECT isnull(max(idx),100000)+1 as max_seq "
	sql = sql & vbcrlf & "	FROM 	tb_sms_master "
			
	rs.open(sql), db
	idx = rs(0)
	rs.close
	
	Sql = "Insert into tb_sms_master ("
	Sql = Sql & " idx"
	Sql = Sql & ",comp_id"
	Sql = Sql & ",sms_date"
	Sql = Sql & ",sms_time"
	Sql = Sql & ") Values ("
	Sql = Sql & "'" & idx & "',"
	Sql = Sql & "'" & comp_id & "',"
	Sql = Sql & "'" & sms_date & "',"
	Sql = Sql & "'" & sms_time & "')"
	
	'Response.Write(Sql)
	db.Execute(Sql)

	do while not xRs.eof 

		mobile = Trim(xRs(2))

		'if len(mobile) = 11 then
			'tmobile = left(mobile, 3) & "-" & mid(mobile, 4, 4) & "-" & right(mobile, 4)
		'else
			'tmobile = left(mobile, 3) & "-" & mid(mobile, 4, 3) & "-" & right(mobile, 4)
		'end if

		Sql = "Insert into tb_sms_slave ("
		Sql = Sql & " idx"
		Sql = Sql & ",idx_sub"
		Sql = Sql & ",code"
		Sql = Sql & ",code_name"
		Sql = Sql & ",mobile"
		Sql = Sql & ",mobile_company"
		Sql = Sql & ",result"
		Sql = Sql & ") Values ("
		Sql = Sql & "'" & idx & "',"
		Sql = Sql & "'" & i & "',"
		Sql = Sql & "'" & xRs(0) & "',"
		Sql = Sql & "'" & xRs(1) & "',"
		Sql = Sql & "'" & mobile & "',"
		Sql = Sql & "'" & xRs(3) & "',"
		Sql = Sql & "'')"
	
		'Response.Write(Sql)
		db.Execute(Sql)

		if xRs(3) = "lgt" then
	
			QSql = "INSERT INTO em_tran "
			QSql = QSql & "(tran_phone, tran_callback, tran_status, tran_date, tran_msg, tran_type, tran_id) values " 
			QSql = QSql & "('" & mobile & "','7575','1',getdate(),'http://www.p-114.co.kr/wap/index019.asp ## 핸드폰주문##','5','" & idx & i & "')"

		elseif xRs(3) = "ktf" then

			QSql = "INSERT INTO em_tran "
			QSql = QSql & "(tran_phone, tran_callback, tran_status, tran_date, tran_msg, tran_type, tran_id) values " 
			QSql = QSql & "('" & mobile & "','7575','1',getdate(),'http://www.p-114.co.kr/wap/index016.asp ## 핸드폰주문##','5','" & idx & i & "')"

		else
			QSql = "INSERT INTO em_tran "
			QSql = QSql & "(tran_phone, tran_callback, tran_status, tran_date, tran_msg, tran_type, tran_id) values " 
			QSql = QSql & "('" & mobile & "','7575','1',getdate(),'http://www.p-114.co.kr/wap/index011.asp ## 핸드폰주문##','5','" & idx & i & "')"
		
		end if

		set db1 = server.CreateObject("ADODB.Connection")   '서버객체 db연결
		db1.Open "provider=sqloledb;server=61.97.113.73;database=MYPG;uid=sa;pwd=1234;"	'db를 연다

		'response.write QSql
		db1.Execute(QSql)

		i = i + 1
	
	xRs.moveNext
	loop
%>