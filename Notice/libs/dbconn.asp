<%
	DIM db_connect, DbCon
	db_connect = "Provider=SQLOLEDB.1;Password=" & CONF_strDbPass & ";Persist Security Info=False;User ID=" & CONF_strDbId & ";Initial Catalog=" & CONF_strDbName & ";Data Source=" & CONF_strDbIp & "," & CONF_strDbPort & "; Network Library=DBMSSOCN"

	SET DbCon = Server.CreateObject("ADODB.Connection")
	DbCon.Open db_connect
%>