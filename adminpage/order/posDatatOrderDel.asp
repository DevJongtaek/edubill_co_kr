<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/fun.asp"-->
<!--#include virtual="/db/db.asp"-->
<%

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	ymd1   = request("ymd1")
	ymd2   = request("ymd2")
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'if ymd1-ymd2=0 then
		sql = "delete PosData_order where OD_DATE >= '"& ymd1 &"' and OD_DATE <= '"& ymd2 &"' "
		db.execute sql
		db.close
		call FunSucMsg("�ӽ����̺� ����Ÿ ������ ���������� �̷�� �����ϴ�.","posDatatOrder.asp")
	'else
	'	call FunErrorMsg("1�� ����Ÿ�� ���� �����մϴ�.")
	'end if
%>