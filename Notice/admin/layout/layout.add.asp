<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 2
	menuID      = "B01"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.layout.layout.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<link type="text/css" href="../style/jqueryFileTree.css" rel="stylesheet"media="screen" />
<link type="text/css" href="../style/jquery.colorpicker.css" rel="stylesheet" />
<link type="text/css" href="../js/swfupload/default.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery.colorPicker.js"></script>
<script type="text/javascript" src="../js/jqueryFileTree.js"></script>
<script type="text/javascript" src="../js/jquery.textarearesizer.js"></script>
<script type="text/javascript" src="../js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="../js/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="../js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="../js/swfupload/handlers_1.js"></script>
<script type="text/javascript" src="layout/js/layout.add.js"></script>
<%
	DIM Act
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	IF Act = "" THEN Act = "layoutadd"

	DIM intPage, intPageSize

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""

	DIM strLayoutCode, strTitle, strHeaderConts, strBrowserTitle, strLayoutAlign, intLayoutWidth, strLayOutWidth
	DIM strLayoutMargin, strBackType, strBackColor, strBackImg, strBackImgRepeat, strUserStyle, strHeaderFile
	DIM strHeaderHtml, strFooterFile, strFooterHtml, bitUse

	strLayoutCode = GetInputReplce(REQUEST.QueryString("strLayoutCode"), "")

	SELECT CASE Act
	CASE "layoutadd"

		strLayoutAlign   = "left"
		intLayoutWidth   = 100
		strLayOutWidth   = "%"
		strLayoutMargin  = SPLIT(",,,", ",")
		strBackType      = "2"
		strBackColor     = "FFFFFF"
		strBackImgRepeat = "n"
		bitUse           = "1"

	CASE "layoutedit"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_LAYOUT_READ] 'N', '" & strLayoutCode & "' ")

		IF RS.EOF THEN

			RESPONSE.WRITE "Error"
			RESPONSE.End()

		ELSE

			strTitle         = GetReplaceTag2Text(RS("strTitle"))
			strHeaderConts   = RS("strHeaderConts")
			strBrowserTitle  = GetReplaceTag2Text(RS("strBrowserTitle"))
			strLayoutAlign   = RS("strLayoutAlign")
			intLayoutWidth   = RS("intLayoutWidth")
			strLayOutWidth   = RS("strLayOutWidth")
			strLayoutMargin  = SPLIT(RS("strLayoutMargin"), ",")
			strBackType      = RS("strBackType")
			strBackColor     = RIGHT(RS("strBackColor"),6)
			strBackImg       = RS("strBackImg")
			strBackImgRepeat = RS("strBackImgRepeat")
			strUserStyle     = RS("strUserStyle")
			strHeaderFile    = GetReplaceTag2Text(RS("strHeaderFile"))
			strHeaderHtml    = RS("strHeaderHtml")
			strFooterFile    = GetReplaceTag2Text(RS("strFooterFile"))
			strFooterHtml    = RS("strFooterHtml")
			bitUse           = GetBitTypeNumberChg(RS("bitUse"))

		END IF

	END SELECT
%>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" name="intPageSize" value="<%=intPageSize%>">
		</form>
		<div id="content">
			<form id="theForm" action="action/?subAct=layout&Act=<%=Act%>">
			<input type="hidden" name="strLayoutCode" value="<%=strLayoutCode%>">
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
						<th scope="row"><%=objXmlLang("title_subject")%></th>
						<td>
						<input name="strTitle" type="text" id="strTitle" value="<%=strTitle%>" maxlength="250" class="inp_97" />
						<p class="tip"><%=objXmlLang("about_subject")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_header_code")%></th>
						<td>
							<textarea name="strHeaderConts" id="strHeaderConts" rows="10" class="resizable"><%=strHeaderConts%></textarea>
							<p class="tip"><%=objXmlLang("about_header_code")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_browser_msg")%></th>
						<td>
							<input name="strBrowserTitle" type="text" id="strBrowserTitle" value="<%=strBrowserTitle%>" maxlength="250" class="inp_97" />
							<p class="tip"><%=objXmlLang("about_browser_msg")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_align_width")%></th>
						<td>
						<span class="fl">
						<select name="strLayoutAlign" id="strLayoutAlign">
						<%=GetMakeSelectForm(objXmlLang("option_align"), ",", strLayoutAlign, "")%>
						</select>
						</span>
						<span class="fl pl5">
						<input name="intLayoutWidth" type="text" class="integer ime_mode" id="intLayoutWidth" value="<%=intLayoutWidth%>" size="6" maxlength="4">
						</span>
						<span class="fl pl5">
						<select name="strLayoutWidth" id="strLayoutWidth">
						<option value="%"<% IF strLayOutWidth = "%" THEN %> selected<% END IF %>>%</option>
						<option value="px"<% IF strLayOutWidth = "px" THEN %> selected<% END IF %>>px</option>
						</select>
						</span>
						<p class="tip"><%=objXmlLang("about_align_width")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_margin")%></th>
						<td>
						<label><%=objXmlLang("text_top")%> : </label>
						<input name="strLayoutMarginT" type="text" class="integer ime_mode" id="strLayoutMarginT" value="<%=strLayoutMargin(0)%>" size="6" maxlength="4">
						px
						<label class="ml5"><%=objXmlLang("text_right")%> : </label>
						<input name="strLayoutMarginR" type="text" class="integer ime_mode" id="strLayoutMarginR" value="<%=strLayoutMargin(1)%>" size="6" maxlength="4">
						px
						<label class="ml5"><%=objXmlLang("text_bottom")%> : </label>
						<input name="strLayoutMarginB" type="text" class="integer ime_mode" id="strLayoutMarginB" value="<%=strLayoutMargin(2)%>" size="6" maxlength="4">
						px
						<label class="ml5"><%=objXmlLang("text_left")%> : </label>
						<input name="strLayoutMarginL" type="text" class="integer ime_mode" id="strLayoutMarginL" value="<%=strLayoutMargin(3)%>" size="6" maxlength="4">
						px
						<p class="tip"><%=objXmlLang("about_margin")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_background")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_background"), ",", strBackType, "strBackType", "<dd>", "</dd>")%>
							</dl>
							<div id="backColorLayer" class="pt5">
							<LABEL class="fl"><%=objXmlLang("text_background")%> : </LABEL>
							<span class="fl"><input name="strBackColor" type="text" id="strBackColor" value="<%=strBackColor%>" size="10" readonly / class="hand"></span>
							</div>
							
						
							<div id="backImgLayer">
								<ul>
									<li class="fl"><input name="strBackImg" type="text" id="strBackImg" value="<%=strBackImg%>" size="40" readonly /></li>
									<li class="fl ml5"><span id="spanButtonPlaceHolder"></span></li>
									<li class="fl ml5">
									<select name="strBackImgRepeat" id="strBackImgRepeat">
									<%=GetMakeSelectForm(objXmlLang("option_backimg_repeat"), ",", strBackImgRepeat, "")%>
									</select>
									</li>
								</ul>
								<div class="ml5 mt5 both fl" id="fsUploadProgress"></div>
								<div class="both fl">
									<input type="checkbox" name="usePreviewFile" id="usePreviewFile"><label for="usePreviewFile" style="text-decoration:underline;"><%=objXmlLang("text_use_previmg")%></LABEL>
								</div>
								<ul id="layoutBackUploadedFile" class="both">
<%
	IF GetFolderFileList(GetNowFolderPath("..") & "\" & CONF_strFilePath & "\site\layout") <> "" THEN
		DIM tmpFileList
		tmpFileList = SPLIT(GetFolderFileList(GetNowFolderPath("..") & "\" & CONF_strFilePath & "\site\layout"), "|")
		FOR tmpFor = 0 TO UBOUND(tmpFileList)
			IF TRIM(tmpFileList(tmpFor)) <> "" THEN RESPONSE.WRITE "<li><a name=""file_list"" class=""hand"">" & tmpFileList(tmpFor) & "</a><a name=""file_remove"" class=""hand ml5""><img src=images/btn_x.gif></a></li>"
		NEXT
	END IF
%>
								</ul>
							</div>
							<p class="tip"><%=objXmlLang("about_background")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_user_style")%></th>
						<td>
							<textarea name="strUserStyle" id="strUserStyle" rows="10" class="resizable"><%=strUserStyle%></textarea>
							<p class="tip"><%=objXmlLang("about_user_style")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_header_file")%></th>
						<td>
						<span class="fl mr5">
						<input name="strHeaderFile" type="text" id="strHeaderFile" value="<%=strHeaderFile%>" maxlength="250" class="inp_500P" />
						</span>
						<span class="fl">
						<span class="button medium"><input type="button" id="btn_file_find1" value="<%=objXmlLang("btn_file_find")%>"></span>
						</span>
						<p class="pt10"></p>
						<div id="fileTreeList1" class="fileTreeList"></div>
						<p class="tip"><%=objXmlLang("about_header_file")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_header_html")%></th>
						<td>
							<textarea name="strHeaderHtml" id="strHeaderHtml" rows="10" class="resizable"><%=strHeaderHtml%></textarea>
							<p class="tip"><%=objXmlLang("about_header_html")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_footer_file")%></th>
						<td>
						<span class="fl mr5">
						<input name="strFooterFile" type="text" id="strFooterFile" value="<%=strFooterFile%>" maxlength="250" class="inp_500P" />
						</span>
						<span class="fl">
						<span class="button medium"><input type="button" id="btn_file_find2" value="<%=objXmlLang("btn_file_find")%>"></span>
						</span>
						<p class="pt10"></p>
						<div id="fileTreeList2" class="fileTreeList"></div>
						<p class="tip"><%=objXmlLang("about_footer_file")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_footer_html")%></th>
						<td>
							<textarea name="strFooterHtml" id="strFooterHtml" rows="10" class="resizable"><%=strFooterHtml%></textarea>
							<p class="tip"><%=objXmlLang("about_footer_html")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_layout_use")%></th>
						<td>
						<ul>
							<%=GetMakeRadioForm(objXmlLang("option_layout_use"), ",", bitUse, "bitUse", "<li class=""fl mr10 wd80"">", "</li>")%>
						</ul>
						<p class="tip"><%=objXmlLang("about_layout_use")%></p>
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