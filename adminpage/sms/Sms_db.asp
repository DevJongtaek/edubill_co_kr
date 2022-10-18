<%
	Set smsdb = Server.CreateObject("ADODB.Connection")
	dbstr = "provider=sqloledb;server=220.73.136.21, 2101;database=LGUplusSMS;uid=agentsms;pwd=total_sms_21;"	'db¸¦ ¿¬´Ù
	smsdb.Open dbstr
    smsdb.CommandTimeout = 120
%>
