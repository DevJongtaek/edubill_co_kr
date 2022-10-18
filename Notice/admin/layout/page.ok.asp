<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "B02"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	
		DIM intSeq, strPid, strTitle, strBrowserTitle, strCateCode, strLayoutCode, strPageType, strContent, strContentFile
		DIM strAccessType, strAccessGroup, strMessage, bitUse
	
		DIM tmpFor
	
		SELECT CASE Act
	
		CASE "pageadd", "pageedit"
	
			WITH REQUEST
	
				intSeq          = GetInputReplce(.FORM("intSeq"), "")
				strPid          = GetInputReplce(.FORM("strPid"), "")
				strTitle        = GetInputReplce(.FORM("strTitle"), "")
				strBrowserTitle = GetCutInputData(GetInputReplce(.FORM("strBrowserTitle"), ""), 250)
				strCateCode     = GetInputReplce(.FORM("strCateCode"), "")
				strLayoutCode   = GetInputReplce(.FORM("strLayoutCode"), "")
				strPageType     = GetInputReplce(.FORM("strPageType"), "")
				strContent      = GetInputReplce(.FORM("strContent"), "")
				strContentFile  = GetCutInputData(GetInputReplce(.FORM("strContentFile"), ""), 250)
				strAccessType   = GetInputReplce(.FORM("strAccessType"), "")
				strAccessGroup  = GetInputReplce(.FORM("strAccessGroup"), "")
				strMessage      = GetInputReplce(.FORM("strMessage"), "")
				bitUse          = GetInputReplce(.FORM("bitUse"), "")
	
			END WITH
	
			SELECT CASE Act
			CASE "pageadd"
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_PAGE_READ] '" & strPid & "' ")
	
				IF NOT(RS.EOF) THEN
		
					RESPONSE.WRITE "EC"
		
				ELSE
	
					DBCON.EXECUTE("[ARTY30_SP_PAGE_ADD] 'W', '" & strPid & "', N'" & strTitle & "', N'" & strBrowserTitle & "', '" & strCateCode & "', '" & strLayoutCode & "', '" & strPageType & "', N'" & strContent & "', N'" & strContentFile & "', '" & strAccessType & "', N'" & strAccessGroup & "', N'" & strMessage & "', '" & bitUse & "' ")
	
					RESPONSE.WRITE "SW"
		
				END IF
	
			CASE "pageedit"
	
				DIM strPidPrev
				strPidPrev = GetInputReplce(REQUEST.FORM("strPidPrev"), "")
	
				IF strPid <> strPidPrev THEN
	
					SET RS = DBCON.EXECUTE("[ARTY30_SP_PAGE_READ] '" & strPid & "' ")
	
					IF NOT(RS.EOF) THEN
	
						RESPONSE.WRITE "EC"
						RESPONSE.End()
	
					END IF
	
				END IF

				DBCON.EXECUTE("[ARTY30_SP_PAGE_ADD] 'E', '" & strPid & "', N'" & strTitle & "', N'" & strBrowserTitle & "', '" & strCateCode & "', '" & strLayoutCode & "', '" & strPageType & "', N'" & strContent & "', N'" & strContentFile & "', '" & strAccessType & "', N'" & strAccessGroup & "', N'" & strMessage & "', '" & bitUse & "', '" & strPidPrev & "' ")
	
				RESPONSE.WRITE "SE"
	
			END SELECT
	
		CASE "pageremove"
	
			FOR tmpFor = 1 TO REQUEST.FORM("strPid").COUNT
	
				DBCON.EXECUTE("[ARTY30_SP_PAGE_REMOVE] '" & GetInputReplce(REQUEST.FORM("strPid")(tmpFor), "") & "' ")
	
			NEXT
	
		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>