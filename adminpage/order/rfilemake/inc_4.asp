<%
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	filename     = imsifnow &".xls"	'파일명
	filepath     = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\txt\rmake\"	'파일경로
	filepathname = filepath&filename
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag, isnull(b.request_day,'') as request_day, B.orderday,B.carname,A.fileregcode,D.fileregcode "
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C, tb_product D"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"	'체인점정보
	SQL = sql & " AND B.idx = C.idx"			'주문자/주문상품 정보
	SQL = sql & " AND C.pcodeidx = D.idx"
	SQL = sql & " AND C.flag = 'T'"				'초기값 : T
	SQL = sql & " AND substring(C.idx,1,14) >= '"& searchaa &"' and substring(C.idx,1,14) <= '"& searchcc &"' "
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 	'체인점정보
     SQL = sql & " AND ISNULL(B.Rgubun,0) != 1 "
	if session("Ausergubun")="3" then
		SQL = sql & " AND substring(b.usercode,1,10) = '" & session("Ausercode") & "'" 
	end if
	SQL = sql & " order by B.idx asc"
	rs.Open sql, db, 1
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if not rs.eof then
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
		order_num = 0
		imsiorderidx_old = ""
		count_num = 0
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		r=0
		Do Until rs.EOF
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			imsiorderidx_new = rs("idx") 
			if imsiorderidx_new<>imsiorderidx_old then
				imsiorderidx_old = rs("idx")
				order_num = order_num+1
			end if
			if count_num=0 then yyyymmdd1 = left(rs("idx") ,14)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			ex_orderday  = trim(rs(8))
			ex_cTcode    = trim(rs(3))
			ex_pcode     = trim(rs(4))
			ex_rordernum = trim(rs(5))
			ex_carname   = trim(rs(9))
			ex_cTcode2   = trim(rs(10))
			ex_pcode2    = trim(rs(11))
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			if count_num=0 then objFile.writeLine(imsilinetxt1)
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
			yyyymmdd = left(rs("idx"),14)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		rs.MoveNext
		count_num = count_num+1
		Loop
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		objFile.writeLine(imsilinetxt2)
		objFile.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		call FunErrorMsg("해당 자료가 없습니다.")
	end if

%>