<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D02"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act, intSrl
		Act    = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
		intSrl = GetInputReplce(REQUEST.QueryString("intSrl"), "")
	
		SELECT CASE Act
		CASE "remove"
	
			DBCON.EXECUTE("[ARTY30_SP_BOARD_SKIN_UPDATE] 'Y', '" & intSrl & "' ")

		CASE "add"

			DIM strName, strValue
	
			strName  = GetInputReplce(REQUEST.FORM("fieldname"), "")
			strValue = GetInputReplce(REQUEST.FORM("fieldvalue"), "")
	
			DBCON.EXECUTE("[ARTY30_SP_BOARD_SKIN_UPDATE] 'N', '" & intSrl & "', '" & strName & "', N'" & strValue & "' ")
	
		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>