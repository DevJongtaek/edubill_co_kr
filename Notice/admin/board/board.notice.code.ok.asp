<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D08"
	isStaffAddLog = False
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM strSourceType, strDataType, strBoardSrl, intListCount, bitUseThrum, strCutText
		
		WITH REQUEST

			strSourceType = .FORM("strSourceType")
			strDataType   = .FORM("strDataType")
			strFolder     = .FORM("strFolder")
			strBoardSrl   = .FORM("strBoardSrl")
			intListCount  = .FORM("intListCount")
			bitUseThrum   = .FORM("bitUseThrum")
			strCutText    = SPLIT(.FORM("strCutText"), ",")

		END WITH	

		IF bitUseThrum = "" THEN bitUseThrum = "0"

		DIM strFileName, strCodeText

		strFileName = strSourceType & ".asp"
		IF strSourceType = "extend" THEN
			strCodeText = GetReadFromTextFile(GetNowFolderPath("../board/main_design/" & strDataType) & "\" & strFileName,"utf-8")
		ELSE
			strCodeText = GetReadFromTextFile(GetNowFolderPath("../board/main_design/" & strDataType & "/" & strFolder) & "\" & strFileName,"utf-8")
		END IF

		SELECT CASE strSourceType
		CASE "code"
			strCodeText = REPLACE(strCodeText, "{{board_srl}}", strBoardSrl)
			strCodeText = REPLACE(strCodeText, "{{count}}", intListCount)
			strCodeText = REPLACE(strCodeText, "{{data_type}}", strDataType)

			IF strCutText(0) = "" OR strCutText(0) = "0" THEN strCodeText = REPLACE(strCodeText, "{{title}}", "&lt;%=RS(""strTitle"")%&gt;") ELSE strCodeText = REPLACE(strCodeText, "{{title}}", "&lt;%=GetCutDispData(RS(""strTitle"")," & strCutText(0) & ", "".."")%&gt;")

			IF strCutText(1) = "" OR strCutText(1) = "0" THEN strCodeText = REPLACE(strCodeText, "{{content}}", "&lt;%=RS(""strContent"")%&gt;") ELSE strCodeText = REPLACE(strCodeText, "{{content}}", "&lt;%=GetCutDispData(RS(""strContent"")," & strCutText(1) & ", "".."")%&gt;")

			strCodeText = REPLACE(strCodeText, "{{link_title}}", LCASE(REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")) & "?Act=bbs&subAct=view&bid=&lt;%=RS(""strBoardID"")%&gt;&seq=&lt;%=RS(""intSeq"")%&gt;")

			strCodeText = REPLACE(strCodeText, "{{link_board}}", LCASE(REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")) & "?bid=게시판아이디")

			IF bitUseThrum = "1" THEN
				strCodeText = REPLACE(strCodeText, "{{image}}", LCASE(REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")) & CONF_strFilePath & "/board/&lt;%=RS(""intSrl"")%&gt;/images/thrum/&lt;%=RS(""strImage"")%&gt;")
			ELSE
				strCodeText = REPLACE(strCodeText, "{{image}}", LCASE(REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")) & CONF_strFilePath & "/board/&lt;%=RS(""intSrl"")%&gt;/images/&lt;%=RS(""strImage"")%&gt;")
			END IF

			strCodeText = REPLACE(strCodeText, "{{=", "&lt;%=")
			strCodeText = REPLACE(strCodeText, "}}", "%&gt;")

			strCodeText = "&lt;!-- #include file = """ & LCASE(REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")) & "files/config/db.config.asp"" --&gt;" & CHR(10) & "&lt;!-- #include file = """ & LCASE(REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")) & "libs/dbconn.asp"" --&gt;" & CHR(10) & "&lt;!-- #include file = """ & LCASE(REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")) & "libs/function.asp"" --&gt;" & CHR(10) & strCodeText
			strCodeText = REPLACE(REPLACE(strCodeText, "&lt;", "<"), "&gt;", ">")
		END SELECT

		RESPONSE.WRITE strCodeText

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	RESPONSE.End()

	DBCON.CLOSE
%>