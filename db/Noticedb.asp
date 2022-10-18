<%
set noticedb = server.CreateObject("ADODB.Connection")   '서버객체 db연결
' noticedb.Open "provider=sqloledb;server=220.73.136.52;database=enotice;uid=sa;pwd=edubill@6508;"	'db를 연다 ( OdbcEdubill )
 db.Open "provider=sqloledb;server=127.0.0.1;database=edubill_co_kr;uid=sa;pwd=qsefofedubill;"	'db를 연다 ( OdbcEdubill )
 noticedb.CommandTimeout = 120
%>
