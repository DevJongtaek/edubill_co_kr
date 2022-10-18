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

		DIM Act, strGroupCode
		Act          = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
		strGroupCode = GetInputReplce(REQUEST.QueryString("strGroupCode"), "")

		SELECT CASE Act
	
		CASE "groupadd"

			FOR tmpFor = 1 TO REQUEST.FORM("strUserID").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_MEMBER_ADD] '" & strGroupCode & "', '" & REQUEST.FORM("strUserID")(tmpFor) & "' ")

			NEXT

		CASE "groupremove"

			FOR tmpFor = 1 TO REQUEST.FORM("strUserID").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_MEMBER_REMOVE] '" & strGroupCode & "', '" & REQUEST.FORM("strUserID")(tmpFor) & "' ")

			NEXT

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>