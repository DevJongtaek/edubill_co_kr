<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<% 
	DIM strPath, strUserPath, bitFileremove

	strPath = SERVER.MAPPATH("../../" & CONF_strFilePath) & "\"
%>
<!-- #include file = "../../libs/upload.config.asp" -->
<%
	UPLOAD.CodePage      = 65001
	Server.ScriptTimeout = 100000

	strUserPath   = REPLACE(GetInputReplce(UPLOAD("userpath"), ""), "/", "\")
	strPath       = strPath & strUserPath & "\"
	bitFileremove = GetInputReplce(UPLOAD("fileremove"), "")

	DIM tmpFor, strFileName

	IF bitFileremove = "1" THEN
		DIM strUploadedFile
		strUploadedFile = GetFolderFileList(strPath)
		IF strUploadedFile <> "" AND ISNULL(strUploadedFile) = False THEN CALL ActFileDelete(strPath & strUploadedFile)
	END IF

	FOR tmpFor = 1 TO UPLOAD("Filedata").COUNT

		SET strFileField = UPLOAD("Filedata")(tmpFor)

		strFileName = ActFileUpload(CONF_strUploadComponet, strFileField, 1048576000, strPath, False, "", False, "")

		IF strFileName = False THEN strFileName = ""

		RESPONSE.WRITE strFileName & "," & GetUploadFileInfo(CONF_strUploadComponet, strFileField, "size") & ","

		IF GetUploadFileImage(CONF_strUploadComponet, strFileField) = True THEN
			RESPONSE.WRITE strFileField.ImageWidth & "," & strFileField.ImageHeight
		ELSE
			RESPONSE.WRITE ","
		END IF

	NEXT

	SET UPLOAD = NOTHING
%>