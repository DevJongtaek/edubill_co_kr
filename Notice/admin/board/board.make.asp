<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D01"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM strSkinName, bitUseConsult, bitUseSecret

	strSkinName   = SPLIT(GetFolderList(GetNowFolderPath("../skin/board")), ",")(0)
	bitUseConsult = "0"
	bitUseSecret  = "1"
%>
<script type="text/javascript" src="../js/jquery.textarearesizer.js"></script>
<script type="text/javascript" src="board/js/board.make.js"></script>
		<div id="content">
			<form id="theForm">
			<input type="hidden" name="intSrl" id="intSrl" value="<%=intSrl%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_make")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_make")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title_1")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_board_id")%></th>
						<td>
						<input name="strBoardID" type="text" id="strBoardID" size="30" maxlength="30"/>
						<p class="tip"><%=objXmlLang("about_board_id")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_subject")%></th>
						<td>
						<input name="strTitle" type="text" id="strTitle" size="80" maxlength="100"/>
						<p class="tip"><%=objXmlLang("about_subject")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_layout")%></th>
						<td>
						<select name="strLayoutCode" id="strLayoutCode">
						<%=GetMakeSelectForm(objXmlLang("option_nouse"), ",", strLayoutCode, "")%>
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
						<th scope="row"><%=objXmlLang("title_category")%></th>
						<td>
						<span class="fl">
						<select name="strCateCode" id="strCateCode" style="width:250px;">
						<%=GetMakeSelectForm(objXmlLang("option_nouse"), ",", strCateCode, "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] 'C000000003' ")
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
	SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] 'C000000003' ")

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
						<th scope="row"><%=objXmlLang("title_skin")%></th>
						<td>
						<p>
<%
	DIM skinFolderList
	skinFolderList = SPLIT(GetFolderList(GetNowFolderPath("../") & "\skin\board"), ",")
%>
						<span class="fl">
						<select name="strSkinName" id="strSkinName" onChange="Skin.ColorSet(this.value);Skin.LangSet(this.value);">
<%
	FOR tmpFor = 0 TO UBOUND(skinFolderList)

		xmlDOM.Load Server.MapPath("..\skin\board\" & skinFolderList(tmpFor) & "\") & "\skin.xml"

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
	xmlDOM.Load Server.MapPath("..\skin\board\" & strSkinName & "\") & "\skin.xml"
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
						<p class="tip"><%=objXmlLang("about_skin")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_browser_msg")%></th>
						<td>
							<input name="strBrowserTitle" type="text" id="strBrowserTitle" size="100" maxlength="200"/>
							<p class="tip"><%=objXmlLang("about_browser_msg")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use_customer")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseConsult, "bitUseConsult", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_use_customer")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use_secret")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseSecret, "bitUseSecret", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_use_secret")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_header_html")%></th>
						<td>
							<textarea name="strHeaderHtml" id="strHeaderHtml" class="resizable"></textarea>
							<p class="tip"><%=objXmlLang("about_header_html")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_footer_html")%></th>
						<td>
							<textarea name="strFooterHtml" id="strFooterHtml" class="resizable"></textarea>
							<p class="tip"><%=objXmlLang("about_footer_html")%></p>
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