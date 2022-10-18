<%
	DIM topMenu, menuID, langXmlPath, langXmlFile, isPopup

	topMenu     = 2
	menuID      = "H01"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.manage.xml"
	isPopup     = True
%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop

	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false

	DIM strSeq
	strSeq = GetInputReplce(REQUEST.QueryString("seq"), "")
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<!-- #include file = "../comm/staff.check.asp" -->
<body id="bodyPopup">
<div id="wrap_manage">
<script type="text/javascript" src="../js/jquery.textarearesizer.js"></script>
<script type="text/javascript">

	var arApplMsg = new Array();

	$(document).ready(function() {

		$.ajax({
			url: "lang/<%=CONF_strLangType%>/<%=REPLACE(langXmlFile, "\", "/")%>", data: "xml",
			success: function(xml){
				$(xml).find("alert").find("item").each(function(idx) {
					arApplMsg[$(this).attr("name")] = $(this).text();
				});
			}, error: function(xhr){alert(xhr.status);}
		});
	});

</script>
<script type="text/javascript" src="board/js/board.manage.js"></script>
		<div class="content">
			<form id="theForm" method="post">
			<input type="hidden" name="strSeq" value="<%=strSeq%>">
			<input type="hidden" id="bitTrash" name="bitTrash">
			<div class="subBody">
				<h4><%=objXmlLang("page_title")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_board")%></th>
						<td>
						<select name="intSrl" id="intSrl" onChange="boardCategorySet(this);">
						<%=GetMakeSelectForm(objXmlLang("option_board_select"), ",", "", "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LIST] 'L', '', '', '' ")

	WHILE NOT(RS.EOF)
%>
						<option value="<%=RS("intSrl")%>"<% IF INT(RS("intSrl")) = INT(intSrl) THEN %> selected<% END IF %>><%=RS("strTitle")%> [<%=RS("strBoardID")%>]</option>
<%
	RS.MOVENEXT
	WEND
%>
						</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_category")%></th>
						<td>
						<select name="intCategory" id="intCategory">
						<%=GetMakeSelectForm(objXmlLang("option_category_select"), ",", "", "")%>
						</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_memo")%></th>
						<td><textarea name="strMemo" id="strMemo" class="resizable"></textarea></td>
					</tr>
				</table>
				<div class="formButtonBox">
					<span class="button large"><input id="btn_trash" type="button" value="<%=objXmlLang("btn_trash")%>"></span>
					<span class="button large"><input id="btn_remove" type="button" value="<%=objXmlLang("btn_remove")%>"></span>
					<span class="button large"><input id="btn_move" type="button" value="<%=objXmlLang("btn_move")%>"></span>
					<span class="button large"><input id="btn_close" type="button" value="<%=objXmlLang("btn_close")%>"></span>
				</div>
			</div>
		</form>
	</div>
</body>
<%
	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET objRoot = NOTHING : SET rootNode = NOTHING
%>