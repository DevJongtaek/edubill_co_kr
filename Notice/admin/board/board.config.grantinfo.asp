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

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LEVEL_POINT_READ] '" & intSrl & "' ")

	DIM strListLevel, strListGroup, strListAction, strReadLevel, strReadGroup, strReadAction, strWriteLevel, strWriteGroup
	DIM strWriteAction, strCmtWriteLevel, strCmtWriteGroup, strUploadLevel, strUploadGroup, strDownLevel, strDownGroup

	strListLevel     = RS("strListLevel")
	strListGroup     = RS("strListGroup")
	strListAction    = SPLIT(RS("strListAction"), "^$$^")
	strReadLevel     = RS("strReadLevel")
	strReadGroup     = RS("strReadGroup")
	strReadAction    = SPLIT(RS("strReadAction"), "^$$^")
	strWriteLevel    = RS("strWriteLevel")
	strWriteGroup    = RS("strWriteGroup")
	strWriteAction   = SPLIT(RS("strWriteAction"), "^$$^")
	strCmtWriteLevel = RS("strCmtWriteLevel")
	strCmtWriteGroup = RS("strCmtWriteGroup")
	strUploadLevel   = RS("strUploadLevel")
	strUploadGroup   = RS("strUploadGroup")
	strDownLevel     = RS("strDownLevel")
	strDownGroup     = RS("strDownGroup")

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
<script type="text/javascript">

	var adminListMsgItem = "<%=objXmlLang("text_admin_item")%>";
	adminListMsgItem = adminListMsgItem.split(",");

	$(document).ready(function() {

		$("#btn_search").click(function(){

			if ($("#searchWord").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_search_keyword"]);$("#searchWord").focus();return false;
			}

			$.ajax({type: "POST", url: "action/?subAct=boardadminlist", data: "intSrl=" + $("#intSrl").val() + "&searchMode=" + $("#searchMode").val() + "&searchText=" + $("#searchWord").val(), dataType: "json", success: function(responseText){

				if (responseText.length == 0){
					alert(arApplMsg["is_null_search_member"]);$("#admin_search").hide();$("#admin_search").html('');return false;
				}else{

					var html = "";

					for(var i = 0; i < responseText.length; i++){

						html += '<p class="admin"><input type="checkbox" name="memberSrl" id="memberSrl' + i + '" value="' + responseText[i].memberSrl + '$$$' + responseText[i].username + '$$$' + responseText[i].userid + '$$$' + responseText[i].visitdate + '$$$' + responseText[i].visit + '$$$' + responseText[i].article + '$$$' + responseText[i].comment + '"><label for="adminid' + i + '">' + responseText[i].username + ' (' + responseText[i].userid + ') | ' + adminListMsgItem[0] + ' ' + responseText[i].visitdate + ' | ' + adminListMsgItem[1] + ' ' + responseText[i].visit + ' | ' + adminListMsgItem[2] + ' ' + responseText[i].article + ' | ' + adminListMsgItem[3] +' ' + responseText[i].comment + '</label></p>';

					}

					html += '<p class="mt5"><span class="button medium"><input type="button" id="btn_admin_add" class="btn_admin_add" onclick="addMember();" value="<%=objXmlLang("btn_insert")%>" /></span></p>'

				}

				$("#admin_search").show();
				$("#admin_search").html(html);
				$("input:checkbox").checkbox();
	
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

		});

	});

</script>
<script type="text/javascript" src="board/js/board.config.grantinfo.js"></script>
		<div id="content">
			<form id="theForm">
			<input type="hidden" name="intSrl" id="intSrl" value="<%=intSrl%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_config_grantinfo")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_config_grantinfo")%>
			</p>
			<div id="subBody">
<!-- #include file = "board.config.comm.asp" -->
				<h4><%=objXmlLang("page_sub_title_8")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_board_admin")%></th>
						<td>
							<div><span class="fl mr5">
								<select name="strAdminList" size="5" id="strAdminList" style="width:500px; height:83px;">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_ADMIN_READ] '" & intSrl & "', '', '0' ")

	strAdminListMsgItem = SPLIT(objXmlLang("text_admin_item"), ",")

	WHILE NOT(RS.EOF)
%>
									<option value="<%=RS("intSeq")%>"><%=RS("strUserName")%> (<%=RS("strLoginID")%>) / <%=strAdminListMsgItem(0)%> <%=REPLACE(LEFT(RS("strVisitDate"),10),"-",".")%> / <%=strAdminListMsgItem(1)%> <%=rS("intVisit")%> / <%=strAdminListMsgItem(2)%> <%=RS("intArticle")%> / <%=strAdminListMsgItem(3)%> <%=RS("intComment")%></option>
<%
	RS.MOVENEXT
	WEND
%>
								</select>
							</span>
							<span>
								<span class="button small"><input type="button" id="btn_remove" value="<%=objXmlLang("btn_remove")%>" /></span>
							</span>
							</div>
							<div class="pt5 both">
							<span class="mr5">
							<select name="searchMode" id="searchMode">
							<%=GetMakeSelectForm(objXmlLang("option_member_search"), ",", "", "")%>
							</select>
							</span>
							<span class="fl ml5"><input name="searchWord" type="text" id="searchWord" size="30"></span>
							<span><span class="button small"><input type="button" id="btn_search" value="<%=objXmlLang("btn_search")%>" /></span></span>
							</div>
							<div id="admin_search" class="both pt5">
							</div>
						</td>
					</tr>
				</table>
				<div class="pt10"></div>
				<h4><%=objXmlLang("page_sub_title_9")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_list_level")%></th>
						<td>
							<p>
								<select name="strListLevel" id="strListLevel" onChange="dispAccGroup(this, 'strListGroupDiv');">
								<%=GetMakeSelectForm(objXmlLang("option_access"), ",", strListLevel, "")%>
								</select>
							</p>
							<div id="strListGroupDiv" class="radiocheckArea pt5 both">
								<ul>
<%
	FOR tmpFor = 0 TO UBOUND(strGroupCode)

		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strListGroup"" id=""strListGroup" & tmpFor & """ value=""" & strGroupCode(tmpFor) & """"
		IF strListGroup <> "" AND ISNULL(strListGroup) = False THEN
			IF INSTR(strListGroup, strGroupCode(tmpFor)) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strListGroup" & tmpFor & ">" & strGroupTitle(tmpFor) & "</label></li>" & CHR(13)

	NEXT
%>
								</ul>
							</div>
							<div class="both pt5">
								<p style="line-height:25px;"><%=objXmlLang("text_page_move")%> : <input name="strListAction1" type="text" id="strListAction1" value="<%=strListAction(0)%>" size="80"></p>
								<p><%=GetMakeCheckForm(objXmlLang("option_login"), ",", strListAction(1), "strListAction2", "", "")%></p>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_read_level")%></th>
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
							<div class="both pt5">
								<p style="line-height:25px;"><%=objXmlLang("text_page_move")%> : <input name="strReadAction1" type="text" id="strReadAction1" value="<%=strReadAction(0)%>" size="80"></p>
								<p><%=GetMakeCheckForm(objXmlLang("option_login"), ",", strReadAction(1), "strReadAction2", "", "")%></p>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_write_level")%></th>
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
							<div class="both pt5">
								<p style="line-height:25px;"><%=objXmlLang("text_page_move")%> : <input name="strWriteAction1" type="text" id="strWriteAction1" value="<%=strWriteAction(0)%>" size="80"></p>
								<p><%=GetMakeCheckForm(objXmlLang("option_login"), ",", strWriteAction(1), "strWriteAction2", "", "")%></p>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_comment_level")%></th>
						<td>
							<p>
								<select name="strCmtWriteLevel" id="strCmtWriteLevel" onChange="dispAccGroup(this, 'strCmtWriteGroupDiv');">
								<%=GetMakeSelectForm(objXmlLang("option_access"), ",", strCmtWriteLevel, "")%>
								</select>
							</p>
							<div id="strCmtWriteGroupDiv" class="radiocheckArea pt5 both">
								<ul>
<%
	FOR tmpFor = 0 TO UBOUND(strGroupCode)

		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strCmtWriteGroup"" id=""strCmtWriteGroup" & tmpFor & """ value=""" & strGroupCode(tmpFor) & """"
		IF strCmtWriteGroup <> "" AND ISNULL(strCmtWriteGroup) = False THEN
			IF INSTR(strCmtWriteGroup, strGroupCode(tmpFor)) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strCmtWriteGroup" & tmpFor & ">" & strGroupTitle(tmpFor) & "</label></li>" & CHR(13)

	NEXT
%>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_upload_level")%></th>
						<td>
							<p>
								<select name="strUploadLevel" id="strUploadLevel" onChange="dispAccGroup(this, 'strUploadGroupDiv');">
								<%=GetMakeSelectForm(objXmlLang("option_access"), ",", strUploadLevel, "")%>
								</select>
							</p>
							<div id="strUploadGroupDiv" class="radiocheckArea pt5 both">
								<ul>
<%
	FOR tmpFor = 0 TO UBOUND(strGroupCode)

		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strUploadGroup"" id=""strUploadGroup" & tmpFor & """ value=""" & strGroupCode(tmpFor) & """"
		IF strUploadGroup <> "" AND ISNULL(strUploadGroup) = False THEN
			IF INSTR(strUploadGroup, strGroupCode(tmpFor)) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strUploadGroup" & tmpFor & ">" & strGroupTitle(tmpFor) & "</label></li>" & CHR(13)

	NEXT
%>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_down_level")%></th>
						<td>
							<p>
								<select name="strDownLevel" id="strDownLevel" onChange="dispAccGroup(this, 'strDownGroupDiv');">
								<%=GetMakeSelectForm(objXmlLang("option_access"), ",", strDownLevel, "")%>
								</select>
							</p>
							<div id="strDownGroupDiv" class="radiocheckArea pt5 both">
								<ul>
<%
	FOR tmpFor = 0 TO UBOUND(strGroupCode)

		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strDownGroup"" id=""strDownGroup" & tmpFor & """ value=""" & strGroupCode(tmpFor) & """"
		IF strDownGroup <> "" AND ISNULL(strDownGroup) = False THEN
			IF INSTR(strDownGroup, strGroupCode(tmpFor)) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strDownGroup" & tmpFor & ">" & strGroupTitle(tmpFor) & "</label></li>" & CHR(13)

	NEXT
%>
								</ul>
							</div>
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