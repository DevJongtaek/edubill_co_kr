<%
set noticedb = server.CreateObject("ADODB.Connection")   '������ü db����
 noticedb.Open "provider=sqloledb;server=220.73.136.46;database=enotice;uid=sa;pwd=qsefofedubill;"	'db�� ���� ( OdbcEdubill )
 noticedb.CommandTimeout = 120
%>
