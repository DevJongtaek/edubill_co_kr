<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intSrl
	intSrl = GetInputReplce(REQUEST.QueryString("intSrl"), "")

	DIM Act
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))

	DIM strFieldRecord, strFieldName, strFieldType, strDefaultValue, strReadLevel, strReadGroup, strWriteLevel, strWriteGroup
	DIM bitUse, bitRquired, bitReadDisplay, bitSearch, strDescription

	SELECT CASE Act
	CASE "boardconfigfieldadd"

		bitUse         = "1"
		bitRquired     = "0"
		bitReadDisplay = "1"
		bitSearch      = "0"

	CASE "boardconfigfieldmodify"

		strFieldRecord = GetInputReplce(REQUEST.QueryString("strFieldRecord"), "")

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_READ] '" & intSrl & "', '" & strFieldRecord & "' ")
		
		strFieldName    = RS("strFieldName")
		strFieldType    = RS("strFieldType")
		strDefaultValue = RS("strDefaultValue")
		strReadLevel    = RS("strReadLevel")
		strReadGroup    = RS("strReadGroup")
		strWriteLevel   = RS("strWriteLevel")
		strWriteGroup   = RS("strWriteGroup")
		bitUse          = GetBitTypeNumberChg(RS("bitUse"))
		bitRquired      = GetBitTypeNumberChg(RS("bitRquired"))
		bitReadDisplay  = GetBitTypeNumberChg(RS("bitReadDisplay"))
		bitSearch       = GetBitTypeNumberChg(RS("bitSearch"))
		strDescription  = RS("strDescription")

	END SELECT

	DIM strGroupCode, strGroupTitle

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	WHILE NOT(RS.EOF)

		IF strGroupCode <> "" THEN
			strGroupCode = strGroupCode & "$$$"
			strGroupTitle = strGroupTitle & "$$$"
		END IF

		strGroupCode  = strGroupCode  & RS("strGroupCode")
		strGroupTitle = strGroupTitle & RS("strTitle")

	RS.MOVENEXT
	WEND

	strGroupCode  = SPLIT(strGroupCode, "$$$")
	strGroupTitle = SPLIT(strGroupTitle, "$$$")
%>
<script type="text/javascript" src="board/js/board.config.field.add.js"></script>
		<div id="content">
			<form id="extForm" method="post" class="none">
			</form>
			<form id="theForm">
			<input type="hidden" name="intSrl" id="intSrl" value="<%=intSrl%>">
			<input type="hidden" name="Act" id="Act" value="<%=Act%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_config_field")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_config_field")%>
			</p>
			<div id="subBody">
<!-- #include file = "board.config.comm.asp" -->
				<h4><%=objXmlLang("page_sub_title_1")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_field")%></th>
						<td>
<% IF Act = "boardconfigfieldadd" THEN %>
							<select name="strFieldRecord" id="strFieldRecord">
<%
	DIM strFieldRecordTemp
	strFieldRecordTemp = "strAddData1,strAddData2,strAddData3,strAddData4,strAddData5,strAddData6,strAddData7,strAddData8,strAddData9,strAddData10,strAddData11,strAddData12,strAddData13,strAddData14,strAddData15"

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_READ] '" & intSrl & "', '', 'Y' ")
	
	WHILE NOT(RS.EOF)

		strFieldRecordTemp = REPLACE(strFieldRecordTemp, RS("strFieldRecord") & ",", "")

	RS.MOVENEXT
	WEND
%>
							<%=GetMakeSelectForm(strFieldRecordTemp & "$$$" & strFieldRecordTemp, ",", strFieldRecord, "")%>
							</select>
<% ELSE %>
							<%=strFieldRecord%><input type="hidden" id="strFieldRecord" name="strFieldRecord" value="<%=strFieldRecord%>">
<% END IF %>
							<p class="tip"><%=objXmlLang("about_field")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_field_name")%></th>
						<td>
							<input name="strFieldName" type="text" id="strFieldName" value="<%=strFieldName%>" size="40" maxlength="100">
							<p class="tip"><%=objXmlLang("about_field_name")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_field_type")%></th>
						<td>
							<select name="strFieldType" id="strFieldType">
							<%=GetMakeSelectForm(objXmlLang("option_field_type"), ",", strFieldType, "strFieldType")%>
							</select>
							<p class="tip"><%=objXmlLang("about_field_type")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_default_value")%></th>
						<td>
							<textarea name="strDefaultValue" id="strDefaultValue" cols="45" rows="5"><%=strDefaultValue%></textarea>
							<p class="tip"><%=objXmlLang("about_default_value")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row">읽기권한</th>
						<td>
							<p>
								<select name="strReadLevel" id="strReadLevel" onChange="dispAccGroup(this, 'strReadGroupDiv');">
								<%=GetMakeSelectForm(objXmlLang("option_access"), ",", strReadLevel, "")%>
								</select>
							</p>
							<div id="strReadGroupDiv" class="radiocheckArea pt5 both">
								<ul>
<%
	FOR tmpFor = 0 TO UBOUND(strGroupCode)

		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strReadGroup"" id=""strReadGroup" & tmpFor & """ value=""" & strGroupCode(tmpFor) & """"
		IF strReadGroup <> "" AND ISNULL(strReadGroup) = False THEN
			IF INSTR(strReadGroup, strGroupCode(tmpFor)) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strReadGroup" & tmpFor & ">" & strGroupTitle(tmpFor) & "</label></li>" & CHR(13)

	NEXT
%>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">등록권한</th>
						<td>
							<p>
								<select name="strWriteLevel" id="strWriteLevel" onChange="dispAccGroup(this, 'strWriteGroupDiv');">
								<%=GetMakeSelectForm(objXmlLang("option_access"), ",", strWriteLevel, "")%>
								</select>
							</p>
							<div id="strWriteGroupDiv" class="radiocheckArea pt5 both">
								<ul>
<%
	FOR tmpFor = 0 TO UBOUND(strGroupCode)

		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strWriteGroup"" id=""strWriteGroup" & tmpFor & """ value=""" & strGroupCode(tmpFor) & """"
		IF strWriteGroup <> "" AND ISNULL(strWriteGroup) = False THEN
			IF INSTR(strWriteGroup, strGroupCode(tmpFor)) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strWriteGroup" & tmpFor & ">" & strGroupTitle(tmpFor) & "</label></li>" & CHR(13)

	NEXT
%>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUse, "bitUse", "<dd>", "</dd>")%>
							</dl>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_equired")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_rquired"), ",", bitRquired, "bitRquired", "<dd>", "</dd>")%>
							</dl>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_read_disp")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_display"), ",", bitReadDisplay, "bitReadDisplay", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_read_display")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_search")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_search"), ",", bitSearch, "bitSearch", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_search")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_description")%></th>
						<td>
							<textarea name="strDescription" id="strDescription" cols="45" rows="5"><%=strDescription%></textarea>
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