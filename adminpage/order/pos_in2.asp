<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Function FunRealChek(rdata,rdatalen)	'유효성검사
		rdata = trim(rdata)
		if rdata<>"" then
			rdata = replace(rdata," ","")
			rdata = replace(rdata,"-","")
			rdata = replace(rdata,":","")
			if rdatalen>0 and rdata<>"" then
				if rdatalen <> len(rdata) then
					rdata = ""
				end if
			end if
		end if
		FunRealChek = rdata
	End Function
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	filepath     = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\pos_error\"	'파일경로
	filepathname = filepath & session.sessionid & ".txt"
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile filepathname,true 
	Set objFile = fs.OpenTextFile(filepathname,8)

	tot_cnt = order_posarrayint+1
	suc_cnt = 0
	fai_cnt = 0
	for i=0 to order_posarrayint
		errorflag      = ""
		real_OD_NO    = FunRealChek(order_posarray(0,i),15)	'키값 15
		real_OD_DATE  = FunRealChek(order_posarray(1,i),8)	'주문일시(0000-00-00) 8
		real_OD_TIME  = FunRealChek(order_posarray(2,i),6)	'주문시분(00:00:00)   6
		real_OD_CUST  = FunRealChek(order_posarray(3,i),0)	'체인점코드
		real_ODD_ITEM = FunRealChek(order_posarray(4,i),0)	'상품코드
		real_ODD_QTY  = FunRealChek(order_posarray(5,i),0)	'주문수랑

		if real_OD_NO    = "" then 
			errorflag = "1" 
		end if
		if real_OD_DATE  = "" then 
			errorflag = errorflag & "2" 
		end if
		if real_OD_TIME  = "" then 
			errorflag = errorflag & "3" 
		end if
		if real_OD_CUST  = "" then 
			errorflag = errorflag & "4" 
		end if
		if real_ODD_ITEM = "" then 
			errorflag = errorflag & "5" 
		end if
		if real_ODD_QTY  = "" then 
			errorflag = errorflag & "6" 
		end if

		if errorflag="" then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select idx from PosData_order where OD_NO = '"& real_OD_NO &"' and OD_CUST = '"& real_OD_CUST &"' and ODD_ITEM = '"& real_ODD_ITEM &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				errorflag = errorflag & "7"	'상품있음
			end if
			rs.close

			set rs = server.CreateObject("ADODB.Recordset")
			Sql = " select idx "
			Sql = sql & "  from tb_company where bidxsub <= '"& bcode &"' and idxsub = "& ccode &" and fileregcode = '"& real_OD_CUST &"' " 
			rs.Open sql, db, 1
			if not rs.eof then
				scode     = rs(0)	'체인점내부idx
			else
				errorflag = errorflag & "8"
			end if
			rs.close

			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select pcode from tb_product "
			SQL = sql & " where usercode  = '"& bcode &"' and proout = 'y'"
			SQL = sql & " and fileregcode = '"& real_ODD_ITEM &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				pro_pcode = rs(0)	'입력상품코드
			else
				errorflag = errorflag & "9"
			end if
			rs.close

			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select d_requestday from tb_company where idx = "& bcode
			rs.Open sql, db, 1
			d_requestday = rs(0)
			rs.close

			if errorflag="" then
				bcscode = bcode&ccode&scode
				sql = "insert into PosData_order(OD_NO,OD_DATE,OD_TIME,OD_CUST,ODD_ITEM,ODD_QTY, bcscode, pcode, d_requestday,sessionid) values "
				sql = sql & " ('"& real_OD_NO &"' "
				sql = sql & " ,'"& real_OD_DATE &"' "
				sql = sql & " ,'"& real_OD_TIME &"' "
				sql = sql & " ,'"& real_OD_CUST &"' "
				sql = sql & " ,'"& real_ODD_ITEM &"' "
				sql = sql & " ,'"& real_ODD_QTY &"' "
				sql = sql & " ,'"& bcscode &"' "
				sql = sql & " ,'"& pro_pcode &"' "
				sql = sql & " ,'"& d_requestday &"' "
				sql = sql & " ,'"& session.sessionid &"' )"
				db.execute sql
				suc_cnt = suc_cnt+1
			end if
		end if

		if errorflag<>"" then
			fai_cnt = fai_cnt+1
			imsitab = chr(9)
			imsifwriteval = order_posarray(0,i) & imsitab & order_posarray(1,i) & imsitab & order_posarray(2,i) & imsitab & order_posarray(3,i) & imsitab & order_posarray(4,i) & imsitab & order_posarray(5,i) & imsitab &"error:"&errorflag
			objFile.writeLine(imsifwriteval)
		end if
	next

	objFile.close
%>