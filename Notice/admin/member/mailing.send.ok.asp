<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"
	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C10"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	
		SELECT CASE Act
	
		CASE "mailingsendadd", "mailingsendedit"

			DIM strCode, strName, strEmail, strTitle, bitUseEditor, strContent, strContentHtml
	
			WITH REQUEST
	
				strCode        = GetInputReplce(.FORM("strCode"), "")
				strName        = GetInputReplce(.FORM("strName"), "")
				strEmail       = GetInputReplce(.FORM("strEmail"), "")
				strTitle       = GetInputReplce(.FORM("strTitle"), "")
				bitUseEditor   = GetInputReplce(.FORM("bitUseEditor"), "")
				strContent     = GetInputReplce(.FORM("strContent"), "")
				strContentHtml = GetInputReplce(.FORM("strContentHtml"), False)
	
			END WITH
	
			SELECT CASE Act
			CASE "mailingsendadd"
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_READ] 'Y' ")
	
				IF RS.EOF THEN
					strCode = "C000000001"
				ELSE
					strCode = INT(REPLACE(RS("strCode"), "C", "")) + 1
					FOR tmpFor = LEN(strCode) TO 8
						strCode = "0" & strCode
					NEXT
					strCode = "C" & strCode
				END IF
	
				DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_ADD] 'W', '" & strCode & "', N'" & strName & "', N'" & strEmail & "', N'" & strTitle & "', '" & bitUseEditor & "', N'" & strContent & "', N'" & strContentHtml & "' ")
	
				RESPONSE.WRITE "SW"
	
			CASE "mailingsendedit"
	
				DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_ADD] 'E', '" & strCode & "', N'" & strName & "', N'" & strEmail & "', N'" & strTitle & "', '" & bitUseEditor & "', N'" & strContent & "', N'" & strContentHtml & "' ")
	
				RESPONSE.WRITE "SE"
	
			END SELECT

		CASE "mailingremove"

			DIM tmpFor
			
			FOR tmpFor = 1 TO REQUEST.FORM("strCode").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_REMOVE] '" & REQUEST.FORM("strCode")(tmpFor) & "' ")

			NEXT

		CASE "mailingsendmember"

			DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_MEMBER] '0', '" & GetInputReplce(REQUEST.FORM("strCode"), "") & "' ")

			FOR tmpFor = 1 TO REQUEST.FORM("strMemberGroup").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_MEMBER] '1', '" & GetInputReplce(REQUEST.FORM("strCode"), "") & "', '" & REQUEST.FORM("strMemberGroup")(tmpFor) & "' ")

			NEXT

			FOR tmpFor = 1 TO REQUEST.FORM("strMailGroup").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_MEMBER] '2', '" & GetInputReplce(REQUEST.FORM("strCode"), "") & "', '', '" & REQUEST.FORM("strMailGroup")(tmpFor) & "' ")

			NEXT

			DIM strMemberID
			strMemberID = GetInputReplce(REQUEST.FORM("strMemberID"), "")

			IF strMemberID <> "" THEN
				strMemberID = SPLIT(strMemberID, ",")
				FOR tmpFor = 0 TO UBOUND(strMemberID)
					IF TRIM(strMemberID(tmpFor)) <> "" THEN
						DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_MEMBER] '3', '" & GetInputReplce(REQUEST.FORM("strCode"), "") & "', '', '', '" & TRIM(strMemberID(tmpFor)) & "' ")
					END IF
				NEXT
			END IF

			DIM strMemberEmail, strMemberEmailDim
			strMemberEmail = GetInputReplce(REQUEST.FORM("strMemberEmail"), "")

			IF strMemberEmail <> "" THEN
				strMemberEmail = SPLIT(strMemberEmail, ",")
				FOR tmpFor = 0 TO UBOUND(strMemberEmail)
					IF TRIM(strMemberEmail(tmpFor)) <> "" THEN
						strMemberEmailDim = SPLIT(strMemberEmail(tmpFor), ":")
						IF UBOUND(strMemberEmailDim) = 1 THEN
							DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_MEMBER] '4', '" & GetInputReplce(REQUEST.FORM("strCode"), "") & "', '', '', '', '" & strMemberEmailDim(0) & "', '" & strMemberEmailDim(1) & "' ")
						END IF
					END IF
				NEXT
			END IF

			DIM strMemberEtc
			strMemberEtc = GetInputReplce(REQUEST.FORM("strMemberEtc"), "")

			IF strMemberEtc = "1" THEN DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_MEMBER] '5', '" & GetInputReplce(REQUEST.FORM("strCode"), "") & "' ")

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_MEMBER] '6', '" & GetInputReplce(REQUEST.FORM("strCode"), "") & "' ")

			IF RS(0) = 0 THEN RESPONSE.WRITE "SR" ELSE RESPONSE.WRITE "SW"

		CASE "mailingsendprev"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_READ] 'N', '" & GetInputReplce(REQUEST.QueryString("strCode"), "") & "' ")

			IF RS("bitUseEditor") = True THEN RESPONSE.WRITE RS("strContent") ELSE RESPONSE.WRITE RS("strContentHtml")
			RESPONSE.End()

		CASE "sendmail"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_READ] 'N', '" & GetInputReplce(REQUEST.FORM("strCode"), "") & "', 'Y' ")

			DIM strSendName, strSendMail, strMailTitle, strMailContent

			strSendName  = RS("strName")
			strSendMail  = RS("strEmail")
			strMailTitle = RS("strTitle")

			IF RS("bitUseEditor") = True THEN strMailContent = RS("strContent") ELSE strMailContent = RS("strContentHtml")

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_ADDR_LIST] '" & GetInputReplce(REQUEST.FORM("strCode"), "") & "', '" & GetInputReplce(REQUEST.FORM("intPage"), "") & "', '" & GetInputReplce(REQUEST.FORM("intSendPage"), "") & "' ")
			
			WHILE NOT(RS.EOF)

				CALL ActSendEmail(strSendName, strSendMail, RS("strName"), RS("strEmail"), strMailTitle, strMailContent, "", "", "", "")
		
			RS.MOVENEXT
			WEND

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>