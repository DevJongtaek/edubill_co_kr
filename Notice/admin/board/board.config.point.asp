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

	DIM bitUsePoint, intReadPoint, intWritePoint, intCmtWritePoint, intUploadPoint, intDownPoint, intVotePoint
	DIM intBlamedPoint, strReadPoint, strWritePoint, strCmtWritePoint, strUploadPoint, strDownPoint, strVotePoint
	DIM strBlamedPoint

	bitUsePoint      = GetBitTypeNumberChg(RS("bitUsePoint"))
	intReadPoint     = RS("intReadPoint")
	intWritePoint    = RS("intWritePoint")
	intCmtWritePoint = RS("intCmtWritePoint")
	intUploadPoint   = RS("intUploadPoint")
	intDownPoint     = RS("intDownPoint")
	intVotePoint     = RS("intVotePoint")
	strReadPoint     = GetReplaceTag2Text(RS("strReadPoint"))
	strWritePoint    = GetReplaceTag2Text(RS("strWritePoint"))
	strCmtWritePoint = GetReplaceTag2Text(RS("strCmtWritePoint"))
	strUploadPoint   = GetReplaceTag2Text(RS("strUploadPoint"))
	strDownPoint     = GetReplaceTag2Text(RS("strDownPoint"))
	strVotePoint     = GetReplaceTag2Text(RS("strVotePoint"))
	intBlamedPoint   = RS("intBlamedPoint")
	strBlamedPoint   = GetReplaceTag2Text(RS("strBlamedPoint"))
%>
<script type="text/javascript" src="board/js/board.config.point.js"></script>
		<div id="content">
			<form id="theForm">
			<input type="hidden" name="intSrl" id="intSrl" value="<%=intSrl%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_config_point")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_config_point")%>
			</p>
			<div id="subBody">
<!-- #include file = "board.config.comm.asp" -->
				<h4><%=objXmlLang("page_sub_title_10")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_use_point")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUsePoint, "bitUsePoint", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_use_point")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_read_point")%></th>
						<td>
							<p class="inp"><%=objXmlLang("text_point1")%> : <input name="strReadPoint" type="text" id="strReadPoint" size="40" value="<%=strReadPoint%>"></p>
							<p class="inp"><%=objXmlLang("text_point2")%> : <input name="intReadPoint" type="text" id="intReadPoint" size="15" maxlength="10" class="integer ime_mode" value="<%=intReadPoint%>"></p>
							<p class="tip"><%=objXmlLang("about_read_point")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_write_point")%></th>
						<td>
							<p class="inp"><%=objXmlLang("text_point1")%> : <input name="strWritePoint" type="text" id="strWritePoint" size="40" value="<%=strWritePoint%>"></p>
							<p class="inp"><%=objXmlLang("text_point2")%> : <input name="intWritePoint" type="text" id="intWritePoint" size="15" maxlength="10" class="integer ime_mode" value="<%=intWritePoint%>"></p>
							<p class="tip"><%=objXmlLang("about_write_point")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_comment_point")%></th>
						<td>
							<p class="inp"><%=objXmlLang("text_point1")%> : <input name="strCmtWritePoint" type="text" id="strCmtWritePoint" size="40" value="<%=strCmtWritePoint%>"></p>
							<p class="inp"><%=objXmlLang("text_point2")%> : <input name="intCmtWritePoint" type="text" id="intCmtWritePoint" size="15" maxlength="10" class="integer ime_mode" value="<%=intCmtWritePoint%>"></p>
							<p class="tip"><%=objXmlLang("about_comment_point")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_upload_point")%></th>
						<td>
							<p class="inp"><%=objXmlLang("text_point1")%> : <input name="strUploadPoint" type="text" id="strUploadPoint" size="40" value="<%=strUploadPoint%>"></p>
							<p class="inp"><%=objXmlLang("text_point2")%> : <input name="intUploadPoint" type="text" id="intUploadPoint" size="15" maxlength="10" class="integer ime_mode" value="<%=intUploadPoint%>"></p>
							<p class="tip"><%=objXmlLang("about_upload_point")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_down_point")%></th>
						<td>
							<p class="inp"><%=objXmlLang("text_point1")%> : <input name="strDownPoint" type="text" id="strDownPoint" size="40" value="<%=strDownPoint%>"></p>
							<p class="inp"><%=objXmlLang("text_point2")%> : <input name="intDownPoint" type="text" id="intDownPoint" size="15" maxlength="10" class="integer ime_mode" value="<%=intDownPoint%>"></p>
							<p class="tip"><%=objXmlLang("about_down_point")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_vote_point")%></th>
						<td>
							<p class="inp"><%=objXmlLang("text_point1")%> : <input name="strVotePoint" type="text" id="strVotePoint" size="40" value="<%=strVotePoint%>"></p>
							<p class="inp"><%=objXmlLang("text_point2")%> : <input name="intVotePoint" type="text" id="intVotePoint" size="15" maxlength="10" class="integer ime_mode" value="<%=intVotePoint%>"></p>
							<p class="tip"><%=objXmlLang("about_vote_point")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_blamed_point")%></th>
						<td>
							<p class="inp"><%=objXmlLang("text_point1")%> : <input name="strBlamedPoint" type="text" id="strBlamedPoint" size="40" value="<%=strBlamedPoint%>"></p>
							<p class="inp"><%=objXmlLang("text_point2")%> : <input name="intBlamedPoint" type="text" id="intBlamedPoint" size="15" maxlength="10" class="integer ime_mode" value="<%=intBlamedPoint%>"></p>
							<p class="tip"><%=objXmlLang("about_blamed_point")%></p>
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