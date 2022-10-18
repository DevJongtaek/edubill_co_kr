<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 2
	menuID      = "B02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.layout.page.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM strEditorLangFile
	strEditorLangFile = Server.MapPath("../") & "\daum\lang\lang." & GetEditorUtfCode(CONF_strLangType) & ".xml"
%>
<link href="../style/jqueryFileTree.css" rel="stylesheet" type="text/css" media="screen" />
<link rel="stylesheet" href="../daum/css/editor_<%=GetEditorUtfCode(CONF_strLangType)%>.css" type="text/css"  charset="utf-8"/>
<script src="../daum/js/editor_<%=GetEditorUtfCode(CONF_strLangType)%>.js" type="text/javascript" charset="utf-8"></script>
<script src="../daum/js/editor_config.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

	var set_editor = {
		config: {
			path : '/<%=REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")%>',
			pdspath : '<%=CONF_strFilePath%>',
			imagepath : 'site/page/',
			filepath : 'site/page/',
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
<script type="text/javascript" src="../js/jqueryFileTree.js"></script>
<script type="text/javascript" src="layout/js/page.add.js"></script>
<%
	DIM Act
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	IF Act = "" THEN Act = "pageadd"

	DIM intPage, intPageSize

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""

	DIM strPid, strTitle, strBrowserTitle, strCateCode, strLayoutCode, strPageType, strContent, strContentFile
	DIM strAccessType, strAccessGroup, strMessage, bitUse

	SELECT CASE Act
	CASE "pageadd"

		strPageType   = "0"
		strAccessType = "0"
		bitUse        = "1"

	CASE "pageedit"

		strPid = GetInputReplce(REQUEST.QueryString("strPid"), "")

		SET RS = DBCON.EXECUTE("[ARTY30_SP_PAGE_READ] '" & strPid & "' ")

		IF RS.EOF THEN

			RESPONSE.WRITE "Error"
			RESPONSE.End()

		ELSE

			strTitle        = GetReplaceTag2Text(RS("strTitle"))
			strBrowserTitle = GetReplaceTag2Text(RS("strBrowserTitle"))
			strCateCode     = RS("strCateCode")
			strLayoutCode   = RS("strLayoutCode")
			strPageType     = RS("strPageType")
			strContent      = RS("strContent")
			strContentFile  = GetReplaceTag2Text(RS("strContentFile"))
			strAccessType   = RS("strAccessType")
			strAccessGroup  = RS("strAccessGroup")
			bitUse          = GetBitTypeNumberChg(RS("bitUse"))
			strMessage      = GetReplaceTag2Text(RS("strMessage"))

		END IF

	END SELECT
%>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" name="intPageSize" value="<%=intPageSize%>">
		</form>
		<div id="content">
			<form id="theForm" name="theForm" action="action/?subAct=page&Act=<%=Act%>" method="post">
			<input type="hidden" name="strPidPrev" id="strPidPrev" value="<%=strPid%>" />
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
						<th scope="row"><%=objXmlLang("title_pageid")%></th>
						<td class="detail">
						<input name="strPid" type="text" class="ime_mode" id="strPid" value="<%=strPid%>" size="60" maxlength="40"/>
						<p class="tip"><%=objXmlLang("about_pageid")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_page_subject")%></th>
						<td class="detail">
							<input name="strTitle" type="text"  id="strTitle" value="<%=strTitle%>" maxlength="64" class="inp_97" />
							<p class="tip"><%=objXmlLang("about_page_subject")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_browser_msg")%></th>
						<td class="detail">
							<input name="strBrowserTitle" type="text" id="strBrowserTitle" value="<%=strBrowserTitle%>" class="inp_97" />
							<p class="tip"><%=objXmlLang("about_browser_msg")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_category")%></th>
						<td class="detail">
						<span class="fl">
						<select name="strCateCode" id="strCateCode" style="width:250px;">
						<%=GetMakeSelectForm(objXmlLang("option_no_use"), ",", strCateCode, "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] 'C000000001' ")
	WHILE NOT(RS.EOF)
%>
						<option value="<%=RS("strSecondCode")%>"<% IF strCateCode = RS("strSecondCode") THEN %> selected<% END IF %>><%=RS("strName")%></option>
<%
	RS.MOVENEXT
	WEND
%>
						</select>
						</span>
						<span class="fl pl5">
						<span class="button medium"><input type="button" id="btn_cate_config" value="<%=objXmlLang("btn_category")%>"></span>
						</span>
						<div id="cateDiv">
							<div class="cateLeft">
								<input type="text" class="fl" id="cateInput" maxlength="64">&nbsp;<span class="button small"><input type="button" id="btn_cate_add" value="<%=objXmlLang("btn_add")%>"></span>
							</div>
							<div class="cateRight">
								<ul id="cateList">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] 'C000000001' ")

	WHILE NOT(RS.EOF)
%>
									<li id="<%=RS("strSecondCode")%>">
										<label class="fl"><%=RS("strName")%></label>
										<input type="text" id="catetxt_<%=RS("strSecondCode")%>" class="fl" value="<%=RS("strName")%>">
										<a name="btn_cate_remove" class="hand"><IMG src="images/btn_x2.gif" class="fr"></a>
									</li>
<%
	RS.MOVENEXT
	WEND
%>
								</ul>
							</div>
						</div>
						<p class="tip"><%=objXmlLang("about_category")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_layout")%></th>
						<td class="detail">
						<select name="strLayoutCode" id="strLayoutCode">
						<%=GetMakeSelectForm(objXmlLang("option_no_use"), ",", strLayoutCode, "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_LAYOUT_LIST] 'S' ")
	WHILE NOT(RS.EOF)
%>
						<option value="<%=RS("strLayoutCode")%>"<% IF RS("strLayoutCode") = strLayoutCode THEN %> selected<% END IF %>><%=RS("strTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
						</select>
						<p class="tip"><%=objXmlLang("about_layout")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_type")%></th>
						<td class="detail">
							<div id="pageTypeDiv">
								<dl class="radio_form">
									<%=GetMakeRadioForm(objXmlLang("option_type"), ",", strPageType, "strPageType", "<dd>", "</dd>")%>
								</dl>
							</div>
							<p class="tip"><%=objXmlLang("about_type")%></p>
						</td>
					</tr>
					<tr id="pageEditor">
						<th colspan="2" scope="row" class="editor">
							<!-- #include file = "../../daum/editor_inc.asp" -->
							<textarea id="strContent" name="strContent" style="display:none;"><%=strContent%></textarea>
						</th>
					</tr>
					<tr id="pageLink">
						<th scope="row"><%=objXmlLang("title_link")%></th>
						<td class="detail">
						<span class="fl mr5">
						<input name="strContentFile" type="text"  id="strContentFile" value="<%=strContentFile%>" class="inp_500P" maxlength="250"/>
						</span>
						<span class="fl">
						<span class="button medium"><input type="button" id="btn_file_find" value="<%=objXmlLang("btn_file_find")%>"></span>
						</span>
							<p class="pt10"></p>
							<div id="fileTreeList" class="fileTreeList"></div>
						<p class="tip"><%=objXmlLang("about_link")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_access")%></th>
						<td class="detail">
						<p>
						<select name="strAccessType" id="strAccessType" onChange="dispAccGroup(this);">
						<%=GetMakeSelectForm(objXmlLang("option_access"), ",", strAccessType, "")%>
						</select>
						</p>
						<div id="groupDiv" class="radiocheckArea pt5 pb5 both">
							<ul>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	tmpFor = 0

	WHILE NOT(RS.EOF)

		tmpFor = tmpFor + 1
		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strAccessGroup"" id=""strAccessGroup" & tmpFor & """ value=""" & RS("strGroupCode") & """"
		IF strAccessGroup <> "" AND ISNULL(strAccessGroup) = False THEN
			IF INSTR(strAccessGroup, RS("strGroupCode")) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strAccessGroup" & tmpFor & ">" & RS("strTitle") & "</label></li>" & CHR(13)
	RS.MOVENEXT
	WEND
%>
							</ul>
						</div>
						<div id="groupMessage" class="both">권한부족 메시지 : <input type="text" id="strMessage" name="strMessage" value="<%=strMessage%>" class="wd500"></div>
						<p class="tip"><%=objXmlLang("about_access")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_page_use")%></th>
						<td class="detail">
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUse, "bitUse", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_page_use")%></p>
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