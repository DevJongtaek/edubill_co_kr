<!--#include virtual="/adminpage/account/dataup/fileup.asp"-->
<!--#include virtual="/db/db.asp" -->
<!--#include virtual="/adminpage/account/dataup/fun.asp"-->
<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if len(Filename1)<12 then
		FunErrorMsg("파일명을 년월일 8자리로 바꾸어서 입력하세요.")
	end if
	'SQL = " select count(seq) from tAccountM where Aym = '"& left(Filename1,6) &"' "
	'Set Rs = Db.Execute(SQL)
	'if rs(0)<>0 then
	'	FunErrorMsg("이미 청구년월이 있습니다.\n기존 데이타를 삭제후 다시 올려주세요.")
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

	'xSql = "SELECT [회원사코드],[flag],[회원사명],[이용료],[체인점수],[비고] FROM [" & xSheetName & "$]" 
	xSql = "SELECT * FROM [" & xSheetName & "$]" 
	xRs.open(xSql),xConn
	
	if Err.number <> 0 then
	    	xRs.close: set xRs=nothing
	    	xConn.close : set xConn =nothing
		FunErrorMsg("엑셀파일 연결 실패! " & Err.description)
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	wdate = FunYMDHMS(now())	'등록일시
	Aym   = left(Filename1,6)	'청구년월
	Aymd  = left(Filename1,8)	'청구일자
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	imsidir_file2 = server.MapPath("/") & "\fileupdown\account\error.xls"	'엑셀경로
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
			errormsg = errormsg & "회원사코드없음/"
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
				errormsg = errormsg & "회원사코드틀림/"
			end if
			rs.close
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		errormsg = errormsg & FunNullMsg(trim(xRs(1)),"flag없음/")
		errormsg = errormsg & FunNullMsg(trim(xRs(2)),"회원사명없음/")
		errormsg = errormsg & FunNullMsg(trim(xRs(3)),"이용료없음/")
		errormsg = errormsg & FunNullMsg(trim(xRs(4)),"체인점수없음/")
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
			errormsg = errormsg & "이용료또는체인점수숫자아님/"
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if right(errormsg,1)="/" then
			errormsg = left(errormsg,len(errormsg)-1)
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		textName  = hname						'거래명세표 회원사명
		textPname = "수,발주 이용료 (" & right(Aym,2) & "월분)"		'거래명세표 품목명
		textBigo  = xRs(5)						'거래명세표 비고
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
	▶ 총 건수 : <%=i-1%> 건 <BR>
	▶ 입력 건수 :   <%=i-errcnt%> 건 <BR>
	▶ 오류 건수 :   <%=errcnt%> 건  <BR>
	<center><a href="/fileupdown/account/error.xls">오류내역 다운로드</a></center>
</td>
</tr>
</table>

<%	end if%>

