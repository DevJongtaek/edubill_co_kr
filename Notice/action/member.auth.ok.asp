<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM subAct, checkType, checkData, inputData
	subAct    = LCASE(GetInputReplce(REQUEST.FORM("subAct"), False))
	checkType = LCASE(GetInputReplce( REQUEST.FORM("checkType"), False))
	checkData = REQUEST.FORM("checkData")
	inputData = REQUEST.FORM("inputData")

	SELECT CASE subAct
	CASE "send"

		SELECT CASE checkType
		CASE "email"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'EMAIL', '" & checkData & "' ")

			IF RS(0) > 0 THEN
				RESPONSE.WRITE "ERROR01"
				RESPONSE.End()
			END IF

			DIM strKeyData

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_AUTH] '" & checkType & "', '" & checkData & "', '" & SESSION.SessionID & "', 'I' ")

			strKeyData = RS(0)

			DIM strMasterName, strMasterEmail
			
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

			strMasterName  = RS("strMasterName")
			strMasterEmail = RS("strMasterEmail")

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_READ] 'R', '', 'D003' ")

			CALL ActSendEmail(strMasterName, strMasterEmail, checkData, checkData, RS("strSubject"), REPLACE(RS("strContent"), "{{authnum}}", strKeyData), "", "", "", "")

		END SELECT

	CASE "auth"

		SELECT CASE checkType
		CASE "email"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_AUTH] '" & checkType & "', '" & checkData & "', '" & inputData & "', 'R' ")

			RESPONSE.WRITE RS(0)

		END SELECT

	CASE "cancel"

		DBCON.EXECUTE("[ARTY30_SP_MEMBER_AUTH] '" & checkType & "', '" & checkData & "', '', 'C' ")

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>