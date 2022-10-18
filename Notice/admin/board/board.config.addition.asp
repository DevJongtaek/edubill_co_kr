<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<script type="text/javascript" src="../js/jquery.colorPicker.js"></script>
<link type="text/css" href="../style/jquery.colorpicker.css" rel="stylesheet" />
<%
	DIM intSrl
	intSrl = GetInputReplce(REQUEST.QueryString("intSrl"), "")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '" & intSrl & "' ")

	DIM bitDispNotice, strOrderField, strOrderDescAsc, intListCount, strCutText, intPageCount, strDispListField, bitReVisit
	DIM bitDispPrevNextList, bitDispReadList, bitUseComment, bitUseCommentReply, intCommentListCount, intCommentEditorHeight
	DIM strCommentEditorBgColor, strCommentEditorEtc, bitUseWriteCaptcha, strWriteNotName, bitUseWriteEmail, strWriteEmailList
	DIM strDocumentCode, strWriteMoveOpt, strModifyMoveOpt, intWriteEditorHeight, strWriteEditorBgColor, strWriteEditorEtc
	DIM bitUseUpload, intUploadFileSize, intUploadFileTotalSize, strUploadFileExt, bitUseThrum, strThrumOption, bitUseWaterMark
	DIM strWaterMarkOption

	bitDispNotice           = GetBitTypeNumberChg(RS("bitDispNotice"))
	strOrderField           = RS("strOrderField")
	strOrderDescAsc         = RS("strOrderDescAsc")
	intListCount            = RS("intListCount")
	strCutText              = SPLIT(RS("strCutText"), ",")
	intPageCount            = RS("intPageCount")
	strDispListField        = RS("strDispListField")
	bitDispPrevNextList     = GetBitTypeNumberChg(RS("bitDispPrevNextList"))
	bitDispReadList         = GetBitTypeNumberChg(RS("bitDispReadList"))
	bitUseComment           = GetBitTypeNumberChg(RS("bitUseComment"))
	bitUseCommentReply      = GetBitTypeNumberChg(RS("bitUseCommentReply"))
	intCommentListCount     = RS("intCommentListCount")
	intCommentEditorHeight  = RS("intCommentEditorHeight")
	strCommentEditorBgColor = REPLACE(RS("strCommentEditorBgColor"), "#", "")
	strCommentEditorEtc     = SPLIT(RS("strCommentEditorEtc"), ",")
	bitUseWriteCaptcha      = GetBitTypeNumberChg(RS("bitUseWriteCaptcha"))
	strWriteNotName         = RS("strWriteNotName")
	bitUseWriteEmail        = GetBitTypeNumberChg(RS("bitUseWriteEmail"))
	strWriteEmailList       = RS("strWriteEmailList")
	strDocumentCode         = RS("strDocumentCode")
	strWriteMoveOpt         = SPLIT(RS("strWriteMoveOpt"), "$$$")
	strModifyMoveOpt        = SPLIT(RS("strModifyMoveOpt"), "$$$")
	intWriteEditorHeight    = RS("intWriteEditorHeight")
	strWriteEditorBgColor   = REPLACE(RS("strWriteEditorBgColor"), "#", "")
	strWriteEditorEtc       = SPLIT(RS("strWriteEditorEtc"), ",")
	bitUseUpload            = GetBitTypeNumberChg(RS("bitUseUpload"))
	intUploadFileSize       = RS("intUploadFileSize")
	intUploadFileTotalSize  = RS("intUploadFileTotalSize")
	strUploadFileExt        = RS("strUploadFileExt")
	bitUseThrum             = GetBitTypeNumberChg(RS("bitUseThrum"))
	strThrumOption          = SPLIT(RS("strThrumOption"), ",")
	bitUseWaterMark         = GetBitTypeNumberChg(RS("bitUseWaterMark"))
	strWaterMarkOption      = SPLIT(RS("strWaterMarkOption"), "$^^$")
%>
<link type="text/css" href="../js/swfupload/default.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery.colorPicker.js"></script>
<script type="text/javascript" src="../js/jqueryFileTree.js"></script>
<script type="text/javascript" src="../js/jquery.textarearesizer.js"></script>
<script type="text/javascript" src="../js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="../js/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="../js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="../js/swfupload/handlers_1.js"></script>
<script type="text/javascript">

	$(document).ready(function() {

		var swfu;
		var settings = {
			flash_url : "../js/swfupload/swfupload.swf",
			flash9_url : "../js/swfupload/swfupload_fp9.swf",
			upload_url: "action/?subAct=swfupload",
			post_params: {"userpath" : "board/<%=intSrl%>/config"},
			file_size_limit : "100 MB",
			file_types : "*.jpg;*.gif;*.bmp;*.jpeg;*.png",
			file_types_description : "Image Files",
			file_upload_limit : 100,
			file_queue_limit : 0,
			custom_settings : {
				progressTarget : "fsUploadProgress",
				cancelButtonId : "btnCancel"
			},
			debug: false,

			// Button settings
			button_image_url: "images/btn_upload.gif",
			button_width: "60",
			button_height: "20",
			button_placeholder_id: "spanButtonPlaceHolder",
			button_text: "<span class='theFont'><%=objXmlLang("btn_upload")%></span>",
			button_text_style: ".theFont {text-align:center; color:#666666;}",
			button_cursor: SWFUpload.CURSOR.HAND,
			
			// The event handler functions are defined in handlers.js
			swfupload_preload_handler : preLoad,
			swfupload_load_failed_handler : loadFailed,
			file_queued_handler : fileQueued,
			file_queue_error_handler : fileQueueError,
			file_dialog_complete_handler : fileDialogComplete,
			upload_start_handler : uploadStart,
			upload_progress_handler : uploadProgress,
			upload_error_handler : uploadError,
			upload_success_handler : uploadSuccessUser,
			upload_complete_handler : uploadComplete,
			queue_complete_handler : queueComplete	// Queue plugin event
		};

		swfu = new SWFUpload(settings);

	});

</script>
<script type="text/javascript" src="board/js/board.config.addition.js"></script>
		<div id="content">
			<form id="theForm">
			<input type="hidden" name="intSrl" id="intSrl" value="<%=intSrl%>">
			<input type="hidden" name="strDispListFieldSet" id="strDispListFieldSet">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_config_addition")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_config_addition")%>
			</p>
			<div id="subBody">
<!-- #include file = "board.config.comm.asp" -->
				<h4><%=objXmlLang("page_sub_title_2")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_disp_notice")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_display"), ",", bitDispNotice, "bitDispNotice", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_disp_notice")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_order_field")%></th>
						<td>
							<span class="fl mr5">
							<select name="strOrderField" id="strOrderField">
							<%=GetMakeSelectForm(objXmlLang("option_order_field"), ",", strOrderField, "")%>
							</select>
							</span>
							<span class="fl">
							<select name="strOrderDescAsc" id="strOrderDescAsc">
							<%=GetMakeSelectForm(objXmlLang("option_order"), ",", strOrderDescAsc, "")%>
							</select>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_list_count")%></th>
						<td>
							<input name="intListCount" type="text" id="intListCount" size="10" maxlength="4" class="integer ime_mode" value="<%=intListCount%>">
							<p class="tip"><%=objXmlLang("about_list_count")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_string_cut")%></th>
						<td>
						<span class="fl mr10">
						<%=objXmlLang("text_title")%> : <input name="strCutText" type="text" id="strCutText" size="10" maxlength="4" class="integer ime_mode" value="<%=strCutText(0)%>">
						</span>
						<span class="fl mr10">
						<%=objXmlLang("text_content")%> : <input name="strCutText" type="text" id="strCutText" size="10" maxlength="4" class="integer ime_mode" value="<%=strCutText(1)%>">
						</span>
						<span class="fl">
						<%=objXmlLang("text_writer")%> : <input name="strCutText" type="text" id="strCutText" size="10" maxlength="4" class="integer ime_mode" value="<%=strCutText(2)%>">
						</span>
						<p class="tip"><%=objXmlLang("about_string_cut")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_page_count")%></th>
						<td>
							<input name="intPageCount" type="text" id="intPageCount" size="10" maxlength="4" class="integer ime_mode" value="<%=intPageCount%>">
							<p class="tip"><%=objXmlLang("about_page_count")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_list_field")%></th>
						<td>
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="nostyle">
									<select name="strDispListFieldTotal" size="10" id="strDispListFieldTotal" style="width:200px; height:145px;">
									<%=GetMakeSelectForm(objXmlLang("option_list_field"), ",", "", "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_LIST] '" & intSrl & "' ")

	WHILE NOT(RS.EOF)

		RESPONSE.WRITE GetMakeSelectForm(RS("strFieldRecord") & "$$$" & RS("strFieldName"), ",", "", "")

	RS.MOVENEXT
	WEND
%>
									</select>
									</td>
									<td style="border-bottom:none;">
									<ul>
										<li style="margin-bottom:3px;"><img id="menuAdd" src="images/blank.gif" width="20" height="20" class="btnMenuRight hand" /></li>
										<li style="margin-bottom:3px;"><img id="menuRemove" src="images/blank.gif" width="20" height="20" class="btnMenuLeft hand" /></li>
										<li style="margin-bottom:3px;"><img id="menuMoveUp" src="images/blank.gif" width="20" height="20" class="btnMenuUp_01 hand" /></li>
										<li style="margin-bottom:3px;"><img id="menuMoveDown" src="images/blank.gif" width="20" height="20" class="btnMenuDown_01 hand" /></li>
									</ul>
									</td>
									<td style="border-bottom:none;">
<%
	DIM strDispListFieldText, strDispListFieldValue, dispField

	strDispListFieldText  = ""
	strDispListFieldValue = strDispListField

	FOR EACH dispField IN SPLIT(strDispListField, ",")
		IF GetOptionArrText(objXmlLang("option_list_field"), dispField) <> "" THEN
			IF strDispListFieldText <> "" THEN strDispListFieldText = strDispListFieldText & ","
			strDispListFieldText = strDispListFieldText & GetOptionArrText(objXmlLang("option_list_field"), dispField)
		END IF
	NEXT

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_LIST] '" & intSrl & "' ")

	WHILE NOT(RS.EOF)

		IF INSTR(strDispListFieldValue, RS("strFieldRecord")) > 0 THEN strDispListFieldText  = strDispListFieldText  & "," & RS("strFieldName")

	RS.MOVENEXT
	WEND

	strDispListFieldText  = SPLIT(strDispListFieldText, ",")
	strDispListFieldValue = SPLIT(strDispListFieldValue, ",")
%>
									<select name="strDispListField" size="10" id="strDispListField" style="width:200px; height:145px;">
<%
	FOR tmpFor = 0 TO UBOUND(strDispListFieldValue)
		IF strDispListFieldValue(tmpFor) <> "" THEN
			IF INSTR(strDispListField, strDispListFieldValue(tmpFor)) > 0 THEN
				RESPONSE.WRITE "<option value='" & strDispListFieldValue(tmpFor) & "'>" & strDispListFieldText(tmpFor) & "</option>" & CHR(10)
			END IF
		END IF
	NEXT
%>
									</select>
									</td>
								</tr>
							</table>
							<p class="tip"><%=objXmlLang("about_list_field")%></p>
						</td>
					</tr>
				</table>
				<div class="pt10"></div>
				<h4><%=objXmlLang("page_sub_title_3")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_prev_next_list")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_display"), ",", bitDispPrevNextList, "bitDispPrevNextList", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_prev_next_list")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_read_board_list")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_display"), ",", bitDispReadList, "bitDispReadList", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_read_board_list")%></p>
						</td>
					</tr>
				</table>
				<div class="pt10"></div>
				<h4><%=objXmlLang("page_sub_title_4")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_use_comment")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseComment, "bitUseComment", "<dd>", "</dd>")%>
							</dl>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use_comment_reply")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseCommentReply, "bitUseCommentReply", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_use_comment_reply")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_list_comment_count")%></th>
						<td>
							<input name="intCommentListCount" type="text" id="intCommentListCount" size="10" maxlength="4" class="integer ime_mode" value="<%=intCommentListCount%>">
							<p class="tip"><%=objXmlLang("about_list_comment_count")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_comment_editor_style")%></th>
						<td>
							<span class="fl mr10">
							<%=objXmlLang("text_height")%> : 
							<input name="intCommentEditorHeight" type="text" id="intCommentEditorHeight" size="10" maxlength="4" class="integer ime_mode" value="<%=intCommentEditorHeight%>">
							px
							</span>
							<span class="fl">
							<%=objXmlLang("text_bgcolor")%> : 
							<input name="strCommentEditorBgColor" type="text" id="strCommentEditorBgColor" value="<%=strCommentEditorBgColor%>" size="10" readonly class="hand">
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_comment_editor_etc")%></th>
						<td>
							<span class="fl mr10">
							<%=GetMakeCheckForm(objXmlLang("option_editor_etc1"), ",", strCommentEditorEtc(0), "strCommentEditorEtc1", "", "")%>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_comment_editor_img")%></th>
						<td>
						<span class="fl mr10">
						<%=objXmlLang("text_image_width")%> : 
						<input name="strCommentEditorEtc2" type="text" id="strCommentEditorEtc2" size="10" maxlength="4" class="integer ime_mode" value="<%=strCommentEditorEtc(1)%>">
						px
						</span>
						<span class="fl mr10">
						<%=objXmlLang("text_image_height")%> : 
						<input name="strCommentEditorEtc3" type="text" id="strCommentEditorEtc3" size="10" maxlength="4" class="integer ime_mode" value="<%=strCommentEditorEtc(2)%>">
						px
						</span>
						</td>
					</tr>
				</table>
				<div class="pt10"></div>
				<h4><%=objXmlLang("page_sub_title_5")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_write_use_captcha")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseWriteCaptcha, "bitUseWriteCaptcha", "<dd>", "</dd>")%>
							</dl>			
							<p class="tip"><%=objXmlLang("about_write_use_captcha")%></p>			
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_write_nouse_name")%></th>
						<td>
							<textarea name="strWriteNotName" id="strWriteNotName" cols="45" rows="5"><%=strWriteNotName%></textarea>
							<p class="tip"><%=objXmlLang("about_write_nouse_name")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_write_send_email")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseWriteEmail, "bitUseWriteEmail", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_write_send_email")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_write_email_addr")%></th>
						<td>
							<textarea name="strWriteEmailList" id="strWriteEmailList" cols="45" rows="5"><%=strWriteEmailList%></textarea>
							<p class="tip"><%=objXmlLang("about_write_email_addr")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_document")%></th>
						<td>
							<select id="strDocumentCode" name="strDocumentCode">
							<%=GetMakeSelectForm(objXmlLang("option_nouse"), ",", strDocumentCode, "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_DOCUMENT_LIST] 'S' ")
	WHILE NOT(RS.EOF)
%>
							<option value="<%=RS("strDocCode")%>"<% IF RS("strDocCode") = strDocumentCode THEN %> selected<% END IF %>><%=RS("strTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
							</select>
							<p class="tip"><%=objXmlLang("about_document")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_write_move")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_write_move"), ",", strWriteMoveOpt(0), "strWriteMoveOpt", "<dd>", "</dd>")%>
							</dl>
							<div class="mt5" id="write_move_url"><input type="text" id="strWriteMoveOptUrl" name="strWriteMoveOptUrl" value="<%=strWriteMoveOpt(1)%>" size="80" maxlength="200"></div>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_modify_move")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_write_move"), ",", strModifyMoveOpt(0), "strModifyMoveOpt", "<dd>", "</dd>")%>
							</dl>
							<div class="mt5" id="write_move_url"><input type="text" id="strModifyMoveOptUrl" name="strModifyMoveOptUrl" value="<%=strModifyMoveOpt(1)%>" size="80" maxlength="200"></div>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_write_editor_style")%></th>
						<td>
							<span class="fl mr10">
							<%=objXmlLang("text_height")%> : 
							<input name="intWriteEditorHeight" type="text" id="intWriteEditorHeight" size="10" maxlength="4" class="integer ime_mode" value="<%=intWriteEditorHeight%>">
							px
							</span>
							<span class="fl">
							<%=objXmlLang("text_bgcolor")%> : 
							<input name="strWriteEditorBgColor" type="text" id="strWriteEditorBgColor" value="<%=strWriteEditorBgColor%>" size="10" readonly class="hand">
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_write_editor_etc")%></th>
						<td>
							<span class="fl mr10">
							<%=GetMakeCheckForm(objXmlLang("option_editor_etc1"), ",", strWriteEditorEtc(0), "strWriteEditorEtc1", "", "")%>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_write_editor_img")%></th>
						<td>
						<span class="fl mr10">
						<%=objXmlLang("text_image_width")%> : 
						<input name="strWriteEditorEtc2" type="text" id="strWriteEditorEtc2" size="10" maxlength="4" class="integer ime_mode" value="<%=strWriteEditorEtc(1)%>">
						px
						</span>
						<span class="fl mr10">
						<%=objXmlLang("text_image_height")%> : 
						<input name="strWriteEditorEtc3" type="text" id="strWriteEditorEtc3" size="10" maxlength="4" class="integer ime_mode" value="<%=strWriteEditorEtc(2)%>">
						px
						</span>
						</td>
					</tr>
				</table>
				<div class="pt10"></div>
				<h4><%=objXmlLang("page_sub_title_6")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_use_upload")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseUpload, "bitUseUpload", "<dd>", "</dd>")%>
							</dl>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_file_size")%></th>
						<td>
							<input name="intUploadFileSize" type="text" id="intUploadFileSize" size="10" maxlength="4" class="integer ime_mode" value="<%=intUploadFileSize%>"> MB
							<p class="tip"><%=objXmlLang("about_file_size")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_file_total_size")%></th>
						<td>
							<input name="intUploadFileTotalSize" type="text" id="intUploadFileTotalSize" size="10" maxlength="4" class="integer ime_mode" value="<%=intUploadFileTotalSize%>"> MB
							<p class="tip"><%=objXmlLang("about_file_total_size")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_file_ext")%></th>
						<td>
							<input name="strUploadFileExt" type="text" id="strUploadFileExt" value="<%=strUploadFileExt%>" size="60">
							<p class="tip"><%=objXmlLang("about_file_ext")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use_thrum")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseThrum, "bitUseThrum", "<dd>", "</dd>")%>
							</dl>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_thrum_componet")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_thrum_componet"), ",", strThrumOption(0), "strThrumOption1", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_thrum_componet")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_thrum_option")%></th>
						<td>
							<span class="fl mr10">
							<%=objXmlLang("text_image_width")%> : 
							<input name="strThrumOption2" type="text" id="strThrumOption2" size="10" maxlength="4" class="integer ime_mode" value="<%=strThrumOption(1)%>">
							px
							</span>
							<span class="fl mr10">
							<%=objXmlLang("text_image_height")%> : 
							<input name="strThrumOption3" type="text" id="strThrumOption3" size="10" maxlength="4" class="integer ime_mode" value="<%=strThrumOption(2)%>">
							px
							</span>
							<span>
							<%=GetMakeCheckForm(objXmlLang("option_thrum_scale"), ",", strThrumOption(3), "strThrumOption4", "", "")%>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_use_watermark")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseWaterMark, "bitUseWaterMark", "<dd>", "</dd>")%>
							</dl>
							<p class="tip"><%=objXmlLang("about_use_watermark")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_watermark_type")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_watermark"), ",", strWaterMarkOption(0), "strWaterMarkOption0", "<dd>", "</dd>")%>
							</dl>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_watermark_file")%></th>
						<td>
							<div id="backImgLayer">
								<ul>
									<li class="fl"><input name="strWaterMarkOption1" type="text" id="strWaterMarkOption1" value="<%=strWaterMarkOption(1)%>" size="40" readonly /></li>
									<li class="fl ml5"><span id="spanButtonPlaceHolder"></span></li>
								</ul>
								<div class="ml5 mt5 both fl" id="fsUploadProgress"></div>
								<div class="both fl">
									<input type="checkbox" name="usePreviewFile" id="usePreviewFile"><LABEL FOR="usePreviewFile" style="text-decoration:underline;"><%=objXmlLang("text_use_previmg")%></LABEL>
								</div>
								<ul id="uploadedFile" class="both" style="display:none;">
<%
	IF GetFolderFileList(GetNowFolderPath("..") & "\" & CONF_strFilePath & "\board\" & intSrl & "\config") <> "" THEN
		DIM tmpFileList
		tmpFileList = SPLIT(GetFolderFileList(GetNowFolderPath("..") & "\" & CONF_strFilePath & "\board\" & intSrl & "\config"), "|")
		FOR tmpFor = 0 TO UBOUND(tmpFileList)
			IF TRIM(tmpFileList(tmpFor)) <> "" THEN RESPONSE.WRITE "<li><a name=""file_list"" class=""hand"">" & tmpFileList(tmpFor) & "</a><a name=""file_remove"" class=""hand ml5""><img src=images/btn_x.gif></a></li>"
		NEXT
	END IF
%>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_watermark_text")%></th>
						<td><input name="strWaterMarkOption2" type="text" id="strWaterMarkOption2" value="<%=strWaterMarkOption(2)%>" size="60"></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_watermark_etc")%></th>
						<td>
						<span class="fl mr10">
						<%=objXmlLang("text_pos_x")%> : 
						<input name="strWaterMarkOption3" type="text" id="strWaterMarkOption3" size="10" maxlength="4" class="integer ime_mode" value="<%=strWaterMarkOption(3)%>">
						</span>
						<span class="fl mr10">
						<%=objXmlLang("text_pos_y")%> : 
						<input name="strWaterMarkOption4" type="text" id="strWaterMarkOption4" size="10" maxlength="4" class="integer ime_mode" value="<%=strWaterMarkOption(4)%>">
						</span>
						<span class="fl">
						<%=objXmlLang("text_font_size")%> : <input name="strWaterMarkOption5" type="text" id="strWaterMarkOption5" size="10" maxlength="4" class="integer ime_mode" value="<%=strWaterMarkOption(5)%>">
						pt
						</span>
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