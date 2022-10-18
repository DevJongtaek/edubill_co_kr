<%
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile filepathname,true 
	Set objFile = fs.OpenTextFile(filepathname,8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT substring(c.idx,1,8) as idx, C.pcode, C.rordernum as rordernum,b.usercode,c.idx as imsidx ,c.pidx, isnull(b.request_day,'') as request_day"
	SQL = sql & " FROM tb_company a, tb_order B, tb_order_product C"
	SQL = sql & " WHERE B.idx = C.idx AND C.flag = 'F' "
	SQL = sql & " AND A.idx = right(B.usercode, 5) "
	SQL = sql & " AND substring(b.usercode,1,5) = '" & left(session("Ausercode"),5) & "'" 
	SQL = sql & " AND a.mi_money <=0 "
     SQL = sql & " AND ISNULL(B.Rgubun,0) != 1 "
	SQL = sql & " order by b.usercode asc, c.pcode asc"
	
	'response.write sql
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

      set rs2 = server.CreateObject("ADODB.Recordset")
				SQL = "select  count(SetMenuItems) from tb_product "
				SQL = sql & " where usercode = '" & left(session("Ausercode"),5) & "' "
				SQL = sql & " and fileregcode = '" & fileregcode2 & "' "	'상품정보
				SQL = sql & " and SetMenuItems  != ''"
				rs2.Open sql, db, 1
			
						if not rs2.eof Then
							If rs2(0) > 0 Then 
							SetmenuYN = "Y"
							else 
							SetmenuYn = "N"
				      end if
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
				
				if SetmenuYn = "N" then
				objFile.writeLine(LEFT(Trim(rs("idx")),8) & imsitab & fileregcode & imsitab & fileregcode2 & imsitab & trim(rs("rordernum")) & imsitab & "ZU01" & imsitab & request_day)
				
				else
				
				    '세트 상품 추가
    				set rsSet = server.CreateObject("ADODB.Recordset")
    				SQL = "select SetMenuItems from tb_product "
    				SQL = sql & " where usercode = '" & left(session("Ausercode"),5) & "' "
    				SQL = sql & " and fileregcode = '" & fileregcode2 & "' "	'상품정보
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
    								
    								set rs2 = server.CreateObject("ADODB.Recordset")
            				SQL = "SELECT fileregcode from tb_product where usercode = '"& left(session("Ausercode"),5) &"' and pcode = '"& rsSetCodeList(q) &"' "
            				rs2.Open sql, db, 1
            				if not rs2.eof then
            					fileregcode3 = rs2("fileregcode")
            				end if
            				rs2.close
    				
    				
    								objFile.writeLine(LEFT(Trim(rs("idx")),8) & imsitab & fileregcode & imsitab & fileregcode3 & imsitab & trim(rs("rordernum")) & imsitab & "ZU01" & imsitab & request_day)
    								
    							End If 
    						End If 
    						rsSet.close
    					Next 
    				End If 
				end if
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