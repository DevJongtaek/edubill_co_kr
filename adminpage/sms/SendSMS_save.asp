<%@ Language=VBScript %>
<%
'/**
'// ������Ʈ: edubill
'// ���α׷�: list_in_save.asp
'// ��	  ��: û������ �Է�
'// �� �� ��: �輺ȣ webadvisor@korea.com
'// �� �� ��: 2003/10/10  
'// INPUT	: ���̵�, �ֹε�Ϲ�ȣ, �̸�, ��й�ȣ, �̸���, ��ȭ, �޴���, �����ȣ, �ּ�
'// OUTPUT	: 
'// History : 
'*/
%>

<!--#include FILE="db.asp"-->  
<%
	' strConn = "provider=SQLOLEDB.1; persist security info=false;" & _
	' "data source=192.168.90.61; initial catalog=MYPG;" & _
	' "user id=sa;password=xxxxxx"    
	'Option Explicit

	response.expires = 0

	'set db = Server.CreateObject("ADODB.Connection")
	'db.open strConn
	
	Dim mobile, goodname, standard, custmoney, quantity, totalmoney

	mobile = replace(Request.form("mobile"),"-","")
	mobile = trim(mobile)
	hnum = mid(mobile,4,2)
	
	if len(mobile) = 11 then
		tmobile = left(mobile, 3) & "-" & mid(mobile, 4, 4) & "-" & right(mobile, 4)
	else
		tmobile = left(mobile, 3) & "-" & mid(mobile, 4, 3) & "-" & right(mobile, 4)
	end if

	dim m_num
	m_num = Trim(left(mobile, 3))

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if m_num="010" then

	        If (hnum >= "25" And hnum <= "28") Or hnum = "29" Or hnum = "30" Or (hnum >= "32" And hnum <= "34") Or (hnum >= "42" And hnum <= "44") Or (hnum >= "65" And hnum <= "68") Or (hnum >= "70" And hnum <= "70") Or (hnum >= "72" And hnum <= "74") Or (hnum >= "95" And hnum <= "99") Then
        	    	'KTF �����κ�
			m_num = "016"
		ElseIf hnum = "21" Or (hnum >= "22" And hnum <= "24") Or hnum = "39" Or (hnum >= "55" And hnum <= "58") Or (hnum >= "75" And hnum <= "79") Or (hnum >= "80" And hnum <= "84") Then
            		'LGT �����κ�
			m_num = "019"
		Else
            		'SKT �����κ�
			m_num = "011"
		end if
	end if
	'response.write m_num
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	if m_num = "019" then
	
		QSql = "INSERT INTO em_tran "
		QSql = QSql & "(tran_phone, tran_callback, tran_status, tran_date, tran_msg, tran_type) values " 
		QSql = QSql & "('" & tmobile & "','7114','1',getdate(),'http://www.p-114.co.kr/wap/index019.asp ## �ڵ����ֹ� ##','5')"

	elseif m_num = "016" or m_num = "018" then

		QSql = "INSERT INTO em_tran "
		QSql = QSql & "(tran_phone, tran_callback, tran_status, tran_date, tran_msg, tran_type) values " 
		QSql = QSql & "('" & tmobile & "','7114','1',getdate(),'http://www.p-114.co.kr/wap/index016.asp ## �ڵ����ֹ� ##','5')"

	else
		'QSql = "INSERT INTO em_tran2 "
		'QSql = QSql & "(tran_phone, tran_callback, tran_status, tran_date, tran_msg, tran_id, tran_type) values " 
		'QSql = QSql & "('" & tmobile & "','7114','1',getdate(),'## �ڵ����ֹ� ##|http://www.p-114.co.kr/wap/index011.asp','111','5')"
		QSql = "INSERT INTO em_tran "
		QSql = QSql & "(tran_phone, tran_callback, tran_status, tran_date, tran_msg, tran_type) values " 
		QSql = QSql & "('" & tmobile & "','7114','1',getdate(),'http://www.p-114.co.kr/wap/index011.asp ## �ڵ����ֹ� ##','5')"
		
	end if
	
	'response.write QSql
	db.Execute(QSql)
	
	db.Close
	Set db = Nothing
%>

	<Script language=javascript>
		alert("���������� ���½��ϴ�.");
		location.href = "write.asp";
	</Script>
