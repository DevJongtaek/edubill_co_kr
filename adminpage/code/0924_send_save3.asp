<!--#include virtual="/db/db.asp" -->
<%
'dir = server.MapPath("upfile")
'response.write dir
'response.end
	db.BeginTrans
	
	errorflag = "0"
	nextcount = 0
	totalcount = 0
	imsiError = "���� ���������� ����Ǿ����ϴ�."
	Set upload = Server.CreateObject("DEXT.FileUpload") 
	upload.DefaultPath = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\misu"

	searcha = upload("searcha")
	searchb = upload("searchb")
	searchc = upload("searchc")
	searchd = upload("searchd")
	searche = upload("searche")
	searchf = upload("searchf")
	searchg = upload("searchg")
	gotopage = upload("gotopage")
	idx = upload("idx")
	dflag = upload("dflag")
	flag = upload("flag")

	'1'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''1
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

	if xSheetName = "" then 
    		xSheetName = "Sheet1"
	end if
	
	dim uploadRoot, uploadPath, srcFile
	uploadRoot = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\misu"
	uploadPath = Filename1

Response.write Filename1 &"<BR>"

	Server.ScriptTimeout = 10000'-������������ ��Ȱ�� ó���� ���� Ÿ�Ӿƿ� ����
       On Error Resume Next
    '���� Open
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
	xSql = "SELECT [ü�����ڵ�], [ü������], [�ֹ�����], [���] FROM [" & xSheetName & "$] " 
	xRs.open(xSql),xConn
	if Err.number <> 0 then
	    	xRs.close: set xRs=nothing
	    	xConn.close : set xConn =nothing
		FunErrorMsg("�������� ���� ����! " & Err.description)
	end if

    do while not xRs.eof 

response.write "read"
response.write xRs(0)
response.write xRs(1)
response.write xRs(2)

	    tcode   = trim(xRs(0))
	    tname   = trim(xRs(1))
	    orderflag   = trim(xRs(2))

response.write tcode
response.write tname   
response.write orderflag


    	nextflag = False ' ���� �ִ� �� ������ �˻� �÷���

        If Trim(tcode) = "" And Trim(tname) = "" And Trim(orderflag) = "" Then 
            nextflag = True  
            If nextcount > 5 Then
	            Exit do
            End If 
            nextcount = nextcount + 1
        Else
            nextcount = 0
        End If 

        If nextflag Then '���� �ִ� �� ������ �˻�
        else

	        If IsEmpty(tcode) Then
			        errorflag = "1"
			        imsiError = "���ο� �ŷ�ó�� �����ϴ�. <br> ���������� ������� �ʾҽ��ϴ�."
		        Exit do
	        Else
		        If Len(tcode) <> 4 Then
			        errorflag = "1"
			        imsiError = "���ο� �ŷ�ó�ڵ尡 �߸��Ǿ����ϴ�. <br> ���������� ������� �ʾҽ��ϴ�."
		        End If 	
	        End If 
            If IsEmpty(orderflag) Then
		        errorflag = "1"
		        imsiError = "���ο� �ֹ����ΰ� ����ֽ��ϴ�. <br> ���������� ������� �ʾҽ��ϴ�."
		        Exit do
	        Else
		        Select Case orderflag
			        Case "y"
			        Case "1"
			        Case "2"
			        Case "3"
			        Case "4"
			        Case "5"
			        Case "6"
			        Case Else
				        errorflag = "1"
				        imsiError = "���ο� �ֹ����ΰ� �߸��Ǿ����ϴ�. <br> ���������� ������� �ʾҽ��ϴ�."
				        Exit do 
		        End Select
	        End If 


	        usercode = session("Ausercode")
	        wuserid = session("Auserid")
	        set rs = server.CreateObject("ADODB.Recordset")
	        sql = "SELECT COUNT(TCODE) FROM tb_company "
	        sql = sql & "WHERE tcode = '" & aData(i,1) & "' "
  	        sql = sql & "AND flag = '3' "
	        sql = sql & "AND bidxsub = (SELECT LEFT(usercode, 5) FROM tb_adminuser WHERE userid ='" & wuserid & "') "
	        rs.Open sql, db, 1
		        if not rs.eof then
			        dcarno = rs(0)
			        if dcarno <= 0 Then
				        errorflag = "1"
				        imsiError = "���ο� ��ġ�ϴ� �ŷ�ó�ڵ�(" & tcode & ")�� �����ϴ�. <br> ���������� ������� �ʾҽ��ϴ�."
				        Exit do
			        end if
		        Else
			        errorflag = "1"
			        imsiError = "���ο� ���� �� ������ �߻��Ͽ����ϴ�. <br> ���������� ������� �ʾҽ��ϴ�."
			        Exit do 
		        end if
	        rs.close

   	        SQL = "UPDATE tb_company SET "
            SQL = SQL & " orderflag = '" & orderflag & "' "
            SQL = SQL & " ,edate = getdate() "
            SQL = SQL & " ,euserid = 'admin' "
  	        SQL = SQL & " WHERE tcode = '" & tcode & "' "
	        SQL = SQL & " AND flag = '3' "
            SQL = SQL & " AND bidxsub = (SELECT LEFT(usercode,5) FROM tb_adminuser WHERE userid ='" & wuserid & "')"

	        db.Execute SQL
            totalcount = totalcount + 1
            'Response.Write sql
	        'response.write "<br>"
	        'response.write imsiError 
        End If 


    loop

	If db.Errors.Count > 0 Or errorflag = "1" Then
		db.RollbackTrans
	Else
		db.CommitTrans
	End if
  

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
<a href="#" onclick="javascript:history.back();">[���ư���]</a>
<%Else %>
<a href="#" onclick="javascript:location.href='list.asp?flag=<%=flag%>&gotopage=<%=gotopage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>'">[���ư���]</a>
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

