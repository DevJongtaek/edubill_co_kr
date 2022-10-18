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

	'[체인점코드],[체인점명],[대표자],[사업자등록번호],[우편번호],[주소1],[주소2],[업태],[업종],[전화번호],[핸드폰번호],[호차],[파일생성코드]
	'xSql = "SELECT [체인점코드],[체인점명],[대표자],[사업자등록번호],[우편번호],[주소1],[주소2],[업태],[업종],[전화번호],[핸드폰번호],[호차],[파일생성코드],[이메일] FROM [" & xSheetName & "$]" 
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
	fax1=""
	fax2=""
	fax3=""
	startday = replace(left(now(),10),"-","")
	vatflag = ""
	taxtitle = ""
	juminno1 = ""
	juminno2 = ""
	homepage = ""
	usegubun = "2"
	usemoney = 0
	soundfile=""

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
	if imsierrorcheck > 0 then
		imsitcode = xRs(0)
		imsiline = i
		errorflag = "1"
		Exit Do
	end if

	imsixRs11 = replace(trim(xRs(11)),"호","")
	imsixRs11 = replace(imsixRs11,"차","")
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx from tb_car where usercode = '"& bidxsub &"' and dcarno = '"& imsixRs11 &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		dcarno = rs(0)
	else
		imsicarno = xRs(11)
		imsiline = i
		errorflag = "2"
		Exit Do
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname from tb_company where idx = "&idxsub
	rs.Open sql, db, 1
	idxsubname = rs(0)
	rs.close

	testimsi=xRs(9)
	testimsi2=xRs(10)

	if (mid(testimsi,3,1)="-" or mid(testimsi,3,1)=")") and mid(testimsi,8,1)="-" then		'02-2214-0833
		imsitel1 = left(testimsi,2)
		imsitel2 = mid(testimsi,4,4)
		imsitel3 = right(testimsi,4)
	elseif (mid(testimsi,3,1)="-" or mid(testimsi,3,1)=")") and mid(testimsi,7,1)="-" then	'02-214-0833
		imsitel1 = left(testimsi,2)
		imsitel2 = mid(testimsi,4,3)
		imsitel3 = right(testimsi,4)
	elseif (mid(testimsi,4,1)="-" or mid(testimsi,4,1)=")") and mid(testimsi,9,1)="-" then	'031-2214-0833
		imsitel1 = left(testimsi,3)
		imsitel2 = mid(testimsi,5,4)
		imsitel3 = right(testimsi,4)
	elseif (mid(testimsi,4,1)="-" or mid(testimsi,4,1)=")") and mid(testimsi,8,1)="-" then	'031-214-0833
		imsitel1 = left(testimsi,3)
		imsitel2 = mid(testimsi,5,3)
		imsitel3 = right(testimsi,4)
	else
		imsitel1 = "000"
		imsitel2 = "000"
		imsitel3 = "0000"
	end if

	if (mid(testimsi2,3,1)="-" or mid(testimsi2,3,1)=")")  and mid(testimsi2,8,1)="-" then		'02-2214-0833
		imsitel11 = left(testimsi2,2)
		imsitel22 = mid(testimsi2,4,4)
		imsitel33 = right(testimsi2,4)
	elseif (mid(testimsi2,3,1)="-" or mid(testimsi2,3,1)=")") and mid(testimsi2,7,1)="-" then	'02-214-0833
		imsitel11 = left(testimsi2,2)
		imsitel22 = mid(testimsi2,4,3)
		imsitel33 = right(testimsi2,4)
	elseif (mid(testimsi2,4,1)="-" or mid(testimsi2,4,1)=")") and mid(testimsi2,9,1)="-" then	'031-2214-0833
		imsitel11 = left(testimsi2,3)
		imsitel22 = mid(testimsi2,5,4)
		imsitel33 = right(testimsi2,4)
	elseif (mid(testimsi2,4,1)="-" or mid(testimsi2,4,1)=")") and mid(testimsi2,8,1)="-" then	'031-214-0833
		imsitel11 = left(testimsi2,3)
		imsitel22 = mid(testimsi2,5,3)
		imsitel33 = right(testimsi2,4)
	else
		imsitel11 = "000"
		imsitel22 = "000"
		imsitel33 = "0000"
	end if
	
	'2011-06-01 : 비밀번호, 가상계좌은행, 가상계좌번호
	If isnull(xRs(15)) Then 
		soundfile = ""
	Else
		soundfile = xRs(15)
		If Len(soundfile) > 2 Then
			soundfile = Left(soundfile, 2)
		End If 
	End If 
	
	imsibank = xRs(16)
	imsiaccount = xRs(17)
	
	imsiemail = xRs(18)
    
    imsibank4 = xRs(19)
	imsiaccount4 = xRs(20)
    imsibank5 = xRs(21)
	imsiaccount5 = xRs(22)
    imsibank6 = xRs(23)
	imsiaccount6 = xRs(24)

	SQL = "INSERT INTO tb_company(idx,tcode,flag,bidxsub,idxsub,idxsubname,comname,name,post,addr,addr2,companynum1,companynum2,companynum3,uptae,upjong,orderreg,"
	SQL = SQL & " tel1,tel2,tel3,fax1,fax2,fax3,hp1,hp2,hp3,dcarno,startday,vatflag,taxtitle,juminno1,juminno2,homepage,usegubun,usemoney,soundfile,fileregcode,wdate,wuserid,email,virtual_acnt,virtual_acnt_bank,"
    SQL = SQL & "virtual_acnt4,virtual_acnt4_bank,virtual_acnt5,virtual_acnt5_bank,virtual_acnt6,virtual_acnt6_bank) VALUES "
	SQL = SQL & " (dbo.getIDXfromTB_Company(),'"& xRs(0) &"',"
	SQL = SQL & " '"& flag &"',"
	SQL = SQL & " "& bidxsub &","
	SQL = SQL & " "& idxsub &","
	SQL = SQL & " '"& idxsubname &"',"
	SQL = SQL & " '"& xRs(1) &"',"
	SQL = SQL & " '"& xRs(2) &"',"
	SQL = SQL & " '"& replace(xRs(4)," ","") &"', "
	SQL = SQL & " '"& xRs(5) &"', "
	SQL = SQL & " '"& xRs(6) &"', "
	SQL = SQL & " '"& left(xRs(3),3) &"', "
	SQL = SQL & " '"& mid(xRs(3),5,2) &"', "
	SQL = SQL & " '"& right(xRs(3),5) &"', "
	SQL = SQL & " '"& xRs(7) &"', "
	SQL = SQL & " '"& xRs(8) &"', "
	SQL = SQL & " '"& orderreg &"', "

	SQL = SQL & " '"& imsitel1 &"', "
	SQL = SQL & " '"& imsitel2 &"', "
	SQL = SQL & " '"& imsitel3 &"', "
	SQL = SQL & " '"& fax1 &"', "
	SQL = SQL & " '"& fax2 &"', "
	SQL = SQL & " '"& fax3 &"', "
	SQL = SQL & " '"& imsitel11 &"', "
	SQL = SQL & " '"& imsitel22 &"', "
	SQL = SQL & " '"& imsitel33 &"', "
	SQL = SQL & "  "& dcarno &", "
	SQL = SQL & " "& startday &", "
	SQL = SQL & " '"& vatflag &"', "
	SQL = SQL & " '"& taxtitle &"', "
	SQL = SQL & " '"& juminno1 &"', "
	SQL = SQL & " '"& juminno2 &"', "
	SQL = SQL & " '"& homepage &"', "
	SQL = SQL & " '"& usegubun &"', "
	SQL = SQL & " "& usemoney &", "
	SQL = SQL & " '"& soundfile &"', "
	SQL = SQL & " '"& xRs(12) &"', "
	SQL = SQL & " '"& now() &"', "
	SQL = SQL & " '"& session("Auserid") &"',"
	SQL = SQL & " '"& imsiemail &"', "
	SQL = SQL & " '"& imsiaccount &"', "
	SQL = SQL & " '"& imsibank &"',"
    SQL = SQL & " '"& imsiaccount4 &"', "
	SQL = SQL & " '"& imsibank4 &"',"
    SQL = SQL & " '"& imsiaccount5 &"', "
	SQL = SQL & " '"& imsibank5 &"',"
    SQL = SQL & " '"& imsiaccount6 &"', "
	SQL = SQL & " '"& imsibank6 &"' )"
	db.Execute SQL


xRs.moveNext
i=i+1
loop

	if errorflag="1" then
		imsimsg = imsiline&"라인에 체인점코드 "&imsitcode&"가 중복됩니다."
	elseif errorflag="2" then
		imsimsg = imsiline&"라인에 등록된 "&imsicarno&" 호차가 없습니다."
	elseif errorflag="3" then
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

