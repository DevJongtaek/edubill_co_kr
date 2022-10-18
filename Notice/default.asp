<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/jquery.format.js"></script>
<script type="text/javascript" src="js/sideview.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/jquery.sns.js"></script>
<link rel="stylesheet" type="text/css" href="style/base.css" />
<link rel="stylesheet" type="text/css" href="style/pop.menu.css" />
<!-- #include file = "files/config/db.config.asp" -->
<!-- #include file = "libs/dbconn.asp" -->
<!-- #include file = "libs/function.asp" -->
<%
	RESPONSE.AddHeader "Pragma","no-cache"
	RESPONSE.AddHeader "Cache-Control","private"
	RESPONSE.CacheControl = "no-chche"
	RESPONSE.Buffer = True
	RESPONSE.Expires = -1

	DIM Act, subAct, strPageID
	Act       = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	subAct    = LCASE(GetInputReplce(REQUEST.QueryString("subAct"), ""))
	strPageID = LCASE(GetInputReplce(REQUEST.QueryString("pid"), ""))

	DIM CONF_strBrowserTitle, CONF_strLayoutCode, CONF_strSKinName, CONF_strHeaderHtml, CONF_strFooterHtml, CONF_bitDispReadList
	DIM CONF_skinExecuteFile

	IF Act = "" THEN
		IF strPageID = "" THEN Act = "bbs" ELSE Act = "page"
	END IF

	SELECT CASE Act
	CASE "member", "login", "logout"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

		CONF_strBrowserTitle = RS("strBrowserTitle")
		CONF_strLayoutCode   = RS("strLayoutCode")
		CONF_strSKinName     = RS("strSKinName")
		CONF_bitDispAgree    = RS("bitDispAgree")
		CONF_bitUseCertified = RS("bitUseCertified")

		SELECT CASE Act
		CASE "member"

			IF subAct = "" THEN
				IF CONF_bitDispAgree = True THEN
					subAct = "agree"
				ELSE
					SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_READ] 'strSSN' ")
					IF RS("bitUse") = True AND RS("bitRquired") = True THEN
						subAct = "ssncheck"
					ELSE
						IF CONF_bitUseCertified = True THEN subAct = "certified" ELSE subAct = "dispform"
					END IF
				END IF
			END IF

			SELECT CASE subAct
			CASE "agree"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.agree.asp"
			CASE "ssncheck"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.ssn.asp"
			CASE "certified"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.certified.asp"
			CASE "dispform"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.join.asp"
			CASE "joinresult"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.join.result.asp"
			CASE "info"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.info.asp"
			CASE "modify"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.modify.check.asp"
			CASE "modifyform"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.modify.asp"
			CASE "modifyresult"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.modify.result.asp"
			CASE "modifypwd"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.modify.pwd.asp"
			CASE "out"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.out.asp"
			CASE "outresult"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.out.result.asp"
			CASE "findid"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/account.id.form.asp"
			CASE "findidresult"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/account.id.result.asp"
			CASE "findpwd"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/account.pwd.form.asp"
			CASE "findpwdresult"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/account.pwd.result.asp"
			CASE "messagesend"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/message.send.asp"
				CONF_strLayoutCode   = ""
			CASE "message"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/message.list.asp"
			CASE "messageread"
				CONF_strLayoutCode   = ""
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/message.read.asp"
			CASE "friend"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.friend.asp"
			CASE "friendadd", "friendmodify"
				CONF_strLayoutCode   = ""
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.friend.add.asp"
			CASE "friendgroup"
				CONF_strLayoutCode   = ""
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.friend.group.asp"
			CASE "scrap"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.scrap.asp"
			CASE "document"
				CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/member.document.asp"
			END SELECT

		CASE "login"

			CONF_skinExecuteFile = "skin/member/" & CONF_strSKinName & "/login.form.asp"

		CASE "logout"

			CONF_skinExecuteFile = "libs/logout.asp"

		END SELECT

	CASE "bbs"

		DIM REQ_strBid, REQ_intPage, REQ_intCategory, REQ_strOrderIndex, REQ_strOrderType, REQ_strSearchTarget
		DIM REQ_strSearchKeyword, REQ_strListType, REQ_intSeq
	
		REQ_strBid           = GetInputReplce(REQUEST.QueryString("bid"), "")
		REQ_intPage          = GetInputReplce(REQUEST.QueryString("page"), "")
		REQ_intCategory      = GetInputReplce(REQUEST.QueryString("category"), "")
		REQ_strOrderIndex    = GetInputReplce(REQUEST.QueryString("order_index"), "")
		REQ_strOrderType     = GetInputReplce(REQUEST.QueryString("order_type"), "")
		REQ_strSearchTarget  = GetInputReplce(REQUEST.QueryString("search_target"), "")
		REQ_strSearchKeyword = GetInputReplce(REQUEST.QueryString("search_keyword"), "")
		REQ_strListType      = GetInputReplce(REQUEST.QueryString("list_style"), "")
		REQ_intSeq           = GetInputReplce(REQUEST.QueryString("seq"), "")
	
		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '', '" & REQ_strBid & "' ")
		
		IF RS.EOF THEN
			RESPONSE.WRITE "ERROR"
			RESPONSE.End()
		END IF

		CONF_intSrl          = RS("intSrl")
		CONF_strBrowserTitle = RS("strBrowserTitle")
		CONF_strLayoutCode   = RS("strLayoutCode")
		CONF_strSKinName     = RS("strSKinName")
		CONF_strSkinLang     = RS("strSkinLang")
		CONF_strSkinColor    = RS("strSkinColor")
		CONF_skinPath        = CONF_strBbsUrl & "skin/board/" & CONF_strSkinName & "/"
		CONF_strHeaderHtml   = RS("strHeaderHtml")
		CONF_strFooterHtml   = RS("strFooterHtml")
		CONF_bitDispReadList = RS("bitDispReadList")
		CONF_strOrderField   = RS("strOrderField")
		CONF_strOrderDescAsc = RS("strOrderDescAsc")
		CONF_bitUseCategory  = RS("bitUseCategory")
		CONF_bitUseConsult   = RS("bitUseConsult")
		CONF_intListCount    = RS("intListCount")																				'L
		CONF_bitBoardAdmin   = GetBoardAdminCheck(CONF_intSrl, SESSION("memberSeq"), SESSION("staff"))

		IF REQ_strOrderIndex = "" THEN REQ_strOrderIndex = CONF_strOrderField
		IF REQ_strOrderType  = "" THEN REQ_strOrderType  = CONF_strOrderDescAsc

		IF REQ_intPage = "" THEN
			IF subAct = "view" THEN
				SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_LIST] '" & CONF_intSrl & "', 'P', '" & REQ_intCategory & "', '', '', '" & GetBoardSearchField(REQ_strSearchTarget) & "', '" & REQ_strSearchKeyword & "', '', '', '" & GetBitTypeNumberChg(CONF_bitUseConsult) & "', '" & SESSION("memberSeq") & "', '', '" & REQ_intSeq & "' ")
				REQ_intPage = INT(RS(0) / CONF_intListCount) + 1
			ELSE
				REQ_intPage = 1
			END IF
		ELSE
			IF GetNumericCheck(REQ_intPage, "i") = False THEN intPage = 1
		END IF
	
		IF REQ_intCategory <> "" THEN
			IF GetNumericCheck(REQ_intCategory, "i") = False THEN REQ_intCategory = ""
		END IF
	
		IF REQ_intSeq <> "" THEN
			IF GetNumericCheck(REQ_intSeq, "i") = False THEN REQ_intSeq = 0
		END IF

		IF subAct = "" THEN subAct = "list"

		SELECT CASE subAct
		CASE "list"
			CONF_skinExecuteFile = "skin/board/" & CONF_strSKinName & "/list.asp"
		CASE "view"
			CONF_skinExecuteFile = "skin/board/" & CONF_strSKinName & "/view.asp"
		CASE "write", "modify"
			CONF_skinExecuteFile = "skin/board/" & CONF_strSKinName & "/write.asp"
		CASE "remove"
			CONF_skinExecuteFile = "skin/board/" & CONF_strSKinName & "/board.remove.asp"
		CASE "message"
			CONF_skinExecuteFile = "skin/board/" & CONF_strSKinName & "/message.asp"
		CASE "password"
			CONF_skinExecuteFile = "skin/board/" & CONF_strSKinName & "/password.asp"
		CASE "comment_modify", "comment_reply"
			CONF_skinExecuteFile = "skin/board/" & CONF_strSKinName & "/comment.write.asp"
		CASE "comment_remove"
			CONF_skinExecuteFile = "skin/board/" & CONF_strSKinName & "/comment.remove.asp"
		CASE "filedown"
			CONF_skinExecuteFile = "libs/file.down.asp"
		CASE "tag"
			CONF_skinExecuteFile = "skin/board/" & CONF_strSKinName & "/tag.asp"
		END SELECT
%>
<script type="text/javascript" src="skin/board/<%=CONF_strSkinName%>/lang/<%=CONF_strSkinLang%>/lang.js"></script>
<script type="text/javascript">

	var set_bbs_default = {srl : "<%=CONF_intSrl%>", skinapth : "<%=CONF_skinPath%>", skincolor : "<%=CONF_strSkinColor%>", use_category : "<%=GetBitTypeNumberChg(CONF_bitUseCategory)%>", member_srl : "<%=SESSION("memberSeq")%>", staff_user : "<%=GetBitTypeNumberChg(CONF_bitBoardAdmin)%>"}

	$(document).ready(function() {

		$(".copyright").attr("width", "400px");

	});

</script>
<form id="extForm" name="extForm" method="get">
<input type="hidden" id="act" name="act" value="<%=Act%>" />
<input type="hidden" id="subAct" name="subAct" value="<%=subAct%>" />
<input type="hidden" id="bid" name="bid" value="<%=REQ_strBid%>" />
<input type="hidden" id="seq" name="seq" value="<%=REQ_intSeq%>" />
<input type="hidden" id="page" name="page" value="<%=REQ_intPage%>" />
<input type="hidden" id="category" name="category" value="<%=REQ_intCategory%>" />
<input type="hidden" id="order_index" name="order_index" value="<%=REQ_strOrderIndex%>" />
<input type="hidden" id="order_type" name="order_type" value="<%=REQ_strOrderType%>" />
<input type="hidden" id="search_target" name="search_target" value="<%=REQ_strSearchTarget%>" />
<input type="hidden" id="search_keyword" name="search_keyword" value="<%=REQ_strSearchKeyword%>" />
<input type="hidden" id="list_style" name="list_style" value="<%=REQ_strListType%>" />
<input type="submit" class="none" />
</form>
<%
	CASE "page"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_PAGE_READ] '" & strPageID & "' ")

		IF RS.EOF OR RS("bitUse") = False THEN
			RESPONSE.End()
		END IF

		CONF_strBrowserTitle = RS("strBrowserTitle")
		CONF_strLayoutCode   = RS("strLayoutCode")

		DIM strPageContent, strPageContentFile

		SELECT CASE RS("strAccessType")
		CASE "1"
			IF SESSION("memberSeq") = "" THEN
				RESPONSE.WRITE ActFormSubmit("", "?act=login", "post", "strPrevUrl", "/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & "?pid=" & strPageID)
				RESPONSE.End()
			END IF
		CASE "2"
			IF INSTR(RS("strAccessGroup"), SESSION("memberGroup")) < 0 THEN
				RESPONSE.WRITE ActJsAlertMsg(RS("strMessage"), "", "")
				RESPONSE.End()
			END IF
		END SELECT
		
		IF RS("strPageType") = "0" THEN
			strPageContent = RS("strContent")
		ELSE
			strPageContentFile = RS("strContentFile")
		END IF
		
	CASE "document"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '', '" & GetInputReplce(REQUEST.QueryString("bid"), "") & "' ")

		IF RS.EOF THEN
			RESPONSE.WRITE "ERROR"
			RESPONSE.End()
		END IF

		CONF_strBrowserTitle = RS("strBrowserTitle")
		CONF_strLayoutCode   = ""
		CONF_skinExecuteFile = "libs/board.print.asp"

	CASE "search"
	
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_CONFIG] ")

		CONF_strBrowserTitle = RS("strBrowserTitle")
		CONF_strLayoutCode   = RS("strLayoutCode")
		CONF_strSKinName     = RS("strSKinName")
		CONF_strSkinLang     = RS("strSkinLang")
		CONF_strSkinColor    = RS("strSkinColor")
		CONF_skinExecuteFile = "skin/search/" & CONF_strSKinName & "/list.asp"
%>
<script type="text/javascript" src="skin/search/<%=CONF_strSkinName%>/lang/<%=CONF_strSkinLang%>/lang.js"></script>
<%
	END SELECT

	IF CONF_strLayoutCode <> "" THEN

		SET RS = DBCON.EXECUTE("[ARTY30_SP_LAYOUT_READ] '', '" & CONF_strLayoutCode & "' ")

		IF NOT(RS.EOF) THEN
	
			IF RS("bitUse") = True THEN
		
				LAYOUT_strHeaderConts  = RS("strHeaderConts")
				LAYOUT_strBrowserTitle = RS("strBrowserTitle")
				IF CONF_strBrowserTitle = "" OR ISNULL(CONF_strBrowserTitle) = True THEN CONF_strBrowserTitle = LAYOUT_strBrowserTitle
		
				LAYOUT_strLayoutStyle = GetLayoutStyle(RS("strLayoutAlign"), RS("intLayoutWidth"), RS("strLayoutWidth"), RS("strLayoutMargin"), RS("strBackType"),  RS("strBackColor"), RS("strBackImg"), RS("strBackImgRepeat"), CONF_strFilePath & "/site/layout/")
		
				LAYOUT_strUserStyle    = RS("strUserStyle")
				LAYOUT_strHeaderFile   = RS("strHeaderFile")
				LAYOUT_strHeaderHtml   = RS("strHeaderHtml")
				LAYOUT_strFooterFile   = RS("strFooterFile")
				LAYOUT_strFooterHtml   = RS("strFooterHtml")
		
			END IF

		END IF

	END IF

	SELECT CASE Act
	CASE "page", "document", "search"
	CASE ELSE
%>
<script type="text/javascript">

	var calendar_path = "";
	var set_member_srl = "<%=SESSION("memberSeq")%>";
	var set_act = "<%=Act%>";
	var set_sub_act = "<%=subAct%>";

	$(document).ready(function() {

		$.ajax({
			url: "lang/lang.popup.<%=CONF_strLangType%>.xml", data: "xml",
			success: function(xml){
				$(xml).find("item").each(function(idx) {
					arApplMsg[$(this).attr("name")] = $(this).text();
				});
			}, error: function(xhr){alert(xhr.status);}
		});

	});

</script>
<% END SELECT %>
<title><%=CONF_strBrowserTitle%></title>
<% IF LAYOUT_strHeaderConts <> "" AND ISNULL(LAYOUT_strHeaderConts) = False THEN RESPONSE.WRITE LAYOUT_strHeaderConts %>
</head>
<% IF LAYOUT_strUserStyle <> "" THEN %>
<style type="text/css">
<%=LAYOUT_strUserStyle%>
</style>
<% END IF %>
<body>
<div<%=LAYOUT_strLayoutStyle%> id="boardLayout">
<%
	IF LAYOUT_strHeaderFile <> "" AND ISNULL(LAYOUT_strHeaderFile) = False THEN SERVER.EXECUTE(LAYOUT_strHeaderFile)
	IF LAYOUT_strHeaderHtml <> "" AND ISNULL(LAYOUT_strHeaderHtml) = False THEN RESPONSE.WRITE LAYOUT_strHeaderHtml
	IF CONF_strHeaderHtml <> "" AND ISNULL(CONF_strHeaderHtml) = False THEN RESPONSE.WRITE CONF_strHeaderHtml

	IF CONF_skinExecuteFile = "" THEN
		IF strPageContent <> "" THEN
			RESPONSE.WRITE strPageContent
		ELSE
			SERVER.EXECUTE(strPageContentFile)
		END IF
	ELSE
		SERVER.EXECUTE(CONF_skinExecuteFile)
		IF Act = "bbs" AND subAct = "view" AND CONF_bitDispReadList = True THEN SERVER.EXECUTE("skin/board/" & CONF_strSKinName & "/list.asp")
	END IF

	IF CONF_strFooterHtml <> "" AND ISNULL(CONF_strFooterHtml) = False THEN RESPONSE.WRITE CONF_strFooterHtml
	IF LAYOUT_strFooterHtml <> "" AND ISNULL(LAYOUT_strFooterHtml) = False THEN RESPONSE.WRITE LAYOUT_strFooterHtml
	IF LAYOUT_strFooterFile <> "" AND ISNULL(LAYOUT_strFooterFile) = False THEN SERVER.EXECUTE(LAYOUT_strFooterFile)

	IF Act <> "logout" THEN
%>
	<p style="clear:both; width:100%; height:30px; text-align:right; margin-top:10px;"><span style="padding-right:30px;">CopyRight Since 2001-2011 WEBARTY.COM All Rights RESERVED. / Skin By Webarty</span></p>
<%
	END IF
%>
</div>
</body>
</html>
<% SET RS = NOTHING : DBCON.CLOSE : SET objXmlLang = NOTHING %>