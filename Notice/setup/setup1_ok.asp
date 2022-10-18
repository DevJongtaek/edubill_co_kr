<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	Response.CharSet = "utf-8"

	DIM db_ip, db_port, db_name, db_id, db_password, site_path, board_path, upload_componet, p_version

	WITH REQUEST

		db_ip           = .FORM("db_ip")
		db_port         = .FORM("db_port")
		db_name         = .FORM("db_name")
		db_id           = .FORM("db_id")
		db_password     = .FORM("db_password")
		site_path       = .FORM("site_path")
		board_path      = .FORM("board_path")
		upload_componet = .FORM("upload_componet")
		p_version       = .FORM("p_version")

	END WITH

	DIM config_path

	config_path = SERVER.MapPath("/notice/files/config") & "\"

	ON ERROR RESUME NEXT

	DIM DbCon, FSO

	SET DbCon = Server.CreateObject("ADODB.Connection")

	DbCon.Open "Provider=SQLOLEDB.1;Password=" & db_password & ";Persist Security Info=False;User ID=" & db_id & ";Initial Catalog=" & db_name & ";Data Source=" & db_ip & "," & db_port & "; Network Library=DBMSSOCN"

	IF err.Number <> 0 THEN
		RESPONSE.WRITE "<script type=""text/javascript"">" & vbcrlf
		RESPONSE.WRITE "alert(""설치 오류가 발생되었습니다.\n\nERR:" & err.Number & ":" & err.Description & """);" & vbcrlf
		RESPONSE.WRITE "history.back(-1);" & vbcrlf
		RESPONSE.wRITE "</script>" & vbcrlf
		RESPONSE.End()
	END IF

	SET FSO = Server.CreateObject("Scripting.FileSystemObject")
	IF FSO.fileExists(config_path & "db.config.asp") THEN FSO.DeleteFile(config_path & "db.config.asp")

	SET FILE = FSO.createTextFile(config_path & "db.config.asp", ForWriting)

	FILE.WRITELINE("<%")
	FILE.WRITELINE("	DIM CONF_strDbName, CONF_strDbId, CONF_strDbPass, CONF_strDbIp, CONF_strDbPort, CONF_strSiteUrl, CONF_strBbsUrl")
	FILE.WRITELINE("	DIM CONF_strLangType, CONF_strUseSSL, CONF_intHttpPort, CONF_intHttpsPort, CONF_strFilePath, CONF_strUploadComponet ")
	FILE.WRITELINE("	DIM CONF_strAdminPath ")
	FILE.WRITELINE("")
	FILE.WRITELINE("	CONF_strDbName         = " & CHR(34) & db_name & CHR(34))
	FILE.WRITELINE("	CONF_strDbId           = " & CHR(34) & db_id & CHR(34))
	FILE.WRITELINE("	CONF_strDbPass         = " & CHR(34) & db_password & CHR(34))
	FILE.WRITELINE("	CONF_strDbIp           = " & CHR(34) & db_ip & CHR(34))
	FILE.WRITELINE("	CONF_strDbPort         = " & CHR(34) & db_port & CHR(34))
	FILE.WRITELINE("	CONF_strSiteUrl        = " & CHR(34) & site_path & CHR(34))
	FILE.WRITELINE("	CONF_strBbsUrl         = " & CHR(34) & board_path & CHR(34))
	FILE.WRITELINE("	CONF_strAdminPath      = " & CHR(34) & "admin" & CHR(34))
	FILE.WRITELINE("	CONF_strUploadComponet = " & CHR(34) & upload_componet & CHR(34))
	FILE.WRITELINE("	CONF_strLangType       = " & CHR(34) & "ko" & CHR(34))
	FILE.WRITELINE("	CONF_strUseSSL         = " & CHR(34) & "none" & CHR(34))
	FILE.WRITELINE("	CONF_intHttpPort       = " & CHR(34) & "80" & CHR(34))
	FILE.WRITELINE("	CONF_intHttpsPort      = " & CHR(34) & "443" & CHR(34))
	FILE.WRITELINE("	CONF_strFilePath       = " & CHR(34) & "pds" & CHR(34))
	FILE.WRITELINE(CHR(37) & ">")
	FILE.CLOSE

	IF err.Number <> 0 THEN
		RESPONSE.WRITE "<script type=""text/javascript"">" & vbcrlf
		RESPONSE.WRITE "alert(""설치 오류가 발생되었습니다.\n" & err.Number & ":폴더에 권한이 부족합니다."");" & vbcrlf
		RESPONSE.WRITE "history.back(-1);" & vbcrlf
		RESPONSE.wRITE "</script>" & vbcrlf
		RESPONSE.End()
	END IF

	RESPONSE.WRITE "<form id=""extForm"" name=""extForm"" method=""post"" action=""http://webarty.com/v30_setup/?act=setup"">" & CHR(10)
	RESPONSE.WRITE "<input type=""hidden"" name=""db_ip"" value=""" & db_ip & """>" & CHR(10)
	RESPONSE.WRITE "<input type=""hidden"" name=""db_port"" value=""" & db_port & """>" & CHR(10)
	RESPONSE.WRITE "<input type=""hidden"" name=""db_name"" value=""" & db_name & """>" & CHR(10)
	RESPONSE.WRITE "<input type=""hidden"" name=""db_id"" value=""" & db_id & """>" & CHR(10)
	RESPONSE.WRITE "<input type=""hidden"" name=""db_password"" value=""" & db_password & """>" & CHR(10)
	RESPONSE.WRITE "<input type=""hidden"" name=""site_path"" value=""" & site_path & """>" & CHR(10)
	RESPONSE.WRITE "<input type=""hidden"" name=""board_path"" value=""" & board_path & """>" & CHR(10)
	RESPONSE.WRITE "<input type=""hidden"" name=""p_version"" value=""" & p_version & """>" & CHR(10)
	RESPONSE.WRITE "</form>" & CHR(10)
	RESPONSE.WRITE "<script type=""text/javascript"">" & CHR(10)
	RESPONSE.WRITE "	document.extForm.submit();" & CHR(10)
	RESPONSE.WRITE "</script>" & CHR(10)
	RESPONSE.End()

	SET DB = NOTHING : SET FSO = NOTHING
%>