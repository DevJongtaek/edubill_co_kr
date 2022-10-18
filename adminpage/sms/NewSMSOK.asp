<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	
					SQL = "delete NewSMS "
					
					db.Execute SQL

				

	

	db.close
	set db=nothing
	response.redirect "NewSMS.asp"

%>