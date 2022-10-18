<%
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile filepathname,true 
	Set objFile = fs.OpenTextFile(filepathname,8)

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag"
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C, tb_product d"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"
	SQL = sql & " AND B.idx = C.idx"
	SQL = sql & " AND c.pcode = d.pcode"
     SQL = sql & " AND ISNULL(B.Rgubun,0) != 1 "
	if cbrandchoice<>"" then
		sql = sql & " AND a.cbrandchoice='"& cbrandchoice &"' "
		sql = sql & " AND (d.cbrandchoice='00000' "
		sql = sql & " or d.cbrandchoice like '%"& cbrandchoice &"%') "
	end if

	SQL = sql & " AND B.flag = 'y'"
	SQL = sql & " AND B.deflag = 'n'"
	SQL = sql & " AND C.flag = 'F'"
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " group by A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag"
	SQL = sql & " order by C.pidx"
	rs.Open sql, db, 1

	if not rs.eof then

		order_num = 0
		imsiorderidx_old = ""
		count_num = 0
		r=0
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
			if r=0 then
				imsipidxArray = trim(rs("pidx"))
			else
				imsipidxArray = imsipidxArray &","& trim(rs("pidx"))
			end if
			'''''''''''''''''''''''''''''''''''''''''''''
			if rs("rordernum")>0 then
				str = ""
				onlen = len(Trim(rs("rordernum")))
				onlen1 = 5-onlen
				for i = 1 to onlen1
					str = str & " "
				next
				ordernum = Trim(rs("rordernum")) & str

				objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum)
			end if
			yyyymmdd = rs("idx")
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