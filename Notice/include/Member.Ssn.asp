<!-- #include file = "Member.Default.asp" -->
<%
	IF CONF_bitDispAgree = True THEN
		IF REQUEST.FORM("checkMemberAgree") = "" OR REQUEST.FORM("checkMemberType") = "" THEN
			RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_access_page"), "url", "/")
			RESPONSE.End()
		END IF
	END IF

	IF CONF_bitUseNameCheck = True THEN
		SELECT CASE CONF_strNameCheckCorp
		CASE "1"
%>
<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.msg.js"></script>
<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>
<%
		END SELECT
	END IF

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="extForm" name="extForm" method="post">
<input type="hidden" id="checkMemberType" name="checkMemberType" value="<%=REQUEST.FORM("checkMemberType")%>" />
<input type="hidden" id="checkMemberAgree" name="checkMemberAgree" value="<%=REQUEST.FORM("checkMemberAgree")%>" />
<input type="hidden" id="bitUseNameCheck" name="bitUseNameCheck" value="<%=GetBitTypeNumberChg(CONF_bitUseNameCheck)%>" />
<input type="hidden" id="strNameCheckCorp" name="strNameCheckCorp" value="<%=CONF_strNameCheckCorp%>" />
<input type="hidden" id="c_name" name="c_name" />
<input type="hidden" id="c_ssn" name="c_ssn" />
<!-- 실명인증 1업체 필요 필드 -->
<input type="hidden" id="SendInfo" name="SendInfo">
<!-- 실명인증 1업체 필요 필드 -->
</form>