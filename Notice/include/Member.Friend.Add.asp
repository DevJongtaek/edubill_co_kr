<!-- #include file = "Member.Default.asp" -->
<%
	DIM subAct, intSeq
	subAct = LCASE(GetInputReplce(REQUEST.QueryString("subAct"), ""))
	intSeq = GetInputReplce(REQUEST.QueryString("seq"), "")

	DIM READ_intGroupSrl, READ_strLoginID, READ_strUserName, READ_strNickName, READ_strMemo

	IF subAct = "friendmodify" THEN

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FRIENDS_READ] '" & intSeq & "' ")

		IF RS.EOF THEN

			RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_invalid_request"), "close", "")
			RESPONSE.End()

		END IF

		READ_intGroupSrl = RS("intGroupSrl")
		READ_strLoginID  = RS("strLoginID")
		READ_strUserName = RS("strUserName")
		READ_strNickName = RS("strNickName")
		READ_strMemo     = RS("strMemo")

		IF INT(SESSION("memberSeq")) <> INT(RS("intMemberSrl")) THEN

			RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_invalid_request"), "close", "")
			RESPONSE.End()

		END IF

	END IF

	IF SESSION("memberSeq") = "" THEN

		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_session_error"), "close", "")
		RESPONSE.End()

	END IF
%>
<form id="extForm" name="extForm" method="post">
<input type="hidden" id="subAct" value="<%=subAct%>" />
<input type="hidden" id="seq" name="seq" value="<%=intSeq%>" />
<input type="hidden" id="group_srl" name="group_srl" value="<%=READ_intGroupSrl%>" />
<input type="hidden" id="member_srl" name="member_srl" value="<%=SESSION("memberSeq")%>" />
<input type="hidden" id="friend_srl" name="friend_srl" />
<input type="hidden" id="friend_memo" name="friend_memo" />
</form>