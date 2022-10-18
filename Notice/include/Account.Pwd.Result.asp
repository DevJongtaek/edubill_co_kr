<!-- #include file = "Member.Default.asp" -->
<%
	DIM strLoginID, strUserName, strEmail, strSSN, ssnCheck, strNickName

	WITH REQUEST

		strLoginID  = GetInputReplce(.FORM("strLoginID"), "")
		strUserName = GetInputReplce(.FORM("strUserName"), "")
		strEmail    = GetInputReplce(.FORM("strEmail"), "")
		strSSN      = GetInputReplce(.FORM("strSSN"), "")
		ssnCheck    = GetInputReplce(.FORM("ssnCheck"), "")

	END WITH

	DIM strRandomStr, strTempPassword
	strRandomStr = "abcdefghijklmnopqrstuvwxyz0123456789"
	
	Randomize
	FOR tmpFor = 1 TO 10
		strTempPassword = strTempPassword & MID(strRandomStr, INT((36-1+1) * Rnd + 1), 1)
	NEXT

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_ACCOUNT_FIND] '1', '" & strLoginID & "', N'" & strUserName & "', '" & strEmail & "', '" & strSSN & "' ")

	IF RS.EOF THEN

		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_membership"), "url", "?act=member&subAct=findpwd")
		RESPONSE.End()

	ELSE

		strNickName = RS("strNickName")

		DBCON.EXECUTE("[ARTY30_SP_MEMBER_PASSWORD_UPDATE] '" & RS("intSeq") & "', '" & strTempPassword & "' ")

	END IF

	DIM FIND_Password

	SELECT CASE CONF_strAccountFind
	CASE "0", "2"

		FIND_Password = strTempPassword

	CASE "1"

		FIND_Password = ""

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_READ] 'R', '', 'D005' ")

		DIM strMailSubject, strMailContent

		strMailSubject = RS("strSubject")
		strMailContent = RS("strContent")
		strMailContent = REPLACE(strMailContent, "{{userid}}", strLoginID)
		strMailContent = REPLACE(strMailContent, "{{username}}", strUserName)
		strMailContent = REPLACE(strMailContent, "{{usernick}}", strNickName)
		strMailContent = REPLACE(strMailContent, "{{userpass}}", strTempPassword)

		CALL ActSendEmail(CONF_strMasterName, CONF_strMasterEmail, strUserName, strEmail, strMailSubject, GetReplaceTag2Html(strMailContent), "", "", "", "")
		
	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>