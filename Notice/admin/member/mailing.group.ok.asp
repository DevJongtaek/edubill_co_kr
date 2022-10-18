<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"
	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C10"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	
		SELECT CASE Act
	
		CASE "mailinggroupadd", "mailinggroupedit"

			DIM strGroupCode, strTitle, strDescription
	
			WITH REQUEST
	
				strGroupCode   = GetInputReplce(.FORM("strGroupCode"), "")
				strTitle       = GetInputReplce(GetCutInputData(.FORM("strTitle"), 200), "")
				strDescription = GetInputReplce(.FORM("strDescription"), "")
	
			END WITH
	
			SELECT CASE Act
			CASE "mailinggroupadd"
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_READ] 'Y' ")
	
				IF RS.EOF THEN
					strGroupCode = "C000000001"
				ELSE
					strGroupCode = INT(REPLACE(RS("strGroupCode"), "C", "")) + 1
					FOR tmpFor = LEN(strGroupCode) TO 8
						strGroupCode = "0" & strGroupCode
					NEXT
					strGroupCode = "C" & strGroupCode
				END IF
	
				DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_ADD] 'W', '" & strGroupCode & "', N'" & strTitle & "', N'" & strDescription & "' ")
	
				RESPONSE.WRITE "SW"
	
			CASE "mailinggroupedit"
	
				DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_ADD] 'E', '" & strGroupCode & "', N'" & strTitle & "', N'" & strDescription & "' ")
	
				RESPONSE.WRITE "SE"
	
			END SELECT

		CASE "mailinggroupremove"

			FOR tmpFor = 1 TO REQUEST.FORM("strGroupCode").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_REMOVE] '" & GetInputReplce(REQUEST.FORM("strGroupCode")(tmpFor), "") & "' ")

			NEXT

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>