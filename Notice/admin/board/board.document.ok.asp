<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D09"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))

		DIM strDocCode, strTitle, strContent, bitUse

		SELECT CASE Act
		CASE "boarddocumentadd", "boarddocumentmodify"

			WITH REQUEST
	
				strDocCode = GetInputReplce(.FORM("strDocCode"), "")
				strTitle   = GetInputReplce(.FORM("strTitle"), "")
				strContent = GetInputReplce(.FORM("strContent"), "")
				bitUse     = GetInputReplce(.FORM("bitUse"), "")
	
			END WITH

			SELECT CASE Act
			CASE "boarddocumentadd"

				SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_DOCUMENT_READ] '', 'Y' ")

				IF RS.EOF THEN
					strDocCode = "D000000001"
				ELSE
					strDocCode = INT(RIGHT(RS("strDocCode"), 9)) + 1
					FOR tmpFor = LEN(strDocCode) TO 8
						strDocCode = "0" & strDocCode
					NEXT
					strDocCode = "D" & strDocCode
				END IF

				DBCON.EXECUTE("[ARTY30_SP_BOARD_DOCUMENT_ADD] 'W', '" & strDocCode & "', N'" & strTitle & "', N'" & strContent & "', '" & bitUse & "' ")

				RESPONSE.WRITE "SW"
				RESPONSE.End()

			CASE "boarddocumentmodify"

				DBCON.EXECUTE("[ARTY30_SP_BOARD_DOCUMENT_ADD] 'E', '" & strDocCode & "', N'" & strTitle & "', N'" & strContent & "', '" & bitUse & "' ")

				RESPONSE.WRITE "SE"
				RESPONSE.End()

			END SELECT

		CASE "boarddocumentremove"
		
			DIM tmpFor
			FOR tmpFor = 1 TO REQUEST.FORM("strDocCode").COUNT

				DBCON.EXECUTE("[ARTY30_SP_BOARD_DOCUMENT_REMOVE] '" & REQUEST.FORM("strDocCode")(tmpFor) & "' ")

			NEXT
		
		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>