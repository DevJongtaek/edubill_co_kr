<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D10"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.search.config.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM strBrowserTitle, strLayoutCode, strSkinName, strSkinColor, strSkinLang, strSearchTarget, bitSearchDocument
	DIM bitSearchComment, bitSearchImage, bitSearchFile, bitSearchBoardTotal, strSearchBoard, intCutTitle, intCutContent
	DIM strLinkTarget, intImageWidth, intImageHeight, intDefaultListCount, intListCount

	SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_CONFIG] ")

	strBrowserTitle     = RS("strBrowserTitle")
	strLayoutCode       = RS("strLayoutCode")
	strSkinName         = RS("strSkinName")
	strSkinColor        = RS("strSkinColor")
	strSkinLang         = RS("strSkinLang")
	strSearchTarget     = RS("strSearchTarget")
	bitSearchDocument   = GetBitTypeNumberChg(RS("bitSearchDocument"))
	bitSearchComment    = GetBitTypeNumberChg(RS("bitSearchComment"))
	bitSearchImage      = GetBitTypeNumberChg(RS("bitSearchImage"))
	bitSearchFile       = GetBitTypeNumberChg(RS("bitSearchFile"))
	bitSearchBoardTotal = GetBitTypeNumberChg(RS("bitSearchBoardTotal"))
	strSearchBoard      = RS("strSearchBoard")
	intCutTitle         = RS("intCutTitle")
	intCutContent       = RS("intCutContent")
	strLinkTarget       = RS("strLinkTarget")
	intImageWidth       = RS("intImageWidth")
	intImageHeight      = RS("intImageHeight")
	intDefaultListCount = RS("intDefaultListCount")
	intListCount        = RS("intListCount")

	DIM strTempBoardSrl, strTempBoardID, strTempBoardName

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LIST] 'L', '', '', '', '' ")

	WHILE NOT(RS.EOF)

		IF strTempBoardSrl <> "" THEN
			strTempBoardSrl  = strTempBoardSrl  & "$$$"
			strTempBoardID   = strTempBoardID   & "$$$"
			strTempBoardName = strTempBoardName & "$$$"
		END IF

		strTempBoardSrl  = strTempBoardSrl  & RS("intSrl")
		strTempBoardID   = strTempBoardID   & RS("strBoardID")
		strTempBoardName = strTempBoardName & RS("strTitle")

	RS.MOVENEXT
	WEND

	strTempBoardSrl  = SPLIT(strTempBoardSrl, "$$$")
	strTempBoardID   = SPLIT(strTempBoardID, "$$$")
	strTempBoardName = SPLIT(strTempBoardName, "$$$")
%>
<script type="text/javascript" src="board/js/search.config.js"></script>
		<div id="content">
			<form id="theForm">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
				<div class="right_area">
					<span class="button medium"><button id="btn_preview" type="button"><%=objXmlLang("btn_preview")%></button></span>
				</div>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_browser_msg")%></th>
						<td>
							<input name="strBrowserTitle" type="text" id="strBrowserTitle" value="<%=strBrowserTitle%>" class="inp_97" />
							<p class="tip"><%=objXmlLang("about_browser_msg")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_layout")%></th>
						<td>
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
						<th scope="row"><%=objXmlLang("title_skin")%></th>
						<td>
						<p>
<%
	DIM skinFolderList
	skinFolderList = SPLIT(GetFolderList(GetNowFolderPath("../") & "\skin\search"), ",")
%>
						<span class="fl">
						<select name="strSkinName" id="strSkinName" onChange="Skin.ColorSet(this.value);Skin.LangSet(this.value);">
<%
	FOR tmpFor = 0 TO UBOUND(skinFolderList)

		xmlDOM.Load Server.MapPath("..\skin\search\" & skinFolderList(tmpFor) & "\") & "\skin.xml"

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
	xmlDOM.Load Server.MapPath("..\skin\search\" & strSkinName & "\") & "\skin.xml"
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
					<tr>
						<th scope="row"><%=objXmlLang("title_search_target")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_search_target"), ",", strSearchTarget, "strSearchTarget", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_search_target")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_search_item")%></th>
						<td>
							<span class="fl mr10">
								<ul>
									<%=GetMakeCheckForm(objXmlLang("option_search_document"), ",", bitSearchDocument, "bitSearchDocument", "<li class=""fl mr10"">", "</li>")%>
									<%=GetMakeCheckForm(objXmlLang("option_search_comment"), ",", bitSearchComment, "bitSearchComment", "<li class=""fl mr10"">", "</li>")%>
									<%=GetMakeCheckForm(objXmlLang("option_search_image"), ",", bitSearchImage, "bitSearchImage", "<li class=""fl mr10"">", "</li>")%>
									<%=GetMakeCheckForm(objXmlLang("option_search_file"), ",", bitSearchFile, "bitSearchFile", "<li class=""fl mr10"">", "</li>")%>
								</ul>
							</span>
							<p class="tip"><%=objXmlLang("about_search_item")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_search_board")%></th>
						<td>
							<div>
								<dl class="radio_form">
									<%=GetMakeRadioForm(objXmlLang("option_search_board"), ",", bitSearchBoardTotal, "bitSearchBoardTotal", "<dd>", "</dd>")%>
								</dl>
							</div>
							<div id="boardSelectList" class="mt10">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="nostyle">
									<select name="strSearchBoard" size="10" multiple id="strSearchBoard" style="width:300px; height:200px;">
<%
	IF strSearchBoard <> "" AND ISNULL(strSearchBoard) = False THEN
		FOR EACH boardSrl IN SPLIT(strSearchBoard, ",")
			FOR tmpFor = 0 TO UBOUND(strTempBoardSrl)
				IF INT(boardSrl) = INT(strTempBoardSrl(tmpFor)) THEN
					RESPONSE.WRITE GetMakeSelectForm(strTempBoardSrl(tmpFor) & "$$$" & "[" & strTempBoardID(tmpFor) & "] " & strTempBoardName(tmpFor), ",", "", "")
				END IF
			NEXT
		NEXT
	END IF
%>
									</select>
									</td>
									<td style="border-bottom:none;">
									<ul>
										<li style="margin-bottom:3px;"><img id="menuRemove" src="images/blank.gif" width="20" height="20" class="btnMenuRight hand" /></li>
										<li style="margin-bottom:3px;"><img id="menuAdd" src="images/blank.gif" width="20" height="20" class="btnMenuLeft hand" /></li>
									</ul>
									</td>
									<td style="border-bottom:none;">
									<select name="strBoardList" size="10" multiple id="strBoardList" style="width:300px; height:200px;">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LIST] 'L', '', '', '', '" & strSearchBoard & "' ")

	WHILE NOT(RS.EOF)
		RESPONSE.WRITE GetMakeSelectForm(RS("intSrl") & "$$$" & "[" & RS("strBoardID") & "] " & RS("strTitle"), ",", "", "")
	RS.MOVENEXT
	WEND
%>
									</select>
									</td>
								</tr>
							</table>
							</div>
							<p class="tip"><%=objXmlLang("about_search_board")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_cut_title")%></th>
						<td>
							<input name="intCutTitle" type="text" class="integer ime_mode" id="intCutTitle" value="<%=intCutTitle%>" size="10" maxlength="4" />
							<p class="tip"><%=objXmlLang("about_cut_title")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_cut_content")%></th>
						<td>
							<input name="intCutContent" type="text" class="integer ime_mode" id="intCutContent" value="<%=intCutContent%>" size="10" maxlength="4" />
							<p class="tip"><%=objXmlLang("about_cut_content")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_link_target")%></th>
						<td>
							<select name="strLinkTarget" id="strLinkTarget">
							<%=GetMakeSelectForm(objXmlLang("option_link_target"), ",", strLinkTarget, "")%>
							</select>
							<p class="tip"><%=objXmlLang("about_link_target")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_image_size")%></th>
						<td>
							<span class="fl mr10">
							<%=objXmlLang("text_image_width")%> : 
							<input name="intImageWidth" type="text" id="intImageWidth" size="10" maxlength="4" class="integer ime_mode" value="<%=intImageWidth%>">
							px
							</span>
							<span class="fl mr10">
							<%=objXmlLang("text_image_height")%> : 
							<input name="intImageHeight" type="text" id="intImageHeight" size="10" maxlength="4" class="integer ime_mode" value="<%=intImageHeight%>">
							px
							</span>
							<p class="tip"><%=objXmlLang("about_image_size")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_default_count")%></th>
						<td>
							<input name="intDefaultListCount" type="text" class="integer ime_mode" id="intDefaultListCount" value="<%=intDefaultListCount%>" size="10" maxlength="4" />
							<p class="tip"><%=objXmlLang("about_default_count")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_list_count")%></th>
						<td>
							<input name="intListCount" type="text" class="integer ime_mode" id="intListCount" value="<%=intListCount%>" size="10" maxlength="4" />
							<p class="tip"><%=objXmlLang("about_list_count")%></p>
						</td>
					</tr>
				</table>
				<div class="formButtonBox">
					<span class="button large strong"><input name="submit" type="submit" value="<%=objXmlLang("btn_save")%>"></span>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->