<%
	LIST_iCount = List_iCount + 1

	SELECT CASE LCASE(CONF_strSearchMode)
	CASE "document"

		LIST_intSeq      = AdRs_List(0, tmpFor)
		LIST_intSrl      = AdRs_List(1, tmpFor)
		LIST_strBoardID  = AdRs_List(2, tmpFor)
		LIST_strTitle    = AdRs_List(3, tmpFor)
		LIST_strContent  = REPLACE(GetStripTags(AdRs_List(4, tmpFor)), "&nbsp;", "")

		IF CONF_intCutTitle > 0 THEN LIST_strTitle = GetCutDispData(LIST_strTitle, CONF_intCutTitle, "..")
		IF CONF_intCutContent > 0 THEN LIST_strContent = GetCutDispData(LIST_strContent, CONF_intCutContent, "..")

		LIST_intMemberSrl = AdRs_List(5, tmpFor)
		LIST_strUserID   = AdRs_List(6, tmpFor)
		LIST_UserName    = AdRs_List(7, tmpFor)
		LIST_strNickName = AdRs_List(8, tmpFor)
		LIST_intRead     = AdRs_List(9, tmpFor)
		LIST_intVote     = AdRs_List(10, tmpFor)
		LIST_intBlamed   = AdRs_List(11, tmpFor)
		LIST_intComment  = AdRs_List(12, tmpFor)
		LIST_bitSecret   = AdRs_List(13, tmpFor)

		LIST_bitBoardAdmin = GetBoardAdminCheck(CONF_intSrl, SESSION("memberSeq"), SESSION("staff"))

		IF LIST_bitSecret = True THEN
			IF LIST_bitBoardAdmin = True THEN
				LIST_bitSecret = False
			ELSE
				IF SESSION("memberSeq") <> "" AND SESSION("memberSeq") <> "0" THEN
					IF INT(LIST_intMemberSrl) = INT(SESSION("memberSeq")) THEN LIST_bitSecret = False
				END IF
			END IF
		END IF

		IF LIST_bitSecret = True THEN List_strContent = objXmlLang("secret_posts")

		LIST_strImage    = AdRs_List(14, tmpFor)
	
		IF LIST_strImage = "" OR ISNULL(LIST_strImage) = True THEN
			LIST_strImage = ""
		ELSE
			LIST_strImage = CONF_strFilePath & "/board/" & LIST_intSrl & "/images/" & AdRs_List(14, tmpFor)
		END IF

		LIST_strIpAddr   = AdRs_List(15, tmpFor)
		LIST_strRegDate  = AdRs_List(16, tmpFor)
		LIST_strLink     = "?Act=bbs&subAct=view&bid=" & LIST_strBoardID & "&seq=" & LIST_intSeq

	CASE "comment"

		LIST_intSeq        = AdRs_List(0, tmpFor)
		LIST_intSrl        = AdRs_List(1, tmpFor)
		LIST_strBoardID    = AdRs_List(2, tmpFor)
		LIST_intBoardSeq   = AdRs_List(3, tmpFor)
		LIST_intMemberSrl  = AdRs_List(4, tmpFor)
		LIST_strUserID     = AdRs_List(5, tmpFor)
		LIST_UserName      = AdRs_List(6, tmpFor)
		LIST_strNickName   = AdRs_List(7, tmpFor)
		LIST_strContent    = REPLACE(GetStripTags(AdRs_List(8, tmpFor)), "&nbsp;", "")

		IF CONF_intCutContent > 0 THEN LIST_strContent = GetCutDispData(LIST_strContent, CONF_intCutContent, "..")

		LIST_bitSecret     = AdRs_List(9, tmpFor)
		LIST_bitBoardAdmin = GetBoardAdminCheck(CONF_intSrl, SESSION("memberSeq"), SESSION("staff"))

		IF LIST_bitSecret = True THEN
			IF LIST_bitBoardAdmin = True THEN
				LIST_bitSecret = False
			ELSE
				IF SESSION("memberSeq") <> "" AND SESSION("memberSeq") <> "0" THEN
					IF INT(LIST_intMemberSrl) = INT(SESSION("memberSeq")) THEN LIST_bitSecret = False
				END IF
			END IF
		END IF

		IF LIST_bitSecret = True THEN List_strContent = objXmlLang("secret_posts")

		LIST_strIpAddr   = AdRs_List(10, tmpFor)
		LIST_strRegDate  = AdRs_List(11, tmpFor)
		LIST_strLink     = "?Act=bbs&subAct=view&bid=" & LIST_strBoardID & "&seq=" & LIST_intBoardSeq & "#comment_seq=" & LIST_intSeq

	CASE "image", "file"

		LIST_intSeq        = AdRs_List(0, tmpFor)
		LIST_intSrl        = AdRs_List(1, tmpFor)
		LIST_strBoardID    = AdRs_List(2, tmpFor)
		LIST_intBoardSeq   = AdRs_List(3, tmpFor)
		LIST_intCommentSeq = AdRs_List(4, tmpFor)
		LIST_intMemberSrl  = AdRs_List(5, tmpFor)
		LIST_strNickName   = AdRs_List(6, tmpFor)
		LIST_strFilename   = AdRs_List(7, tmpFor)

		IF CONF_strSearchMode = "image" THEN

			LIST_strImage = CONF_strFilePath
			IF LIST_intCommentSeq = "0" THEN LIST_strImage = LIST_strImage & "/board/" ELSE LIST_strImage = LIST_strImage & "/comment/"
			
			LIST_strImage = LIST_strImage & LIST_intSrl & "/images/" & LIST_strFilename

		END IF

		LIST_intSize       = GetFilesize(AdRs_List(8, tmpFor))
		LIST_intDown       = AdRs_List(9, tmpFor)
		LIST_strRegDate    = AdRs_List(10, tmpFor)
		LIST_strLink       = "?Act=bbs&subAct=view&bid=" & LIST_strBoardID & "&seq=" & LIST_intBoardSeq
		IF LIST_intCommentSeq <> "0" THEN LIST_strLink = LIST_strLink & "#comment_seq=" & LIST_intCommentSeq

	END SELECT
%>