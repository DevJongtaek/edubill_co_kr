<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D02"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
		
		SELECT CASE Act
		CASE "modify"

			DIM intSrl, bitDispNotice, strOrderField, strOrderDescAsc, intListCount, strCutText, intPageCount, strDispListField
			DIM bitDispPrevNextList, bitDispReadList, bitUseComment, bitUseCommentReply, intCommentListCount
			DIM intCommentEditorHeight, strCommentEditorBgColor, strCommentEditorEtc, bitUseWriteCaptcha, strWriteNotName
			DIM bitUseWriteEmail, strWriteEmailList, strDocumentCode, strWriteMoveOpt, strModifyMoveOpt, intWriteEditorHeight
			DIM strWriteEditorBgColor, strWriteEditorEtc, bitUseUpload, intUploadFileSize, intUploadFileTotalSize, strUploadFileExt
			DIM bitUseThrum, strThrumOption, bitUseWaterMark, strWaterMarkOption
	
			WITH REQUEST
	
				intSrl                  = GetInputReplce(.QueryString("intSrl"), "")
				bitDispNotice           = GetInputReplce(.FORM("bitDispNotice"), "")
				strOrderField           = GetInputReplce(.FORM("strOrderField"), "")
				strOrderDescAsc         = GetInputReplce(.FORM("strOrderDescAsc"), "")
				intListCount            = GetUserInputDefault(GetInputReplce(.FORM("intListCount"), ""), 20, True)
				strCutText              = GetUserInputDefault(GetInputReplce(.FORM("strCutText")(1), ""), 40, True) & "," & GetUserInputDefault(GetInputReplce(.FORM("strCutText")(2), ""), 200, True) & "," & GetUserInputDefault(GetInputReplce(.FORM("strCutText")(3), ""), 20, True)
				intPageCount            = GetUserInputDefault(GetInputReplce(.FORM("intPageCount"), ""), 10, True)
				strDispListField        = GetInputReplce(.FORM("strDispListFieldSet"), "")
				bitDispPrevNextList     = GetInputReplce(.FORM("bitDispPrevNextList"), "")
				bitDispReadList         = GetInputReplce(.FORM("bitDispReadList"), "")
				bitUseComment           = GetInputReplce(.FORM("bitUseComment"), "")
				bitUseCommentReply      = GetInputReplce(.FORM("bitUseCommentReply"), "")
				intCommentListCount     = GetUserInputDefault(GetInputReplce(.FORM("intCommentListCount"), ""), 20, True)
				intCommentEditorHeight  = GetUserInputDefault(GetInputReplce(.FORM("intCommentEditorHeight"), ""), 100, True)
				strCommentEditorBgColor = GetUserInputDefault(GetInputReplce(.FORM("strCommentEditorBgColor"), ""), "#FFFFFF", False)
				strCommentEditorEtc     = GetUserInputDefault(GetInputReplce(.FORM("strCommentEditorEtc1"), ""), "0", False) & "," & GetInputReplce(.FORM("strCommentEditorEtc2"), "") & "," & GetInputReplce(.FORM("strCommentEditorEtc3"), "")
				bitUseWriteCaptcha      = GetInputReplce(.FORM("bitUseWriteCaptcha"), "")
				strWriteNotName         = GetInputReplce(.FORM("strWriteNotName"), "")
				bitUseWriteEmail        = GetInputReplce(.FORM("bitUseWriteEmail"), "")
				strWriteEmailList       = .FORM("strWriteEmailList")
				strDocumentCode         = .FORM("strDocumentCode")
				strWriteMoveOpt         = .FORM("strWriteMoveOpt") & "$$$" & GetInputReplce(.FORM("strWriteMoveOptUrl"), "")
				strModifyMoveOpt        = .FORM("strModifyMoveOpt") & "$$$" & GetInputReplce(.FORM("strModifyMoveOptUrl"), "")
				intWriteEditorHeight    = GetUserInputDefault(GetInputReplce(.FORM("intWriteEditorHeight"), ""), 500, True)
				strWriteEditorBgColor   = GetUserInputDefault(GetInputReplce(.FORM("strWriteEditorBgColor"), ""), "#FFFFFF", False)
				strWriteEditorEtc       = GetUserInputDefault(GetInputReplce(.FORM("strWriteEditorEtc1"), ""), "0", False) & "," & GetInputReplce(.FORM("strWriteEditorEtc2"), "") & "," & GetInputReplce(.FORM("strWriteEditorEtc3"), "")
				bitUseUpload            = GetInputReplce(.FORM("bitUseUpload"), "")
				intUploadFileSize       = GetUserInputDefault(GetInputReplce(.FORM("intUploadFileSize"), ""), 2, True)
				intUploadFileTotalSize  = GetUserInputDefault(GetInputReplce(.FORM("intUploadFileTotalSize"), ""), 20, True)
				strUploadFileExt        = GetInputReplce(.FORM("strUploadFileExt"), "")
				bitUseThrum             = GetInputReplce(.FORM("bitUseThrum"), "")
				strThrumOption          = GetInputReplce(.FORM("strThrumOption1"), "") & "," & GetUserInputDefault(GetInputReplce(.FORM("strThrumOption2"), ""), 100, True) & "," & GetUserInputDefault(GetInputReplce(.FORM("strThrumOption3"), ""), 100, True) & "," & GetUserInputDefault(GetInputReplce(.FORM("strThrumOption4"), ""), "0", False)
				bitUseWaterMark         = GetInputReplce(.FORM("bitUseWaterMark"), "")
				strWaterMarkOption = .FORM("strWaterMarkOption0") & "$^^$" & .FORM("strWaterMarkOption1") & "$^^$" & GetInputReplce(.FORM("strWaterMarkOption2"), "") & "$^^$" & GetUserInputDefault(GetInputReplce(.FORM("strWaterMarkOption3"), ""), 10, True) & "$^^$" & GetUserInputDefault(GetInputReplce(.FORM("strWaterMarkOption4"), ""), 10, True) & "$^^$" & GetUserInputDefault(GetInputReplce(.FORM("strWaterMarkOption5"), ""), 10, True)
	
			END WITH
	
			DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_ADDITION_UPDATE] '" & intSrl & "', '" & bitDispNotice & "', '" & strOrderField & "', '" & strOrderDescAsc & "', '" & intListCount & "', '" & strCutText & "', '" & intPageCount & "', '" & strDispListField & "', '" & bitDispPrevNextList & "', '" & bitDispReadList & "', '" & bitUseComment & "', '" & bitUseCommentReply & "', '" & intCommentListCount & "', '" & intCommentEditorHeight & "', '" & strCommentEditorBgColor & "', '" & strCommentEditorEtc & "', '" & bitUseWriteCaptcha & "', N'" & strWriteNotName & "', '" & bitUseWriteEmail & "', N'" & strWriteEmailList & "', '" & strDocumentCode & "', N'" & strWriteMoveOpt & "', N'" & strModifyMoveOpt & "', '" & intWriteEditorHeight & "', '" & strWriteEditorBgColor & "', '" & strWriteEditorEtc & "', '" & bitUseUpload & "', '" & intUploadFileSize & "', '" & intUploadFileTotalSize & "', '" & strUploadFileExt & "', '" & bitUseThrum & "', '" & strThrumOption & "', '" & bitUseWaterMark & "', N'" & strWaterMarkOption & "' ")

		CASE "fileremove"

			CALL ActFileDelete(GetNowFolderPath("../../") & "\" & CONF_strFilePath & REPLACE(REQUEST.FORM("path"), "|", "\") & "\" & REQUEST.FORM("filename"))
	
		END SELECT
			
	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>