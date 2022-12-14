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
     SQL = sql & " AND ISNULL(B.Rgubun,0) != 1 "
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

	if rsarrayint <> "" then
		'''''''''''''''''''''''''
		order_num        = 0
		imsiorderidx_old = ""
		count_num        = 0
		'''''''''''''''''''''''''
		for r=0 to rsarrayint
			'''''''''''''''''''''''''''''''''''''''''''''
			imsiorderidx_new = trim(rsarray(2,r))
			if imsiorderidx_new<>imsiorderidx_old then
				imsiorderidx_old = trim(rsarray(2,r))
				order_num        = order_num+1
			end if
			if count_num=0 then
				yyyymmdd1 = trim(rsarray(2,r))
			end if
			'''''''''''''''''''''''''''''''''''''''''''''
			if r=0 then
				imsipidxArray = trim(rsarray(1,r))
			else
				imsipidxArray = imsipidxArray &","& trim(rsarray(1,r))
			end if
			'''''''''''''''''''''''''''''''''''''''''''''
			if trim(rsarray(5,r)) > 0 then
				str = ""
				onlen = len(Trim(rsarray(5,r)))
				onlen1 = 5-onlen
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				for i = 1 to onlen1
					str = str & " "
				next
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				ordernum = Trim(rsarray(5,r)) & str
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				
				
				 set rs2 = server.CreateObject("ADODB.Recordset")
				SQL = "select  count(SetMenuItems) from tb_product "
				SQL = sql & " where usercode = '" & left(session("Ausercode"),5) & "' "
				SQL = sql & " and pcode = '" & trim(rsarray(4,r)) & "' "	'상품정보
				SQL = sql & " and SetMenuItems  != ''"
				rs2.Open sql, db, 1
		'	response.write sql
						if not rs2.eof Then
							If rs2(0) > 0 Then 
							SetmenuYN = "Y"
							else 
							SetmenuYn = "N"
				      end if
				    end if
				   '  response.write rs2(0)
				rs2.close
       
      
       	if SetmenuYn = "N" then
				
				if imsifileflag="8" then
					str = ""
					if Trim(rsarray(7,r)) <> "" then
						onlen = len(Trim(rsarray(7,r)))
						onlen1 = 4-onlen
						for i = 1 to onlen1
							str = str & " "
						next
						request_day = Trim(rsarray(7,r)) & str
					else
						request_day = "    "
					end if
					objFile.writeLine(LEFT(trim(rsarray(2,r)),14) & trim(rsarray(3,r)) & trim(rsarray(4,r)) & ordernum & request_day)
				else
					objFile.writeLine(LEFT(trim(rsarray(2,r)),14) & trim(rsarray(3,r)) & trim(rsarray(4,r)) & ordernum)
				end if
				'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				
				else
				'세트 상품 추가
				set rsSet = server.CreateObject("ADODB.Recordset")
				SQL = "select SetMenuItems from tb_product "
				SQL = sql & " where usercode = '" & left(session("Ausercode"),5) & "' "
				SQL = sql & " and pcode = '" & trim(rsarray(4,r)) & "' "	'상품정보
				'response.write sql
				rsSet.Open sql, db, 1
				if not rsSet.eof then
					rsSetCodes    = rsSet(0)
					If rsSetCodes <> "" Then 
						rsSetCodeList = Split(rsSetCodes,",")
						rsSetarrayint = ubound(rsSetCodeList,1)
					Else 
						rsSetCodes = ""
						rsSetarrayint = 0
					End If 
				else
					rsSetCodes    = ""
					rsSetarrayint = 0
				end if
				rsSet.close
				If rsSetCodes <> "" Then 
					For q = 0 To rsSetarrayint
						'상품코드 유무 체크
						set rsSet = server.CreateObject("ADODB.Recordset")
						SQL = "select count(pcode) from tb_product "
						SQL = sql & " where usercode = '" & left(session("Ausercode"),5) & "' "
						SQL = sql & " and pcode = '" & rsSetCodeList(q) & "' "	'상품정보
						rsSet.Open sql, db, 1
						if not rsSet.eof Then
							If rsSet(0) > 0 Then 
								if imsifileflag="8" Then
									objFile.writeLine(LEFT(trim(rsarray(2,r)),14) & trim(rsarray(3,r)) & trim(rsSetCodeList(q)) & ordernum & request_day)
								Else 
									objFile.writeLine(LEFT(trim(rsarray(2,r)),14) & trim(rsarray(3,r)) & trim(rsSetCodeList(q)) & ordernum)
								End If 
							End If 
						End If 
						rsSet.close
					Next 
				End If 
				
				
				end if
				
				
				
			end if
			
			
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'수량0개도 포함
			'USql = "Update tb_order_product Set flag = 'T', flagidx = '"& filename &"' "
			'USql = Usql & " where pidx = "& trim(rsarray(1,r))
			'db.execute(USql)
			yyyymmdd = trim(rsarray(2,r))
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			count_num = count_num+1
		next
		objFile.close
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		USql = "Update tb_order_product Set flag = 'T', flagidx = '"& filename &"' "
		USql = Usql & " where pidx in ( "& imsipidxArray &" ) "
		db.execute(USql)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		objFile.close
		call FunErrorMsg("해당 자료가 없습니다.")
	end if

%>