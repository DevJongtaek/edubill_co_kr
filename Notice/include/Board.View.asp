<!-- #include file = "Board.Default.asp" -->
<!-- #include file = "../libs/md5.asp" -->
<%
	IF CONF_strReadLevel = False THEN
		RESPONSE.REDIRECT GetBoardAuthScript(CONF_strReadLevelUrl, CONF_strReadLevelLogin, REQ_intSeq, "", "", "list", "msg_not_permitted_read")
		RESPONSE.End()
	END IF

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_READ] '" & CONF_intSrl & "', '" & REQ_intSeq & "', '" & SESSION("memberSeq") & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "' ")

	IF RS.EOF THEN
		RESPONSE.REDIRECT GetBoardAuthScript(CONF_strReadLevelUrl, CONF_strReadLevelLogin, REQ_intSeq, "", "", "list", "msg_invalid_request")
		RESPONSE.End()
	END IF

	DIM AdRs_List

	IF NOT(RS.EOF) THEN AdRs_List = RS.GetRows() ELSE AdRs_List = ""

	DIM READ_intSeq, READ_intSrl, READ_intCategory, READ_strCategory, READ_intMemberSrl, READ_strGroupLevel, READ_strUserID
	DIM READ_strPassword, READ_strUserName, READ_strNickName, READ_strEmail, READ_strHomepage, READ_strTitle, READ_strContent
	DIM READ_strIpAddr, READ_strTag, READ_bitNotice, READ_bitDelete, READ_bitBad, READ_bitSecret, READ_bitMessage
	DIM READ_bitAllowComment, READ_bitAllowScrap, READ_strFile, READ_strImage, READ_intRead, READ_intVote, READ_intBlamed
	DIM READ_intComment, READ_strCommentDate, READ_strModifyDate, READ_strRegDate, READ_intPrevSeq, READ_strPrevTitle, READ_strPrevDate
	DIM READ_intNextSeq, READ_strNextTitle, READ_strNextDate, READ_strGroupLevelImg, READ_strPhotoImg, READ_strMarkImg, READ_strNameImg
	DIM READ_ExtraDataField, READ_strUserSign

	READ_intSeq          = AdRs_List(0, 0)
	READ_intSrl          = AdRs_List(1, 0)
	READ_intCategory     = AdRs_List(2, 0)
	READ_strCategory     = AdRs_List(3, 0)
	READ_intMemberSrl    = AdRs_List(4, 0)
	READ_strUserID       = AdRs_List(5, 0)
	READ_strPassword     = AdRs_List(6, 0)
	READ_strUserName     = AdRs_List(7, 0)
	READ_strNickName     = AdRs_List(8, 0)
	READ_strEmail        = AdRs_List(9, 0)
	READ_strHomepage     = AdRs_List(10, 0)
	READ_strTitle        = GetBoardTitleStyle(AdRs_List(11, 0), AdRs_List(12, 0), AdRs_List(13, 0), AdRs_List(14, 0))
	READ_strContent      = AdRs_List(15, 0)
	READ_strIpAddr       = GetHiddenIpAddr(AdRs_List(16, 0))
	READ_strTag          = AdRs_List(17, 0)
	READ_bitNotice       = AdRs_List(18, 0)
	READ_bitDelete       = AdRs_List(19, 0)
	READ_bitBad          = AdRs_List(20, 0)
	READ_bitSecret       = AdRs_List(21, 0)
	READ_bitMessage      = AdRs_List(22, 0)
	READ_bitAllowComment = AdRs_List(23, 0)
	READ_bitAllowScrap   = AdRs_List(24, 0)
	READ_strFile         = AdRs_List(25, 0)
	READ_strImage        = AdRs_List(26, 0)
	READ_intRead         = AdRs_List(27, 0)
	READ_intVote         = AdRs_List(28, 0)
	READ_intBlamed       = AdRs_List(29, 0)
	READ_intComment      = AdRs_List(30, 0)
	READ_strCommentDate  = AdRs_List(31, 0)
	READ_strModifyDate   = AdRs_List(32, 0)
	READ_strRegDate      = AdRs_List(33, 0)

	objExtraVar("strAddData1")  = REPLACE(GetNullTextChange(AdRs_List(34, 0)), "$$$", " ")
	objExtraVar("strAddData2")  = REPLACE(GetNullTextChange(AdRs_List(35, 0)), "$$$", " ")
	objExtraVar("strAddData3")  = REPLACE(GetNullTextChange(AdRs_List(36, 0)), "$$$", " ")
	objExtraVar("strAddData4")  = REPLACE(GetNullTextChange(AdRs_List(37, 0)), "$$$", " ")
	objExtraVar("strAddData5")  = REPLACE(GetNullTextChange(AdRs_List(38, 0)), "$$$", " ")
	objExtraVar("strAddData6")  = REPLACE(GetNullTextChange(AdRs_List(39, 0)), "$$$", " ")
	objExtraVar("strAddData7")  = REPLACE(GetNullTextChange(AdRs_List(40, 0)), "$$$", " ")
	objExtraVar("strAddData8")  = REPLACE(GetNullTextChange(AdRs_List(41, 0)), "$$$", " ")
	objExtraVar("strAddData9")  = REPLACE(GetNullTextChange(AdRs_List(42, 0)), "$$$", " ")
	objExtraVar("strAddData10") = REPLACE(GetNullTextChange(AdRs_List(43, 0)), "$$$", " ")
	objExtraVar("strAddData11") = REPLACE(GetNullTextChange(AdRs_List(44, 0)), "$$$", " ")
	objExtraVar("strAddData12") = REPLACE(GetNullTextChange(AdRs_List(45, 0)), "$$$", " ")
	objExtraVar("strAddData13") = REPLACE(GetNullTextChange(AdRs_List(46, 0)), "$$$", " ")
	objExtraVar("strAddData14") = REPLACE(GetNullTextChange(AdRs_List(47, 0)), "$$$", " ")
	objExtraVar("strAddData15") = REPLACE(GetNullTextChange(AdRs_List(48, 0)), "$$$", " ")

	READ_intPrevSeq      = AdRs_List(49, 0)
	READ_strPrevTitle    = AdRs_List(50, 0)
	READ_strPrevDate     = AdRs_List(51, 0)
	READ_intNextSeq      = AdRs_List(52, 0)
	READ_strNextTitle    = AdRs_List(53, 0)
	READ_strNextDate     = AdRs_List(54, 0)

	IF READ_intMemberSrl <> "0" THEN

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & READ_intMemberSrl & "' ")

		IF NOT(RS.EOF) THEN
			IF RS("bitLeave") = False THEN
				READ_strGroupLevel = RS("strGroupCode") & "," & RS("intLevel")
				READ_strUserSign   = RS("strUserSign")
			END IF
		END IF
	END IF

	READ_strGroupLevelImg = GetMemberGroupLevelIcon(READ_strGroupLevel, CONF_bitDispLevelIcon, CONF_strLevelIconFolder, CONF_strFilePath)
	READ_strPhotoImg      = GetMemberImage(READ_intMemberSrl, CONF_bitUsePhoto, "profile", CONF_strFilePath, "image", CONF_strPhotoSize(0), CONF_strPhotoSize(1))
	READ_strMarkImg       = GetMemberImage(READ_intMemberSrl, CONF_bitUseMarkImg, "mark", CONF_strFilePath, "image", CONF_strMarkImgSize(0), CONF_strMarkImgSize(1))
	READ_strNameImg       = GetMemberImage(READ_intMemberSrl, CONF_bitUseNameImg, "name", CONF_strFilePath, "image", CONF_strNameImgSize(0), CONF_strNameImgSize(1))

	IF READ_strNameImg = "" THEN
		READ_strNickName = READ_strGroupLevelImg & READ_strMarkImg & READ_strNickName
	ELSE
		READ_strNickName = READ_strGroupLevelImg & READ_strMarkImg & READ_strNameImg
	END IF

	IF READ_intMemberSrl = "0" THEN
		IF READ_strHomepage <> "" AND ISNULL(READ_strHomepage) = False THEN
			READ_strNickName = "<a href=""" & READ_strHomePage & """ onclick=""window.open(this.href);return false;"">" & READ_strNickName & "</a>"
		END IF
	ELSE
		READ_strNickName = "<a href=""#popup_menu_area"" name=""popup_menu_area"" class=""member_" & READ_intMemberSrl & """ onclick=""return false;"">" & READ_strNickName & "</a>"
	END IF

	IF AdRs_ExtraForm_Count > 0 THEN
		FOR tmpFor = 0 TO AdRs_ExtraForm_Count
			IF extraForm.use(tmpFor + 1) = True THEN
				IF extraForm.readdisp(tmpFor + 1) = True THEN
					READ_ExtraDataField = READ_ExtraDataField & ","
					READ_ExtraDataField = READ_ExtraDataField & extraForm.field(tmpFor + 1)
				END IF
			END IF
		NEXT
		READ_ExtraDataField = SPLIT(READ_ExtraDataField, ",")
	ELSE
		READ_ExtraDataField = SPLIT("", ",")
	END IF

	IF CONF_bitUseConsult = True AND CONF_bitBoardAdmin = False THEN
		IF CONF_intMemberSrl = "" OR CONF_intMemberSrl <> READ_intMemberSrl THEN
			RESPONSE.REDIRECT GetBoardAuthScript(CONF_strReadLevelUrl, CONF_strReadLevelLogin, REQ_intSeq, "", "", "list",  "msg_not_permitted_read")
			RESPONSE.End()
		END IF
	END IF

	IF READ_bitDelete = True THEN
		RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "list", "msg_not_founded")
		RESPONSE.End()
	END IF

	IF READ_bitBad = True THEN
		IF CONF_bitBoardAdmin = False THEN
			RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "list", "msg_declared_document")
			RESPONSE.End()
		END IF
	END IF

	IF READ_bitSecret = True THEN
		IF CONF_bitBoardAdmin = True THEN
			READ_bitSecret = False
		ELSE
			IF GetPasswordSessionCheck(READ_intSeq, SESSION("boardSeq")) = True THEN READ_bitSecret = False ELSE READ_bitSecret = True
		END IF
	END IF

	IF READ_bitSecret = True THEN
		IF READ_intMemberSrl = 0 THEN
			RESPONSE.REDIRECT GetPasswordFormScript(REQ_intSeq, "", "", "list", "view")
			RESPONSE.End()
		ELSE
			IF SESSION("memberSeq") = "" THEN
					RESPONSE.REDIRECT GetBoardAuthScript("", "0", "", "", "", "list", "msg_secret_document")
					RESPONSE.End()
			ELSE
				IF INT(READ_intMemberSrl) <> INT(SESSION("memberSeq") ) THEN
					RESPONSE.REDIRECT GetBoardAuthScript("", "0", "", "", "", "list", "msg_secret_document")
					RESPONSE.End()
				END IF
			END IF
		END IF
	END IF

	IF CONF_bitUsePoint = True AND CONF_intReadPoint <> 0 THEN
		IF SESSION("memberSeq") = "" THEN
			IF CONF_intReadPoint < 0 THEN
				RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "list", "msg_disallow_by_point")
				RESPONSE.End()
			END IF
		ELSE
			IF INT(SESSION("memberSeq")) <> INT(READ_intMemberSrl) THEN
				SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_READ] '', '" & SESSION("memberSeq") & "', '', '" & REQ_intSeq & "', '', '', 'read' ")
				IF RS.EOF THEN
					IF CONF_intReadPoint < 0 THEN
						SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & SESSION("memberSeq") & "' ")
						IF INT(RS("intPoint")) - (CONF_intReadPoint * -1) < 0 THEN
							RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "list", "msg_disallow_by_point")
							RESPONSE.End()
						END IF
					END IF
					DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '" & SESSION("memberSeq") & "', '" & SESSION("memberSeq") & "', '" & CONF_intReadPoint & "', N'" & CONF_strReadPoint & "', 'read', '0', '" & REQ_intSeq & "' ")
				END IF
			END IF
		END IF
	END IF

	IF READ_bitAllowComment = False THEN CONF_bitUseComment = False

	DIM CONF_strModifyLevel

	CONF_strModifyLevel = GetDocumentModifyCheck(CONF_bitBoardAdmin, READ_intMemberSrl, SESSION("memberSeq"))

	IF Act <> "document" THEN
%>
<!-- #include file = "Comment.List.asp" -->
<!-- #include file = "Comment.Write.asp" -->
<%
	END IF

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
	SET AdRs_ExtraForm = NOTHING : SET AdRs_ExtraForm_Count = NOTHING
%>