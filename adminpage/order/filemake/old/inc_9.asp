<%
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile filepathname,true 
	Set objFile = fs.OpenTextFile(filepathname,8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT substring(c.idx,1,8) as idx, C.pcode, C.rordernum as rordernum,b.usercode,c.idx as imsidx ,c.pidx, isnull(b.request_day,'') as request_day"
	SQL = sql & " FROM tb_order B, tb_order_product C"
	SQL = sql & " WHERE B.idx = C.idx AND C.flag = 'F' "
	SQL = sql & " AND substring(b.usercode,1,5) = '" & left(session("Ausercode"),5) & "'" 
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
				yyyymmdd1 = rs("imsidx") 
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

				str = ""
				if rs("request_day")<>"" then
					onlen = len(Trim(rs("request_day")))
					onlen1 = 4-onlen
					for i = 1 to onlen1
						str = str & "0"
					next
					request_day = Trim(rs("request_day")) & str
				else
					request_day = "0000"
				end if
				objFile.writeLine(LEFT(Trim(rs("idx")),8) & imsitab & fileregcode & imsitab & fileregcode2 & imsitab & trim(rs("rordernum")) & imsitab & "ZU01" & imsitab & request_day)
			end if

			USql = "Update tb_order_product Set flag = 'T', flagidx = '"& filename &"' "
			USql = Usql & " where pidx = "& rs("pidx")
			db.execute(USql)
			yyyymmdd = rs("imsidx")
		rs.MoveNext
		count_num = count_num+1
		Loop
	else
		call FunErrorMsg("해당 자료가 없습니다.")
	end if
	objFile.close
%>