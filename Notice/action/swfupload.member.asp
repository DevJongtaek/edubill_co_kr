<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<% 
	DIM strPath, strUserPath, memberSrl, file_type, strUploadedFile

	strPath = SERVER.MAPPATH("../" & CONF_strFilePath) & "\"
%>
<!-- #include file = "../libs/upload.config.asp" -->
<%
	UPLOAD.CodePage      = 65001
	Server.ScriptTimeout = 100000

	strUserPath = REPLACE(GetInputReplce(UPLOAD("userpath"), ""), "/", "\")
	memberSrl   = GetInputReplce(UPLOAD("memberSrl"), "")
	file_type   = GetInputReplce(UPLOAD("file_type"), "")
	strPath     = strPath & strUserPath & "\" & memberSrl

	CALL ActFolderMake(strPath)

	strPath = strPath & "\"

	DIM tmpFor, strFileName

	SET strFileField = UPLOAD("Filedata")

	strUploadedFile = GetFolderFileList(GetNowFolderPath("../") & "\" & CONF_strFilePath & "\" & strUserPath & "\" & memberSrl  & "\")
	IF strUploadedFile <> "" AND ISNULL(strUploadedFile) = False THEN ActFileDelete(strPath & strUploadedFile)

	strFileName = ActFileUpload(CONF_strUploadComponet, strFileField, 2097152, strPath, False, "", False, "")

	IF strFileName = False THEN
		RESPONSE.WRITE "ERROR"
	ELSE
		RESPONSE.WRITE "/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & CONF_strFilePath & "/" & REPLACE(strUserPath, "\", "/") & "/" & memberSrl & "/" & strFileName & "," & file_type
	END IF

	SET UPLOAD = NOTHING : SET RS = NOTHING : DBCON.CLOSE
%>