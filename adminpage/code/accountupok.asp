<!--#include virtual="/db/db.asp" -->
<!--#include virtual="/adminpage/account/dataup/fun.asp"-->
<%
	
    Set upload = Server.CreateObject("DEXT.FileUpload") 
	'upload.DefaultPath = server.MapPath("/") & "\fileupdown\AccountNumber"
    upload.DefaultPath = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\AccountNumber"

  
	'1'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''1
	if upload("bfile4") <> "" then

		filename = upload("bfile4").FileName
		filepath = upload.DefaultPath & "\" & filename

		If upload.FileExists(filepath) Then

			If InStrRev(filename, ".") <> 0 Then 
      				filenameonly = Left(filename, InStrRev(filename, ".") - 1) 
      				fileext = Mid(filename, InStrRev(filename, ".")) 
			Else 
      				filenameonly = filename 
      				fileext = "" 
   			End If

			'i = 2
   			'Do While (1)
      			'	filepath =  upload.DefaultPath & "\" & filenameonly & "[" & i & "]" & fileext
      			'	If Not upload.FileExists(filepath) Then Exit Do 
			'		i = i + 1
			'Loop 

		End If

		upload("bfile4").SaveAs filepath
		Filename1 = Mid(filepath,instrRev(filepath,"\")+1)
		file_width1 = upload("bfile4").ImageWidth 

	end If

	if xSheetName = "" then 
    		xSheetName = "Sheet1"
	end if

	'// working vars
	dim uploadRoot, uploadPath, srcFile
	'uploadRoot = server.MapPath("/") & "\fileupdown\AccountNumber"
 uploadRoot =    "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\AccountNumber"
	uploadPath = Filename1
	set xConn  = createObject("ADODB.connection")
	set xRs    = createObject("ADODB.recordset")
	With xConn
		.Provider = "Microsoft.Jet.OLEDB.4.0"
		.ConnectionString = _
			"Data Source=" & uploadRoot & "\" & uploadPath & ";" & _
			"Extended Properties=Excel 8.0;" 
	'//		"HDR=YES;"
	'	.CursorLocation = adUseClient
		.Open
	End With

	'체인점코드	체인점명	여신금액	미수금액
	xSql = "SELECT * FROM [" & xSheetName & "$] " 
	xRs.open(xSql),xConn
	if Err.number <> 0 then
	    	xRs.close: set xRs=nothing
	    	xConn.close : set xConn =nothing
		FunErrorMsg("엑셀파일 연결 실패! " & Err.description)
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'Set fs = Server.CreateObject("Scripting.FileSystemObject")
	'imsidir_file2 = server.MapPath("/") & "\fileupdown\AccountNumber\error.xls"	'엑셀경로
	'fs.CreateTextFile imsidir_file2,true
	'Set objFile = fs.OpenTextFile(imsidir_file2,8)

	imsilinetxt1 = "<meta http-equiv=""Content-Type"" content=""text/html; charset=euc-kr""> "
	imsilinetxt1 = imsilinetxt1 & "<style type='text/css'> "
	imsilinetxt1 = imsilinetxt1 & "<!-- "
	imsilinetxt1 = imsilinetxt1 & "td.accountnum{ "
	imsilinetxt1 = imsilinetxt1 & "mso-number-format:\@} "
	imsilinetxt1 = imsilinetxt1 & "--> "
	imsilinetxt1 = imsilinetxt1 & "</STYLE> "
	imsilinetxt1 = imsilinetxt1 & "<table border=1>"
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	bidxsub = left(session("Ausercode"),5)
	idxsub  = mid(session("Ausercode"),6,5)
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	errcnt = 0
	i = 1
	do while not xRs.eof 
    flag = "3"
		errormsg = ""
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		tcode       = trim(xRs(0))
		'response.write "<script> alert(" & CStr(xRs(1)) &"); </script>"
		accountno   = "'" & trim(xRs(3)) & "'"
		accountbank = "'" & trim(xRs(2)) & "'"
         accountno4   = "'" & trim(xRs(5)) & "'"
		accountbank4 = "'" & trim(xRs(4)) & "'"
    accountno5   = "'" & trim(xRs(7)) & "'"
		accountbank5 = "'" & trim(xRs(6)) & "'"
     accountno6   = "'" & trim(xRs(9)) & "'"
		accountbank6 = "'" & trim(xRs(8)) & "'"

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		errormsg = errormsg & FunNullMsg(tcode,"회원사코드없음/")
		errormsg = errormsg & FunNullMsg(Replace(accountno, "'", ""),"가상계좌번호없음/")
		
		If Len(tcode) <> 4 Then 
			errormsg = errormsg & "올바르지 않은 거래처코드"
		End If

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if errormsg="" Then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select idx from tb_company where flag = '3' and bidxsub = "& bidxsub &" and idxsub = "& idxsub &" and tcode = '"& tcode &"' "
			'response.write sql
			rs.Open sql, db, 1
			if not rs.eof then
				tidx = rs(0)
			end if
			rs.close
			'If tidx <> "" Then 
				SQL = " update tb_company set "
				SQL = SQL & " virtual_acnt = "& accountno &", "
				SQL = SQL & " virtual_acnt_bank = " & accountbank & ",  "
                SQL = SQL & " virtual_acnt4 = "& accountno4 &", "
				SQL = SQL & " virtual_acnt4_bank = " & accountbank4 & " , "
                SQL = SQL & " virtual_acnt5 = "& accountno5 &", "
				SQL = SQL & " virtual_acnt5_bank = " & accountbank5 & ",  "
                SQL = SQL & " virtual_acnt6 = "& accountno6 &", "
				SQL = SQL & " virtual_acnt6_bank = " & accountbank6 & "  "
               
				SQL = SQL & " where idx = "& tidx
				db.Execute SQL
				'response.write SQL
				'if tcode<>"" and tname<>"" and tymoney<>"" and tmmoney<>"" then
				'	if IsNumeric(tymoney)=true and IsNumeric(tmmoney)=true then
					
				'	end if
			'End If 
		Else
			if errcnt=0 then
				'objFile.writeLine(imsilinetxt1)
			end if
			'imsiline = "<tr align=center class='accountnum'><td>" & tcode & "</td><td>" & accountno & "</td><td>" & errormsg & "</td></tr>"
			'objFile.writeLine(imsiline)
			errcnt = errcnt+1
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	xRs.moveNext
	i=i+1
	loop
	'call FunFileMakeEnd()

	if errcnt=0 then
		'FunWindowrCloseReload()
    response.redirect "list.asp?flag="&flag
   
	else
%>

<SCRIPT LANGUAGE=JavaScript>opener.location.reload();</SCRIPT>
<table align=center>
<tr>
<td>
	▶ 총 건수 : <%=i-1%> 건 <BR>
	▶ 입력 건수 :   <%=i-errcnt-1%> 건 <BR>
	▶ 오류 건수 :   <%=errcnt%> 건  <BR>
	<!--<center><a href="/fileupdown/AccountNumber/error.xls">오류내역 다운로드</a></center>-->
</td>
</tr>
</table>


<%	end if%>

