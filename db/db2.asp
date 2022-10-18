<%
set db = server.CreateObject("ADODB.Connection")   '서버객체 db연결
 db.Open "provider=sqloledb;server=220.73.136.46;database=TR_DB;uid=sa;pwd=edubill@6508;"	'db를 연다 ( OdbcEdubill )
 db.CommandTimeout = 120
%>
