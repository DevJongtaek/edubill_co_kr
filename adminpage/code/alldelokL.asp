<!--#include virtual="/db/db.asp"-->
<%
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'dflag = request("dflag")
	'imsiday = left(now(),10)
	'if dflag="1" then	'6����
'		sday = replace(DateAdd("m",-6,imsiday),"-","")
'	elseif dflag="2" then	'1��
'		sday = replace(DateAdd("m",-12,imsiday),"-","")
'	elseif dflag="3" then	'2��
'		sday = replace(DateAdd("m",-24,imsiday),"-","")
'	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = " ALTER DATABASE edubill_co_kr SET recovery SIMPLE "
	
	
	SQL = SQL & " DBCC SHRINKFILE(edubill_co_kr_log) "
	SQL =SQL & " alter database edubill_co_kr set RECOVERY FULL "
	
	
	'SQL = SQL & " where Aymd < '"& sday &"' "
	
'	response.write SQL
	db.Execute SQL
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	db.close

%>

	<Script language=javascript>
		alert("����Ÿ�� ���������� ���� �Ǿ����ϴ�.");
		location.href = "alldel2.asp";
	</Script>