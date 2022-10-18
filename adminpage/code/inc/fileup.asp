<%
'dir = server.MapPath("/")
'response.write dir
'response.end
'D:\Webhosting\2004VIVA\edubill_co_kr_new\adminpage\account\dataup\upfile

	Set upload = Server.CreateObject("DEXT.FileUpload") 
	upload.DefaultPath = server.MapPath("/") & "\fileupdown\misu"
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

			'i = 2
   			'Do While (1)
      			'	filepath =  upload.DefaultPath & "\" & filenameonly & "[" & i & "]" & fileext
      			'	If Not upload.FileExists(filepath) Then Exit Do 
			'		i = i + 1
			'Loop 

		End If

		upload("bfile1").SaveAs filepath
		Filename1 = Mid(filepath,instrRev(filepath,"\")+1)
		file_width1 = upload("bfile1").ImageWidth 

	end if
%>
