<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<!-- #include file = "../libs/md5.asp" -->
<% 
	DIM strPath, strUserPath, intBoardSrl

	strPath = SERVER.MAPPATH("../" & CONF_strFilePath) & "\"
%>
<!-- #include file = "../libs/upload.config.asp" -->
<%
	UPLOAD.CodePage      = 65001
	Server.ScriptTimeout = 100000

	strUserPath = REPLACE(GetInputReplce(UPLOAD("userpath"), ""), "/", "\")
	intBoardSrl = UPLOAD("boardsrl")
	strPath     = strPath & strUserPath & "\"

	DIM tmpFor, strFileName

	FOR tmpFor = 1 TO UPLOAD("Filedata").COUNT

		SET strFileField = UPLOAD("Filedata")(tmpFor)

		strFileName = ActFileUploadMD5(CONF_strUploadComponet, strFileField, 1048576000, strPath)

		IF strFileName <> False THEN
			RESPONSE.WRITE strFileName & "," & GetUploadFileInfo(CONF_strUploadComponet, strFileField, "size")
		END IF

	NEXT

	SET UPLOAD = NOTHING
	SET RS = NOTHING : DBCON.CLOSE
%>