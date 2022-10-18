<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D06"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM intSeq
		FOR EACH intSeq IN SPLIT(GetInputReplce(REQUEST.QueryString("seq"), ""), ",")

			DBCON.EXECUTE("[ARTY30_SP_DECLARED_REMOVE] '" & intSeq & "' ")

		NEXT
		
	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>