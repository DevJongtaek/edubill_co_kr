<%
set db = server.CreateObject("ADODB.Connection")   '������ü db����
 db.Open "provider=sqloledb;server=220.73.136.46;database=TR_DB;uid=sa;pwd=edubill@6508;"	'db�� ���� ( OdbcEdubill )
 db.CommandTimeout = 120
%>
