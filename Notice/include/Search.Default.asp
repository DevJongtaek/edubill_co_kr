<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	DIM Act, subAct
	Act        = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	subAct     = GetInputReplce(REQUEST.QueryString("subAct"), "")
	strKeyword = GetInputReplce(REQUEST.QueryString("search_keyword"), "")
	strTarget  = GetInputReplce(REQUEST.QueryString("search_target"), "")
	intPage    = GetInputReplce(REQUEST.QueryString("intPage"), "")

	IF intPage = "" THEN
		intPage = 1
	ELSE
		IF GetNumericCheck(intPage, "i") = False THEN intPage = 1
	END IF

	DIM CONF_strBrowserTitle, CONF_strLayoutCode, CONF_strSkinName, CONF_strSkinColor, CONF_strSkinLang, CONF_skinPath
	DIM CONF_strSearchTarget, CONF_bitSearchDocument, CONF_bitSearchComment, CONF_bitSearchImage, CONF_bitSearchFile
	DIM CONF_bitSearchBoardTotal, CONF_strSearchBoard, CONF_intCutTitle, CONF_intCutContent, CONF_intImageWidth
	DIM CONF_intImageHeight, CONF_intDefaultListCount, CONF_intListCount, CONF_strLinkTarget

	SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_CONFIG] ")

	CONF_strBrowserTitle     = RS("strBrowserTitle")
	CONF_strLayoutCode       = RS("strLayoutCode")
	CONF_strSkinName         = RS("strSkinName")
	CONF_strSkinColor        = RS("strSkinColor")
	CONF_strSkinLang         = RS("strSkinLang")
	CONF_skinPath            = "skin/search/" & CONF_strSkinName & "/"
	CONF_strSearchTarget     = RS("strSearchTarget")
	CONF_bitSearchDocument   = RS("bitSearchDocument")
	CONF_bitSearchComment    = RS("bitSearchComment")
	CONF_bitSearchImage      = RS("bitSearchImage")
	CONF_bitSearchFile       = RS("bitSearchFile")
	CONF_bitSearchBoardTotal = RS("bitSearchBoardTotal")
	CONF_strSearchBoard      = RS("strSearchBoard")
	CONF_intCutTitle         = RS("intCutTitle")
	CONF_intCutContent       = RS("intCutContent")
	CONF_intImageWidth       = RS("intImageWidth")
	CONF_intImageHeight      = RS("intImageHeight")
	CONF_intDefaultListCount = RS("intDefaultListCount")
	CONF_intListCount        = RS("intListCount")
	CONF_strLinkTarget       = RS("strLinkTarget")

	IF strTarget <> "" THEN
		SELECT CASE LCASE(strTarget)
		CASE "title", "content", "tag", "title_content"
			CONF_strSearchTarget = strTarget
		END SELECT
	END IF

	IF CONF_bitSearchBoardTotal = True THEN CONF_strSearchBoard = ""

	DIM AdRs_List, AdRs_List_Count, CONF_intPageCount, CONF_intBlockPage, CONF_strSearchMode

	DIM xmlPath
	xmlPath = Server.MapPath(".") & "\skin/search/" & CONF_strSkinName & "/lang/" & CONF_strSkinLang & "/lang.xml"

	DIM LIST_iCount, LIST_intSeq, LIST_intSrl, LIST_strBoardID, LIST_strTitle, LIST_strContent, LIST_strUserID
	DIM LIST_UserName, LIST_strNickName, LIST_intRead, LIST_intVote, LIST_intBlamed, LIST_intComment, LIST_bitSecret
	DIM LIST_bitBoardAdmin, LIST_strImage, LIST_strIpAddr, LIST_strRegDate, LIST_strLink, LIST_intBoardSeq
	DIM LIST_intCommentSeq, LIST_intMemberSrl, LIST_strFilename, LIST_intSize, LIST_intDown

	LIST_iCount = 0
%>
<!--#include file="../include/Xml.Config.asp"-->
<form id="extForm" name="extForm" method="get">
<input type="hidden" id="Act" name="Act" value="<%=Act%>" />
<input type="hidden" id="subAct" name="subAct" value="<%=subAct%>" />
<input type="hidden" id="search_keyword" name="search_keyword" value="<%=strKeyword%>" />
<input type="hidden" id="search_target" name="search_target" value="<%=CONF_strSearchTarget%>" />
<input type="hidden" id="intPage" name="intPage" value="<%=intPage%>" />
</form>