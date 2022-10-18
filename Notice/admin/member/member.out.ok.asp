<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C09"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act, tmpFor
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	
		SELECT CASE Act
		CASE "remove"
	
			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

				CALL ActFolderDelete(GetNowFolderPath("../../") & "\" & CONF_strFilePath & "\member\profile" & "\" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), ""))
				CALL ActFolderDelete(GetNowFolderPath("../../") & "\" & CONF_strFilePath & "\member\name" & "\" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), ""))
				CALL ActFolderDelete(GetNowFolderPath("../../") & "\" & CONF_strFilePath & "\member\mark" & "\" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), ""))

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_REMOVE] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")

			NEXT

		CASE "outcancel"

			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEAVE_CANCEL] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")

			NEXT	

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>