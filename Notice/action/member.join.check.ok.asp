<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	DIM subAct, checkData
	subAct    = LCASE(GetInputReplce(REQUEST.FORM("subAct"), False))
	checkData = REQUEST.FORM("checkData")

	SELECT CASE subAct
	CASE "userid"

		IF GetUserIDCheck(checkData, 3) = True THEN

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'USERID', '" & checkData & "' ")
			
			IF RS(0) = 0 THEN

				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DENIED_ID_LIST] 'R', '', '', '" & checkData & "' ")

				IF RS.EOF THEN RESPONSE.WRITE "SUCCESS" ELSE RESPONSE.WRITE "ERROR03"
				
			ELSE
				
				RESPONSE.WRITE "ERROR02"

			END IF

		ELSE

			RESPONSE.WRITE "ERROR01"

		END IF

	CASE "email"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'EMAIL', '" & checkData & "' ")
		IF RS(0) = 0 THEN RESPONSE.WRITE "SUCCESS" ELSE RESPONSE.WRITE "ERROR02"

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>