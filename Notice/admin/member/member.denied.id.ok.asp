<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"
	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C06"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	
		SELECT CASE Act
		CASE "memberdeniedidadd"

			DIM strUserID, strDescription

			strUserID      = GetCutInputData(GetInputReplce(REQUEST.FORM("strUserID"), ""), 32)
			strDescription = GetInputReplce(REQUEST.FORM("strDescription"), "")

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DENIED_ID_LIST] 'R', '', '', '" & strUserID & "' ")

			IF RS.EOF THEN

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_DENIED_ID_ADD] '" & strUserID & "', N'" & strDescription & "' ")
				
				RESPONSE.WRITE "SW"

			ELSE

				RESPONSE.WRITE "E1"

			END IF

		CASE "memberdeniedidremove"

			DIM tmpFor

			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_DENIED_ID_REMOVE] '" & REQUEST.FORM("intSeq")(tmpFor) & "' ")

			NEXT

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>