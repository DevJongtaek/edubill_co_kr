<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"
	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C11"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM strTitle, strContent, tmpFor
	
		WITH REQUEST

			strTitle   = GetInputReplce(.FORM("strTitle"), "")
			strContent = .FORM("strContent")

		END WITH
	
		FOR tmpFor = 1 TO REQUEST.FORM("strMemberGroup").COUNT

			DBCON.EXECUTE("[ARTY30_SP_MEMBER_MESSAGE_ADD] '" & SESSION("memberSeq") & "', '0', N'" & strTitle & "', N'" & strContent & "', '1', '" & REQUEST.FORM("strMemberGroup")(tmpFor) & "' ")

		NEXT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>