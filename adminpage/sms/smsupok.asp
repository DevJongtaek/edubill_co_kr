<!--#include virtual="/adminpage/SMS/fileup.asp"-->
<!--#include virtual="/db/db.asp" -->
<!--#include virtual="/adminpage/account/dataup/fun.asp"-->
<%
	if xSheetName = "" then 
    		xSheetName = "Sheet1"
	end if

	'// working vars
	dim uploadRoot, uploadPath, srcFile
	uploadRoot = server.MapPath("/") & "\fileupdown\SMS"
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

	'ü�����ڵ�	ü������	���űݾ�	�̼��ݾ�
	xSql = "SELECT * FROM [" & xSheetName & "$] " 
	xRs.open(xSql),xConn
	if Err.number <> 0 then
	    	xRs.close: set xRs=nothing
	    	xConn.close : set xConn =nothing
		FunErrorMsg("�������� ���� ����! " & Err.description)
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'Set fs = Server.CreateObject("Scripting.FileSystemObject")
	'imsidir_file2 = server.MapPath("/") & "\fileupdown\misu\error.xls"	'�������
	'fs.CreateTextFile imsidir_file2,true
	'Set objFile = fs.OpenTextFile(imsidir_file2,8)

	'imsilinetxt1 = "<meta http-equiv=""Content-Type"" content=""text/html; charset=euc-kr""> "
	'imsilinetxt1 = imsilinetxt1 & "<style type='text/css'> "
	'imsilinetxt1 = imsilinetxt1 & "<!-- "
	'imsilinetxt1 = imsilinetxt1 & "td.accountnum{ "
	'imsilinetxt1 = imsilinetxt1 & "mso-number-format:\@} "
	'imsilinetxt1 = imsilinetxt1 & "--> "
	'imsilinetxt1 = imsilinetxt1 & "</STYLE> "
	'imsilinetxt1 = imsilinetxt1 & "<table border=1>"
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	bidxsub = left(session("Ausercode"),5)
	idxsub  = mid(session("Ausercode"),6,5)
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	errcnt = 0
	i = 1

        SQL = " delete newSMS  "
           
           
            db.execute SQL

	do while not xRs.eof 
		errormsg = ""
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		tcode   = trim(xRs(0))
		'tname   = trim(xRs(1))
		'if trim(xRs(2))<>"" then
		'	tymoney = replace(trim(xRs(2)),",","")
		'else
		'	tymoney = ""
		'end if
		'if trim(xRs(3))<>"" then
		'	tmmoney = replace(trim(xRs(3)),",","")
		'else
		'	tmmoney = ""
		'end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'	errormsg = errormsg & FunNullMsg(tcode,"ȸ�����ڵ����/")
	'	errormsg = errormsg & FunNullMsg(tname,"ȸ��������/")
	'	errormsg = errormsg & FunNullMsg(tymoney,"���űݾ׾���/")
	'	errormsg = errormsg & FunNullMsg(tmmoney,"�̼��ݾ׾���/")
		'if IsNumeric(tymoney)<>true then
		'	errormsg = errormsg & "���űݾ׼��ھƴ�/"
		'end if
		'if IsNumeric(tmmoney)<>true then
	'		errormsg = errormsg & "�̼��ݾ׼��ھƴ�/"
	'	end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
if tcode <> "" AND (left(tcode,3) = 010 or left(tcode,3) = 011  or left(tcode,3) = 016 or left(tcode,3) = 017 or left(tcode,3) = 018 or left(tcode,3) = 019 ) AND (len(tcode)= 11 or  len(tcode)= 10)  AND (IsNumeric(tcode) = true )then
			
    
            
            SQL = " insert into newSMS  "
            SQL = SQL & " values( '"&tcode&"')"
           

    'response.Write
            db.execute SQL
         

			

			
		else
			if errcnt=0 then
				'objFile.writeLine(imsilinetxt1)
			end if
			'imsiline = "<tr align=center class='accountnum'><td>" & tcode & "</td><td>" & tname & "</td><td>" & tymoney & "</td><td>" & tmmoney & "</td><td>" & errormsg & "</td></tr>"
			'objFile.writeLine(imsiline)
			errcnt = errcnt+1
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	xRs.moveNext
	i=i+1
	loop
	'call FunFileMakeEnd()

	if errcnt=0 then


		FunWindowrCloseReload()
	else
%>

<SCRIPT LANGUAGE=JavaScript>opener.location.reload();</SCRIPT>
<table align=center>
<tr>
<td>
	�� �� �Ǽ� : <%=i-1%> �� <BR>
	�� �Է� �Ǽ� :   <%=i-errcnt-1%> �� <BR>
	�� ���� �Ǽ� :   <%=errcnt%> ��  <BR>
	<center>
	<!--<a href="/fileupdown/misu/error.xls">�������� �ٿ�ε�</a>--></center>
</td>
</tr>
</table>

<%	end if%>

