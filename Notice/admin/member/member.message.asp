<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C11"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.message.xml"
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
			imagepath : 'site/message/',
			filepath : 'site/message/',
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
<script type="text/javascript" src="member/js/member.message.js"></script>
		<div id="content">
			<form id="theForm" action="action/?subAct=message">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title")%></h4>
				<table class="tabletype02">
					<tr>
						<th scope="row"><%=objXmlLang("title_subject")%></th>
						<td class="detail"><input name="strTitle" type="text"  id="strTitle" maxlength="64" class="inp_97" /></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_group")%></th>
						<td class="detail">
						<div class="radiocheckArea pt5 pb5">
							<ul>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	tmpFor = 0

	WHILE NOT(RS.EOF)

		tmpFor = tmpFor + 1
		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strMemberGroup"" id=""strMemberGroup" & tmpFor & """ value=""" & RS("strGroupCode") & """"
		IF strAccessGroup <> "" AND ISNULL(strAccessGroup) = False THEN
			IF INSTR(strAccessGroup, RS("strGroupCode")) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strMemberGroup" & tmpFor & ">" & RS("strTitle") & " <span class=num>(" & RS("intMemberCount") & ")</span></label></li>" & CHR(13)
	RS.MOVENEXT
	WEND
%>
							</ul>
						</div>
						<p class="tip"><%=objXmlLang("about_group")%></p>
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
					<span class="button large strong"><input type="submit" value="<%=objXmlLang("btn_send")%>"></span>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->