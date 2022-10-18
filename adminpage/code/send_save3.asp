<!--#include virtual="/db/db.asp" -->
<%
	'db.BeginTrans
	'//
	errorflag  = 0
	nextcount  = 0
	totalcount = 0
	imsiError  = "개가 정상적으로 변경되었습니다."
	'//
	Set upload = Server.CreateObject("DEXT.FileUpload") 
	upload.DefaultPath = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\misu"
	'//
	searcha = upload("searcha")
	searchb = upload("searchb")
	searchc = upload("searchc")
	searchd = upload("searchd")
	searche = upload("searche")
	searchf = upload("searchf")
	searchg = upload("searchg")
	gotopage= upload("gotopage")
	idx     = upload("idx")
	dflag   = upload("dflag")
	flag    = upload("flag")
    usercode = session("Ausercode")		'본사+(지점/체인점)코드
    wuserid  = session("Auserid")		'id
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if upload("bfile2") <> "" then
		filename = upload("bfile2").FileName
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
		upload("bfile2").SaveAs filepath
		Filename1 = Mid(filepath,instrRev(filepath,"\")+1)
		file_width1 = upload("bfile2").ImageWidth 
	end if
	'//
	if xSheetName = "" then xSheetName = "Sheet1"
	'//	
	dim uploadRoot, uploadPath, srcFile
	uploadRoot = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\misu"
	uploadPath = Filename1
	'//
	Server.ScriptTimeout = 10000'-엑셀데이터의 원활한 처리를 위해 타임아웃 설정
	' On Error Resume Next
    '엑셀 Open
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
	'//
	xSql = "SELECT [체인점코드], [체인점명], [주문여부], [비고] FROM [" & xSheetName & "$] " 
	'xSql = "SELECT * FROM [" & xSheetName & "$] " 
	xRs.open(xSql),xConn
	if Err.number <> 0 then
	    	xRs.close: set xRs=nothing
	    	xConn.close : set xConn =nothing
		FunErrorMsg("엑셀파일 연결 실패! " & Err.description)
	end if
	'//
	i=1
    do while not xRs.eof
		'//
	    tcode     = trim(xRs(0))
	    tname     = trim(xRs(1))
	    orderflag = trim(xRs(2))
	    errorflag = 0
		'//
        If Trim(tcode) = "" Then errorflag = 1
        If Trim(tcode) = "" Then errorflag = 1
        If Trim(tcode) = "" Then errorflag = 1
		'//
		If errorflag = 0 Then
	        Select Case orderflag
		        Case "y","1","2","3","4","5","6"
			    Case Else
				        errorflag = 1
		        End Select
		End If 
		'//
        set rs = server.CreateObject("ADODB.Recordset")
        sql = "SELECT isnull(COUNT(TCODE),0) FROM tb_company "
        sql = sql & "WHERE tcode = '" & tcode & "' "
		sql = sql & "AND flag = '3' "
        sql = sql & "AND bidxsub = "& Mid(usercode,1,5) &" "
        rs.Open sql, db, 1
		imsicnt = rs(0)
		rs.close
		'//
		If imsicnt=0 Then errorflag = 1
		'//
		If errorflag = 0 then
   	        SQL = "UPDATE tb_company SET "
            SQL = SQL & " orderflag = '" & orderflag & "' "
            SQL = SQL & " ,edate = getdate() "
            SQL = SQL & " ,euserid = '"& wuserid &"' "
  	        SQL = SQL & " WHERE tcode = '" & tcode & "' "
	        SQL = SQL & " AND flag = '3' "
            SQL = SQL & " AND bidxsub = "& Mid(usercode,1,5) &" "
	        db.Execute SQL
			'Response.write sql &"<BR>"
            totalcount = totalcount + 1
        End If 
		'//
	xRs.movenext
	i=i+1
    loop
	xRs.close

	'If db.Errors.Count > 0 Or errorflag = "1" Then
	'	db.RollbackTrans
	'Else
	'	db.CommitTrans
	'End if
  

 'On Error Goto 0




 'End Sub 

%>

<!--#include virtual="/adminpage/incfile/upload_top.asp"-->

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<BR><BR>
<%= totalcount & imsiError%>
<BR><BR>
<% If errorflag = "1" Then %>
<a href="#" onclick="javascript:history.back();">[돌아가기]</a>
<%Else %>
<a href="#" onclick="javascript:location.href='list.asp?flag=<%=flag%>&gotopage=<%=gotopage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>'">[돌아가기]</a>
<%End If%>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR><BR>

<%
	db.close
	set db=Nothing
%>

