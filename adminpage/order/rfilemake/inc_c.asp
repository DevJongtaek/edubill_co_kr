<%
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile filepathname,true 
	Set objFile = fs.OpenTextFile(filepathname,8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag, isnull(b.request_day,'') as request_day "
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"	'ü��������
	SQL = sql & " AND B.idx = C.idx"			'�ֹ���/�ֹ���ǰ ����
	SQL = sql & " AND C.flag = 'T'"				'�ʱⰪ : T
	SQL = sql & " AND substring(C.idx,1,14) >= '"& searchaa &"' and substring(C.idx,1,14) <= '"& searchcc &"' "
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 	'ü��������
     SQL = sql & " AND ISNULL(B.Rgubun,0) != 1 "
	if session("Ausergubun")="3" then
		SQL = sql & " AND substring(b.usercode,1,10) = '" & session("Ausercode") & "'" 
	end if
	SQL = sql & " order by B.idx asc"
	
	'response.write Sql
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
				yyyymmdd1 = left(rs("idx") ,14)
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
        
        
      set rs2 = server.CreateObject("ADODB.Recordset")
				SQL = "select  count(SetMenuItems) from tb_product "
				SQL = sql & " where usercode = '" & left(session("Ausercode"),5) & "' "
				SQL = sql & " and pcode = '" & Trim(rs("pcode")) & "' "	'��ǰ����
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
				
				else
				'��Ʈ ��ǰ �߰�
				set rsSet = server.CreateObject("ADODB.Recordset")
				SQL = "select SetMenuItems from tb_product "
				SQL = sql & " where usercode = '" & left(session("Ausercode"),5) & "' "
				SQL = sql & " and pcode = '" & Trim(rs("pcode")) & "' "	'��ǰ����
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
						'��ǰ�ڵ� ���� üũ
						set rsSet = server.CreateObject("ADODB.Recordset")
						SQL = "select count(pcode) from tb_product "
						SQL = sql & " where usercode = '" & left(session("Ausercode"),5) & "' "
						SQL = sql & " and pcode = '" & rsSetCodeList(q) & "' "	'��ǰ����
						rsSet.Open sql, db, 1
						if not rsSet.eof Then
							If rsSet(0) > 0 Then 
								if imsifileflag="8" Then
								objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & trim(rsSetCodeList(q)) & ordernum & request_day)

								Else 

									objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & trim(rsSetCodeList(q)) & ordernum)
								End If 
							End If 
						End If 
						rsSet.close
					Next 
				End If
				
				 
				end if
				
			end if
			yyyymmdd = left(rs("idx"),14)

		rs.MoveNext
		count_num = count_num+1
		Loop
	else
		call FunErrorMsg("�ش� �ڷᰡ �����ϴ�.")
	end if
	objFile.close
%>