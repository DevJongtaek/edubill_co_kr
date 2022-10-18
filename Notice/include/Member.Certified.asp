<!-- #include file = "Member.Default.asp" -->
<%
	IF CONF_bitDispAgree = True THEN
		IF REQUEST.FORM("checkMemberType") = "" OR REQUEST.FORM("checkMemberAgree") = "" THEN
			RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_access_page"), "url", "/")
			RESPONSE.End()
		END IF
	END IF

	IF CONF_bitUseNameCheck = True THEN
		IF REQUEST.FORM("checkMemberSsn") = "" THEN
			RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_access_page"), "url", "/")
			RESPONSE.End()
		END IF
	END IF

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="extForm" name="extForm" method="post">
<input type="hidden" name="checkMemberType" value="<%=REQUEST.FORM("checkMemberType")%>" />
<input type="hidden" name="checkMemberAgree" value="<%=REQUEST.FORM("checkMemberAgree")%>" />
<input type="hidden" name="checkMemberSsn" value="<%=REQUEST.FORM("checkMemberSsn")%>" />
<input type="hidden" name="checkMemberSsnData1" value="<%=REQUEST.FORM("checkMemberSsnData1")%>" />
<input type="hidden" name="checkMemberSsnData2" value="<%=REQUEST.FORM("checkMemberSsnData2")%>" />
<input type="hidden" name="checkMemberAuth" value="1" />
<input type="hidden" id="checkMemberAuthEmail" name="checkMemberAuthEmail" />
</form>