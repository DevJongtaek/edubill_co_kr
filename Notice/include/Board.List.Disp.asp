<%
	LIST_iCount                 = List_iCount + 1
	LIST_intSeq                 = AdRs_List_Temp(0, tmpFor)
	LIST_intNumber              = INT(CONF_intTotalCount) - (INT(CONF_intListCount) * (INT(REQ_intPage) - 1)) - LIST_iCount + 1
	LIST_intCategory            = AdRs_List_Temp(2, tmpFor)
	LIST_strCategory            = AdRs_List_Temp(3, tmpFor)
	LIST_intMemberSrl           = AdRs_List_Temp(4, tmpFor)
	LIST_strGroupLevel          = AdRs_List_Temp(5, tmpFor)
	LIST_strUserID              = AdRs_List_Temp(6, tmpFor)

	LIST_strUserName            = GetCutDispData(AdRs_List_Temp(8, tmpFor), CONF_strCutText(2), "")
	LIST_strNickName            = GetCutDispData(AdRs_List_Temp(9, tmpFor), CONF_strCutText(2), "")
	LIST_strEmail               = AdRs_List_Temp(10, tmpFor)
	LIST_strHomepage            = AdRs_List_Temp(11, tmpFor)

	LIST_strTitle               = GetCutDispData(AdRs_List_Temp(12, tmpFor), CONF_strCutText(0), "..")
	LIST_strTitle               = GetBoardTitleStyle(LIST_strTitle, AdRs_List_Temp(13, tmpFor), AdRs_List_Temp(14, tmpFor), AdRs_List_Temp(15, tmpFor))
	LIST_strContent             = AdRs_List_Temp(16, tmpFor)
	LIST_strContentMemo         = GetCutDispData(GetStripTags(AdRs_List_Temp(16, tmpFor)), CONF_strCutText(1), "..")
	LIST_strIpAddr              = GetHiddenIpAddr(AdRs_List_Temp(17, tmpFor))
	LIST_strTag                 = AdRs_List_Temp(18, tmpFor)
	LIST_bitNotice              = AdRs_List_Temp(19, tmpFor)
	LIST_bitDelete              = AdRs_List_Temp(20, tmpFor)
	LIST_bitBad                 = AdRs_List_Temp(21, tmpFor)
	LIST_bitSecret              = AdRs_List_Temp(22, tmpFor)
	LIST_bitMessage             = AdRs_List_Temp(23, tmpFor)
	LIST_bitAllowComment        = AdRs_List_Temp(24, tmpFor)
	LIST_bitAllowScrap          = AdRs_List_Temp(25, tmpFor)
	LIST_strFile                = AdRs_List_Temp(26, tmpFor)
	LIST_strImage               = AdRs_List_Temp(27, tmpFor)
	
	IF LIST_strImage = "" OR ISNULL(LIST_strImage) = True THEN
		LIST_strImage = ""
	ELSE
		LIST_strImage = CONF_strFilePath & "/board/" & CONF_intSrl & "/images/"
		IF CONF_bitUseThrum = True THEN LIST_strImage = LIST_strImage & "thrum/"
		LIST_strImage = LIST_strImage & AdRs_List_Temp(27, tmpFor)
	END IF
	
	LIST_intRead                = AdRs_List_Temp(28, tmpFor)
	LIST_intVote                = AdRs_List_Temp(29, tmpFor)
	LIST_intBlamed              = AdRs_List_Temp(30, tmpFor)
	LIST_intComment             = AdRs_List_Temp(31, tmpFor)
	LIST_strCommentDate         = AdRs_List_Temp(32, tmpFor)
	LIST_strModifyDate          = AdRs_List_Temp(33, tmpFor)
	LIST_strRegDate             = AdRs_List_Temp(34, tmpFor)

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
		
	objExtraVar("strAddData1")  = GetExtraVar(AdRs_List_Temp(35, tmpFor), objExtraVar("strAddData1_"))
	objExtraVar("strAddData2")  = GetExtraVar(AdRs_List_Temp(36, tmpFor), objExtraVar("strAddData2_"))
	objExtraVar("strAddData3")  = GetExtraVar(AdRs_List_Temp(37, tmpFor), objExtraVar("strAddData3_"))
	objExtraVar("strAddData4")  = GetExtraVar(AdRs_List_Temp(38, tmpFor), objExtraVar("strAddData4_"))
	objExtraVar("strAddData5")  = GetExtraVar(AdRs_List_Temp(39, tmpFor), objExtraVar("strAddData5_"))
	objExtraVar("strAddData6")  = GetExtraVar(AdRs_List_Temp(40, tmpFor), objExtraVar("strAddData6_"))
	objExtraVar("strAddData7")  = GetExtraVar(AdRs_List_Temp(41, tmpFor), objExtraVar("strAddData7_"))
	objExtraVar("strAddData8")  = GetExtraVar(AdRs_List_Temp(42, tmpFor), objExtraVar("strAddData8_"))
	objExtraVar("strAddData9")  = GetExtraVar(AdRs_List_Temp(43, tmpFor), objExtraVar("strAddData9_"))
	objExtraVar("strAddData10") = GetExtraVar(AdRs_List_Temp(44, tmpFor), objExtraVar("strAddData10_"))
	objExtraVar("strAddData11") = GetExtraVar(AdRs_List_Temp(45, tmpFor), objExtraVar("strAddData11_"))
	objExtraVar("strAddData12") = GetExtraVar(AdRs_List_Temp(46, tmpFor), objExtraVar("strAddData12_"))
	objExtraVar("strAddData13") = GetExtraVar(AdRs_List_Temp(47, tmpFor), objExtraVar("strAddData13_"))
	objExtraVar("strAddData14") = GetExtraVar(AdRs_List_Temp(48, tmpFor), objExtraVar("strAddData14_"))
	objExtraVar("strAddData15") = GetExtraVar(AdRs_List_Temp(49, tmpFor), objExtraVar("strAddData15_"))

	LIST_strModifyLevel = GetDocumentModifyCheck(CONF_bitBoardAdmin, LIST_intMemberSrl, SESSION("memberSeq"))

	AdRs_List_Temp = NULL
%>