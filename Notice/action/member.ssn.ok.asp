<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	DIM isCertified

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

	CONF_strSkinName  = RS("strSkinName")
	CONF_strSkinLang  = RS("strSkinLang")

	IF RS("bitUseCertified") = True THEN
		IF RS("bitUseEmailCheck") = True OR RS("bitUseSmsCheck") = True THEN isCertified = True ELSE isCertified = False
	ELSE
		isCertified = False
	END IF

	bitUseNameCheck  = RS("bitUseNameCheck")
	strNameCheckCorp = RS("strNameCheckCorp")
	strNameCkeckID   = RS("strNameCkeckID")
	strNameCheckPwd  = RS("strNameCheckPwd")

	DIM xmlDOM, rootNode, firstLoop, secondLoop, thirdLoop, tmpFor
	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false

	xmlDOM.Load Server.MapPath("../") & "\lang\" & "lang." & CONF_strSkinLang & ".xml"
	SET rootNode = xmlDOM.selectNodes(LCASE("/root"))

	DIM objXmlLang
	SET objXmlLang = Server.CreateObject("Scripting.Dictionary")

	WITH objXmlLang

		FOR firstLoop = 0 To rootNode(0).childNodes.Length - 1

			IF LEFT(LCASE(rootNode(0).childNodes(firstLoop).getAttribute("name")), 7) = "option_" THEN
				.Add rootNode(0).childNodes(firstLoop).getAttribute("name"), rootNode(0).childNodes(firstLoop).getAttribute("val") & "$$$" & rootNode(0).childNodes(firstLoop).text
			ELSE
				.Add rootNode(0).childNodes(firstLoop).getAttribute("name"), rootNode(0).childNodes(firstLoop).text
			END IF

		NEXT

	END WITH

	DIM strAlertMsg, strMoveLink

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_JOIN_CHECK] 'SSN', '" & REQUEST.FORM("c_ssn") & "' ")

	IF RS(0) > 0 THEN

		strAlertMsg = objXmlLang("msg_same_ssn")
		strMoveLink = "../?act=member&subAct=ssncheck"

	ELSE

		IF bitUseNameCheck = True THEN

			SELECT CASE strNameCheckCorp
			CASE "1"
%>
<!--#include file="../libs/name_check/nice.nuguya.oivs.asp"-->
<%
				oivsObject.clientData = REQUEST.FORM("SendInfo")
				oivsObject.desClientData()
				oivsObject.niceId = strNameCkeckID
				oivsObject.callService()

				SELECT CASE oivsObject.retCd
				CASE "1"
					strAlertMsg = objXmlLang("msg_success_auth")
					IF isCertified = True THEN strMoveLink = "../?act=member&subAct=certified" ELSE strMoveLink = "../?act=member&subAct=dispform"
				CASE "2"
					strAlertMsg = objXmlLang("msg_fail_ssn")
					strMoveLink = "../?act=member&subAct=ssncheck"
				CASE "3"
					strAlertMsg = objXmlLang("msg_impossible_ssn")
					strMoveLink = "../?act=member&subAct=ssncheck"
				END SELECT

			END SELECT

		ELSE

			strAlertMsg = objXmlLang("msg_success_auth")
			IF isCertified = True THEN strMoveLink = "../?act=member&subAct=certified" ELSE strMoveLink = "../?act=member&subAct=dispform"

		END IF

	END IF

	SET RS = NOTHING : DBCON.CLOSE : SET objXmlLang = NOTHING
%>
<form name="theForm" id="theForm" method="post" action="<%=strMoveLink%>">
<input type="hidden" name="checkMemberType" value="<%=REQUEST.FORM("checkMemberType")%>" />
<input type="hidden" name="checkMemberAgree" value="<%=REQUEST.FORM("checkMemberAgree")%>" />
<input type="hidden" name="checkMemberSsn" value="1" />
<input type="hidden" name="checkMemberSsnData1" value="<%=REQUEST.FORM("c_name")%>" />
<input type="hidden" name="checkMemberSsnData2" value="<%=REQUEST.FORM("c_ssn")%>" />
</form>
<script type="text/javascript">

	alert("<%=strAlertMsg%>");
	document.getElementById("theForm").submit();

</script>