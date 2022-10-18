<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "A02"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.FORM("Act"), ""))

		DIM memberSrl, strMenuID, tmpFor

		SELECT CASE Act
		CASE "staffadd", "staffmodify"

			memberSrl = REQUEST.FORM("memberSrl")

			FOR tmpFor = 1 TO REQUEST.FORM("menuID").COUNT

				strMenuID = strMenuID & REQUEST.FORM("menuID")(tmpFor) & ","

			NEXT

			DBCON.EXECUTE("[ARTY30_SP_STAFF_MENU_ADD] '" & memberSrl & "', '" & strMenuID & "' ")

		CASE "staffremove"

			FOR tmpFor = 1 TO REQUEST.FORM("memberSrl").COUNT

				DBCON.EXECUTE("[ARTY30_SP_STAFF_MENU_ADD] '" & REQUEST.FORM("memberSrl")(tmpFor) & "', '' ")

			NEXT

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF
%>