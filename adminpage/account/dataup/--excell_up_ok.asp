<!--#include virtual="/adminpage/account/dataup/fileup.asp"-->
<!--#include virtual="/db/db.asp" -->
<!--#include virtual="/adminpage/account/dataup/fun.asp"-->
<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if len(Filename1)<12 then
		FunErrorMsg("���ϸ��� ����� 8�ڸ��� �ٲپ �Է��ϼ���.")
	end if
	'SQL = " select count(seq) from tAccountM where Aym = '"& left(Filename1,6) &"' "
	'Set Rs = Db.Execute(SQL)
	'if rs(0)<>0 then
	'	FunErrorMsg("�̹� û������� �ֽ��ϴ�.\n���� ����Ÿ�� ������ �ٽ� �÷��ּ���.")
	'end if
	'rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if xSheetName = "" then 
    		xSheetName = "Sheet1"
	end if

	'// working vars
	dim uploadRoot, uploadPath, srcFile
	uploadRoot = server.MapPath("/") & "\fileupdown\account"
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

	'xSql = "SELECT [ȸ�����ڵ�],[flag],[ȸ�����],[�̿��],[ü������],[���] FROM [" & xSheetName & "$]" 
	xSql = "SELECT * FROM [" & xSheetName & "$]" 
	xRs.open(xSql),xConn
	
	if Err.number <> 0 then
	    	xRs.close: set xRs=nothing
	    	xConn.close : set xConn =nothing
		FunErrorMsg("�������� ���� ����! " & Err.description)
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	wdate = FunYMDHMS(now())	'����Ͻ�
	Aym   = left(Filename1,6)	'û�����
	Aymd  = left(Filename1,8)	'û������
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	imsidir_file2 = server.MapPath("/") & "\fileupdown\account\error.xls"	'�������
	fs.CreateTextFile imsidir_file2,true
	Set objFile = fs.OpenTextFile(imsidir_file2,8)

	imsilinetxt1 = "<meta http-equiv=""Content-Type"" content=""text/html; charset=euc-kr""> "
	imsilinetxt1 = imsilinetxt1 & "<style type='text/css'> "
	imsilinetxt1 = imsilinetxt1 & "<!-- "
	imsilinetxt1 = imsilinetxt1 & "td.accountnum{ "
	imsilinetxt1 = imsilinetxt1 & "mso-number-format:\@} "
	imsilinetxt1 = imsilinetxt1 & "--> "
	imsilinetxt1 = imsilinetxt1 & "</STYLE> "
	imsilinetxt1 = imsilinetxt1 & "<table border=1>"
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	errcnt = 0
	i = 1
	do while not xRs.eof 
		errormsg = ""
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if len(xRs(0))<>4 then
			errormsg = errormsg & "ȸ�����ڵ����/"
		else
			SQL = " select idx,comname,name,addr,addr2,uptae,upjong,companynum1,companynum2,companynum3 from tb_company where flag = '1' and tcode = '"& xRs(0) &"' "
			Set Rs = Db.Execute(SQL)
			if not rs.eof then
				idx           = rs(0)
				company       = rs(1)
				companyName   = rs(2)
				companyAddr   = rs(3) &" "&rs(4)
				companyUptae  = rs(5)
				companyUpjong = rs(6)
				companynum1   = rs(7)
				companynum2   = rs(8)
				companynum3   = rs(9)
				companynum    = companynum1 &"-"& companynum2 &"-"& companynum3
				tcode         = xRs(0)
			else
				company       = ""
				companyName   = ""
				companyAddr   = ""
				companyUptae  = ""
				companyUpjong = ""
				errormsg = errormsg & "ȸ�����ڵ�Ʋ��/"
			end if
			rs.close
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		errormsg = errormsg & FunNullMsg(trim(xRs(1)),"flag����/")
		errormsg = errormsg & FunNullMsg(trim(xRs(2)),"ȸ��������/")
		errormsg = errormsg & FunNullMsg(trim(xRs(3)),"�̿�����/")
		errormsg = errormsg & FunNullMsg(trim(xRs(4)),"ü����������/")
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		flag   = xRs(1)
		hname  = xRs(2)
		umoney = xRs(3)
		Anum   = xRs(4)

		if IsNumeric(umoney) = true and IsNumeric(Anum) = true then
			kmoney = umoney * Anum
			smoney = int(kmoney * 0.1)
			hmoney = kmoney + smoney
		else
			kmoney = 0
			smoney = 0
			hmoney = 0
			errormsg = errormsg & "�̿��Ǵ�ü���������ھƴ�/"
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if right(errormsg,1)="/" then
			errormsg = left(errormsg,len(errormsg)-1)
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		textName  = hname						'�ŷ���ǥ ȸ�����
		textPname = "��,���� �̿�� (" & right(Aym,2) & "����)"		'�ŷ���ǥ ǰ���
		textBigo  = xRs(5)						'�ŷ���ǥ ���
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if errormsg="" then
			'idx,tcode,Aym,Aymd,flag,hname,umoney,Anum,kmoney,smoney,hmoney,textName,textPname,textBigo,company,companyName,companyAddr,companyUptae,companyUpjong,wdate
			imsisql1 = "idx,tcode,Aym,Aymd,flag,hname,umoney,Anum,kmoney,smoney,hmoney,textName,textPname,textPname2,textBigo,company,companynum,companyName,companyAddr,companyUptae,companyUpjong,wdate,filename"
			imsisql2 = " "& idx &",'"& tcode &"','"& Aym &"','"& Aymd &"','"& flag &"','"& hname &"',"& umoney &","& Anum &","& kmoney &","& smoney &","& hmoney &",'"& textName &"','"& textPname &"',"
			imsisql2 = imsisql2 & " '"& hname &"','"& textBigo &"','"& company &"','"& companynum &"','"& companyName &"','"& companyAddr &"','"& companyUptae &"','"& companyUpjong &"','"& wdate &"', '"& Filename1 &"' "
			Sql = " Insert into tAccountM ("& imsisql1 &") Values ("& imsisql2 &") "
			db.Execute(Sql)
		else
			if errcnt=0 then
				objFile.writeLine(imsilinetxt1)
			end if
			imsiline = "<tr align=center class='accountnum'><td>" & tcode & "</td><td>" & hname & "</td><td>" & errormsg & "</td></tr>"
			objFile.writeLine(imsiline)
			errcnt = errcnt+1
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	xRs.moveNext
	i=i+1
	loop
	call FunFileMakeEnd()

	if errcnt=0 then
		FunWindowrCloseReload()
	else
%>

<SCRIPT LANGUAGE=JavaScript>opener.location.reload();</SCRIPT>
<table align=center>
<tr>
<td>
	�� �� �Ǽ� : <%=i-1%> �� <BR>
	�� �Է� �Ǽ� :   <%=i-errcnt%> �� <BR>
	�� ���� �Ǽ� :   <%=errcnt%> ��  <BR>
	<center><a href="/fileupdown/account/error.xls">�������� �ٿ�ε�</a></center>
</td>
</tr>
</table>

<%	end if%>

