<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 5
	menuID      = "E02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.popup.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM Act
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	IF Act = "" THEN Act = "popupadd"

	DIM intPage, intPageSize

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""

	DIM intSeq, strStartDate, strEndDate, strPosition, intWidth, intHeight, bitScroll, strPopupType, strTitle, strContentType
	DIM strContent, strContentHtml, strFooter, bitUse

	SELECT CASE Act
	CASE "popupadd"

		strStartDate = YEAR(NOW) & "."
		IF LEN(MONTH(NOW)) = 1 THEN strStartDate = strStartDate & "0"
		strStartDate = strStartDate & MONTH(NOW) & "."
		IF LEN(DAY(NOW)) = 1 THEN strStartDate = strStartDate & "0"
		strStartDate = strStartDate & DAY(NOW)
		
		strEndDate = YEAR(DATEADD("m", 1, NOW)) & "."
		IF LEN(MONTH(DATEADD("m", 1, NOW))) = 1 THEN strEndDate = strEndDate & "0"
		strEndDate = strEndDate & MONTH(DATEADD("m", 1, NOW)) & "."
		IF LEN(DAY(DATEADD("m", 1, NOW))) = 1 THEN strEndDate = strEndDate & "0"
		strEndDate = strEndDate & DAY(DATEADD("m", 1, NOW))

		bitScroll      = "1"
		strPosition    = SPLIT("1,,,1", ",")
		strPopupType   = "1"
		strFooter      = ""
		strContentType = "1"
		bitUse         = "1"

	CASE "popupmodify"

		intSeq = GetInputReplce(REQUEST.QueryString("intSeq"), "")

		SET RS = DBCON.EXECUTE("[ARTY30_SP_POPUPS_READ] 'R', '" & intSeq & "' ")

		IF RS.EOF THEN

			RESPONSE.WRITE "Error"
			RESPONSE.End()

		ELSE

			strStartDate   = REPLACE(LEFT(RS("strStartDate"), 10), "-", ".")
			strEndDate     = REPLACE(LEFT(RS("strEndDate"), 10), "-", ".")
			strPosition    = SPLIT(RS("strPosition"), ",")
			intWidth       = RS("intWidth")
			intHeight      = RS("intHeight")
			bitScroll      = GetBitTypeNumberChg(RS("bitScroll"))
			strPopupType   = RS("strPopupType")
			strTitle       = RS("strTitle")
			strContentType = RS("strContentType")
			strContent     = RS("strContent")
			strContentHtml = RS("strContentHtml")
			strFooter      = RS("strFooter")
			bitUse         = GetBitTypeNumberChg(RS("bitUse"))

		END IF

	END SELECT

	DIM strEditorLangFile
	strEditorLangFile = Server.MapPath("../") & "\daum\lang\lang." & GetEditorUtfCode(CONF_strLangType) & ".xml"
%>
<script type="text/javascript" src="../js/jquery.textarearesizer.js"></script>
<link rel="stylesheet" href="../daum/css/editor_<%=GetEditorUtfCode(CONF_strLangType)%>.css" type="text/css"  charset="utf-8"/>
<script src="../daum/js/editor_<%=GetEditorUtfCode(CONF_strLangType)%>.js" type="text/javascript" charset="utf-8"></script>
<script src="../daum/js/editor_config.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

	var set_editor = {
		config: {
			path : '/<%=REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")%>',
			pdspath : '<%=CONF_strFilePath%>',
			imagepath : 'site/popup/',
			filepath : 'site/popup/',
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
<script type="text/javascript" src="other/js/popup.add.js"></script>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" name="intPageSize" value="<%=intPageSize%>">
		</form>
		<div id="content">
			<form id="theForm" action="action/?subAct=popup&Act=<%=Act%>">
			<input type="hidden" name="intSeq" value="<%=intSeq%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("sub_title_1")%></h4>
				<table class="tabletype02">
					<tr>
						<th scope="row"><%=objXmlLang("title_date")%></th>
						<td class="detail">
						<input name="strStartDate" type="text" id="strStartDate" style="color:#666; background:#fff;" value="<%=strStartDate%>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, 'strStartDate')" /> ~
						<input name="strEndDate" type="text" id="strEndDate" style="color:#666; background:#fff;" value="<%=strEndDate%>" size="10" readonly="readonly" /><input type="button" id="btnEndCal" class="btn_calendar" onClick="calendar(event, 'strEndDate')" />
						<p class="tip"><%=objXmlLang("about_date")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_position")%></th>
						<td class="detail">
							<div>
								<dl class="radio_form">
									<%=GetMakeRadioForm(objXmlLang("option_postion1"), ",", strPosition(0), "strPosition1", "<dd>", "</dd>")%>
								</dl>
							</div>
							<div id="position_set1">
								<p class="mt5">X : <input name="strPosition2" type="text" id="strPosition2" value="<%=strPosition(1)%>" size="6" maxlength="4" class="integer ime_mode" />&nbsp;px</p>
								<p class="mt5">Y : <input name="strPosition3" type="text" id="strPosition3" value="<%=strPosition(2)%>" size="6" maxlength="4" class="integer ime_mode" />&nbsp;px</p>
							</div>
							<div id="position_set2" class="mt5">
								<dl class="radio_form">
									<%=GetMakeRadioForm(objXmlLang("option_postion2"), ",", strPosition(3), "strPosition4", "<dd>", "</dd>")%>
								</dl>
							</div>
							<p class="tip"><%=objXmlLang("about_position")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_size")%></th>
						<td class="detail">
							<p class="mt5"><%=objXmlLang("text_width")%> : <input name="intWidth" type="text" id="intWidth" value="<%=intWidth%>" size="6" maxlength="4" class="integer ime_mode" />&nbsp;px</p>
							<p class="mt5"><%=objXmlLang("text_height")%> : <input name="intHeight" type="text" id="intHeight" value="<%=intHeight%>" size="6" maxlength="4" class="integer ime_mode" />&nbsp;px</p>
							<p class="tip"><%=objXmlLang("about_size")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_scroll")%></th>
						<td class="detail">
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_scroll"), ",", bitScroll, "bitScroll", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_scroll")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_type")%></th>
						<td class="detail">
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_popup_type"), ",", strPopupType, "strPopupType", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_popup_type")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_title")%></th>
						<td class="detail">
							<input name="strTitle" type="text" id="strTitle" value="<%=strTitle%>" maxlength="250" class="inp_97" />
							<p class="tip"><%=objXmlLang("about_title")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_content_type")%></th>
						<td class="detail">
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_content_type"), ",", strContentType, "strContentType", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_content_type")%></p>
							</td>
					</tr>
					<tr id="contentEditor">
						<th colspan="2" scope="row" class="editor">
							<!-- #include file = "../../daum/editor_inc.asp" -->
							<textarea id="strContent" name="strContent" style="display:none;"><%=strContent%></textarea>
						</th>
					</tr>
					<tr id="contentHtml">
						<th scope="row"><%=objXmlLang("title_content")%></th>
						<td class="detail">
							<textarea name="strContentHtml" class="resizable" id="strContentHtml" style="height:400px;"><%=strContentHtml%></textarea>
							<p class="tip"><%=objXmlLang("about_browser_msg")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_footer")%></th>
						<td class="detail">
							<textarea name="strFooter" class="resizable" id="strFooter"><%=strFooter%></textarea>
							<p class="tip"><%=objXmlLang("about_footer")%></p>
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
				</table>
				<div class="formButtonBox">
				<span class="button large strong"><input type="submit" id="btn_save" value="<%=objXmlLang("btn_save")%>"></span>
				<span class="button large"><input type="button" id="btn_cancel" value="<%=objXmlLang("btn_cancel")%>"></span>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->