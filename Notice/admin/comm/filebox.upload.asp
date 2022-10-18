<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "H01"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))

		DIM strFileName, strFileNameFull, strCateCode, strFileMemo
		DIM tmpFor, strFileField

		SELECT CASE Act
		CASE "upload"

			strPath = SERVER.MAPPATH("../../" & CONF_strFilePath) & "\site\filebox\"
%>
<!-- #include file = "../../libs/upload.config.asp" -->
<%
			UPLOAD.CodePage      = 65001
			Server.ScriptTimeout = 100000

			strCateCode = UPLOAD("strCateCode")
			strFileMemo = UPLOAD("strFileMemo")

			FOR tmpFor = 1 TO UPLOAD("filename").COUNT
		
				SET strFileField = UPLOAD("filename")(tmpFor)

				IF GetUploadFileImage(CONF_strUploadComponet, strFileField) = True THEN
					strFileName = ActFileUpload(CONF_strUploadComponet, strFileField, 1048576000, strPath, False, "", False, "")
					IF strFileName = False THEN
						RESPONSE.WRITE "error"
						RESPONSE.End()
					ELSE
						strFileNameFull = "/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & CONF_strFilePath & "/site/filebox/" & strFileName
						DBCON.EXECUTE("[ARTY30_SP_FILEBOX_ADD] '" & strFileName & "', '" & strFileNameFull & "', '" & strFileField.ImageWidth & "', '" & strFileField.ImageHeight & "', '" & GetUploadFileInfo(CONF_strUploadComponet, strFileField, "size") & "', '" & strCateCode & "', '" & strFileMemo & "' ")
						RESPONSE.WRITE "success"
						RESPONSE.End()
					END IF
				ELSE
					RESPONSE.WRITE "noimage"
					RESPONSE.End()
				END IF
		
			NEXT

		CASE "remove"

			DIM strPath
			strPath = SERVER.MAPPATH("../../" & CONF_strFilePath) & "\site\filebox\"
	
			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT
		
				SET RS = DBCON.EXECUTE("[ARTY30_SP_FILEBOX_READ] '" & REQUEST.FORM("intSeq")(tmpFor) & "' ")

				CALL ActFileDelete(strPath & RS("strFileName"))

				DBCON.EXECUTE("[ARTY30_SP_FILEBOX_REMOVE] '" & REQUEST.FORM("intSeq")(tmpFor) & "' ")
		
			NEXT

		END SELECT
	
	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>