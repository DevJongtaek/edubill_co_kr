<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C10"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.mailing.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM Act
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	IF Act = "" THEN Act = "mailingsendadd"

	DIM intPage, intPageSize

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""

	DIM strCode, strName, strEmail, strTitle, bitUseEditor, strContent, strContentHtml

	SELECT CASE Act
	CASE "mailingsendadd"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

		strName      = RS("strMasterName")
		strEmail     = RS("strMasterEmail")
		bitUseEditor = "1"

	CASE "mailingsendedit"

		strCode = GetInputReplce(REQUEST.QueryString("strCode"), "")

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_READ] 'N', '" & strCode & "' ")

		strName        = GetReplaceTag2Text(RS("strName"))
		strEmail       = GetReplaceTag2Text(RS("strEmail"))
		strTitle       = GetReplaceTag2Text(RS("strTitle"))
		bitUseEditor   = GetBitTypeNumberChg(RS("bitUseEditor"))
		strContent     = RS("strContent")
		strContentHtml = RS("strContentHtml")

	END SELECT

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
			imagepath : 'site/mailing/',
			filepath : 'site/mailing/',
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
<script type="text/javascript" src="member/js/mailing.send.add.js"></script>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" name="intPageSize" value="<%=intPageSize%>">
		</form>
		<div id="content">
			<form id="theForm" action="action/?subAct=mailingsend&Act=<%=Act%>">
			<input type="hidden" name="strCode" value="<%=strCode%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_add")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_add")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title_2")%></h4>
				<table class="tabletype02">
					<tr>
						<th scope="row"><%=objXmlLang("title_send_name")%></th>
						<td class="detail">
						<input name="strName" type="text" id="strName" value="<%=strName%>" size="40" maxlength="50"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_send_email")%></th>
						<td class="detail">
						<input name="strEmail" type="text" id="strEmail" value="<%=strEmail%>" size="80" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_subject")%></th>
						<td class="detail">
						<input name="strTitle" type="text" id="strTitle" value="<%=strTitle%>" size="100" maxlength="200"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_input_mode")%></th>
						<td class="detail">
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_input_mode"), ",", bitUseEditor, "bitUseEditor", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_input_mode")%> </p>
						</td>
					</tr>
					<tr id="pageEditor">
						<th colspan="2" scope="row" class="editor">
							<div id="inputMode1">
							<!-- #include file = "../../daum/editor_inc.asp" -->
							<textarea id="strContent" name="strContent" style="display:none;"><%=strContent%></textarea>
							</div>
							<div id="inputMode2">
							<textarea id="strContentHtml" name="strContentHtml" style="height:400px;"><%=strContentHtml%></textarea>
							</div>
						</th>
					</tr>
				</table>
				<div class="formButtonBox">
					<span class="button large strong"><input type="submit" value="<%=objXmlLang("btn_save")%>"></span>
					<span class="button large"><input type="button" id="btn_cancel" value="<%=objXmlLang("btn_cancel")%>"></span>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->