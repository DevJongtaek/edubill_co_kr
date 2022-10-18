<%
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	ymd1   = request("ymd1")
	ymd2   = request("ymd2")
	imsi_Ausergubun = session("Ausergubun")	'1:수퍼유저 2:본사 3:지사 4:체인점
	imsibcs_code = 	session("Ausercode")
	bcode = left(imsibcs_code,5)	'실제본사 idx값
	ccode = mid(imsibcs_code,6,5)	'실제지사 idx값
	errmsg = ""
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	if ymd1="" or ymd2="" then
		call FunErrorMsg("입력값에 NULL값이 있습니다.\n\n확인후 다시 시도해 주시기 바랍니다.")
	end if

	if errmsg="" then
		imsiymd1 = mid(ymd1,1,4)&"-"&mid(ymd1,5,2)&"-"&mid(ymd1,7,2)
		imsiymd2 = mid(ymd2,1,4)&"-"&mid(ymd2,5,2)&"-"&mid(ymd2,7,2)
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'메타시스
		'아이디 : taidi   
		'암호   : q123456
		'Ip     : 222.231.57.237

		'VIEW_ORDERS_TAIDI[주문리스트]
		'OD_DATE	주문일시
		'OD_TIME	시분
		'OD_CUST	체인점코드
		'ODD_ITEM	상품코드
		'ODD_QTY	주문수랑
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		Set db = Server.CreateObject("ADODB.Connection")
		dbstr = "provider=sqloledb;server=222.231.57.237;database=juk001;uid=taidi;pwd=q123456;"	'db를 연다
		db.Open dbstr
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		set rs = server.CreateObject("ADODB.Recordset")
		Sql = " select OD_NO, OD_DATE,OD_TIME,OD_CUST,ODD_ITEM,ODD_QTY "
		Sql = sql & " from VIEW_ORDERS_TAIDI "
		Sql = sql & " where OD_DATE >= '"& imsiymd1 &"' and OD_DATE <= '"& imsiymd2 &"' "
		Sql = sql & " order by OD_NO asc ,OD_CUST asc, ODD_ITEM asc "
		rs.Open sql, db, 1
		if not rs.eof then
			order_posarray = rs.GetRows
			order_posarrayint = ubound(order_posarray,2)
		else
			order_posarray = ""
			order_posarrayint = ""
			call FunErrorMsg("검색된 데이타가 없습니다.\n\n확인후 다시 시도해 주시기 바랍니다.")
		end if
		rs.close
		set rs=nothing
		db.close
		set db=nothing
	end if

'response.write order_posarrayint
'response.end
%>