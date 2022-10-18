<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C07"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act, tmpFor
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	
		SELECT CASE Act
		CASE "leveladd"

			DIM intAddLevel
			intAddLevel = GetInputReplce(REQUEST.FORM("intAddLevel"), "")

			DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_ADD] '" & intAddLevel & "' ")

		CASE "levelremove"

			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_REMOVE] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")
				
			NEXT

		CASE "levelmodify"

			DIM strLevelTitle, intPoint

			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

				strLevelTitle = GetInputReplce(REQUEST.FORM("strLevelTitle")(tmpFor), "")
				intPoint      = GetInputReplce(REQUEST.FORM("intPoint")(tmpFor), "")

				IF strLevelTitle = "" THEN strLevelTitle = "N"
				IF intPoint      = "" THEN intPoint      = 0

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_UPDATE] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "', N'" & strLevelTitle & "', '" & intPoint & "' ")

			NEXT

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>