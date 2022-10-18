<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C02"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM strBrowserTitle, strMasterName, strMasterEmail, strLayoutCode, strSkinName, strSkinColor, strSkinLang, bitUseJoin
		DIM bitAuth, bitDispAgree, bitUseJoinKids, bitUseJoinCorp, bitUseCertified, bitUseEmailCheck, bitUseSmsCheck, strJoinGroup
		DIM intJoinLevel, strJoinPointTitle, intJoinPoint, bitSendJoinEmail, bitDispLevelIcon, strLevelIconFolder, bitUsePhoto, strPhotoSize
		DIM bitUseNameImg, strNameImgSize, bitUseMarkImg, strMarkImgSize, strJoinAct, strJoinActMsg, strJoinActUrl
		DIM strJoinActScript, strEditAct, strEditActMsg, strEditActUrl, strEditActScript, strOutOption, strOutAct
		DIM strOutActMsg, strOutActUrl, strOutActScript, strOutMemo, strAccountFind, strLoginPointTitle, intLoginPoint
		DIM strLoginAct, strLoginActMsg
		DIM strLoginActUrl, strLoginActScript, strLogoutAct, strLogoutActMsg, strLogoutActUrl, strLogoutActScript
		DIM bitUseNameCheck, strNameCheckCorp, strNameCkeckID, strNameCheckPwd

		WITH REQUEST
	
			strBrowserTitle    = GetInputReplce(.FORM("strBrowserTitle"), "")
			strMasterName      = GetInputReplce(.FORM("strMasterName"), "")
			strMasterEmail     = GetInputReplce(.FORM("strMasterEmail"), "")
			strLayoutCode      = GetInputReplce(.FORM("strLayoutCode"), "")
			strSkinName        = GetInputReplce(.FORM("strSkinName"), "")
			strSkinColor       = GetInputReplce(.FORM("strSkinColor"), "")
			strSkinLang        = GetInputReplce(.FORM("strSkinLang"), "")
			bitUseJoin         = GetInputReplce(.FORM("bitUseJoin"), "")
			bitAuth            = GetInputReplce(.FORM("bitAuth"), "")
			bitDispAgree       = GetInputReplce(.FORM("bitDispAgree"), "")
			bitUseJoinKids     = GetInputReplce(.FORM("bitUseJoinKids"), "")
			bitUseJoinCorp     = GetInputReplce(.FORM("bitUseJoinCorp"), "")
			bitUseCertified    = GetInputReplce(.FORM("bitUseCertified"), "")
			bitUseEmailCheck   = GetInputReplce(.FORM("bitUseEmailCheck"), "")
			bitUseSmsCheck     = GetInputReplce(.FORM("bitUseSmsCheck"), "")
			strJoinGroup       = GetInputReplce(.FORM("strJoinGroup"), "")
			intJoinLevel       = GetInputReplce(.FORM("intJoinLevel"), "")
			strJoinPointTitle  = GetInputReplce(.FORM("strJoinPointTitle"), "")
			intJoinPoint       = GetInputReplce(.FORM("intJoinPoint"), "")
			bitSendJoinEmail   = GetInputReplce(.FORM("bitSendJoinEmail"), "")
			bitDispLevelIcon   = GetInputReplce(.FORM("bitDispLevelIcon"), "")
			strLevelIconFolder = GetInputReplce(.FORM("strLevelIconFolder"), "")
			bitUsePhoto        = GetInputReplce(.FORM("bitUsePhoto"), "")
			strPhotoSize       = GetInputReplce(.FORM("strPhotoSize")(1) & "," & .FORM("strPhotoSize")(2), "")
			bitUseNameImg      = GetInputReplce(.FORM("bitUseNameImg"), "")
			strNameImgSize     = GetInputReplce(.FORM("strNameImgSize")(1) & "," & .FORM("strNameImgSize")(2), "")
			bitUseMarkImg      = GetInputReplce(.FORM("bitUseMarkImg"), "")
			strMarkImgSize     = GetInputReplce(.FORM("strMarkImgSize")(1) & "," & .FORM("strMarkImgSize")(2), "")
			strJoinAct         = GetInputReplce(.FORM("strJoinAct"), "")
			strJoinActMsg      = GetInputReplce(.FORM("strJoinActMsg"), "")
			strJoinActUrl      = GetInputReplce(.FORM("strJoinActUrl"), "")
			strJoinActScript   = GetInputReplce(.FORM("strJoinActScript"), False)
			strEditAct         = GetInputReplce(.FORM("strEditAct"), "")
			strEditActMsg      = GetInputReplce(.FORM("strEditActMsg"), "")
			strEditActUrl      = GetInputReplce(.FORM("strEditActUrl"), "")
			strEditActScript   = GetInputReplce(.FORM("strEditActScript"), False)
			strOutOption       = GetInputReplce(.FORM("strOutOption"), "")
			strOutAct          = GetInputReplce(.FORM("strOutAct"), "")
			strOutActMsg       = GetInputReplce(.FORM("strOutActMsg"), "")
			strOutActUrl       = GetInputReplce(.FORM("strOutActUrl"), "")
			strOutActScript    = GetInputReplce(.FORM("strOutActScript"), False)
			strOutMemo         = GetInputReplce(.FORM("strOutMemo"), "")
			strAccountFind     = GetInputReplce(.FORM("strAccountFind"), "")
			strLoginPointTitle = GetInputReplce(.FORM("strLoginPointTitle"), "")
			intLoginPoint      = GetInputReplce(.FORM("intLoginPoint"), "")
			strLoginAct        = GetInputReplce(.FORM("strLoginAct"), "")
			strLoginActMsg     = GetInputReplce(.FORM("strLoginActMsg"), "")
			strLoginActUrl     = GetInputReplce(.FORM("strLoginActUrl"), "")
			strLoginActScript  = GetInputReplce(.FORM("strLoginActScript"), False)
			strLogoutAct       = GetInputReplce(.FORM("strLogoutAct"), "")
			strLogoutActMsg    = GetInputReplce(.FORM("strLogoutActMsg"), "")
			strLogoutActUrl    = GetInputReplce(.FORM("strLogoutActUrl"), "")
			strLogoutActScript = GetInputReplce(.FORM("strLogoutActScript"), False)
			bitUseNameCheck    = GetInputReplce(.FORM("bitUseNameCheck"), "")
			strNameCheckCorp   = GetInputReplce(.FORM("strNameCheckCorp"), "")
			strNameCkeckID     = GetInputReplce(.FORM("strNameCkeckID"), "")
			strNameCheckPwd    = GetInputReplce(.FORM("strNameCheckPwd"), "")
	
		END WITH
		
		IF intJoinPoint = "" THEN intJoinPoint = 0
		IF intLoginPoint = "" THEN intLoginPoint = 0

		IF bitUseNameCheck = "1" OR bitUseJoinKids = "1" OR bitUseJoinCorp = "1" THEN

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_READ] 'strSSN' ")

			IF RS("bitUse") = False OR RS("bitRquired") = False THEN
				IF bitUseNameCheck = "1" THEN
					RESPONSE.WRITE "ERR01"
				END IF
				IF bitUseJoinKids = "1" OR bitUseJoinCorp = "1" THEN
					RESPONSE.WRITE "ERR02"
				END IF
				RESPONSE.End()
			END IF
		END IF

		DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_UPDATE] N'" & strBrowserTitle & "', N'" & strMasterName & "', N'" & strMasterEmail & "', '" & strLayoutCode & "', '" & strSkinName & "', '" & strSkinColor & "', '" & strSkinLang & "', '" & bitUseJoin & "', '" & bitAuth & "', '" & bitDispAgree & "', '" & bitUseJoinKids & "', '" & bitUseJoinCorp & "', '" & bitUseCertified & "', '" & bitUseEmailCheck & "', '" & bitUseSmsCheck & "', '" & strJoinGroup & "', '" & intJoinLevel & "', N'" & strJoinPointTitle & "', '" & intJoinPoint & "', '" & bitSendJoinEmail & "', '" & bitDispLevelIcon & "', '" & strLevelIconFolder & "', '" & bitUsePhoto & "', '" & strPhotoSize & "', '" & bitUseNameImg & "', '" & strNameImgSize & "', '" & bitUseMarkImg & "', '" & strMarkImgSize & "', '" & strJoinAct & "', N'" & strJoinActMsg & "', '" & strJoinActUrl & "', N'" & strJoinActScript & "', '" & strEditAct & "', N'" & strEditActMsg & "', '" & strEditActUrl & "', N'" & strEditActScript & "', '" & strOutOption & "', '" & strOutAct & "', N'" & strOutActMsg & "', '" & strOutActUrl & "', N'" & strOutActScript & "', N'" & strOutMemo & "', '" & strAccountFind & "', N'" & strLoginPointTitle & "', '" & intLoginPoint & "', '" & strLoginAct & "', N'" & strLoginActMsg & "', '" & strLoginActUrl & "', N'" & strLoginActScript & "', '" & strLogoutAct & "', N'" & strLogoutActMsg & "', '" & strLogoutActUrl & "', N'" & strLogoutActScript & "', '" & bitUseNameCheck & "', '" & strNameCheckCorp & "', '" & strNameCkeckID & "', '" & strNameCheckPwd & "' ")

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>