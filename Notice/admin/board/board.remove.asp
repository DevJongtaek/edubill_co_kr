<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D01"
	isStaffAddLog = False
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM intSrl, strPath

		intSrl  = GetInputReplce(REQUEST.FORM("intSrl"), "")
		strPath = GetNowFolderPath("../../" & CONF_strFilePath) & "\"

		CALL ActFolderDelete(strPath & "board\" & intSrl)
		CALL ActFolderDelete(strPath & "board\" & intSrl & "\config")
		CALL ActFolderDelete(strPath & "board\" & intSrl & "\files")
		CALL ActFolderDelete(strPath & "board\" & intSrl & "\images")
		CALL ActFolderDelete(strPath & "board\" & intSrl & "\images\temp")
		CALL ActFolderDelete(strPath & "board\" & intSrl & "\images\thrum")
		CALL ActFolderDelete(strPath & "comment\" & intSrl)
		CALL ActFolderDelete(strPath & "comment\" & intSrl & "\files")
		CALL ActFolderDelete(strPath & "comment\" & intSrl & "\images")
		CALL ActFolderDelete(strPath & "comment\" & intSrl & "\images\temp")
		CALL ActFolderDelete(strPath & "comment\" & intSrl & "\images\thrum")

		DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_REMOVE] '" & intSrl & "' ")

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>