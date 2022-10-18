<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../dbconn.asp" -->
<!-- #include file = "../function.asp" -->
<!--#include file="nice.nuguya.oivs.asp"-->
<%
	DIM strNiceId
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

	strNiceId = RS("strNameCkeckID")

	SendInfo = REQUEST.FORM("SendInfo")
	
	oivsObject.clientData = SendInfo
	oivsObject.desClientData()
	oivsObject.niceId = strNiceId
	oivsObject.callService()

	SELECT CASE oivsObject.retCd
	CASE "1"
		RESPONSE.WRITE "SUCCESS"
'		strHidden = "<input type=hidden name=strLoginName value='" & oivsObject.userNm & "'>"
'		strHidden = strHidden & "<input type=hidden name=strSSN value='" & oivsObject.resIdNo & "'>"
'		RESPONSE.WRITE ExecFormSubmitHidden("정상적으로 실명인증 처리 되었습니다.", strHidden, "join_agree.asp", "")
'		RESPONSE.End()
	CASE "2"
		RESPONSE.WRITE "ERR01"
'		RESPONSE.WRITE ExecFormSubmit("실명확인이 실패되었습니다.\n\n고객상담센터(☎ 1588-2486) 등으로 문의 하십시오.", "name_check.asp", "")
'		RESPONSE.WRITE ExecFormSubmit("실명확인이 불가능한 상태입니다.\n\n고객상담센터(☎ 1588-2486) 등으로 문의 하십시오.", "name_check.asp", "")
	CASE "3"
		RESPONSE.WRITE "ERR02"
	END SELECT

	RESPONSE.End()

	SET RS = NOTHING : DBCON.CLOSE
%>