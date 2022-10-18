<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	Response.CharSet = "utf-8"
%>
<!-- #include file = "../libs/function.asp" -->
<%
	IF REQUEST.ServerVariables("HTTP_REFERER") <> "" THEN
		IF INSTR(REQUEST.ServerVariables("HTTP_REFERER"), "http://" & REQUEST.ServerVariables("HTTP_HOST")) = 0 THEN
			RESPONSE.WRITE "ERROR"
			RESPONSE.End()
		END IF
	END IF

	DIM Act, ExecFile
	Act = GetInputReplce(REQUEST.QueryString("Act"), "")

	SELECT CASE LCASE(Act)
	CASE "memberagree"        : ExecFile = "member.agree.ok.asp"
	CASE "ssncheck"           : ExecFile = "member.ssn.ok.asp"
	CASE "joincheck"          : ExecFile = "member.join.check.ok.asp"
	CASE "joinauth"           : ExecFile = "member.auth.ok.asp"
	CASE "memberjoin", "membermodify", "memberfileremove"  : ExecFile = "member.join.ok.asp"
	CASE "modifypwd"          : ExecFile = "member.modify.pwd.ok.asp"
	CASE "memberout"          : ExecFile = "member.out.ok.asp"
	CASE "login"              : ExecFile = "login.ok.asp"
	CASE "zipcode"            : ExecFile = "../libs/zipcode.asp"
	CASE "swfupload_member"   : ExecFile = "swfupload.member.asp"
	CASE "boardcategorylist"  : ExecFile = "board.category.list.asp"
	CASE "boardfilelist"      : ExecFile = "board.file.list.asp"
	CASE "fileupload"         : ExecFile = "file.upload.asp"
	CASE "imageupload"        : ExecFile = "image.upload.asp"
	CASE "uploadfileremove"   : ExecFile = "file.remove.asp"
	CASE "contentmodify" : ExecFile = "content.modify.asp"
	CASE "captcha"            : ExecFile = "captcha.asp"
	CASE "boardwrite"         : ExecFile = "board.write.ok.asp"
	CASE "boardvote", "boardblamed", "commentvote", "commentblamed"
		ExecFile = "vote.ok.asp"
	CASE "boarddeclare", "commentdeclare"
		ExecFile = "declare.ok.asp"
	CASE "boardremove"        : ExecFile = "board.remove.ok.asp"
	CASE "boardpassword"      : ExecFile = "board.password.ok.asp"
	CASE "boardmainlist"      : ExecFile = "board.main.list.asp"
	CASE "searchkeyword"      : ExecFile = "search.keyword.ok.asp"
	CASE "commentwrite"       : ExecFile = "comment.write.ok.asp"
	CASE "commentremove"      : ExecFile = "comment.remove.ok.asp"
	CASE "memberlogininfo"    : ExecFile = "member.login.info.asp"
	CASE "memberinfo"         : ExecFile = "member.info.asp"
	CASE "membersearch"       : ExecFile = "member.search.asp"
	CASE "friendlist", "friendadd", "friendmodify", "friendremove", "friendgroup" : ExecFile = "member.friend.ok.asp"
	CASE "friendgrouplist", "friendgroupadd", "friendgroupmodify", "friendgroupremove" : ExecFile = "member.friend.group.ok.asp"
	CASE "popup"              : ExecFile = "popup.asp"
	CASE "popupframe"         : ExecFile = "../libs/popup.frame.asp"
	CASE "message"            : ExecFile = "member.message.ok.asp"
	CASE "scrapadd", "scrapremove" : ExecFile = "member.scrap.ok.asp"
	END SELECT

	SERVER.EXECUTE(ExecFile)
%>