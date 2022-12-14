<%
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile filepathname,true 
	Set objFile = fs.OpenTextFile(filepathname,8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag, isnull(b.request_day,'') as request_day "
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"	'체인점정보
	SQL = sql & " AND B.idx = C.idx"			'주문자/주문상품 정보
	SQL = sql & " AND C.flag = 'F'"				'초기값 : F
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 	'체인점정보
	if session("Ausergubun")="3" then
		SQL = sql & " AND substring(b.usercode,1,10) = '" & session("Ausercode") & "'" 
	end if
	SQL = sql & " order by B.idx asc"
'response.write sql
'response.end
	rs.Open sql, db, 1

	if not rs.eof then
		order_num = 0
		imsiorderidx_old = ""
		count_num = 0
		Do Until rs.EOF
			'''''''''''''''''''''''''''''''''''''''''''''
			imsiorderidx_new = rs("idx") 
			if imsiorderidx_new<>imsiorderidx_old then
				imsiorderidx_old = rs("idx")
				order_num = order_num+1
			end if
			if count_num=0 then
				yyyymmdd1 = rs("idx") 
			end if
			'''''''''''''''''''''''''''''''''''''''''''''
			if rs("rordernum") > 0 then
				str = ""
				onlen = len(Trim(rs("rordernum")))
				onlen1 = 5-onlen
				for i = 1 to onlen1
					str = str & " "
				next
				ordernum = Trim(rs("rordernum")) & str

				if imsifileflag="8" then
					str = ""
					if rs("request_day")<>"" then
						onlen = len(Trim(rs("request_day")))
						onlen1 = 4-onlen
						for i = 1 to onlen1
							str = str & " "
						next
						request_day = Trim(rs("request_day")) & str
					else
						request_day = "    "
					end if
					objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum & request_day)
				else
					objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum)
				end if
			end if

			'수량0개도 포함
			USql = "Update tb_order_product Set flag = 'T', flagidx = '"& filename &"' "
			USql = Usql & " where pidx = "& rs("pidx")
			db.execute(USql)
			yyyymmdd = rs("idx")

		rs.MoveNext
		count_num = count_num+1
		Loop
	else
		call FunErrorMsg("해당 자료가 없습니다.")
	end if
	objFile.close
%>