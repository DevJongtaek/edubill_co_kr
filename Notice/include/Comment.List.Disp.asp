<%
	LIST_iCount        = List_iCount + 1
	LIST_intSeq        = AdRs_List(0, tmpFor)
	LIST_intNumber     = INT(CONF_intTotalCount) - (INT(CONF_intListCount) * (INT(REQ_intCommentPage) - 1)) - LIST_iCount + 1
	LIST_intThread     = AdRs_List(3, tmpFor)
	LIST_intDepth      = AdRs_List(4, tmpFor)
	LIST_intMemberSrl  = AdRs_List(5, tmpFor)
	LIST_strGroupLevel = AdRs_List(6, tmpFor)
	LIST_strUserID     = AdRs_List(7, tmpFor)
	LIST_struserName   = AdRs_List(8, tmpFor)
	LIST_strNickName   = AdRs_List(9, tmpFor)
	LIST_strEmail      = AdRs_List(11, tmpFor)
	LIST_strHomepage   = AdRs_List(12, tmpFor)
	LIST_strContent    = AdRs_List(13, tmpFor)
	LIST_bitSecret     = AdRs_List(14, tmpFor)

	IF LIST_bitSecret = True THEN
		IF CONF_bitBoardAdmin = True THEN
			LIST_bitSecret = False
		ELSE
			IF LIST_intMemberSrl = 0 THEN
				IF GetPasswordSessionCheck(LIST_intSeq, SESSION("commentSeq")) = True THEN LIST_bitSecret = False ELSE LIST_bitSecret = True
			ELSE
				IF SESSION("memberSeq") <> "" THEN
					IF INT(SESSION("memberSeq")) = INT(LIST_intMemberSrl) THEN LIST_bitSecret = False
				END IF
			END IF
		END IF
	END IF

	LIST_bitMessage    = AdRs_List(15, tmpFor)
	LIST_intVote       = AdRs_List(16, tmpFor)
	LIST_intBlamed     = AdRs_List(17, tmpFor)
	LIST_strIpAddr     = "*." & SPLIT(AdRs_List(18, tmpFor), ".")(1) & "." & SPLIT(AdRs_List(18, tmpFor), ".")(2) & "." & SPLIT(AdRs_List(18, tmpFor), ".")(3)
	LIST_intFileCount  = AdRs_List(19, tmpFor)
	LIST_strModifyDate = AdRs_List(20, tmpFor)
	LIST_strRegDate    = AdRs_List(21, tmpFor)

	LIST_strGroupLevelImg = GetMemberGroupLevelIcon(LIST_strGroupLevel, CONF_bitDispLevelIcon, CONF_strLevelIconFolder, CONF_strFilePath)
	LIST_strPhotoImg      = GetMemberImage(LIST_intMemberSrl, CONF_bitUsePhoto, "profile", CONF_strFilePath, "image", CONF_strPhotoSize(0), CONF_strPhotoSize(1))
	LIST_strMarkImg       = GetMemberImage(LIST_intMemberSrl, CONF_bitUseMarkImg, "mark", CONF_strFilePath, "image", CONF_strMarkImgSize(0), CONF_strMarkImgSize(1))
	LIST_strNameImg       = GetMemberImage(LIST_intMemberSrl, CONF_bitUseNameImg, "name", CONF_strFilePath, "image", CONF_strNameImgSize(0), CONF_strNameImgSize(1))

	IF LIST_strNameImg = "" THEN
		LIST_strNickName = LIST_strGroupLevelImg & LIST_strMarkImg & LIST_strNickName
	ELSE
		LIST_strNickName = LIST_strGroupLevelImg & LIST_strMarkImg & LIST_strNameImg
	END IF

	IF LIST_intMemberSrl = "0" THEN
		IF LIST_strHomepage <> "" AND ISNULL(LIST_strHomepage) = False THEN
			LIST_strNickName = "<a href=""" & LIST_strHomePage & """ onclick=""window.open(this.href);return false;"">" & LIST_strNickName & "</a>"
		END IF
	ELSE
		LIST_strNickName = "<a href=""#popup_menu_area"" name=""popup_menu_area"" class=""member_" & LIST_intMemberSrl & """ onclick=""return false;"">" & LIST_strNickName & "</a>"
	END IF

	LIST_strModifyLevel = GetDocumentModifyCheck(CONF_bitBoardAdmin, LIST_intMemberSrl, SESSION("memberSeq"))
%>