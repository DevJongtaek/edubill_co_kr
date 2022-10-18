<%
	set DBConn = Server.CreateObject("ADODB.connection")
	DBConn.open ("DSN=MYPG;UID=sa;PWD=copyroom;")
%>