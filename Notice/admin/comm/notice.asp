<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	Response.CharSet = "utf-8"

	DIM CDO

	SET CDO = Server.CreateObject("CDO.Message")
	CDO.CreateMHTMLBody "http://webarty.com/v30_notice", 31
	
	CDO.BodyPart.Charset = "utf-8"
  CDO.HTMLBodyPart.Charset = "utf-8"
	scanHTML = CDO.HTMLBody
	SET CDO = Nothing

	RESPONSE.WRITE scanHTML
%>