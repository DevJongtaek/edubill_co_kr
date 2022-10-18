<!--#include virtual="/db/db.asp"-->
<%
	idx = Trim(request.querystring("idx"))
	
	SQL = "select sms_date from tb_sms_master where idx = '" & idx & "'"
	SET Rs = db.Execute(SQL)
	
	yyyymmdd = Trim(Rs("sms_date"))
	
	yyyymm = left(yyyymmdd, 4) & mid(yyyymmdd, 6,2)

	Rs.close

	set db1 = server.CreateObject("ADODB.Connection")   '서버객체 db연결
	db1.Open "provider=sqloledb;server=61.97.113.73;database=MYPG;uid=sa;pwd=1234;"	'db를 연다
	
	SQL = "select idx_sub from tb_sms_slave where idx = '" & idx & "' order by idx_sub"
	SET Rs = db.Execute(SQL)
	
	Do Until Rs.EOF
	
		QSql = "select tran_status, tran_rslt from em_log_" & yyyymm & " where tran_id = '" & idx & Trim(Rs("idx_sub")) & "'"
		'response.write QSql
		Set Rs1 = db1.Execute(QSql)	
		
		tran_status = Trim(Rs1("tran_rslt"))
		
		if tran_status = "0" then
			result = "T"
		else
			result = "F"
		end if
		
		USql = "UPDATE tb_sms_slave SET result = '" & result & "' WHERE idx = '" & idx & "' and idx_sub = '" & Trim(Rs("idx_sub")) & "'"
		db.Execute(USql)
	
	Rs.MoveNext
	Loop
	

	Rs.close
	set Rs=nothing	
	db1.close
	set db1=nothing		
	db.close
	set db=nothing
%>