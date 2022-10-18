<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C01"
	isStaffAddLog = False
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act, intSeq, checkText
		Act       = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
		intSeq    = GetInputReplce(REQUEST.FORM("intSeq"), "")
		checkText = GetInputReplce(REQUEST.FORM("checkText"), "")

		SELECT CASE Act
		CASE "nick"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'NICKNAME', '" & checkText & "', '" & intSeq & "' ")

		CASE "email"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'EMAIL', '" & checkText & "', '" & intSeq & "' ")

		END SELECT

		RESPONSE.WRITE RS(0)

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>