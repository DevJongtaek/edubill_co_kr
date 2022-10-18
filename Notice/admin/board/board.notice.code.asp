<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D08"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.notice.code.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<script type="text/javascript">

		var set_list_1 = {options:[
<%
	strFilderList = SPLIT(GetFolderList(GetNowFolderPath("board\main_design\document\")), ",")

	FOR tmpFor = 0 TO UBOUND(strFilderList)
		IF tmpFor > 0 THEN RESPONSE.WRITE ","
		RESPONSE.WRITE "{folder:""" & strFilderList(tmpFor) & """}"
	NEXT
%>
		]};

		var set_list_2 = {options:[
<%
	strFilderList = SPLIT(GetFolderList(GetNowFolderPath("board\main_design\gallery\")), ",")

	FOR tmpFor = 0 TO UBOUND(strFilderList)
		IF tmpFor > 0 THEN RESPONSE.WRITE ","
		RESPONSE.WRITE "{folder:""" & strFilderList(tmpFor) & """}"
	NEXT
%>
		]};

		var set_list_3 = {options:[
<%
	strFilderList = SPLIT(GetFolderList(GetNowFolderPath("board\main_design\comment\")), ",")

	FOR tmpFor = 0 TO UBOUND(strFilderList)
		IF tmpFor > 0 THEN RESPONSE.WRITE ","
		RESPONSE.WRITE "{folder:""" & strFilderList(tmpFor) & """}"
	NEXT
%>
		]};

</script>
<script type="text/javascript" src="board/js/board.notice.code.js"></script>
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
						<th scope="row"><%=objXmlLang("title_data_type")%></th>
						<td>
							<select id="strDataType" name="strDataType" onChange="datatype(this);">
							<%=GetMakeSelectForm(objXmlLang("option_data_type"), ",", "", "")%>
							</select>
							<p class="tip"><%=objXmlLang("about_data_type")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_board_select")%></th>
						<td>
							<dl class="checkbox_form">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LIST] 'L', '', '', '' ")

	tmpFor = 0
	WHILE NOT(RS.EOF)
		tmpFor = tmpFor + 1
%>
								<dd><input type="checkbox" id="strBoardSrl<%=tmpFor%>" name="strBoardSrl" value="<%=RS("intSrl")%>"><label for="strBoardSrl<%=tmpFor%>" class="cursor"><%=RS("strTitle")%> [<%=RS("strBoardID")%>]</label></dd>
<%
	RS.MOVENEXT
	WEND
%>
							</dl>
							<p class="tip"><%=objXmlLang("about_board_select")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_list_count")%></th>
						<td>
							<input name="intListCount" type="text" id="intListCount" size="10" maxlength="4" class="integer ime_mode" value="5">
							<p class="tip"><%=objXmlLang("about_list_count")%></p>
						</td>
					</tr>
					<tr id="use_thrum" style="display:none;">
						<th scope="row"><%=objXmlLang("title_thrum")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_thrum"), ",", "0", "bitUseThrum", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_thrum")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_text_cut")%></th>
						<td>
						<span class="fl mr10">
						<%=objXmlLang("text_title")%> : <input name="strCutText" type="text" id="strCutText1" size="10" maxlength="4" class="integer ime_mode">
						</span>
						<span class="fl mr10">
						<%=objXmlLang("text_content")%> : <input name="strCutText" type="text" id="strCutText2" size="10" maxlength="4" class="integer ime_mode">
						</span>
						<p class="tip"><%=objXmlLang("about_cut_title")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_design_style")%></th>
						<td>
							<select id="strDesign" name="strDesign">
							<%=GetMakeSelectForm(objXmlLang("option_design_style"), ",", "", "")%>
							</select>
							<p class="tip"><%=objXmlLang("about_design_style")%></p>
						</td>
					</tr>
				</table>
				<div class="codeArea">
					<div class="tab">
						<ul id="tabNav3">
							<li><a href="#" class="on" name="btn_markup" id="markup_" onClick="return false;">Markup</a></li>
							<li><a href="#" name="btn_css" id="css_" onClick="return false;">CSS</a></li>			
							<li><a href="#" name="btn_preview" id="preview_" onClick="return false;">Preview</a></li>			
							<li><a href="#" name="btn_extend" id="extend_" onClick="return false;">Extend</a></li>			
						</ul>
					</div>
					<div class="codeContent">
						<div id="markup3">
						<h4 class="non">Markup source</h4>
						<div class="selectcode"><a href="#" id="select_code1" onClick="return false;">Select Code</a></div>
						<textarea class="codecontainer" id="codecontainer1" cols="100" rows="10" readonly></textarea>
						</div>
						<div id="css3" class="non">
						<h4 class="non">CSS source</h4>
						<div class="selectcode"><a href="#" id="select_code2" onClick="return false;">Select Code</a></div>
						<textarea class="codecontainer" id="codecontainer2" cols="100" rows="10" readonly></textarea>
						</div>
						<div id="preview3" class="non">
							<div id="codecontainer3" class="preview"></div>
						</div>
						<div id="extend3" class="non">
							<div id="codecontainer4" class="preview"></div>
						</div>
					</div>
				</div>
				<div class="formButtonBox">
					<span class="button large strong"><input name="submit" type="submit" value="<%=objXmlLang("btn_source")%>"></span>
			</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->