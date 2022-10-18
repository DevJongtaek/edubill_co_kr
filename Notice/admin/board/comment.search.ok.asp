<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D04"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))

		SELECT CASE Act
		CASE "remove"

			DIM tmpFor, intSrl, intMemberSrl, intBoardSeq, intRemoveCount

			intRemoveCount = 0

			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

				SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_READ] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")

				intSrl        = RS("intSrl")
				intMemberSrl  = RS("intMemberSrl")
				intBoardSeq   = RS("intBoardSeq")

				IF ActCommentRemove(intSrl, intBoardSeq, GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), ""), intMemberSrl, "0", GetNowFolderPath("../../" & CONF_strFilePath)) = True THEN
					intRemoveCount = intRemoveCount + 1
				END IF

				RESPONSE.WRITE intRemoveCount
				RESPONSE.End()

			NEXT

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>