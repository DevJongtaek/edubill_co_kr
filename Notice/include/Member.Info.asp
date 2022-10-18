<!-- #include file = "Member.Default.asp" -->
<%
	IF SESSION("memberSeq") = "" THEN
		RESPONSE.WRITE ActFormSubmit(objXmlLang("msg_session_error"), "?act=login", "post", "strPrevUrl", "/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & "?act=member&subAct=info")
		RESPONSE.End()
	END IF

	DIM memberSeq, memberFilePath

	memberSeq      = SESSION("memberSeq")
	memberFilePath = GetNowFolderPath("") & "\" & CONF_strFilePath & "\member\"

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & memberSeq & "', '" & GetInputReplce(REQUEST.FORM("memberPwd"), "") & "' ")
	
	IF RS.EOF THEN
		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_passwords_not_match"), "", "")
		RESPONSE.End()
	END IF
%>
<!-- #include file = "../include/Member.Read.asp" -->
<%
	DIM info
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_LIST] 'R' ")

	CLASS memberDispClass

		DIM fieldName(35), title(35), subtitle(35), alertMsg(35), default(35), use(35), rquired(35), formType(35), formData(35)
		DIM width(35), dataValue(100), memo(35)

	END CLASS

	SET info = New memberDispClass

	tmpFor = 0

	WHILE NOT(RS.EOF)

		IF RS("bitCorp") = True THEN

			IF REQUEST.FORM("checkMemberType") = "C" THEN

				info.fieldName(tmpFor) = RS("strFieldName")
				info.title(tmpFor)     = RS("strTitle")
				info.subtitle(tmpFor)  = RS("strSubTitle")
				info.alertMsg(tmpFor)  = RS("strAlertMsg")
				info.rquired(tmpFor)   = RS("bitRquired")
				info.formType(tmpFor)  = RS("strFormType")
				info.formData(tmpFor)  = RS("strFormData")
				info.width(tmpFor)     = RS("intWidth")
				info.memo(tmpFor)      = RS("strDescription")

				tmpFor = tmpFor + 1

			END IF

		ELSE

			info.fieldName(tmpFor) = RS("strFieldName")
			info.title(tmpFor)     = RS("strTitle")
			info.subtitle(tmpFor)  = RS("strSubTitle")
			info.alertMsg(tmpFor)  = RS("strAlertMsg")
			info.rquired(tmpFor)   = RS("bitRquired")
			info.formType(tmpFor)  = RS("strFormType")
			info.formData(tmpFor)  = RS("strFormData")
			info.width(tmpFor)     = RS("intWidth")
			info.memo(tmpFor)      = RS("strDescription")
	
			tmpFor = tmpFor + 1

		END IF

	RS.MOVENEXT
	WEND

	DIM iCount
	iCount = 0

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="extForm">
</form>