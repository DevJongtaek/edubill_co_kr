<%@ LANGUAGE="VBSCRIPT" %>
<%
	Response.ContentType = "application/unknown"
	f_path = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\txt\rmake\"
	f_name = request("filename")

	Response.AddHeader "Content-Disposition","attachment; filename=" & f_name
	Set objStream = Server.CreateObject("ADODB.Stream")
	objStream.Open

	objStream.Type = 1
	objStream.LoadFromFile f_path & f_name
	file_str = objStream.Read

	Response.BinaryWrite file_str
%>

