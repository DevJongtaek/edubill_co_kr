<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.config.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM strBrowserTitle, strMasterName, strMasterEmail, strLayoutCode, strSkinName, strSkinColor, strSkinLang, bitUseJoin
	DIM bitAuth, bitDispAgree, bitUseJoinKids, bitUseJoinCorp, bitUseCertified, bitUseEmailCheck, bitUseSmsCheck, strJoinGroup
	DIM intJoinLevel, strJoinPointTitle, intJoinPoint, bitSendJoinEmail, bitDispLevelIcon, strLevelIconFolder, bitUsePhoto
	DIM strPhotoSize, bitUseNameImg, strNameImgSize, bitUseMarkImg, strMarkImgSize, strJoinAct, strJoinActMsg, strJoinActUrl
	DIM strJoinActScript, strEditAct, strEditActMsg, strEditActUrl, strEditActScript, strOutOption, strOutAct, strOutActMsg
	DIM strOutActUrl, strOutActScript, strOutMemo, strAccountFind, strLoginPointTitle, intLoginPoint, strLoginAct, strLoginActMsg
	DIM strLoginActUrl, strLoginActScript, strLogoutAct, strLogoutActMsg, strLogoutActUrl, strLogoutActScript, bitUseNameCheck
	DIM strNameCheckCorp, strNameCkeckID, strNameCheckPwd

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

	strBrowserTitle    = RS("strBrowserTitle")
	strMasterName      = RS("strMasterName")
	strMasterEmail     = RS("strMasterEmail")
	strLayoutCode      = RS("strLayoutCode")
	strSkinName        = RS("strSkinName")
	strSkinColor       = RS("strSkinColor")
	strSkinLang        = RS("strSkinLang")
	bitUseJoin         = GetBitTypeNumberChg(RS("bitUseJoin"))
	bitAuth            = GetBitTypeNumberChg(RS("bitAuth"))
	bitDispAgree       = GetBitTypeNumberChg(RS("bitDispAgree"))
	bitUseJoinKids     = GetBitTypeNumberChg(RS("bitUseJoinKids"))
	bitUseJoinCorp     = GetBitTypeNumberChg(RS("bitUseJoinCorp"))
	bitUseCertified    = GetBitTypeNumberChg(RS("bitUseCertified"))
	bitUseEmailCheck   = GetBitTypeNumberChg(RS("bitUseEmailCheck"))
	bitUseSmsCheck     = GetBitTypeNumberChg(RS("bitUseSmsCheck"))
	strJoinGroup       = RS("strJoinGroup")
	intJoinLevel       = RS("intJoinLevel")
	strJoinPointTitle  = RS("strJoinPointTitle")
	intJoinPoint       = RS("intJoinPoint")
	bitSendJoinEmail   = GetBitTypeNumberChg(RS("bitSendJoinEmail"))
	bitDispLevelIcon   = GetBitTypeNumberChg(RS("bitDispLevelIcon"))
	strLevelIconFolder = RS("strLevelIconFolder")
	bitUsePhoto        = GetBitTypeNumberChg(RS("bitUsePhoto"))
	strPhotoSize       = SPLIT(RS("strPhotoSize"), ",")
	bitUseNameImg      = GetBitTypeNumberChg(RS("bitUseNameImg"))
	strNameImgSize     = SPLIT(RS("strNameImgSize"), ",")
	bitUseMarkImg      = GetBitTypeNumberChg(RS("bitUseMarkImg"))
	strMarkImgSize     = SPLIT(RS("strMarkImgSize"), ",")
	strJoinAct         = RS("strJoinAct")
	strJoinActMsg      = RS("strJoinActMsg")
	strJoinActUrl      = RS("strJoinActUrl")
	strJoinActScript   = RS("strJoinActScript")
	strEditAct         = RS("strEditAct")
	strEditActMsg      = RS("strEditActMsg")
	strEditActUrl      = RS("strEditActUrl")
	strEditActScript   = RS("strEditActScript")
	strOutOption       = RS("strOutOption")
	strOutAct          = RS("strOutAct")
	strOutActMsg       = RS("strOutActMsg")
	strOutActUrl       = RS("strOutActUrl")
	strOutActScript    = RS("strOutActScript")
	strOutMemo         = RS("strOutMemo")
	strAccountFind     = RS("strAccountFind")
	strLoginPointTitle = RS("strLoginPointTitle")
	intLoginPoint      = RS("intLoginPoint")
	strLoginAct        = RS("strLoginAct")
	strLoginActMsg     = RS("strLoginActMsg")
	strLoginActUrl     = RS("strLoginActUrl")
	strLoginActScript  = RS("strLoginActScript")
	strLogoutAct       = RS("strLogoutAct")
	strLogoutActMsg    = RS("strLogoutActMsg")
	strLogoutActUrl    = RS("strLogoutActUrl")
	strLogoutActScript = RS("strLogoutActScript")
	bitUseNameCheck    = GetBitTypeNumberChg(RS("bitUseNameCheck"))
	strNameCheckCorp   = RS("strNameCheckCorp")
	strNameCkeckID     = RS("strNameCkeckID")
	strNameCheckPwd    = RS("strNameCheckPwd")
	
	IF intJoinAge = 0 THEN intJoinAge = ""
%>
<script type="text/javascript" src="../js/jquery.textarearesizer.js"></script>
<script type="text/javascript" src="member/js/member.config.js"></script>
		<div id="content">
			<form id="theForm">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title_1")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_browser_msg")%></th>
						<td>
						<input name="strBrowserTitle" type="text" id="strBrowserTitle" value="<%=strBrowserTitle%>" size="100" maxlength="250"/>
						<p class="tip"><%=objXmlLang("about_browser_msg")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_admin_name")%></th>
						<td>
						<input name="strMasterName" type="text" id="strMasterName" value="<%=strMasterName%>" size="40" maxlength="40"/>
						<p class="tip"><%=objXmlLang("about_admin_name")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_admin_email")%></th>
						<td>
							<input name="strMasterEmail" type="text" id="strMasterEmail" value="<%=strMasterEmail%>" size="60" maxlength="80"/>
							<p class="tip"><%=objXmlLang("about_admin_email")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_layout")%></th>
						<td>
						<select name="strLayoutCode" id="strLayoutCode">
						<%=GetMakeSelectForm(objXmlLang("option_nouse"), ",", strLayoutAlign, "")%>
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
						<th scope="row"><%=objXmlLang("title_skin")%></th>
						<td>
						<p>
<%
	DIM skinFolderList
	skinFolderList = SPLIT(GetFolderList(GetNowFolderPath("../") & "\skin\member"), ",")
%>
						<span class="fl">
						<select name="strSkinName" id="strSkinName" onChange="Skin.ColorSet(this.value);Skin.LangSet(this.value);">
<%
	FOR tmpFor = 0 TO UBOUND(skinFolderList)

		xmlDOM.Load Server.MapPath("..\skin\member\" & skinFolderList(tmpFor) & "\") & "\skin.xml"

		SET rootNode = xmlDOM.selectNodes(LCASE("/skin/title"))
	
		FOR firstLoop = 0 TO rootNode.length - 1
			IF LCASE(rootNode(firstLoop).getAttribute("lang")) = CONF_strLangType THEN
				RESPONSE.WRITE "<option value=""" & skinFolderList(tmpFor) & """"
				IF LCASE(strSkinName) = LCASE(skinFolderList(tmpFor)) THEN RESPONSE.WRITE " selected"
				RESPONSE.WRITE ">" & rootNode(firstLoop).text & " (" & skinFolderList(tmpFor) & ")</option>"
			END IF
		NEXT

	NEXT
%>
						</select>
						</span>
<%
	xmlDOM.Load Server.MapPath("..\skin\member\" & strSkinName & "\") & "\skin.xml"
	SET rootNode = xmlDOM.selectNodes(LCASE("/skin/languages/title"))
%>
						<span class="fl ml5">
						<select name="strSkinLang" id="strSkinLang">
<%
		FOR firstLoop = 0 TO rootNode.length - 1
			RESPONSE.WRITE "<option value='" & rootNode(firstLoop).getAttribute("lang") & "'"
			IF strSkinLang = rootNode(firstLoop).getAttribute("lang") THEN RESPONSE.WRITE " selected"
			RESPONSE.WRITE ">" & rootNode(firstLoop).text & "</option>" & CHR(10)
		NEXT
%>
						</select>
						</span>
						</p>
						<div id="skinColorSet"></div>
						</td>
					</tr>
				</table>
				<div class="pt10"></div>
				<h4><%=objXmlLang("page_sub_title_2")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_use_join")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_join"), ",", bitUseJoin, "bitUseJoin", "<dd>", "</dd>")%>
							</dl>
						<p class="tip"><%=objXmlLang("about_use_join")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_auth")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_auth"), ",", bitAuth, "bitAuth", "<dd>", "</dd>")%>
							</dl>
						<p class="tip"><%=objXmlLang("about_auth")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_disp_agree")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_disp"), ",", bitDispAgree, "bitDispAgree", "<dd>", "</dd>")%>
							</dl>
						<p class="tip"><%=objXmlLang("about_disp_agree")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use_join_member")%></th>
						<td>
							<dl class="checkbox_form">
								<%=GetMakeCheckForm(objXmlLang("option_join_kids"), "", bitUseJoinKids, "bitUseJoinKids", "<dd>", "</dd>")%>
								<%=GetMakeCheckForm(objXmlLang("option_join_corp"), "", bitUseJoinCorp, "bitUseJoinCorp", "<dd>", "</dd>")%>
							</dl>
						<p class="tip"><%=objXmlLang("about_use_join_member")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_join_certified")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseCertified, "bitUseCertified", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_join_certified")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_kind_certified")%></th>
						<td>
						<dl class="checkbox_form">
							<%=GetMakeCheckForm(objXmlLang("option_check_email"), "", bitUseEmailCheck, "bitUseEmailCheck", "<dt>", "</dt>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_join_email_check")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_default_group")%></th>
						<td>
						<select name="strJoinGroup" id="strJoinGroup">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	WHILE NOT(RS.EOF)
		IF RS("bitAdmin") = False THEN
%>
						<option value="<%=RS("strGroupCode")%>"<% IF RS("strGroupCode") = strJoinGroup THEN %> selected<% END IF %>><%=RS("strTitle")%></option>
<%
		END IF
	RS.MOVENEXT
	WEND
%>
						</select>
						<p class="tip"><%=objXmlLang("about_default_group")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_default_level")%></th>
						<td>
						<select name="intJoinLevel" id="intJoinLevel" class="wd150">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_LIST] ")

	WHILE NOT(RS.EOF)
%>
						<option value="<%=RS("intLevel")%>"<% IF INT(RS("intLevel")) = INT(intJoinLevel) THEN %> selected<% END IF %>><%=RS("strLevelTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
						</select>
						<p class="tip"><%=objXmlLang("about_default_level")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_join_point")%></th>
						<td>
						<p class="inp"><%=objXmlLang("text_point1")%> : <input name="strJoinPointTitle" type="text" id="strJoinPointTitle" value="<%=strJoinPointTitle%>" size="40"></p>
						<p class="inp"><%=objXmlLang("text_point2")%> : <input name="intJoinPoint" type="text" id="intJoinPoint" value="<%=intJoinPoint%>" size="15" maxlength="10" class="integer ime_mode"></p>
						<p class="tip"><%=objXmlLang("about_join_point")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_join_email")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitSendJoinEmail, "bitSendJoinEmail", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_join_email")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_disp_level_icon")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_disp"), ",", bitDispLevelIcon, "bitDispLevelIcon", "<dd>", "</dd>")%>
							<dd>
								<select id="strLevelIconFolder" name="strLevelIconFolder">
								<%=GetMakeSelectForm(objXmlLang("option_level_icon"), ",", strLevelIconFolder, "")%>
<%
	DIM folderList
	FOR EACH folderList IN SPLIT(GetFolderList(GetNowFolderPath("../") & "\" & CONF_strFilePath & "\member\level\"), ",")
		RESPONSE.WRITE "<option value=""" & folderList & """"
		IF folderList = strLevelIconFolder THEN RESPONSE.WRITE " selected"
		RESPONSE.WRITE ">" & folderList & "</option>" & CHR(10)
	NEXT
%>
								</select>
							</dd>
						</dl>
						<p class="tip"><%=objXmlLang("about_disp_level_icon")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use_profile")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUsePhoto, "bitUsePhoto", "<dd>", "</dd>")%>
						</dl>
						<p class="inp"><%=objXmlLang("text_width_size")%> : <input name="strPhotoSize" type="text" class="integer ime_mode" id="strPhotoSize" value="<%=strPhotoSize(0)%>" size="8" maxlength="4"> px</p>
						<p class="inp"><%=objXmlLang("text_height_size")%>: <input name="strPhotoSize" type="text" class="integer ime_mode" id="strPhotoSize" value="<%=strPhotoSize(1)%>" size="8" maxlength="4"> px</p>
						<p class="tip"><%=objXmlLang("about_use_profile")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use_name_img")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseNameImg, "bitUseNameImg", "<dd>", "</dd>")%>
						</dl>
						<p class="inp"><%=objXmlLang("text_width_size")%> : <input name="strNameImgSize" type="text" class="integer ime_mode" id="strNameImgSize" value="<%=strNameImgSize(0)%>" size="8" maxlength="4"> px</p>
						<p class="inp"><%=objXmlLang("text_height_size")%> : <input name="strNameImgSize" type="text" class="integer ime_mode" id="strNameImgSize" value="<%=strNameImgSize(1)%>" size="8" maxlength="4"> px</p>
						<p class="tip"><%=objXmlLang("about_use_name_img")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use_mark_img")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseMarkImg, "bitUseMarkImg", "<dd>", "</dd>")%>
						</dl>
						<p class="inp"><%=objXmlLang("text_width_size")%> : <input name="strMarkImgSize" type="text" class="integer ime_mode" id="strMarkImgSize" value="<%=strMarkImgSize(0)%>" size="8" maxlength="4"> px</p>
						<p class="inp"><%=objXmlLang("text_height_size")%> : <input name="strMarkImgSize" type="text" class="integer ime_mode" id="strMarkImgSize" value="<%=strMarkImgSize(1)%>" size="8" maxlength="4"> px</p>
						<p class="tip"><%=objXmlLang("about_use_mark_img")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_join_url")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_act"), ",", strJoinAct, "strJoinAct", "<dd>", "</dd>")%>
						</dl>
						<div class="strJoinActPage">
							<p class="inp"><label class="wd100"><%=objXmlLang("text_move_page")%> : </label><input name="strJoinActUrl" type="text" id="strJoinActUrl" value="<%=strJoinActUrl%>" size="90"></p>
							<p class="inp"><label><%=objXmlLang("text_disp_msg")%> : </label><input name="strJoinActMsg" type="text" id="strJoinActMsg" value="<%=strJoinActMsg%>" size="90"></p>
						</div>
						<div class="strJoinActScript">
							<textarea name="strJoinActScript" id="strJoinActScript" class="resizable"><%=strJoinActScript%></textarea>
						</div>
						<p class="tip"><%=objXmlLang("about_join_url")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_modify_page")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_act"), ",", strEditAct, "strEditAct", "<dd>", "</dd>")%>
						</dl>
						<div class="strEditActPage">
							<p class="inp"><label class="wd100"><%=objXmlLang("text_move_page")%> : </label><input name="strEditActUrl" type="text" id="strEditActUrl" value="<%=strEditActUrl%>" size="90"></p>
							<p class="inp"><label><%=objXmlLang("text_disp_msg")%> : </label><input name="strEditActMsg" type="text" id="strEditActMsg" value="<%=strEditActMsg%>" size="90"></p>
						</div>
						<div class="strEditActScript">
							<textarea name="strEditActScript" id="strEditActScript" class="resizable"><%=strEditActScript%></textarea>
						</div>
						<p class="tip"><%=objXmlLang("about_modify_page")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_out_type")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_member_data"), ",", strOutOption, "strOutOption", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_out_type")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_out_url")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_act"), ",", strOutAct, "strOutAct", "<dd>", "</dd>")%>
						</dl>
						<div class="strOutActPage">
							<p class="inp"><label class="wd100"><%=objXmlLang("text_move_page")%> : </label><input name="strOutActUrl" type="text" id="strOutActUrl" value="<%=strOutActUrl%>" size="90"></p>
							<p class="inp"><label><%=objXmlLang("text_disp_msg")%> : </label><input name="strOutActMsg" type="text" id="strOutActMsg" value="<%=strOutActMsg%>" size="90"></p>
						</div>
						<div class="strOutActScript">
							<textarea name="strOutActScript" id="strOutActScript" class="resizable"><%=strOutActScript%></textarea>
						</div>
						<p class="tip"><%=objXmlLang("about_out_url")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_out_memo")%></th>
						<td>
						<textarea name="strOutMemo" id="strOutMemo" class="resizable"><%=strOutMemo%></textarea>
						<p class="tip"><%=objXmlLang("about_out_memo")%></p>
						</td>
					</tr>
				</table>
				<div class="pt10"></div>
				<h4><%=objXmlLang("page_sub_title_3")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_find_account")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_disp_type"), ",", strAccountFind, "strAccountFind", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_find_account")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_login_point")%></th>
						<td>
						<p class="inp"><%=objXmlLang("text_point1")%> : <input name="strLoginPointTitle" type="text" id="strLoginPointTitle" value="<%=strLoginPointTitle%>" size="40"></p>
						<p class="inp"><%=objXmlLang("text_point2")%> : <input name="intLoginPoint" type="text" id="intLoginPoint" value="<%=intLoginPoint%>" size="15" maxlength="10" class="integer ime_mode"></p>
						<p class="tip"><%=objXmlLang("about_login_point")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_login_url")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_act_login"), ",", strLoginAct, "strLoginAct", "<dd>", "</dd>")%>
						</dl>
						<div class="strLoginActPage">
							<p class="inp"><label class="wd100"><%=objXmlLang("text_move_page")%> : </label><input name="strLoginActUrl" type="text" id="strLoginActUrl" value="<%=strLoginActUrl%>" size="90"></p>
							<p class="inp"><label><%=objXmlLang("text_disp_msg")%> : </label><input name="strLoginActMsg" type="text" id="strLoginActMsg" value="<%=strLoginActMsg%>" size="90"></p>
						</div>
						<div class="strLoginActScript">
							<textarea name="strLoginActScript" id="strLoginActScript" class="resizable"><%=strLoginActScript%></textarea>
						</div>
						<p class="tip"><%=objXmlLang("about_login_url")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_logout_url")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_act_login"), ",", strLogoutAct, "strLogoutAct", "<dd>", "</dd>")%>
						</dl>
						<div class="strLogoutActPage">
							<p class="inp"><label class="wd100"><%=objXmlLang("text_move_page")%> : </label><input name="strLogoutActUrl" type="text" id="strLogoutActUrl" value="<%=strLogoutActUrl%>" size="90"></p>
							<p class="inp"><label><%=objXmlLang("text_disp_msg")%> : </label><input name="strLogoutActMsg" type="text" id="strLogoutActMsg" value="<%=strLogoutActMsg%>" size="90"></p>
						</div>
						<div class="strLogoutActScript">
							<textarea name="strLogoutActScript" id="strLogoutActScript" class="resizable"><%=strLogoutActScript%></textarea>
						</div>
						<p class="tip"><%=objXmlLang("about_logout_url")%></p>
						</td>
					</tr>
				</table>
				<h4><%=objXmlLang("page_sub_title_4")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_name_check")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseNameCheck, "bitUseNameCheck", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_name_check")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_name_company")%></th>
						<td>
						<select name="strNameCheckCorp" id="strNameCheckCorp">
						<%=GetMakeSelectForm(objXmlLang("option_name_check"), ",", strNameCheckCorp, "")%>
						</select>
						<p class="tip"><%=objXmlLang("about_name_company")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_name_id")%></th>
						<td>
						<input name="strNameCkeckID" type="text" id="strNameCkeckID" value="<%=strNameCkeckID%>" size="40" maxlength="50"/>
						<p class="tip"><%=objXmlLang("about_name_id")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_name_pwd")%></th>
						<td>
						<input name="strNameCheckPwd" type="text" id="strNameCheckPwd" value="<%=strNameCheckPwd%>" size="40" maxlength="40"/>
						<p class="tip"><%=objXmlLang("about_name_pwd")%></p>
						</td>
					</tr>
				</table>
				<div class="formButtonBox">
				&nbsp;
				<span class="button large strong"><input type="submit" id="btn_save" value="<%=objXmlLang("btn_save")%>"></span>
				&nbsp; </div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->