<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "B01"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	
		DIM strLayoutCode, strTitle, strHeaderConts, strBrowserTitle, strLayoutAlign, intLayoutWidth, strLayOutWidth
		DIM strLayoutMargin, strBackType, strBackColor, strBackImg, strBackImgRepeat, strUserStyle, strHeaderFile
		DIM strHeaderHtml, strFooterFile, strFooterHtml, bitUse
	
		DIM tmpFor
	
		SELECT CASE Act
	
		CASE "layoutadd", "layoutedit"
	
			WITH REQUEST
	
				strLayoutCode    = GetInputReplce(.FORM("strLayoutCode"), "")
				strTitle         = GetCutInputData(GetInputReplce(.FORM("strTitle"), ""), 250)
				strHeaderConts   = GetInputReplce(.FORM("strHeaderConts"), False)
				strBrowserTitle  = GetCutInputData(GetInputReplce(.FORM("strBrowserTitle"), ""), 250)
				strLayoutAlign   = GetInputReplce(.FORM("strLayoutAlign"), "")
				intLayoutWidth   = GetInputReplce(.FORM("intLayoutWidth"), "")
				strLayoutWidth   = GetInputReplce(.FORM("strLayoutWidth"), "")
				strLayoutMargin  = GetInputReplce(.FORM("strLayoutMarginT") & "," & .FORM("strLayoutMarginR") & "," & .FORM("strLayoutMarginB") & "," & .FORM("strLayoutMarginL"), "")
				strBackType      = GetInputReplce(.FORM("strBackType"), "")
				strBackColor     = "#" & GetInputReplce(.FORM("strBackColor"), "")
				strBackImg       = GetInputReplce(.FORM("strBackImg"), "")
				strBackImgRepeat = GetInputReplce(.FORM("strBackImgRepeat"), "")
				strUserStyle     = GetInputReplce(.FORM("strUserStyle"), False)
				strHeaderFile    = GetCutInputData(GetInputReplce(.FORM("strHeaderFile"), ""), 250)
				strHeaderHtml    = GetInputReplce(.FORM("strHeaderHtml"), "")
				strFooterFile    = GetCutInputData(GetInputReplce(.FORM("strFooterFile"), ""), 250)
				strFooterHtml    = GetInputReplce(.FORM("strFooterHtml"), "")
				bitUse           = GetInputReplce(.FORM("bitUse"), "")
	
			END WITH
	
			SELECT CASE Act
			CASE "layoutadd"
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_LAYOUT_READ] 'Y' ")
	
				IF RS.EOF THEN
					strLayoutCode = "L001"
				ELSE
					strLayoutCode = INT(REPLACE(RS("strLayoutCode"), "L", "")) + 1
					FOR tmpFor = LEN(strLayoutCode) TO 2
						strLayoutCode = "0" & strLayoutCode
					NEXT
					strLayoutCode = "L" & strLayoutCode
				END IF
	
				DBCON.EXECUTE("[ARTY30_SP_LAYOUT_ADD] 'W', '" & strLayoutCode & "', N'" & strTitle & "', N'" & strHeaderConts & "', N'" & strBrowserTitle & "', '" & strLayoutAlign & "', '" & intLayoutWidth & "', '" & strLayOutWidth & "', '" & strLayoutMargin & "', '" & strBackType & "', '" & strBackColor & "', N'" & strBackImg & "', '" & strBackImgRepeat & "', N'" & strUserStyle & "', N'" & strHeaderFile & "', N'" & strHeaderHtml & "', N'" & strFooterFile & "', N'" & strFooterHtml & "', '" & bitUse & "' ")
	
				RESPONSE.WRITE "SW"
	
			CASE "layoutedit"
	
				DBCON.EXECUTE("[ARTY30_SP_LAYOUT_ADD] 'E', '" & strLayoutCode & "', N'" & strTitle & "', N'" & strHeaderConts & "', N'" & strBrowserTitle & "', '" & strLayoutAlign & "', '" & intLayoutWidth & "', '" & strLayOutWidth & "', '" & strLayoutMargin & "', '" & strBackType & "', '" & strBackColor & "', N'" & strBackImg & "', '" & strBackImgRepeat & "', N'" & strUserStyle & "', N'" & strHeaderFile & "', N'" & strHeaderHtml & "', N'" & strFooterFile & "', N'" & strFooterHtml & "', '" & bitUse & "' ")
	
				RESPONSE.WRITE "SE"
	
			END SELECT
	
		CASE "layoutremove"
	
			FOR tmpFor = 1 TO REQUEST.FORM("strLayoutCode").COUNT
	
				DBCON.EXECUTE("[ARTY30_SP_LAYOUT_REMOVE] '" & GetInputReplce(REQUEST.FORM("strLayoutCode")(tmpFor), "") & "' ")
	
			NEXT
	
		CASE "fileremove"

			CALL ActFileDelete(GetNowFolderPath("../../") & "\" & CONF_strFilePath & REPLACE(REQUEST.FORM("path"), "|", "\") & "\" & REQUEST.FORM("filename"))
	
		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>