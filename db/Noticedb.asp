<%
set noticedb = server.CreateObject("ADODB.Connection")   '������ü db����
' noticedb.Open "provider=sqloledb;server=220.73.136.52;database=enotice;uid=sa;pwd=edubill@6508;"	'db�� ���� ( OdbcEdubill )
 db.Open "provider=sqloledb;server=127.0.0.1;database=edubill_co_kr;uid=sa;pwd=qsefofedubill;"	'db�� ���� ( OdbcEdubill )
 noticedb.CommandTimeout = 120
%>
