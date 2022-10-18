<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	DIM Act
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

	DIM CONF_strMasterName, CONF_strMasterEmail, CONF_strSkinName, CONF_strSkinColor, CONF_strSkinLang, CONF_skinPath
	DIM CONF_bitUseJoin, CONF_bitDispAgree, CONF_bitUseJoinKids, CONF_bitUseJoinCorp, CONF_bitUseCertified, CONF_bitUseEmailCheck
	DIM CONF_bitUseSmsCheck, CONF_bitUsePhoto, CONF_strPhotoSize, CONF_bitUseNameImg, CONF_strNameImgSize, CONF_bitUseMarkImg
	DIM CONF_strMarkImgSize, CONF_strJoinAct, CONF_strJoinActMsg, CONF_strJoinActUrl, CONF_strJoinActScript, CONF_strEditAct
	DIM CONF_strEditActMsg, CONF_strEditActUrl, CONF_strEditActScript, CONF_strOutOption, CONF_strOutAct, CONF_strOutActMsg
	DIM CONF_strOutActUrl, CONF_strOutActScript, CONF_strOutMemo, CONF_strAccountFind, CONF_intLoginPoint, CONF_strLoginAct
	DIM CONF_strLoginActMsg, CONF_strLoginActUrl, CONF_strLoginActScript, CONF_strLogoutAct, CONF_strLogoutActMsg
	DIM CONF_strLogoutActUrl, CONF_strLogoutActScript, CONF_bitUseNameCheck, CONF_strNameCheckCorp

	CONF_strMasterName      = RS("strMasterName")
	CONF_strMasterEmail     = RS("strMasterEmail")
	CONF_strSkinName        = RS("strSkinName")
	CONF_strSkinColor       = RS("strSkinColor")
	CONF_strSkinLang        = RS("strSkinLang")
	CONF_skinPath           = CONF_strBbsUrl & "skin/member/" & CONF_strSkinName & "/"
	CONF_bitUseJoin         = RS("bitUseJoin")
	CONF_bitDispAgree       = RS("bitDispAgree")
	CONF_bitUseJoinKids     = RS("bitUseJoinKids")
	CONF_bitUseJoinCorp     = RS("bitUseJoinCorp")
	CONF_bitUseCertified    = RS("bitUseCertified")
	CONF_bitUseEmailCheck   = RS("bitUseEmailCheck")
	CONF_bitUseSmsCheck     = RS("bitUseSmsCheck")
	CONF_bitUsePhoto        = RS("bitUsePhoto")
	CONF_strPhotoSize       = SPLIT(RS("strPhotoSize"), ",")
	CONF_bitUseNameImg      = RS("bitUseNameImg")
	CONF_strNameImgSize     = SPLIT(RS("strNameImgSize"), ",")
	CONF_bitUseMarkImg      = RS("bitUseMarkImg")
	CONF_strMarkImgSize     = SPLIT(RS("strMarkImgSize"), ",")
	CONF_strJoinAct         = RS("strJoinAct")
	CONF_strJoinActMsg      = RS("strJoinActMsg")
	CONF_strJoinActUrl      = RS("strJoinActUrl")
	CONF_strJoinActScript   = RS("strJoinActScript")
	CONF_strEditAct         = RS("strEditAct")
	CONF_strEditActMsg      = RS("strEditActMsg")
	CONF_strEditActUrl      = RS("strEditActUrl")
	CONF_strEditActScript   = RS("strEditActScript")
	CONF_strOutOption       = RS("strOutOption")
	CONF_strOutAct          = RS("strOutAct")
	CONF_strOutActMsg       = RS("strOutActMsg")
	CONF_strOutActUrl       = RS("strOutActUrl")
	CONF_strOutActScript    = RS("strOutActScript")
	CONF_strOutMemo         = SPLIT(RS("strOutMemo"), CHR(10))
	CONF_strAccountFind     = RS("strAccountFind")
	CONF_intLoginPoint      = RS("intLoginPoint")
	CONF_strLoginAct        = RS("strLoginAct")
	CONF_strLoginActMsg     = RS("strLoginActMsg")
	CONF_strLoginActUrl     = RS("strLoginActUrl")
	CONF_strLoginActScript  = RS("strLoginActScript")
	CONF_strLogoutAct       = RS("strLogoutAct")
	CONF_strLogoutActMsg    = RS("strLogoutActMsg")
	CONF_strLogoutActUrl    = RS("strLogoutActUrl")
	CONF_strLogoutActScript = RS("strLogoutActScript")
	CONF_bitUseNameCheck    = RS("bitUseNameCheck")
	CONF_strNameCheckCorp   = RS("strNameCheckCorp")

	IF CONF_bitUseNameCheck = True THEN
		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_READ] 'strSSN' ")
			IF RS("bitUse") = True AND RS("bitRquired") = True THEN CONF_bitUseNameCheck = True ELSE CONF_bitUseNameCheck = False
	END IF

	DIM xmlPath
	xmlPath = Server.MapPath(".") & "\skin/member/" & CONF_strSkinName & "/lang/" & CONF_strSkinLang & "/lang.xml"
%>
<!--#include file="../include/Xml.Config.asp"-->
<script type="text/javascript" src="js/member.js"></script>
<script type="text/javascript" src="skin/member/<%=CONF_strSkinName%>/lang/<%=CONF_strSkinLang%>/lang.js"></script>
<script type="text/javascript" charset="UTF-8">

	$(document).ready(function() {

		$(".integer").numeric();

	});

</script>
<%
	IF CONF_bitUseJoin = False THEN
		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_signup"), "", "")
		RESPONSE.End()
	END IF
%>