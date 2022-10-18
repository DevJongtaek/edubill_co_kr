<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "dbconn.asp" -->
<!-- #include file = "function.asp" -->
<% 
	DIM strPath, strUserPath, intBoardSrl

	strPath = SERVER.MAPPATH("../" & CONF_strFilePath) & "\"
%>
<!-- #include file = "upload.config.asp" -->
<%
	UPLOAD.CodePage      = 65001
	Server.ScriptTimeout = 100000

	strUserPath = REPLACE(GetInputReplce(UPLOAD("userpath"), ""), "/", "\")
	intBoardSrl = UPLOAD("boardsrl")
	strPath     = strPath & strUserPath & "\"

	IF intBoardSrl = "" THEN

		bitUseThrum        = False
		strThrumOption     = ""
		bitUseWaterMark    = False
		strWaterMarkOption = ""

	ELSE

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '" & intBoardSrl & "' ")

		DIM bitUseThrum, strThrumOption, bitUseWaterMark, strWaterMarkOption

		bitUseThrum        = RS("bitUseThrum")
		strThrumOption     = RS("strThrumOption")
		bitUseWaterMark    = RS("bitUseWaterMark")
		strWaterMarkOption = RS("strWaterMarkOption") & "$^^$" & intBoardSrl

	END IF

	DIM tmpFor, strFileName

	FOR tmpFor = 1 TO UPLOAD("Filedata").COUNT

		SET strFileField = UPLOAD("Filedata")(tmpFor)

		strFileName = ActFileUpload(CONF_strUploadComponet, strFileField, 1048576000, strPath, bitUseThrum, strThrumOption, bitUseWaterMark, strWaterMarkOption)

		IF strFileName = False THEN strFileName = ""
		
		RESPONSE.WRITE strFileName

	NEXT

	SET UPLOAD = NOTHING
	SET RS = NOTHING : DBCON.CLOSE
%>