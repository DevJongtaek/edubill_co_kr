<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	DIM Act, subAct
	Act    = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	subAct = GetInputReplce(REQUEST.QueryString("subAct"), "")

	IF subAct = "" THEN subAct = "list"

	DIM REQ_strBid, REQ_intPage, REQ_intCategory, REQ_strOrderIndex, REQ_strOrderType, REQ_strSearchTarget, REQ_strSearchKeyword
	DIM REQ_strListType, REQ_intSeq

	REQ_strBid           = GetInputReplce(REQUEST.QueryString("bid"), "")
	REQ_intPage          = GetInputReplce(REQUEST.QueryString("page"), "")
	REQ_intCategory      = GetInputReplce(REQUEST.QueryString("category"), "")
	REQ_strOrderIndex    = GetInputReplce(REQUEST.QueryString("order_index"), "")
	REQ_strOrderType     = GetInputReplce(REQUEST.QueryString("order_type"), "")
	REQ_strSearchTarget  = GetInputReplce(REQUEST.QueryString("search_target"), "")
	REQ_strSearchKeyword = GetInputReplce(REQUEST.QueryString("search_keyword"), "")
	REQ_strListType      = GetInputReplce(REQUEST.QueryString("list_style"), "")
	REQ_intSeq           = GetInputReplce(REQUEST.QueryString("seq"), "")

	IF REQ_intCategory <> "" THEN
		IF GetNumericCheck(REQ_intCategory, "i") = False THEN REQ_intCategory = ""
	END IF

	IF REQ_intSeq <> "" THEN
		IF GetNumericCheck(REQ_intSeq, "i") = False THEN REQ_intSeq = 0
	END IF

	DIM CONF_intSrl, CONF_strTitle, CONF_strSkinName, CONF_strSkinColor, CONF_strSkinLang, CONF_skinPath, CONF_bitUseConsult
	DIM CONF_bitUseSecret, CONF_bitDispNotice, CONF_strOrderField, CONF_strOrderDescAsc, CONF_intListCount, CONF_strCutText
	DIM CONF_intCutTitle, CONF_intCutContent, CONF_intCutUserName, CONF_intPageSet, CONF_strDispListField
	DIM CONF_bitDispPrevNextList, CONF_bitDispReadList, CONF_bitUseComment, CONF_bitUseCommentReply, CONF_intCommentListCount
	DIM CONF_intCommentEditorHeight, CONF_strCommentEditorBgColor, CONF_strCommentEditorEtc, CONF_strCommentEditorImageWidth
	DIM CONF_strCommentEditorImageHeight, CONF_bitUseWriteCaptcha, CONF_strWriteNotName, CONF_bitUseWriteEmail
	DIM CONF_strWriteEmailList, CONF_strDocumentCode, CONF_strWriteMoveOpt, CONF_strModifyMoveOpt, CONF_intWriteEditorHeight
	DIM CONF_strWriteEditorBgColor, CONF_strWriteEditorEtc, CONF_strWriteEditorImageWidth, CONF_strWriteEditorImageHeight
	DIM CONF_bitUseUpload, CONF_intUploadFileSize, CONF_intUploadFileTotalSize, CONF_strUploadFileExt, CONF_bitUseThrum
	DIM CONF_strThrumOption, CONF_bitUseWaterMark, CONF_strWaterMarkOption, CONF_bitUseCategory, CONF_bitBoardAdmin
	DIM CONF_strAdminLink

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '', '" & REQ_strBid & "' ")

	CONF_intSrl                  = RS("intSrl")
	CONF_strTitle                = RS("strTitle")
	CONF_strSkinName             = RS("strSkinName")
	CONF_strSkinColor            = RS("strSkinColor")
	CONF_strSkinLang             = RS("strSkinLang")
	CONF_skinPath                = CONF_strBbsUrl & "skin/board/" & CONF_strSkinName & "/"
	CONF_bitUseConsult           = RS("bitUseConsult")
	CONF_bitUseSecret            = RS("bitUseSecret")
	CONF_bitDispNotice           = RS("bitDispNotice")
	CONF_strOrderField           = RS("strOrderField")
	CONF_strOrderDescAsc         = RS("strOrderDescAsc")
	CONF_intListCount            = RS("intListCount")
	CONF_strCutText              = SPLIT(RS("strCutText"), ",")
	CONF_intCutTitle             = CONF_strCutText(0)
	CONF_intCutContent           = CONF_strCutText(1)
	CONF_intCutUserName          = CONF_strCutText(2)
	CONF_intPageSet              = RS("intPageCount")
	CONF_strDispListField        = SPLIT(RS("strDispListField"), ",")
	CONF_bitDispPrevNextList     = RS("bitDispPrevNextList")
	CONF_bitDispReadList         = RS("bitDispReadList")
	CONF_bitUseComment           = RS("bitUseComment")
	CONF_bitUseCommentReply      = RS("bitUseCommentReply")
	CONF_intCommentListCount     = RS("intCommentListCount")
	CONF_intCommentEditorHeight  = RS("intCommentEditorHeight")
	CONF_strCommentEditorBgColor = RS("strCommentEditorBgColor")
	CONF_strCommentEditorEtc     = SPLIT(RS("strCommentEditorEtc"), ",")
	
	IF CONF_strCommentEditorEtc(0) = "0" THEN
		CONF_strCommentEditorImageWidth  = 0
		CONF_strCommentEditorImageHeight = 0
	ELSE
		CONF_strCommentEditorImageWidth  = CONF_strCommentEditorEtc(1)
		CONF_strCommentEditorImageHeight = CONF_strCommentEditorEtc(2)
	END IF
	
	CONF_bitUseWriteCaptcha      = RS("bitUseWriteCaptcha")																	'W
	CONF_strWriteNotName         = RS("strWriteNotName")																		'W
	CONF_bitUseWriteEmail        = RS("bitUseWriteEmail")																		'W
	CONF_strWriteEmailList       = RS("strWriteEmailList")																	'W
	CONF_strDocumentCode         = RS("strDocumentCode")																		'W
	CONF_strWriteMoveOpt         = SPLIT(RS("strWriteMoveOpt"), "$$$")
	CONF_strModifyMoveOpt        = SPLIT(RS("strModifyMoveOpt"), "$$$")
	CONF_intWriteEditorHeight    = RS("intWriteEditorHeight")																'W
	CONF_strWriteEditorBgColor   = RS("strWriteEditorBgColor")															'W
	CONF_strWriteEditorEtc       = SPLIT(RS("strWriteEditorEtc"), ",")

	IF CONF_strWriteEditorEtc(0) = "0" THEN
		CONF_strWriteEditorImageWidth = 0
		CONF_strWriteEditorImageHeight = 0
	ELSE
		CONF_strWriteEditorImageWidth = CONF_strWriteEditorEtc(1)
		CONF_strWriteEditorImageHeight = CONF_strWriteEditorEtc(2)
	END IF

	CONF_bitUseUpload            = RS("bitUseUpload")																				'W
	CONF_intUploadFileSize       = RS("intUploadFileSize")																	'W
	CONF_intUploadFileTotalSize  = RS("intUploadFileTotalSize")															'W
	CONF_strUploadFileExt        = RS("strUploadFileExt")																		'W
	CONF_bitUseThrum             = RS("bitUseThrum")																				'W
	CONF_strThrumOption          = RS("strThrumOption")																			'W
	CONF_bitUseWaterMark         = RS("bitUseWaterMark")																		'W
	CONF_strWaterMarkOption      = RS("strWaterMarkOption")																	'W
	CONF_bitUseCategory          = RS("bitUseCategory")																			'W
	CONF_bitBoardAdmin           = GetBoardAdminCheck(CONF_intSrl, SESSION("memberSeq"), SESSION("staff"))	'R
	CONF_strAdminLink            = CONF_strAdminPath & "/?act=boardconfigdefault&intSrl=" & CONF_intSrl			'R

	IF REQ_strOrderIndex = "" THEN REQ_strOrderIndex = CONF_strOrderField
	IF REQ_strOrderType  = "" THEN REQ_strOrderType  = CONF_strOrderDescAsc

	IF REQ_intPage = "" THEN
		IF REQ_intSeq <> "" THEN
			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_LIST] '" & CONF_intSrl & "', 'P', '" & REQ_intCategory & "', '', '', '" & GetBoardSearchField(REQ_strSearchTarget) & "', '" & REQ_strSearchKeyword & "', '', '', '" & GetBitTypeNumberChg(CONF_bitUseConsult) & "', '" & SESSION("memberSeq") & "', '', '" & REQ_intSeq & "' ")
			REQ_intPage = INT(RS(0) / CONF_intListCount) + 1
		ELSE
			REQ_intPage = 1
		END IF
	ELSE
		IF GetNumericCheck(REQ_intPage, "i") = False THEN intPage = 1
	END IF

	DIM CONF_strLevelIconFolder, CONF_bitDispLevelIcon, CONF_bitUsePhoto, CONF_strPhotoSize, CONF_bitUseNameImg, CONF_strNameImgSize, CONF_bitUseMarkImg, CONF_strMarkImgSize

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

	CONF_strLevelIconFolder = RS("strLevelIconFolder")
	CONF_bitDispLevelIcon   = RS("bitDispLevelIcon")
	CONF_bitUsePhoto        = RS("bitUsePhoto")
	CONF_strPhotoSize       = SPLIT(RS("strPhotoSize"), ",")
	CONF_bitUseNameImg      = RS("bitUseNameImg")
	CONF_strNameImgSize     = SPLIT(RS("strNameImgSize"), ",")
	CONF_bitUseMarkImg      = RS("bitUseMarkImg")
	CONF_strMarkImgSize     = SPLIT(RS("strMarkImgSize"), ",")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LEVEL_POINT_READ] '" & CONF_intSrl & "' ")

	DIM CONF_strListLevel, CONF_strListLevelUrl, CONF_strListLevelLogin, CONF_strWriteLevel, CONF_strWriteLevelUrl
	DIM CONF_strWriteLevelLogin, CONF_strReadLevel, CONF_strReadLevelUrl, CONF_strReadLevelLogin
	DIM CONF_bitUsePoint, CONF_intReadPoint, CONF_intWritePoint, CONF_intCmtWritePoint, CONF_intUploadPoint, CONF_intDownPoint
	DIM CONF_intVotePoint, CONF_intBlamedPoint, CONF_strReadPoint, CONF_strWritePoint, CONF_strCmtWritePoint, CONF_strUploadPoint
	DIM CONF_strDownPoint, CONF_strVotePoint, CONF_strBlamedPoint

	CONF_strListLevel       = GetBoardLevelCheck(RS("strListLevel"), SESSION("memberSeq"), SESSION("memberGroup"), RS("strListGroup"), CONF_bitBoardAdmin, CONF_bitUseConsult)

	DIM CONF_strListAction, CONF_strReadAction, CONF_strWriteAction

	CONF_strListAction  = RS("strListAction")
	CONF_strReadAction  = RS("strReadAction")
	CONF_strWriteAction = RS("strWriteAction")

	CONF_strListLevelUrl    = SPLIT(CONF_strListAction, "^$$^")(0)
	CONF_strListLevelLogin  = SPLIT(CONF_strListAction, "^$$^")(1)
	CONF_strReadLevel       = GetBoardLevelCheck(RS("strReadLevel"), SESSION("memberSeq"), SESSION("memberGroup"), RS("strReadGroup"), CONF_bitBoardAdmin, CONF_bitUseConsult)
	CONF_strReadLevelUrl    = SPLIT(CONF_strReadAction, "^$$^")(0)
	CONF_strReadLevelLogin  = SPLIT(CONF_strReadAction, "^$$^")(1)
	CONF_strWriteLevel      = GetBoardLevelCheck(RS("strWriteLevel"), SESSION("memberSeq"), SESSION("memberGroup"), RS("strWriteGroup"), CONF_bitBoardAdmin, CONF_bitUseConsult)
	CONF_strWriteLevelUrl   = SPLIT(CONF_strWriteAction, "^$$^")(0)
	CONF_strWriteLevelLogin = SPLIT(CONF_strWriteAction, "^$$^")(1)
	CONF_strCmtWriteLevel   = GetBoardLevelCheck(RS("strCmtWriteLevel"), SESSION("memberSeq"), SESSION("memberGroup"), RS("strCmtWriteGroup"), CONF_bitBoardAdmin, CONF_bitUseConsult)

	CONF_strUploadLevel     = GetBoardLevelCheck(RS("strUploadLevel"), SESSION("memberSeq"), SESSION("memberGroup"), RS("strUploadGroup"), CONF_bitBoardAdmin, CONF_bitUseConsult)
	CONF_strDownLevel       = GetBoardLevelCheck(RS("strDownLevel"), SESSION("memberSeq"), SESSION("memberGroup"), RS("strDownGroup"), CONF_bitBoardAdmin, CONF_bitUseConsult)

	IF CONF_strUploadLevel = False THEN CONF_bitUseUpload = False

	CONF_bitUsePoint      = RS("bitUsePoint")
	CONF_intReadPoint     = RS("intReadPoint")
	CONF_intWritePoint    = RS("intWritePoint")
	CONF_intCmtWritePoint = RS("intCmtWritePoint")
	CONF_intUploadPoint   = RS("intUploadPoint")
	CONF_intDownPoint     = RS("intDownPoint")
	CONF_intVotePoint     = RS("intVotePoint")
	CONF_intBlamedPoint   = RS("intBlamedPoint")
	CONF_strReadPoint     = RS("strReadPoint")
	CONF_strWritePoint    = RS("strWritePoint")
	CONF_strCmtWritePoint = RS("strCmtWritePoint")
	CONF_strUploadPoint   = RS("strUploadPoint")
	CONF_strDownPoint     = RS("strDownPoint")
	CONF_strVotePoint     = RS("strVotePoint")
	CONF_strBlamedPoint   = RS("strBlamedPoint")
	CONF_intMemberSrl     = SESSION("memberSeq")

	IF CONF_bitBoardAdmin = True THEN
		CONF_intUploadFileSize       = 10000
		CONF_intUploadFileTotalSize  = 10000
		CONF_bitUseConsult           = False
		CONF_bitUsePoint             = False
	END IF

	DIM xmlPath
	xmlPath = Server.MapPath(".") & "\skin/board/" & CONF_strSkinName & "/lang/" & CONF_strSkinLang & "/lang.xml"
%>
<!--#include file="../include/Xml.Config.asp"-->
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_LIST] '" & CONF_intSrl & "' ")

	DIM strAddFieldRecord, strAddFieldName

	WHILE NOT(RS.EOF)

		strAddFieldRecord = RS("strFieldRecord")
		strAddFieldName = RS("strFieldName")

		objXmlLang.Add strAddFieldRecord, strAddFieldName

	RS.MOVENEXT
	WEND

	DIM objSkinConfig
	SET objSkinConfig = Server.CreateObject("Scripting.Dictionary")

	xmlDOM.Load Server.MapPath(".") & "\skin/board/" & CONF_strSkinName & "/skin.xml"
	SET rootNode = xmlDOM.selectNodes(LCASE("/skin/extra_vars"))

	WITH objSkinConfig
		FOR rootLoop = 0 To rootNode(0).childNodes.Length-1
			.Add rootNode(0).childNodes(rootLoop).getAttribute("name"), rootNode(0).childNodes(rootLoop).getAttribute("default")
		NEXT
	END WITH

	DIM AdRs_GetRows, AdRs_GetRows_Count

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_SKIN_CONFIG_LIST] '" & CONF_intSrl & "' ")

	IF NOT(RS.EOF) THEN
		AdRs_GetRows 		= RS.GetRows
		AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
	END IF
			
	WITH objSkinConfig

		IF AdRs_GetRows_Count <> "" THEN
			FOR tmpFor = 0 TO AdRs_GetRows_Count
				IF AdRs_GetRows(1, tmpFor) <> "" AND ISNULL(AdRs_GetRows(1, tmpFor)) = False THEN
					objSkinConfig(AdRs_GetRows(0, tmpFor)) = AdRs_GetRows(1, tmpFor)
				END IF
			NEXT
		END IF
	
	END WITH

	DIM extraForm

	CLASS bbsAddFieldClass

		DIM field(15), title(15), formType(15), formData(15), use(15), rquired(15), readdisp(15), search(15)

	END CLASS

	SET extraForm = New bbsAddFieldClass

	tmpFor = 0

	DIM AdRs_ExtraForm, AdRs_ExtraForm_Count

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_LIST] '" & CONF_intSrl & "' ")

	IF NOT(RS.EOF) THEN
		AdRs_ExtraForm       = RS.GetRows()
		AdRs_ExtraForm_Count = UBOUND(AdRs_ExtraForm, 2)
	ELSE
		AdRs_ExtraForm       = ""
		AdRs_ExtraForm_Count = -1
	END IF

	DIM objExtraVar
	SET objExtraVar = Server.CreateObject("Scripting.Dictionary")

	FOR tmpFor = 0 TO AdRs_ExtraForm_Count

		extraForm.field(tmpFor + 1)    = AdRs_ExtraForm(0, tmpFor)
		extraForm.title(tmpFor + 1)    = AdRs_ExtraForm(1, tmpFor)
		extraForm.formType(tmpFor + 1) = AdRs_ExtraForm(2, tmpFor)
		extraForm.formData(tmpFor + 1) = AdRs_ExtraForm(3, tmpFor)
		extraForm.use(tmpFor + 1)      = AdRs_ExtraForm(8, tmpFor)

		IF AdRs_ExtraForm(8, tmpFor) = True THEN
			SELECT CASE subAct
			CASE "list", "view"
				extraForm.use(tmpFor + 1) = GetBoardLevelCheck(AdRs_ExtraForm(4, tmpFor), SESSION("memberSeq"), SESSION("memberGroup"), AdRs_ExtraForm(5, tmpFor), CONF_bitBoardAdmin, False)
			CASE "write", "modify"
				extraForm.use(tmpFor + 1) = GetBoardLevelCheck(AdRs_ExtraForm(6, tmpFor), SESSION("memberSeq"), SESSION("memberGroup"), AdRs_ExtraForm(7, tmpFor), CONF_bitBoardAdmin, False)
			END SELECT
		END IF

		extraForm.rquired(tmpFor + 1)  = AdRs_ExtraForm(9, tmpFor)
		extraForm.readdisp(tmpFor + 1) = AdRs_ExtraForm(10, tmpFor)
		extraForm.search(tmpFor + 1)   = AdRs_ExtraForm(11, tmpFor)

		objExtraVar(extraForm.field(tmpFor + 1) & "_") = extraForm.formType(tmpFor + 1)

	NEXT
%>