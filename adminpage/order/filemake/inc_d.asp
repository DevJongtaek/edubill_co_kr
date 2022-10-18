<%
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	filename     = imsifnow &".xls"	'파일명
	filepath     = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\txt\"	'파일경로
	filepathname = filepath&filename
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	'SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag, isnull(b.request_day,'') as request_day "
	SQL = "SELECT  A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag, isnull(b.request_day,'') as request_day, B.orderday,B.carname,A.fileregcode, D.fileregcode "
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C, tb_product D"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"	'체인점정보
	SQL = sql & " AND B.idx = C.idx"			'주문자/주문상품 정보
	SQL = sql & " AND C.pcodeidx = D.idx"
	SQL = sql & " AND C.flag = 'F'"				'초기값 : F
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 	'체인점정보
     SQL = sql & " AND ISNULL(B.Rgubun,0) != 1 "
    SQL = sql & " AND B.flag = 'y' " 
	if session("Ausergubun")="3" then
		SQL = sql & " AND substring(b.usercode,1,10) = '" & session("Ausercode") & "'" 
	end if
	SQL = sql & " order by B.idx asc"
'response.write sql
	rs.Open sql, db, 1
	if not rs.eof then
		rsarray    = rs.GetRows
		rsarrayint = ubound(rsarray,2)
	else
		rsarray    = ""
		rsarrayint = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if rsarrayint <> "" then
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		Set fs = Server.CreateObject("Scripting.FileSystemObject")
		fs.CreateTextFile filepathname,true 
		Set objFile = fs.OpenTextFile(filepathname,8) 
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		imsilinetxt1 = "<meta http-equiv=""Content-Type"" content=""text/html; charset=euc-kr""> "
		imsilinetxt1 = imsilinetxt1 & "<style type='text/css'> "
		imsilinetxt1 = imsilinetxt1 & "<!-- "
		imsilinetxt1 = imsilinetxt1 & "td.accountnum{ "
		imsilinetxt1 = imsilinetxt1 & "mso-number-format:\@} "
		imsilinetxt1 = imsilinetxt1 & "--> "
		imsilinetxt1 = imsilinetxt1 & "</STYLE> "
		imsilinetxt1 = imsilinetxt1 & "<table border=1><tr align=center>"
		imsilinetxt1 = imsilinetxt1 & "<td>주문일자</tD>"
		imsilinetxt1 = imsilinetxt1 & "<td>체인점코드</tD>"
		imsilinetxt1 = imsilinetxt1 & "<td>체인화일생성코드</tD>"
		imsilinetxt1 = imsilinetxt1 & "<td>상품코드</tD>"
		imsilinetxt1 = imsilinetxt1 & "<td>상품화일생성코드</tD>"
		imsilinetxt1 = imsilinetxt1 & "<td>수량</tD>"
		imsilinetxt1 = imsilinetxt1 & "<td>호차</tD>"
		imsilinetxt1 = imsilinetxt1 & "</tr>"
		imsilinetxt2 = "</table>"
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		order_num        = 0
		imsiorderidx_old = ""
		count_num        = 0
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		for r=0 to rsarrayint
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			imsiorderidx_new = trim(rsarray(2,r))
			if imsiorderidx_new<>imsiorderidx_old then
				imsiorderidx_old = trim(rsarray(2,r))
				order_num        = order_num+1
			end if
			if count_num=0 then yyyymmdd1 = trim(rsarray(2,r))
			if r=0 then
				imsipidxArray = trim(rsarray(1,r))
			else
				imsipidxArray = imsipidxArray &","& trim(rsarray(1,r))
			end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			ex_orderday  = trim(rsarray(8,r))
			ex_cTcode    = trim(rsarray(3,r))
			ex_pcode     = trim(rsarray(4,r))
			ex_rordernum = trim(rsarray(5,r))
			ex_carname   = trim(rsarray(9,r))
			ex_cTcode2   = trim(rsarray(10,r))
			ex_pcode2    = trim(rsarray(11,r))
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			if r=0 then objFile.writeLine(imsilinetxt1)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			imsiline = "<tr align=center>"
			imsiline = imsiline & "<td class='accountnum'>" & ex_orderday & "</td>"
			imsiline = imsiline & "<td class='accountnum'>" & ex_cTcode & "</td>"
			imsiline = imsiline & "<td class='accountnum'>" & ex_cTcode2 & "</td>"
			imsiline = imsiline & "<td class='accountnum'>" & ex_pcode & "</td>"
			imsiline = imsiline & "<td class='accountnum'>" & ex_pcode2 & "</td>"
			imsiline = imsiline & "<td class='accountnum'>" & ex_rordernum & "</td>"
			imsiline = imsiline & "<td class='accountnum'>" & ex_carname & "</td>"
			imsiline = imsiline & "</tr>"
			objFile.writeLine(imsiline)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			if r=rsarrayint then objFile.writeLine(imsilinetxt2)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			yyyymmdd = trim(rsarray(2,r))
			count_num = count_num+1
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		next
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		objFile.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		USql = "Update tb_order_product Set flag = 'T', flagidx = '"& filename &"' "
		USql = Usql & " where pidx in ( "& imsipidxArray &" ) "
		db.execute(USql)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		call FunErrorMsg("해당 자료가 없습니다.")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

%>