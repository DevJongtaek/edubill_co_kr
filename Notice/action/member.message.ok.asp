<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<!-- #include file = "../libs/md5.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM subAct
	subAct = LCASE(GetInputReplce(REQUEST.QueryString("subAct"), ""))

	DIM tmpFor

	IF SESSION("memberSeq") = "" THEN
		RESPONSE.WRITE "ERROR"
		RESPONSE.End()
	ELSE

		SELECT CASE subAct
		CASE "send"
	
			DIM intSenderSrl, intReceiverSrl, strNickName, strTitle, strContent, bitSendMail, bitMailing
	
			WITH REQUEST
	
				intSenderSrl   = GetInputReplce(.FORM("intSenderSrl"), "")
				intReceiverSrl = SPLIT(GetInputReplce(.FORM("intReceiverSrl"), ""), ",")
				strTitle       = GetInputReplce(.FORM("strTitle"), "")
				strNickName    = GetInputReplce(.FORM("strNickName"), "")
				strContent     = .FORM("strContent")
				bitSendMail    = GetInputReplce(.FORM("bitSendMail"), "")
				bitMailing     = SPLIT(GetInputReplce(.FORM("bitMailing"), ""), ",")
	
			END WITH

			DIM strSendName, strSendMail, strRecvName, strRecvMail

			FOR tmpFor = 0 TO UBOUND(intReceiverSrl)

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_MESSAGE_ADD] '" & intSenderSrl & "', '" & intReceiverSrl(tmpFor) & "', N'" & strTitle & "', N'" & strContent & "' ")
		
				IF bitSendMail = "1" AND bitMailing(tmpFor) = "1" THEN
		
					SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & intSenderSrl & "' ")
		
					strSendName = RS("strNickName")
					strSendMail = RS("strEmail")
		
					SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & intReceiverSrl(tmpFor) & "' ")
		
					strRecvName = RS("strNickName")
					strRecvMail = RS("strEmail")
		
					CALL ActSendEmail(strSendName, strSendMail, strRecvName, strRecvMail, strTitle, strContent, "", "", "", "")
		
				END IF
	
			NEXT
	
			IF strNickName <> "" THEN

				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LIST_MESSAGE] '" & strNickName & "' ")

				WHILE NOT(RS.EOF)

					DBCON.EXECUTE("[ARTY30_SP_MEMBER_MESSAGE_ADD] '" & intSenderSrl & "', '" & RS("intSeq") & "', N'" & strTitle & "', N'" & strContent & "' ")

				RS.MOVENEXT
				WEND

			END IF
	
			RESPONSE.WRITE "SUCCESS"
	
		CASE "save"

			FOR tmpFor = 1 TO REQUEST.FORM("seq").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_MESSAGE_UPDATE] 'S', '" & REQUEST.FORM("seq")(tmpFor) & "' , '" & SESSION("memberSeq") & "'")

			NEXT

			RESPONSE.WRITE "SUCCESS"
			RESPONSE.End()

		CASE "remove"

			FOR tmpFor = 1 TO REQUEST.FORM("seq").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_MESSAGE_UPDATE] 'D', '" & REQUEST.FORM("seq")(tmpFor) & "', '" & SESSION("memberSeq") & "' ")

			NEXT

			RESPONSE.WRITE "SUCCESS"
			RESPONSE.End()

		END SELECT

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>