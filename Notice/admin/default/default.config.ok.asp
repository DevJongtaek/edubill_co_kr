<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "A01"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		WITH REQUEST
	
			CONF_strSiteUrl        = GetInputReplce(.FORM("CONF_strSiteUrl"), "")
			CONF_strBbsUrl         = GetInputReplce(.FORM("CONF_strBbsUrl"), "")
			CONF_strAdminPath      = GetInputReplce(.FORM("CONF_strAdminPath"), "")
			CONF_strUploadComponet = GetInputReplce(.FORM("CONF_strUploadComponet"), "")
			CONF_strLangType       = GetInputReplce(.FORM("CONF_strLangType"), "")
			CONF_strUseSSL         = GetInputReplce(.FORM("CONF_strUseSSL"), "")
			CONF_intHttpPort       = GetInputReplce(.FORM("CONF_intHttpPort"), "")
			CONF_intHttpsPort      = GetInputReplce(.FORM("CONF_intHttpsPort"), "")
			CONF_strFilePath       = GetInputReplce(.FORM("CONF_strFilePath"), "")
	
		END WITH
	
		IF CONF_intHttpPort  = "" THEN CONF_intHttpPort  = "80"
		IF CONF_intHttpsPort = "" THEN CONF_intHttpsPort = "443"
	
		DIM conFile
		conFile = Server.MapPath("../../files/") & "\config\db.config.asp"
	
		SET FSO = SERVER.CREATEOBJECT("Scripting.FileSystemObject")
	
		IF FSO.fileExists(conFile) THEN
	
			FSO.DeleteFile(conFile)
			SET FILE = FSO.createTextFile(conFile, ForWriting)
	
			FILE.WRITELINE("<%")
			FILE.WRITELINE("	DIM CONF_strDbName, CONF_strDbId, CONF_strDbPass, CONF_strDbIp, CONF_strDbPort, CONF_strSiteUrl, CONF_strBbsUrl")
			FILE.WRITELINE("	DIM CONF_strLangType, CONF_strUseSSL, CONF_intHttpPort, CONF_intHttpsPort, CONF_strFilePath, CONF_strUploadComponet")
			FILE.WRITELINE("	DIM CONF_strAdminPath")
			FILE.WRITELINE("")
			FILE.WRITELINE("	CONF_strDbName = """ & CONF_strDbName & """ ")
			FILE.WRITELINE("	CONF_strDbId = """ & CONF_strDbId & """ ")
			FILE.WRITELINE("	CONF_strDbPass = """ & CONF_strDbPass & """ ")
			FILE.WRITELINE("	CONF_strDbIp = """ & CONF_strDbIp & """ ")
			FILE.WRITELINE("	CONF_strDbPort = """ & CONF_strDbPort & """ ")
			FILE.WRITELINE("	CONF_strSiteUrl = """ & CONF_strSiteUrl & """ ")
			FILE.WRITELINE("	CONF_strBbsUrl = """ & CONF_strBbsUrl & """ ")
			FILE.WRITELINE("	CONF_strAdminPath = """ & CONF_strAdminPath & """ ")
			FILE.WRITELINE("	CONF_strUploadComponet = """ & CONF_strUploadComponet & """ ")
			FILE.WRITELINE("	CONF_strLangType = """ & CONF_strLangType & """ ")
			FILE.WRITELINE("	CONF_strUseSSL = """ & CONF_strUseSSL & """ ")
			FILE.WRITELINE("	CONF_intHttpPort = """ & CONF_intHttpPort & """ ")
			FILE.WRITELINE("	CONF_intHttpsPort = """ & CONF_intHttpsPort & """ ")
			FILE.WRITELINE("	CONF_strFilePath = """ & CONF_strFilePath & """ ")
			FILE.WRITELINE(CHR(37 ) & ">")
			FILE.CLOSE
	
		END IF

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF
%>