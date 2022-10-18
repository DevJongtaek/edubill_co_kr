<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D05"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))

		DIM intSeq, strFileName, strFileSid, strDownFileName

		SELECT CASE Act
		CASE "remove"

			DIM tmpFor

			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

				SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_READ] 'R', '" & REQUEST.FORM("intSeq")(tmpFor) & "' ")

				CALL ActFileDelete(GetNowFolderPath("../../") & "\" & CONF_strFilePath & "\board\" & RS("intSrl") & "\files\" & RS("strSid"))

				DBCON.EXECUTE("[ARTY30_SP_FILES_REMOVE] '" & REQUEST.FORM("intSeq")(tmpFor) & "' ")

			NEXT

		CASE "down"

			intSeq = GetInputReplce(REQUEST.QueryString("intSeq"), "")

			SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_READ] 'R', '" & intSeq & "' ")

			strFileName = RS("strFileName")
			strFileSid  = RS("strSid")

			IF RS("intCommentSeq") = "0" THEN
				strDownFileName = GetNowFolderPath("../../") & "\" & CONF_strFilePath & "\board\" & RS("intSrl") & "\files\" & strFileSid
			ELSE
				strDownFileName = GetNowFolderPath("../../") & "\" & CONF_strFilePath & "\comment\" & RS("intSrl") & "\files\" & strFileSid
			END IF

			DIM strUserAgent, strContentDisp, strContentType
		
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

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>