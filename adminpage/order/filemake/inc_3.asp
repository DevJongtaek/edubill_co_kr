<%
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile filepathname,true 
	Set objFile = fs.OpenTextFile(filepathname,8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT max(substring(c.idx,1,8)) as idx, C.pcode, sum(C.rordernum) as rordernum,b.usercode,max(c.idx) as imsidx ,c.pidx"
	SQL = sql & " FROM tb_order B, tb_order_product C"
	SQL = sql & " WHERE B.idx = C.idx AND C.flag = 'F' "
	SQL = sql & " AND b.flag = 'y' "
	SQL = sql & " AND b.deflag = 'n' "
	SQL = sql & " AND substring(b.usercode,1,5) = '" & left(session("Ausercode"),5) & "'" 
     SQL = sql & " AND ISNULL(B.Rgubun,0) != 1 "
	SQL = sql & " group by C.pcode,substring(c.idx,1,8),b.usercode,c.pidx" 
	'SQL = sql & " group by C.pcode,substring(c.idx,1,8),b.usercode" 
	SQL = sql & " order by imsidx asc, b.usercode asc, c.pcode asc"
	rs.Open sql, db, 1

	if not rs.eof then
		imsitab = chr(9)
		order_num = 0
		imsiorderidx_old = ""
		count_num = 0
		r=0
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
			if r=0 then
				imsipidxArray = trim(rs("pidx"))
			else
				imsipidxArray = imsipidxArray &","& trim(rs("pidx"))
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

				imsipday = LEFT(Trim(rs("idx")),8)
				imsipday = LEFT(imsipday,4)&"-"&mid(imsipday,5,2)&"-"&right(imsipday,2)
				imsipday = cdate(imsipday)+1
				imsipday2 = Weekday(imsipday)
				'1:일요일 ~ 7:토요일
				if imsipday2="1" then
					imsipday = cdate(imsipday)+1
				end if
				imsipday = replace(imsipday,"-","")

				objFile.writeLine(imsipday & imsitab & fileregcode & imsitab & fileregcode2 & imsitab & trim(rs("rordernum")) & imsitab &"ZU01")
			end if
			yyyymmdd = rs("imsidx")
		rs.MoveNext
		count_num = count_num+1
		r=r+1
		Loop

		USql = "Update tb_order_product Set flag = 'T', flagidx = '"& filename &"' "
		USql = Usql & " where pidx in ( "& imsipidxArray &" ) "
		db.execute(USql)
	else
		call FunErrorMsg("해당 자료가 없습니다.")
	end if
	objFile.close
%>