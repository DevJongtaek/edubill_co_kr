<%
set noticedb = server.CreateObject("ADODB.Connection")   '서버객체 db연결
 noticedb.Open "provider=sqloledb;server=220.73.136.46;database=enotice;uid=sa;pwd=qsefofedubill;"	'db를 연다 ( OdbcEdubill )
 noticedb.CommandTimeout = 120
%>
