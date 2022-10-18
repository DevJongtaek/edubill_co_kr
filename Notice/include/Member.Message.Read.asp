<!-- #include file = "Member.Default.asp" -->
<%
	DIM intSeq
	intSeq = REQUEST.QueryString("seq")

	IF SESSION("memberSeq") = "" THEN

		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_session_error"), "close", "")
		RESPONSE.End()

	END IF

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_MESSAGE_READ] '" & intSeq & "', '" & SESSION("memberSeq") & "' ")

	IF RS.EOF THEN
		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_access_page"), "close", "")
		RESPONSE.End()
	END IF

	IF INT(SESSION("memberSeq")) = INT(RS("intSenderSrl")) OR INT(SESSION("memberSeq")) = INT(RS("intReceiverSrl")) THEN

		DIM intSenderSrl, READ_strSenderNick, READ_strSenderID, intReceiverSrl, READ_strReceiverNick, READ_strReceiverID
		DIM strMessageType, READ_strTitle, READ_strContent, READ_strReadedDate, READ_strRegDate

		intSenderSrl         = RS("intSenderSrl")
		READ_strSenderNick   = RS("strSenderNick")
		READ_strSenderID     = RS("strSenderID")
		intReceiverSrl       = RS("intReceiverSrl")
		READ_strReceiverNick = RS("strReceiverNick")
		READ_strReceiverID   = RS("strReceiverID")
		strMessageType       = RS("strMessageType")
		READ_strTitle        = RS("strTitle")
		READ_strContent      = RS("strContent")
		READ_strReadedDate   = RS("strReadedDate")
		READ_strRegDate      = RS("strRegDate")

		IF READ_strReadedDate = "" OR ISNULL(READ_strReadedDate) = True THEN READ_strReadedDate = "-"

	ELSE

		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_access_page"), "close", "")
		RESPONSE.End()

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>
<form id="extForm" name="extForm" method="post">
<input type="hidden" id="intSeq" value="<%=intSeq%>" />
<input type="hidden" id="intSenderSrl" name="intSenderSrl" value="<%=intSenderSrl%>" />
<input type="hidden" id="intReceiverSrl" name="intReceiverSrl" value="<%=intReceiverSrl%>" />
<input type="hidden" id="strMessageType" value="<%=strMessageType%>" />
</form>