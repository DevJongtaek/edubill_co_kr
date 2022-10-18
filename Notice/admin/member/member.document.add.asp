<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C05"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.document.xml"
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
			imagepath : 'site/document/',
			filepath : 'site/document/',
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
<%
	DIM Act
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	IF Act = "" THEN Act = "memberdocadd"

	DIM strDocCode, strCateCode, strSubject, strContent, bitDefault

	SELECT CASE Act
	CASE "memberdocadd"

		bitDefault  = "0"

	CASE "memberdocedit"

		strDocCode = REQUEST.QueryString("strDocCode")

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_READ] 'N', '" & strDocCode & "' ")

		strCateCode = RS("strCateCode")
		strSubject  = RS("strSubject")
		strContent  = RS("strContent")
		bitDefault  = GetBitTypeNumberChg(RS("bitDefault"))

	END SELECT

	DIM strUserDim1, strUserDim2, strUserDim3, strUserDim4, strUserDim5

	strUserDim1 = SPLIT(objXmlLang("option_add_dim"), "$$$")
	strUserDim2 = SPLIT(objXmlLang("option_add_dim"), "$$$")
	strUserDim3 = SPLIT(objXmlLang("option_select_dim1"), "$$$")
	strUserDim4 = SPLIT(objXmlLang("option_select_dim2"), "$$$")
	strUserDim5 = SPLIT(objXmlLang("option_select_dim2"), "$$$")
%>
<script type="text/javascript">

	var userDim1 = "<%=strUserDim1(0)%>";
	var userDim1_ = "<%=strUserDim1(1)%>";
	var userDim2 = "<%=strUserDim2(0)%>";
	var userDim2_ = "<%=strUserDim2(1)%>";
	var userDim3 = "<%=strUserDim3(0)%>";
	var userDim3_ = "<%=strUserDim3(1)%>";
	var userDim4 = "<%=strUserDim4(0)%>";
	var userDim4_ = "<%=strUserDim4(1)%>";
	var userDim5 = "<%=strUserDim5(0)%>";
	var userDim5_ = "<%=strUserDim5(1)%>";

</script>
<script type="text/javascript" src="member/js/member.document.add.js"></script>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=REQUEST.QueryString("intPage")%>">
		<input type="hidden" name="intPageSize" value="<%=REQUEST.FORM("intPageSize")%>">
		<input type="hidden" name="strCateCode" value="<%=REQUEST.FORM("strCateCode")%>">
		</form>
		<div id="content">
			<form id="theForm" action="action/?subAct=memberdoc&Act=<%=Act%>">
			<input type="hidden" name="strDocCode" value="<%=strDocCode%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title_1")%></h4>
				<table class="tabletype02">
					<tr>
						<th scope="row"><%=objXmlLang("title_category")%></th>
						<td class="detail">
						<select name="strCateCode" id="strCateCode" onChange="populateCombo(this.value);"<% IF Act = "memberdocedit" THEN %> disabled<% END IF %>>
						<%=GetMakeSelectForm(objXmlLang("option_category"), ",", strCateCode, "")%>
						</select>
						<p class="tip"><%=objXmlLang("about_category")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_subject")%></th>
						<td class="detail">
						<input name="strSubject" type="text" id="strSubject" value="<%=strSubject%>" size="100" maxlength="250"/>
							<p class="tip"><%=objXmlLang("about_subject")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_default")%></th>
						<td class="detail">
							<%=GetMakeCheckForm(objXmlLang("option_default"), ",", bitDefault, "bitDefault", "", "")%>
							<p class="tip"><%=objXmlLang("about_default")%></p>
						</td>
					</tr>
					<tr id="pageEditor">
						<th colspan="2" scope="row" class="editor">
						<div class="fr mb5 both">
						<select name="strUserDim" id="strUserDim" onChange="setUserDim(this.value);">
<%
	SELECT CASE strCateCode
	CASE "D003" : RESPONSE.WRITE GetMakeSelectForm(objXmlLang("option_select_dim1"), ",", strCateCode, "")
	CASE "D004", "D005" : RESPONSE.WRITE GetMakeSelectForm(objXmlLang("option_select_dim2"), ",", strCateCode, "")
	CASE ELSE : RESPONSE.WRITE GetMakeSelectForm(objXmlLang("option_add_dim"), ",", strCateCode, "")
	END SELECT
%>
						</select>
						</div>
						<!-- #include file = "../../daum/editor_inc.asp" -->
						<textarea id="strContent" name="strContent" style="display:none;"><%=strContent%></textarea>
						<p class="tip"><%=objXmlLang("about_content")%></p>
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