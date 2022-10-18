<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM intBoardSrl, strFileName, strFileSid, strFileFolder, strDownFileName, strUserAgent, strContentDisp, strContentType

	intBoardSrl     = REQUEST.QueryString("intBoardSrl")
	strFileName     = REQUEST.QueryString("strFileName")
	strFileSid      = REQUEST.QueryString("strFileSid")
	strFileFolder   = REQUEST.QueryString("strFileFolder")
	strDownFileName = GetNowFolderPath("../") & "\" & CONF_strFilePath & "\" & strFileFolder & "\" & intBoardSrl & "\files\" & strFileSid

	strUserAgent = Request.ServerVariables("HTTP_USER_AGENT")

	IF InStr(strUserAgent, "MSIE") > 0 THEN
		IF InStr(strUserAgent, "MSIE 5.0") > 0 THEN
			strContentDisp = "attachment;filename="
			strContentType = "application/x-msdownload"
		ELSE
			strContentDisp = "attachment;filename="
			strContentType = "application/unknown"
		END IF
	ELSE
		strContentDisp = "attachment;filename="
		strContentType = "application/unknown"
	END IF

	SELECT CASE CONF_strUploadComponet
	CASE "dext"

		DIM objFS, objF, objDownload

		RESPONSE.AddHeader "Content-Disposition", strContentDisp & SERVER.URLPathEncode(strFileName)
		SET objFS = Server.CreateObject("Scripting.FileSystemObject")
		SET objF = objFS.GetFile(strDownFileName)
		RESPONSE.AddHeader "Content-Length", objF.Size
		SET objF = NOTHING
		SET objFS = NOTHING
		RESPONSE.ContentType = strContentType
		RESPONSE.CacheControl = "public"
		 
		SET objDownload = Server.CreateObject("DEXT.FileDownload")
		objDownload.Download strDownFileName
		SET objDownload = NOTHING

	CASE "abc"

		DIM objstream, download

		RESPONSE.AddHeader "Content-Disposition", strContentDisp & SERVER.URLPathEncode(strFileName)
		RESPONSE.ContentType  = strContentType
		RESPONSE.CacheControl = "public"
	 
		SET objStream = Server.CreateObject("ADODB.Stream")
		objStream.Open
		objStream.Type = 1
		objStream.LoadFromFile strDownFileName

		download = objStream.Read
		RESPONSE.BinaryWrite download
		
		SET objstream = NOTHING

	CASE "tabs"

		SET objDownload = Server.CreateObject("TABS.Download")

		objDownload.FilePath = strDownFileName
		objDownload.TransferFile True, True
		SET objDownload = NOTHING

	END SELECT

%>