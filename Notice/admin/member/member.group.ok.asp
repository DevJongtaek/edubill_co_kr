<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C03"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act, tmpFor
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	
		DIM strGroupCode, strTitle, bitDefault, bitAdmin, strDescription, strMarkFile, intUpLevel, strUploadedFile
	
		SELECT CASE Act
		CASE "membergroupadd", "membergroupmodify"
	
			WITH REQUEST
	
				strGroupCode   = GetInputReplce(.FORM("strGroupCode"), "")
				strTitle       = GetInputReplce(.FORM("strTitle"), "")
				bitDefault     = GetInputReplce(.FORM("bitDefault"), "")
				strDescription = GetInputReplce(.FORM("strDescription"), "")
				strMarkFile    = GetInputReplce(.FORM("strMarkFile"), "")
				intUpLevel     = GetInputReplce(.FORM("intUpLevel"), "")
	
			END WITH
	
			SELECT CASE Act
			CASE "membergroupadd"
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_READ] '', 'Y' ")
	
				strGroupCode = INT(RIGHT(RS(0), 9)) + 1
	
				FOR tmpFor = LEN(strGroupCode) TO 8
					strGroupCode = "0" & strGroupCode
				NEXT
	
				strGroupCode = "G" & strGroupCode
	
				DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_ADD] 'W', '" & strGroupCode & "', N'" & strTitle & "', '" & bitDefault & "', N'" & strDescription & "', N'" & strMarkFile & "', '" & intUpLevel & "' ")
	
				RESPONSE.WRITE "SW"
	
			CASE "membergroupmodify"
	
				DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_ADD] 'E', '" & strGroupCode & "', N'" & strTitle & "', '" & bitDefault & "', N'" & strDescription & "', N'" & strMarkFile & "', '" & intUpLevel & "' ")
	
				RESPONSE.WRITE "SE"
	
			END SELECT
	
		CASE "groupremove"
	
			strGroupCode    = GetInputReplce(REQUEST.FORM("strGroupCode"), "")
			strUploadedFile = GetFolderFileList(SERVER.MAPPATH("../../" & CONF_strFilePath) & "\member\group\" & strGroupCode & "\")
	
			IF strUploadedFile <> "" AND ISNULL(strUploadedFile) = False THEN CALL ActFileDelete(SERVER.MAPPATH("../../" & CONF_strFilePath) & "\member\group\" & strGroupCode & "\" & strUploadedFile)
	
			DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_REMOVE] '" & strGroupCode & "' ")

		CASE "groupmove"

			FOR tmpFor = 1 TO REQUEST.FORM("strGroupCode").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_MOVE] '" & REQUEST.FORM("strGroupCode")(tmpFor) & "', '" & REQUEST.FORM("strMoveGroup") & "' ")

			NEXT	

		CASE "fileremove"

			strGroupCode    = GetInputReplce(REQUEST.FORM("strGroupCode"), "")
			strUploadedFile = GetFolderFileList(SERVER.MAPPATH("../../" & CONF_strFilePath) & "\member\group\" & strGroupCode & "\")
	
			IF strUploadedFile <> "" AND ISNULL(strUploadedFile) = False THEN CALL ActFileDelete(SERVER.MAPPATH("../../" & CONF_strFilePath) & "\member\group\" & strGroupCode & "\" & strUploadedFile)

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>