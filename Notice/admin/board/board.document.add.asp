<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D09"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.document.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM strEditorLangFile
	strEditorLangFile = Server.MapPath("../") & "\daum\lang\lang." & GetEditorUtfCode(CONF_strLangType) & ".xml"
%>
<link rel="stylesheet" href="../daum/css/editor_<%=GetEditorUtfCode(CONF_strLangType)%>.css" type="text/css"  charset="utf-8"/>
<script src="../daum/js/editor_<%=GetEditorUtfCode(CONF_strLangType)%>.js" type="text/javascript" charset="utf-8"></script>
<script src="../daum/js/editor_config.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

	var set_editor = {
		config: {
			path : '/<%=REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")%>',
			pdspath : '<%=CONF_strFilePath%>',
			imagepath : 'site/board/',
			filepath : 'site/board/',
			boardsrl : '',
			editorMode : 'site',
			usefile : false,
			useimage : true
		}
	};

	window.onload = function() {

		new Editor({
			txHost: '',
			txPath: set_editor.config.path + 'daum/',
			txVersion: '5.4.0',
			txService: 'sample',
			txProject: 'sample',
			initializedId: "",
			wrapper: "tx_trex_container"+"",
			form: 'theForm'+"",
			txIconPath: set_editor.config.path + "daum/images/icon/<%=CONF_strLangType%>/",
			txDecoPath: set_editor.config.path + "daum/images/deco/",
			canvas: {
				styles: {color: "#666666", fontFamily: "gulim", fontSize: "12px", backgroundColor: "#fff", lineHeight: "1.5", padding: "8px"}
			},
			sidebar: {
				attachbox: {show:false},
				attacher: {
					image: {
						objattr: {width: set_editor.config.imagewidth}
					},
					file: {}
				}
			}
		})

		$(".tx-canvas iframe").css("height", "400px");

		if (set_editor.config.usefile == false){
			$("#editor_file_upload").hide();
		}

		if (set_editor.config.useimage == false){
			$("#editor_image_upload").hide();
		}

		loadContent();

	};

	function loadContent() {

		var attachments = {};

		Editor.modify({
			"attachments": function() {
				var allattachments = [];
				for(var i in attachments) {
					allattachments = allattachments.concat(attachments[i]);
				}
				return allattachments;
			}(),
			"content": $tx("strContent")
		});
	}

</script>
<%
	DIM Act
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	IF Act = "" THEN Act = "boarddocumentadd"

	DIM intPage, intPageSize

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""

	DIM strDocCode, strTitle, strContent, bitUse

	SELECT CASE Act
	CASE "boarddocumentadd"

		bitUse = "1"

	CASE "boarddocumentmodify"

		strDocCode = GetInputReplce(REQUEST.QueryString("strDocCode"), "")

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_DOCUMENT_READ] '" & strDocCode & "', 'N' ")

		IF RS.EOF THEN

			RESPONSE.WRITE "Error"
			RESPONSE.End()

		ELSE

			strTitle   = GetReplaceTag2Text(RS("strTitle"))
			strContent = RS("strContent")
			bitUse     = GetBitTypeNumberChg(RS("bitUse"))

		END IF

	END SELECT
%>
<script type="text/javascript" src="board/js/board.document.add.js"></script>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" id="intPageSize" value="<%=intPageSize%>">
		</form>
		<div id="content">
			<form id="theForm" name="theForm" action="action/?subAct=boarddocument&Act=<%=Act%>" method="post">
			<input type="hidden" name="strDocCode" id="strDocCode" value="<%=strDocCode%>" />
			<div id="subHead">
				<h3><%=objXmlLang("page_title_add")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_add")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title_1")%></h4>
				<table class="tabletype02">
					<tr>
						<th scope="row"><%=objXmlLang("title_document")%></th>
						<td class="detail">
							<input name="strTitle" type="text"  id="strTitle" value="<%=strTitle%>" maxlength="64" class="inp_97" />
							<p class="tip"><%=objXmlLang("about_document")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use")%></th>
						<td class="detail">
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUse, "bitUse", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_use")%></p>
						</td>
					</tr>
					<tr>
						<th colspan="2" scope="row" class="editor">
							<!-- #include file = "../../daum/editor_inc.asp" -->
							<textarea id="strContent" name="strContent" style="display:none;"><%=strContent%></textarea>
						</th>
					</tr>
				</table>
				<div class="formButtonBox">
				<span class="button large strong"><input type="submit" id="btn_save" value="<%=objXmlLang("btn_save")%>"></span>
				<span class="button large"><input type="button" id="btn_cancel" value="<%=objXmlLang("btn_cancel")%>"></span>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->