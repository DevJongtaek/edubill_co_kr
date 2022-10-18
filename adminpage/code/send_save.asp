<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
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
    		xSheetName = "Sheet1"
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
	
	xSql = "SELECT [상품코드],[상품명],[규격],[단가],[구분],[비고],[파일생성코드],[서브매뉴],[상품사진명] FROM [" & xSheetName & "$]" 
	'xSql = xSql & " ORDER BY 1 " 

	xRs.open(xSql),xConn
	
	if Err.number <> 0 then
	    response.write "엑셀파일 연결 실패! " & Err.description
	    xRs.close: set xRs=nothing
	    xConn.close : set xConn =nothing
	    response.end
	end if
	
	set rs = createObject("ADODB.recordset")

	usercode = session("Ausercode")
	wuserid = session("Auserid")
	wdate = now()
	excell_gubun = upload("excell_gubun")


if excell_gubun="" then
	i = 1
	do while not xRs.eof 

		if trim(xRs(0)) = "" or isnull(xRs(0)) then
			imsiline = i
			errorflag = "2"
			Exit Do
		end if

		if trim(xRs(1)) = "" or isnull(xRs(1)) then
			imsiline = i
			errorflag = "3"
			Exit Do
		end if

		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select count(idx) from tb_product where usercode = "& usercode &" and pcode = '"& xRs(0) &"' "
		rs.Open sql, db, 1
		imsierrorcheck = rs(0)
		rs.close
		if imsierrorcheck > 0 then
			imsipcode = xRs(0)
			imsiline = i
			errorflag = "1"
			Exit Do
		end if

		imsiprice=""
		imsiprice = replace(trim(replace(xRs(3),",","")),"원","")
		if imsiprice="" then
			imsiprice=0
		end if

		cbrandchoice = "00000"

		if xRs(7)="" or isnull(xRs(7)) then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select top 1 sidx from tb_product_submenu where idx = "& left(session("Ausercode"),5) &" order by sidx asc "
			rs.Open sql, db, 1
			if not rs.eof then
				imsisidx = rs(0)
			else
				imsisidx = ""
			end if
			imsisidx = ""
		else
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select sidx from tb_product_submenu where idx = "& left(session("Ausercode"),5) &" and sname = '"& xRs(7) &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				imsisidx = rs(0)
			else
				imsisidx = ""
			end if
		end if

		Sql = "Insert into tb_product ("
		Sql = Sql & " usercode"
		Sql = Sql & ",pcode"
		Sql = Sql & ",pname"
		Sql = Sql & ",pprice"
		Sql = Sql & ",ptitle"
		Sql = Sql & ",gubun"
		Sql = Sql & ",bigo"
		Sql = Sql & ",wdate"
		Sql = Sql & ",soundfile"
		Sql = Sql & ",fileregcode"
		Sql = Sql & ",wuserid"
		Sql = Sql & ",cbrandchoice"
		Sql = Sql & ",prochoice"
		Sql = Sql & ",proimage"
		Sql = Sql & ") Values ("
		Sql = Sql & "'" & usercode & "',"
		Sql = Sql & "'" & xRs(0) & "',"
		Sql = Sql & "'" & Replace(xRs(1), "'", "")  & "',"
		Sql = Sql & " " & imsiprice & ", "
		Sql = Sql & "'" & Replace(xRs(2), "'", "") & "',"
		Sql = Sql & "'" & Replace(xRs(4), "'", "") & "',"
		Sql = Sql & "'" & xRs(5) & "',"
		Sql = Sql & "'" & wdate & "',"
		Sql = Sql & "'',"
		Sql = Sql & "'" & xRs(6) & "',"
		Sql = Sql & "'" & wuserid & "',"
		Sql = Sql & "'" & cbrandchoice & "',"

		Sql = Sql & "'" & imsisidx & "',"
		Sql = Sql & "'" & xRs(8) & "')"
		'Response.Write(Sql)
		db.Execute(Sql)
	
	xRs.moveNext
	i=i+1
	loop

	if errorflag="1" then
		imsimsg = imsiline&"라인에 상품코드 "&imsipcode&"가 중복됩니다."
	elseif errorflag="2" then
		imsimsg = imsiline&"라인에 상품코드가 비어 있습니다."
	elseif errorflag="3" then
		imsimsg = imsiline&"라인에 상품명이 비어 있습니다."
	else
		response.redirect "plist.asp?gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb
	end if
else


	i = 1
	do while not xRs.eof 
		imsiline = 0
		if trim(xRs(0)) = "" or isnull(xRs(0)) then
			imsiline = 1
		else
			imsipcode = trim(xRs(0))
		end if

		if trim(xRs(3)) = "" or isnull(xRs(3)) or trim(xRs(3)) = "0" then
			imsiline  = 0
			imsiprice = 0
		else
			imsiprice = replace(trim(replace(xRs(3),",","")),"원","")
		end if

		if imsiline=0 then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select count(idx) from tb_product where usercode = "& usercode &" and pcode = '"& imsipcode &"' "
			rs.Open sql, db, 1
			imsierrorcheck = rs(0)
			rs.close
			if imsierrorcheck <> 1 then
				imsiline = 1
			end if
		end if

		if imsiline=0 then
			Sql = "update tb_product set"
			Sql = Sql & " pprice = "& imsiprice &" "
			Sql = Sql & " where usercode = '"& usercode &"' and pcode = '"& imsipcode &"' "
			db.Execute(Sql)
		end if

	xRs.moveNext
	i=i+1
	loop
	response.redirect "plist.asp?gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb

end if
%>



<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<BR><BR>
<%=imsimsg%>
<BR><BR>
<a href="#" onclick="javascript:history.back();">[돌아가기]</a>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR><BR>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->