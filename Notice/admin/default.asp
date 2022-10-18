<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<%
	RESPONSE.AddHeader "Pragma","no-cache"
	RESPONSE.AddHeader "Cache-Control","private"
	RESPONSE.CacheControl = "no-chche"
	RESPONSE.Buffer = True
	RESPONSE.Expires = -1
	Response.Codepage = "65001"
	Response.CharSet = "utf-8"
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>Admin Mode</title>
	<link rel="stylesheet" href="style/default.css" type="text/css">	
	<link type="text/css" href="../style/jquery.combo.css" rel="stylesheet" />
	<link type="text/css" href="../style/jquery.checkbox.css" rel="stylesheet" />
</head>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.format.js"></script>
<script type="text/javascript" src="../js/jquery.form.js"></script>
<script type="text/javascript" src="../js/jquery.combo.js"></script>
<script type="text/javascript" src="../js/jquery.checkbox.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script type="text/javascript" src="../js/swfobject.js"></script>
<script type="text/javascript">

	$(document).ready(function() {

		$(".integer").numeric();
		$("input:checkbox").checkbox();
		$("input:radio").checkbox({cls:"jquery-radio"});

	});

	var calendar_path = "../";

</script>
<%
	DIM act
	act = REQUEST.QueryString("act")
	IF act = "" THEN act = "main"

	DIM actMoveFile

	SELECT CASE LCASE(act)
	CASE "login"
		actMoveFile = "login.asp"
	CASE "logout"
		actMoveFile = "logout.asp"
	CASE "main"
		actMoveFile = "main.asp"
	CASE "defaultconfig"
		actMoveFile = "default/default.config.asp"
	CASE "stafflist"
		actMoveFile = "default/staff.list.asp"
	CASE "staffadd", "staffmodify"
		actMoveFile = "default/staff.add.asp"
	CASE "layout"
		actMoveFile = "layout/layout.list.asp"
	CASE "layoutadd", "layoutedit"
		actMoveFile = "layout/layout.add.asp"
	CASE "page"
		actMoveFile = "layout/page.list.asp"
	CASE "pageadd", "pageedit"
		actMoveFile = "layout/page.add.asp"
	CASE "memberlist"
		actMoveFile = "member/member.list.asp"
	CASE "memberdisp"
		actMoveFile = "member/member.disp.asp"
	CASE "membermodify"
		actMoveFile = "member/member.modify.asp"
	CASE "memberform"
		actMoveFile = "member/member.form.asp"
	CASE "memberconfig"
		actMoveFile = "member/member.config.asp"
	CASE "membergroup"
		actMoveFile = "member/member.group.list.asp"
	CASE "membergroupadd", "membergroupmodify"
		actMoveFile = "member/member.group.add.asp"
	CASE "memberdoc"
		actMoveFile = "member/member.document.list.asp"
	CASE "memberdocadd", "memberdocedit"
		actMoveFile = "member/member.document.add.asp"
	CASE "memberdeniedid"
		actMoveFile = "member/member.denied.id.list.asp"
	CASE "memberlevel"
		actMoveFile = "member/member.level.asp"
	CASE "pointconfig"
		actMoveFile = "member/point.config.asp"
	CASE "pointlist"
		actMoveFile = "member/point.list.asp"
	CASE "memberout"
		actMoveFile = "member/member.out.list.asp"
	CASE "mailingsendlist"
		actMoveFile = "member/mailing.send.list.asp"
	CASE "mailingsendadd", "mailingsendedit"
		actMoveFile = "member/mailing.send.add.asp"
	CASE "mailingsendmember"
		actMoveFile = "member/mailing.send.member.asp"
	CASE "mailingsend"
		actMoveFile = "member/mailing.send.asp"
	CASE "mailinggrouplist"
		actMoveFile = "member/mailing.group.list.asp"
	CASE "mailinggroupadd", "mailinggroupedit"
		actMoveFile = "member/mailing.group.add.asp"
	CASE "mailinggroupmember"
		actMoveFile = "member/mailing.group.member.asp"
	CASE "mailingetclist"
		actMoveFile = "member/mailing.etc.list.asp"
	CASE "mailingetcadd", "mailingetcedit"
		actMoveFile = "member/mailing.etc.add.asp"
	CASE "message"
		actMoveFile = "member/member.message.asp"
	CASE "boardlist"
		actMoveFile = "board/board.list.asp"
	CASE "boardmake"
		actMoveFile = "board/board.make.asp"
	CASE "boardconfigdefault"
		actMoveFile = "board/board.config.default.asp"
	CASE "boardconfigaddition"
		actMoveFile = "board/board.config.addition.asp"
	CASE "boardconfigfield"
		actMoveFile = "board/board.config.field.asp"
	CASE "boardconfigfieldadd", "boardconfigfieldmodify"
		actMoveFile = "board/board.config.field.add.asp"
	CASE "boardconfigcategory"
		actMoveFile = "board/board.config.category.asp"
	CASE "boardconfiggrantinfo"
		actMoveFile = "board/board.config.grantinfo.asp"
	CASE "boardconfigpoint"
		actMoveFile = "board/board.config.point.asp"
	CASE "boardconfigskin"
		actMoveFile = "board/board.config.skin.asp"
	CASE "boardconfigcategorytree"
		actMoveFile = "board/board.config.caetgory.tree.asp"
	CASE "boardsearch"
		actMoveFile = "board/board.search.list.asp"
	CASE "boardmanage"
		actMoveFile = "board/board.manage.asp"
	CASE "commentsearch"
		actMoveFile = "board/comment.search.list.asp"
	CASE "filesearch"
		actMoveFile = "board/file.search.list.asp"
	CASE "boarddeclared"
		actMoveFile = "board/board.declared.list.asp"
	CASE "commentdeclared"
		actMoveFile = "board/comment.declared.list.asp"
	CASE "boardtrash"
		actMoveFile = "board/board.trash.list.asp"
	CASE "boardnotice"
		actMoveFile = "board/board.notice.code.asp"
	CASE "boarddocument"
		actMoveFile = "board/board.document.list.asp"
	CASE "boarddocumentadd", "boarddocumentmodify"
		actMoveFile = "board/board.document.add.asp"
	CASE "searchconfig"
		actMoveFile = "board/search.config.asp"
	CASE "statmemberjoindate"
		actMoveFile = "stat/stat.member.join.date.asp"
	CASE "statmemberjoinage"
		actMoveFile = "stat/stat.member.join.age.asp"
	CASE "statmemberjoinarea"
		actMoveFile = "stat/stat.member.join.area.asp"
	CASE "statmemberjoinjob"
		actMoveFile = "stat/stat.member.join.job.asp"
	CASE "statsite"
		actMoveFile = "stat/stat.site.asp"
	CASE "statsitelog"
		actMoveFile = "stat/stat.site.log.asp"
	CASE "statboard"
		actMoveFile = "stat/stat.board.asp"
	CASE "stattag"
		actMoveFile = "stat/stat.tag.asp"
	CASE "statsearch"
		actMoveFile = "stat/stat.search.asp"
	CASE "schedule"
		actMoveFile = "other/schedule.asp"
	CASE "popup"
		actMoveFile = "other/popup.list.asp"
	CASE "popupadd", "popupmodify"
		actMoveFile = "other/popup.add.asp"
	CASE "filebox"
		actMoveFile = "comm/filebox.list.asp"
	END SELECT
	
	SERVER.EXECUTE(actMoveFile)
%>
</html>