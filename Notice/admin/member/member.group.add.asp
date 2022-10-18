<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C03"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.group.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<link type="text/css" href="../js/swfupload/default.css" rel="stylesheet" />
<script type="text/javascript" src="../js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="../js/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="../js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="../js/swfupload/handlers_1.js"></script>
<script type="text/javascript" src="member/js/member.group.add.js"></script>
<%
	DIM act, strGroupCode
	act = GetInputReplce(REQUEST.QueryString("act"), "")

	strGroupCode = GetInputReplce(REQUEST.QueryString("strGroupCode"), "")

	DIM strTitle, bitDefault, bitAdmin, strDescription, strMarkFile, intUpLevel

	SELECT CASE LCASE(Act)
	CASE "membergroupadd"

		bitDefault = "0"
		intUpLevel = 0

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_READ] '', 'Y' ")

		strGroupCode = INT(RIGHT(RS(0), 9)) + 1

		FOR tmpFor = LEN(strGroupCode) TO 8
			strGroupCode = "0" & strGroupCode
		NEXT

		strGroupCode = "G" & strGroupCode

		CALL ActFolderMake(SERVER.MAPPATH("../" & CONF_strFilePath) & "\member\group\" & strGroupCode)

		DIM strUploadedFile
		strUploadedFile = GetFolderFileList(SERVER.MAPPATH("../" & CONF_strFilePath) & "\member\group\" & strGroupCode & "\")

		IF strUploadedFile <> "" AND ISNULL(strUploadedFile) = False THEN CALL ActFileDelete(SERVER.MAPPATH("../" & CONF_strFilePath) & "\member\group\" & strGroupCode & "\" & strUploadedFile)

	CASE "membergroupmodify"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_READ] '" & strGroupCode & "' ")

		strTitle       = GetReplaceTag2Text(RS("strTitle"))
		bitAdmin       = RS("bitAdmin")
		bitDefault     = GetBitTypeNumberChg(RS("bitDefault"))
		strDescription = RS("strDescription")
		intUpLevel     = RS("intUpLevel")
		strMarkFile    = RS("strMarkFile")

	END SELECT
%>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
				<div class="right_area">
					<span class="button medium icon"><span class="add"></span><button id="btn_group_add" type="button"><%=objXmlLang("btn_group_add")%></button></span>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description")%></p>
			<div id="subBody">
			<h4><%=objXmlLang("page_sub_title_1")%></h4>
			<form id="theForm" action="action/?subAct=membergroup&Act=<%=Act%>">
			<input name="strGroupCode" type="hidden" id="strGroupCode" value="<%=strGroupCode%>" />
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_subject")%></th>
						<td>
						<input name="strTitle" type="text" id="strTitle" value="<%=strTitle%>" size="60" maxlength="128" style="width:400px;" />
						</td>
					</tr>
<% IF bitAdmin = False THEN %>
					<tr>
						<th scope="row"><%=objXmlLang("title_group")%></th>
						<td>
							<dl class="checkbox_form">
								<%=GetMakeCheckForm(objXmlLang("option_default"), ",", bitDefault, "bitDefault", "", "")%>
							</dl>
						</td>
					</tr>
<% END IF %>
					<tr>
						<th scope="row"><%=objXmlLang("title_group_level")%></th>
						<td>
						<select name="intUpLevel" id="intUpLevel">
						<%=GetMakeSelectForm(objXmlLang("option_level"), ",", "", "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_LIST] ")

	WHILE NOT(RS.EOF)
%>
						<option value="<%=RS("intLevel")%>"<% IF INT(RS("intLevel")) = INT(intUpLevel) THEN %> selected<% END IF %>><%=RS("strLevelTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
						</select>
						<p class="tip"><%=objXmlLang("about_group_level")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_memo")%></th>
						<td><textarea name="strDescription" id="strDescription" cols="45" rows="5" style="width:400px;"><%=strDescription%></textarea></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_img")%></th>
						<td>
							<ul>
								<li class="fl"><input name="strMarkFile" type="text" id="strMarkFile" value="<%=strMarkFile%>" /></li>
								<li class="fl ml5"><span id="spanButtonPlaceHolder"></span></li>
								<li class="fl ml5"><span class="button medium"><input type="button" id="btn_delete" value="<%=objXmlLang("btn_remove")%>" /></span></li>
							</ul>
							<div class="ml5 mt5 both fl" id="fsUploadProgress"></div>
						</td>
					</tr>
				</table>
				<div class="formButtonBox">
				<span class="button large strong"><input type="submit" id="btn_save" value="<%=objXmlLang("btn_save")%>"></span>
				<span class="button large"><input type="button" id="btn_cancel" value="<%=objXmlLang("btn_cancel")%>"></span>
				</div>
			</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->