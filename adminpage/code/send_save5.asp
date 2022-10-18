<!--#include virtual="/db/db.asp"-->
<%
'dir = server.MapPath("upfile")
'response.write dir
'response.end

	Set upload = Server.CreateObject("DEXT.FileUpload") 
	upload.DefaultPath = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown"
  

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

			i = 2
   			Do While (1)

      				filepath =  upload.DefaultPath & "\" & filenameonly & "[" & i & "]" & fileext

      				If Not upload.FileExists(filepath) Then Exit Do 
					i = i + 1
			Loop 

		End If

		upload("bfile4").SaveAs filepath
		Filename1 = Mid(filepath,instrRev(filepath,"\")+1)
		file_width1 = upload("bfile4").ImageWidth 

	end if

	if xSheetName = "" then 
    		xSheetName = "Sheet1"
	end if
	
	dim uploadRoot, uploadPath, srcFile
	uploadRoot = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown"
	uploadPath = Filename1

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

	'[체인점코드],[체인점명],[브랜드코드],[브랜드명] FROM [" & xSheetName & "$]" 
	xSql = "SELECT * FROM [" & xSheetName & "$]" 
	'xSql = xSql & " ORDER BY 1 " 
	xRs.open(xSql),xConn
	
	if Err.number <> 0 then
	    response.write "엑셀파일 연결 실패! " & Err.description
	    xRs.close: set xRs=nothing
	    xConn.close : set xConn =nothing
	    response.end
	end if

i = 1
do while not xRs.eof 

	imsitel1 = ""
	imsitel2 = ""
	imsitel3 = ""
	imsitel11 = ""
	imsitel22 = ""
	imsitel33 = ""

	usercode = session("Ausercode")
	wuserid = session("Auserid")
	wdate = now()

	flag = "3"
	bidxsub = left(session("Ausercode"),5)
	idxsub = mid(session("Ausercode"),6,5)
	if idxsub = "" then
		idxsub=0
	end if

	orderreg = "n"


	if trim(xRs(0)) = "" or isnull(xRs(0)) then
		imsiline = i
		errorflag = "3"
		Exit Do
	end if

	if trim(xRs(1)) = "" or isnull(xRs(1)) then
		imsiline = i
		errorflag = "4"
		Exit Do
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select count(idx) from tb_company where bidxsub = "& bidxsub &" and tcode = '"& xRs(0) &"' "
	rs.Open sql, db, 1
	imsierrorcheck = rs(0)
	rs.close
	

	

	
	idxsubname = xRs(1)



 imsicbrandchoice = xRs(2)

'if imsierrorcheck > 0 then
  SQL =  "UPDATE tb_company"
  SQL = SQL & " set dcarno = '"& imsicbrandchoice &"'"
  SQL = SQL & " where tcode = '"& xRs(0) &"'"
  SQL = SQL & " and bidxsub = "& bidxsub &""
  SQL = SQL & " and comname = '"& idxsubname &"'"
  db.Execute SQL

'end if

xRs.moveNext
i=i+1
loop

  if errorflag="3" then
		imsimsg = imsiline&"라인에 체인점코드가 비어있습니다."
	elseif errorflag="4" then
		imsimsg = imsiline&"라인에 체인명이 비어있습니다."
	else
		response.redirect "list.asp?flag="&flag

	end if
	

%>

<!--#include virtual="/adminpage/incfile/upload_top.asp"-->

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

