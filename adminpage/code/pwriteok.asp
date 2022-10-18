<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	Set upload = Server.CreateObject("DEXT.FileUpload") 
	upload.DefaultPath = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\pr_image"

	if upload("bfile2") <> "" then
		filename = upload("bfile2").FileName
		filepath = upload.DefaultPath & "\" & filename

		createfolder = upload.DefaultPath & "\" & upload("BonsaTcode")
  		Set FSO = Server.CreateObject("Scripting.FileSystemObject")
    		If Not(FSO.FolderExists(createfolder)) Then
    			FSO.CreateFolder(createfolder)
    		end if
		filepath = createfolder & "\" & filename

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

      				filepath =  createfolder & "\" & filenameonly & "[" & i & "]" & fileext

      				If Not upload.FileExists(filepath) Then Exit Do 
					i = i + 1
			Loop
		End If

		upload("bfile2").SaveAs filepath
		Filename1 = Mid(filepath,instrRev(filepath,"\")+1)
		file_width1 = upload("bfile2").ImageWidth 
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	searcha = upload("searcha")
	searchb = upload("searchb")
	gotopage = upload("gotopage")
	idx = upload("idx")
	dflag = upload("dflag")

	pcode = replace(upload("pcode"),"'","''")
	pname = replace(upload("pname"),"'","''")
	old_pname = replace(upload("old_pname"),"'","''")
	pprice = upload("pprice")
	ptitle = replace(upload("ptitle"),"'","''")
	gubun = replace(upload("gubun"),"'","''")
	bigo = replace(upload("bigo"),"'","''")
	soundfile = replace(upload("soundfile"),"'","''")
	fileregcode = replace(upload("fileregcode"),"'","''")
	old_fileregcode = replace(upload("old_fileregcode"),"'","''")
	fileflag = upload("fileflag")
	fileflagchb = upload("fileflagchb")
	'상품주문 요일
	order_weekchoice1 = upload("order_weekchoice1")
	order_weekchoice2 = upload("order_weekchoice2")
	order_weekchoice3 = upload("order_weekchoice3")
	order_weekchoice4 = upload("order_weekchoice4")
	order_weekchoice5 = upload("order_weekchoice5")
	order_weekchoice6 = upload("order_weekchoice6")
	order_weekchoice7 = upload("order_weekchoice7")
	order_weekchoice = order_weekchoice1&order_weekchoice2&order_weekchoice3&order_weekchoice4&order_weekchoice5&order_weekchoice6&order_weekchoice7
	'세트메뉴
	setmenuitems = upload("setmenuitems")
    Returnyn = upload("chkReturnyn")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select productorderweek from tb_company where idx = '"& left(session("Ausercode"),5) &"' "
	rs.Open sql, db, 1
	productorderweek = rs(0)
	rs.close 

	If productorderweek = "n" then
		order_weekchoice = "1234567"
	End If 

	if pprice="" then
		pprice = 0
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if fileflag="a" and fileflagchb="y" then
		if idx="" then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select isnull(count(idx),0) from tb_product where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' and fileregcode = '"& fileregcode &"' "
			rs.Open sql, db, 1
			errorcnt = rs(0)
			rs.close
		else
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select isnull(count(a.idx),0) from (select * from tb_product where idx <> "& idx &") a where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' and a.fileregcode = '"& fileregcode &"' "
			rs.Open sql, db, 1
			errorcnt = rs(0)
			rs.close
		end if
		if errorcnt>0 then
%>
			<script language="javascript">
				alert("파일생성코드가 중복됩니다.\n\n다른 파일생성코드를 입력해 주시기 바랍니다.")
				history.back();
			</script>
<%
			response.end
		end if
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	cbrandchoice = replace(upload("cbrandchoice")," ","")
	cbrandchoice_all = replace(upload("cbrandchoice_all")," ","")
	if cbrandchoice_all <> "" then
		cbrandchoice = "00000"
	end if
	if cbrandchoice_all = "" and cbrandchoice = "" then
		cbrandchoice = "00000"
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	dcenterchoice = replace(upload("dcenterchoice")," ","")
	dcenterchoice_all = replace(upload("dcenterchoice_all")," ","")
	if dcenterchoice_all <> "" then
		dcenterchoice = "00000"
	end if
	if dcenterchoice_all = "" and dcenterchoice = "" then
		dcenterchoice = "00000"
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	proout = replace(upload("proout"),"'","''")
	if proout="" then
		proout="y"
	end if

	qty = upload("qty")
	if qty="" then
		qty = "Q100"
	end if

	prochoice = upload("prochoice")

	select case idx
		case ""

			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select count(idx) "
			SQL = sql & " from tb_product "
			SQL = sql & " where usercode = '"& session("Ausercode") &"' "
			SQL = sql & " and pcode = '"& pcode &"' "
			rs.Open sql, db, 1
			imsicount = rs(0)
			rs.close

			if imsicount = 0 then
				SQL = "INSERT INTO tb_product(usercode,pcode,pname,pprice,ptitle,gubun,bigo,soundfile,fileregcode,wdate,wuserid,cbrandchoice,proout,qty_code,prochoice,proimage,dcenterchoice,Order_WeekChoice,ReturnYn,setmenuitems) VALUES "
				SQL = SQL & " ('"& session("Ausercode") &"',"
				SQL = SQL & " '"& pcode &"',"
				SQL = SQL & " '"& pname &"',"
				SQL = SQL & " "& pprice &","
				SQL = SQL & " '"& ptitle &"', "
				SQL = SQL & " '"& gubun &"', "
				SQL = SQL & " '"& bigo &"', "
				SQL = SQL & " '"& soundfile &"', "
				SQL = SQL & " '"& fileregcode &"', "
				SQL = SQL & " '"& now() &"', "
				SQL = SQL & " '"& session("Auserid") &"',"
				SQL = SQL & " '"& cbrandchoice &"',"
				SQL = SQL & " '"& proout &"',"
				SQL = SQL & " '"& qty &"',"
				SQL = SQL & " '"& prochoice &"',"
				SQL = SQL & " '"& Filename1 &"',"
				SQL = SQL & " '"& dcenterchoice &"',"
				SQL = SQL & " '"& order_weekchoice &"',"
                SQL = SQL & " '"& Returnyn &"',"
				SQL = SQL & " '"& setmenuitems &"')"
				db.Execute SQL

				'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				flag = "상품"
				gubun = "추가"
				code = pcode
				content = pname
				SQL = "INSERT INTO tb_log(wdate,userid,usercode,flag,gubun,code,content) VALUES "
				SQL = SQL & " ('"& now() &"',"
				SQL = SQL & " '"& session("Auserid") &"',"
				SQL = SQL & " '"& session("Ausercode") &"',"
				SQL = SQL & " '"& flag &"', "
				SQL = SQL & " '"& gubun &"', "
				SQL = SQL & " '"& code &"', "
				SQL = SQL & " '"& content &"') "
				db.Execute SQL
				'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			else
%>
				<script language="javascript">
					alert("상품코드가 중복됩니다.\n\n상품코드를 올바르게 입력해 주시기 바랍니다.")
					history.back();
				</script>
<%
				response.end
			end if

		case else
			select case dflag
				case ""
					SQL = "update tb_product set "
					SQL = SQL & " pname = '"& pname &"' ,"
					SQL = SQL & " pprice = "& pprice &" ,"
					SQL = SQL & " ptitle = '"& ptitle &"', "
					SQL = SQL & " gubun = '"& gubun &"', "
					SQL = SQL & " bigo = '"& bigo &"', "
					SQL = SQL & " soundfile = '"& soundfile &"', "
					SQL = SQL & " fileregcode = '"& fileregcode &"', "
					SQL = SQL & " proout = '"& proout &"', "
					SQL = SQL & " qty_code = '"& qty &"', "
					SQL = SQL & " edate = '"& now() &"', "
					SQL = SQL & " cbrandchoice = '"& cbrandchoice &"', "
					SQL = SQL & " dcenterchoice = '"& dcenterchoice &"', "
					SQL = SQL & " prochoice = '"& prochoice &"', "
					SQL = SQL & " Order_WeekChoice = '"& order_weekchoice &"', "
					SQL = SQL & " setmenuitems = '"& setmenuitems &"', "
                    SQL = SQL & " ReturnYn='" & Returnyn &"',"

					if Filename1<>"" then
						SQL = SQL & " proimage = '"& Filename1 &"', "
					end if

					SQL = SQL & " euserid = '"& session("Auserid") &"' "
					SQL = SQL & " where idx = "& idx
					db.Execute SQL
	
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					flag = "상품"
					gubun = "수정"
					code = pcode
					content = pname
					'''''''''''''''''''''''''''''''''''''''''
					if old_pname<>pname then
						gubun = "추가"
					end if
					'''''''''''''''''''''''''''''''''''''''''
					SQL = "INSERT INTO tb_log(wdate,userid,usercode,flag,gubun,code,content) VALUES "
					SQL = SQL & " ('"& now() &"',"
					SQL = SQL & " '"& session("Auserid") &"',"
					SQL = SQL & " '"& session("Ausercode") &"',"
					SQL = SQL & " '"& flag &"', "
					SQL = SQL & " '"& gubun &"', "
					SQL = SQL & " '"& code &"', "
					SQL = SQL & " '"& content &"') "
					db.Execute SQL
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				case "1"
					SQL = "delete tb_product "
					SQL = SQL & " where idx = "& idx
					db.Execute SQL

					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					flag = "상품"
					gubun = "삭제"
					code = pcode
					content = pname
					SQL = "INSERT INTO tb_log(wdate,userid,usercode,flag,gubun,code,content) VALUES "
					SQL = SQL & " ('"& now() &"',"
					SQL = SQL & " '"& session("Auserid") &"',"
					SQL = SQL & " '"& session("Ausercode") &"',"
					SQL = SQL & " '"& flag &"', "
					SQL = SQL & " '"& gubun &"', "
					SQL = SQL & " '"& code &"', "
					SQL = SQL & " '"& content &"') "
					db.Execute SQL
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			end select

	end select

	db.close
	set db=nothing
   
	response.redirect "plist.asp?gotopage="&gotopage
    
    '&"&searcha="&searcha&"&searchb="&searchb
%>
