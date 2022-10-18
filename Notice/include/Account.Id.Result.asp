<!-- #include file = "Member.Default.asp" -->
<%
	DIM strUserName, strEmail, strSSN, ssnCheck

	WITH REQUEST

		strUserName = GetInputReplce(.FORM("strUserName"), "")
		strEmail    = GetInputReplce(.FORM("strEmail"), "")
		strSSN      = GetInputReplce(.FORM("strSSN"), "")
		ssnCheck    = GetInputReplce(.FORM("ssnCheck"), "")

	END WITH

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_ACCOUNT_FIND] '0', '', N'" & strUserName & "', '" & strEmail & "', '" & strSSN & "' ")
	
	IF RS.EOF THEN

		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_membership"), "url", "?act=member&subAct=findid")
		RESPONSE.End()

	ELSE

		DIM FIND_UserID, FIND_Regdate

		WHILE NOT(RS.EOF)

			IF FIND_UserID <> "" THEN
				FIND_UserID = FIND_UserID & "$$$"
				FIND_Regdate = FIND_Regdate & "$$$"
			END IF

			FIND_UserID  = FIND_UserID & RS("strLoginID")
			FIND_Regdate = FIND_Regdate & RS("strRegDate")

		RS.MOVENEXT
		WEND

		FIND_UserID  = SPLIT(FIND_UserID, "$$$")
		FIND_Regdate = SPLIT(FIND_Regdate, "$$$")

	END IF

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="extForm">
<input type="hidden" name="strUserID" id="strUserID" />
</form>