<%
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	ymd1   = request("ymd1")
	ymd2   = request("ymd2")
	imsi_Ausergubun = session("Ausergubun")	'1:�������� 2:���� 3:���� 4:ü����
	imsibcs_code = 	session("Ausercode")
	bcode = left(imsibcs_code,5)	'�������� idx��
	ccode = mid(imsibcs_code,6,5)	'�������� idx��
	errmsg = ""
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	if ymd1="" or ymd2="" then
		call FunErrorMsg("�Է°��� NULL���� �ֽ��ϴ�.\n\nȮ���� �ٽ� �õ��� �ֽñ� �ٶ��ϴ�.")
	end if

	if errmsg="" then
		imsiymd1 = mid(ymd1,1,4)&"-"&mid(ymd1,5,2)&"-"&mid(ymd1,7,2)
		imsiymd2 = mid(ymd2,1,4)&"-"&mid(ymd2,5,2)&"-"&mid(ymd2,7,2)
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		'��Ÿ�ý�
		'���̵� : taidi   
		'��ȣ   : q123456
		'Ip     : 222.231.57.237

		'VIEW_ORDERS_TAIDI[�ֹ�����Ʈ]
		'OD_DATE	�ֹ��Ͻ�
		'OD_TIME	�ú�
		'OD_CUST	ü�����ڵ�
		'ODD_ITEM	��ǰ�ڵ�
		'ODD_QTY	�ֹ�����
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		Set db = Server.CreateObject("ADODB.Connection")
		dbstr = "provider=sqloledb;server=222.231.57.237;database=juk001;uid=taidi;pwd=q123456;"	'db�� ����
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
			call FunErrorMsg("�˻��� ����Ÿ�� �����ϴ�.\n\nȮ���� �ٽ� �õ��� �ֽñ� �ٶ��ϴ�.")
		end if
		rs.close
		set rs=nothing
		db.close
		set db=nothing
	end if

'response.write order_posarrayint
'response.end
%>