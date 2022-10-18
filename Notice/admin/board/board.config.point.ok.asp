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

		DIM intSrl, bitUsePoint, intReadPoint, intWritePoint, intCmtWritePoint, intUploadPoint, intDownPoint, intVotePoint
		DIM intBlamedPoint, strReadPoint, strWritePoint, strCmtWritePoint, strUploadPoint, strDownPoint, strVotePoint, strBlamedPoint

		WITH REQUEST

			intSrl           = GetInputReplce(.QueryString("intSrl"), "")
			bitUsePoint      = GetInputReplce(.FORM("bitUsePoint"), "")
			intReadPoint     = GetInputReplce(.FORM("intReadPoint"), "")
			intWritePoint    = GetInputReplce(.FORM("intWritePoint"), "")
			intCmtWritePoint = GetInputReplce(.FORM("intCmtWritePoint"), "")
			intUploadPoint   = GetInputReplce(.FORM("intUploadPoint"), "")
			intDownPoint     = GetInputReplce(.FORM("intDownPoint"), "")
			intVotePoint     = GetInputReplce(.FORM("intVotePoint"), "")
			intBlamedPoint   = GetInputReplce(.FORM("intBlamedPoint"), "")
			strReadPoint     = GetInputReplce(.FORM("strReadPoint"), "")
			strWritePoint    = GetInputReplce(.FORM("strWritePoint"), "")
			strCmtWritePoint = GetInputReplce(.FORM("strCmtWritePoint"), "")
			strUploadPoint   = GetInputReplce(.FORM("strUploadPoint"), "")
			strDownPoint     = GetInputReplce(.FORM("strDownPoint"), "")
			strVotePoint     = GetInputReplce(.FORM("strVotePoint"), "")
			strBlamedPoint   = GetInputReplce(.FORM("strBlamedPoint"), "")

		END WITH

		IF intReadPoint     = "" THEN intReadPoint     = 0
		IF intWritePoint    = "" THEN intWritePoint    = 0
		IF intCmtWritePoint = "" THEN intCmtWritePoint = 0
		IF intUploadPoint   = "" THEN intUploadPoint   = 0
		IF intDownPoint     = "" THEN intDownPoint     = 0
		IF intVotePoint     = "" THEN intVotePoint     = 0

		DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_POINT_UPDATE] '" & intSrl & "', '" & bitUsePoint & "', " & intReadPoint & ", " & intWritePoint & ", " & intCmtWritePoint & ", " & intUploadPoint & ", " & intDownPoint & ", " & intVotePoint & ", " & intBlamedPoint & ", N'" & strReadPoint & "', N'" & strWritePoint & "', N'" & strCmtWritePoint & "', N'" & strUploadPoint & "', N'" & strDownPoint & "', N'" & strVotePoint & "', N'" & strBlamedPoint & "' ")

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>