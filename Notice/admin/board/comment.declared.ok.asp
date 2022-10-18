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

		DIM Act, intSeq
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))

		SELECT CASE Act
		CASE "declaredcanecel"

			FOR EACH intSeq IN SPLIT(GetInputReplce(REQUEST.QueryString("seq"), ""), ",")
	
				DBCON.EXECUTE("[ARTY30_SP_DECLARED_REMOVE] '" & intSeq & "' ")
	
			NEXT

		CASE "remove"

			DIM intSrl, intMemberSrl, intBoardSeq, intRemoveCount

			intRemoveCount = 0

			FOR EACH intSeq IN REQUEST.FORM("intSeq")

				SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_READ] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")

				intSrl        = RS("intSrl")
				intMemberSrl  = RS("intMemberSrl")
				intBoardSeq   = RS("intBoardSeq")

				IF ActCommentRemove(intSrl, intBoardSeq, intSeq, intMemberSrl, "0", GetNowFolderPath("../../" & CONF_strFilePath)) = True THEN intRemoveCount = intRemoveCount + 1

				RESPONSE.WRITE intRemoveCount
				RESPONSE.End()

			NEXT

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>