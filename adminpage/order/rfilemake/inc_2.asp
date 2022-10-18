<%
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile filepathname,true 
	Set objFile = fs.OpenTextFile(filepathname,8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT max(substring(c.idx,1,8)) as idx, C.pcode, sum(C.rordernum) as rordernum,b.usercode,max(c.idx) as imsidx ,c.pidx"
	SQL = sql & " FROM tb_order B, tb_order_product C"
	SQL = sql & " WHERE B.idx = C.idx "
	SQL = sql & " AND C.flag = 'T'"				'초기값 : T
	SQL = sql & " AND substring(C.idx,1,14) >= '"& searchaa &"' and substring(C.idx,1,14) <= '"& searchcc &"' "
	SQL = sql & " AND substring(b.usercode,1,5) = '" & left(session("Ausercode"),5) & "'" 
     SQL = sql & " AND ISNULL(B.Rgubun,0) != 1 "
	SQL = sql & " group by C.pcode,substring(c.idx,1,8),b.usercode,c.pidx" 
	SQL = sql & " order by b.usercode asc, c.pcode asc"
	rs.Open sql, db, 1

	if not rs.eof then
		imsitab = chr(9)
		order_num = 0
		imsiorderidx_old = ""
		count_num = 0
		Do Until rs.EOF
			'''''''''''''''''''''''''''''''''''''''''''''
			imsiorderidx_new = rs("imsidx") 
			if imsiorderidx_new<>imsiorderidx_old then
				imsiorderidx_old = rs("imsidx")
				order_num = order_num+1
			end if
			if count_num=0 then
				yyyymmdd1 = left(rs("imsidx") ,14)
			end if
			'''''''''''''''''''''''''''''''''''''''''''''
			if rs("rordernum")>0 then
				fileregcode = ""
				fileregcode2 = ""

				set rs2 = server.CreateObject("ADODB.Recordset")
				SQL = "SELECT fileregcode from tb_company where bidxsub = '"& left(rs("usercode"),5) &"' and idx = '"& right(rs("usercode"),5) &"' "
				rs2.Open sql, db, 1
				if not rs2.eof then
					fileregcode = rs2("fileregcode")
				end if
				rs2.close

				set rs2 = server.CreateObject("ADODB.Recordset")
				SQL = "SELECT fileregcode from tb_product where usercode = '"& left(session("Ausercode"),5) &"' and pcode = '"& rs("pcode") &"' "
				rs2.Open sql, db, 1
				if not rs2.eof then
					fileregcode2 = rs2("fileregcode")
				end if
				rs2.close

				objFile.writeLine(LEFT(Trim(rs("idx")),8) & imsitab & fileregcode & imsitab & fileregcode2 & imsitab & trim(rs("rordernum")) & imsitab &"ZU01")
			end if

			yyyymmdd = left(rs("imsidx") ,14)
		rs.MoveNext
		count_num = count_num+1
		Loop
	else
		call FunErrorMsg("해당 자료가 없습니다.")
	end if
	objFile.close
%>