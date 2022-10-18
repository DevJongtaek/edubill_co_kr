<!-- #include file = "Member.Default.asp" -->
<link type="text/css" href="js/swfupload/default.css" rel="stylesheet" />
<script type="text/javascript" src="js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="js/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="js/swfupload/handlers_1.js"></script>
<%
	IF SESSION("memberSeq") = "" THEN
		RESPONSE.WRITE ActFormSubmit(objXmlLang("msg_session_error"), "?act=login", "post", "strPrevUrl", "/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & "?act=member&subAct=modify")
		RESPONSE.End()
	END IF

	DIM memberSeq, memberFilePath

	memberSeq      = SESSION("memberSeq")
	memberFilePath = GetNowFolderPath("") & "\" & CONF_strFilePath & "\member\"

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & memberSeq & "', '" & GetInputReplce(REQUEST.FORM("memberPwd"), "") & "' ")
	
	IF RS.EOF THEN
		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_passwords_not_match"), "", "")
		RESPONSE.End()
	END IF

	DIM isNameModify, isEmailCheck

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_READ] 'strSSN' ")

	IF RS("bitUse") = True AND RS("bitRquired") = True THEN isNameModify = False ELSE isNameModify = True

	IF CONF_bitUseCertified = True AND CONF_bitUseEmailCheck = True THEN isEmailCheck = True ELSE isEmailCheck = False

	DIM strEditorLangFile
	strEditorLangFile = Server.MapPath(".") & "\daum\lang\lang." & GetEditorUtfCode(CONF_strSkinLang) & ".xml"
%>
<!-- #include file = "../include/Member.Read.asp" -->
<!-- #include file = "../include/Member.Form.asp" -->
<script type="text/javascript">

	var member_file = {
		use_photo : "<%=GetBitTypeNumberChg(CONF_bitUsePhoto)%>",
		use_nameimg : "<%=GetBitTypeNumberChg(CONF_bitUseNameImg)%>",
		use_markimg : "<%=GetBitTypeNumberChg(CONF_bitUseMarkImg)%>"
	}

	jQuery(function($){

		$.memberModifyComplate = function(){

			var strEditAct_ = "<%=CONF_strEditAct%>";
			var strEditActMsg_ = "<%=CONF_strEditActMsg%>";
			var strEditActUrl_ = "<%=CONF_strEditActUrl%>";

			function memberModifyComplateScript(){
				<%=CONF_strEditActScript%>
			}

			switch (strEditAct_){
				case "0" :
					if (strEditActMsg_!= "")
						alert(strEditActMsg_);
					document.location.href = strEditActUrl_;
					return false;
					break;
				case "1" : memberModifyComplateScript(); break;
				case "2" :
					$("#resultForm").attr("action", "?act=member&subAct=modifyresult");
					$("#resultForm").submit();
					break;
			}

		}
	});

</script>
<%
	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="extForm">
<input type="hidden" id="isNameModify" value="<%=GetBitTypeNumberChg(isNameModify)%>" />
<input type="hidden" id="isEmailCheck" value="<%=GetBitTypeNumberChg(isEmailCheck)%>" />
</form>
<form id="resultForm" method="post">
<input type="hidden" id="strPassword" name="strPassword" value="<%=REQUEST.FORM("memberPwd")%>" />
</form>
<script type="text/javascript">

	var set_editor = {
		config: {
			path : '/<%=REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")%>',
			pdspath : '<%=CONF_strFilePath%>',
			imagepath : 'member/sign/',
			filepath : 'member/sign/',
			boardsrl : '',
			editorMode : 'member',
			usefile : false,
			useimage : true
		}
	};

	jQuery(function($){

		if (member_file.use_photo == "1"){

			var upload1 = new SWFUpload({
				flash_url : "js/swfupload/swfupload.swf",
				flash9_url : "js/swfupload/swfupload_fp9.swf",
				upload_url: "action/?Act=swfupload_member",
				post_params: {"userpath" : "member/profile", "memberSrl" : $("#intSeq").val(), "file_type" : "profile"},
				file_size_limit : "100 MB",
				file_types : "*.jpg;*.gif;*.bmp;*.jpeg;*.png",
				file_types_description : "Image Files",
				file_upload_limit : 2,
				file_queue_limit : 1,
				custom_settings : {
					progressTarget : "fsUploadProgress1",
					cancelButtonId : "btnCancel"
				},
				debug: false,
	
				// Button settings
				button_image_url: "images/btn/btn_upload.gif",
				button_width: "60",
				button_height: "20",
				button_placeholder_id: "spanButtonPlaceHolder1",
				button_text: "<span class='theFont'>" + arApplMsg['cmd_upload'] + "</span>",
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
			});

	}

	if (member_file.use_nameimg == "1"){

		var upload2 = new SWFUpload({
			flash_url : "js/swfupload/swfupload.swf",
			flash9_url : "js/swfupload/swfupload_fp9.swf",
			upload_url: "action/?Act=swfupload_member",
			post_params: {"userpath" : "member/name", "memberSrl" : $("#intSeq").val(), "file_type" : "name"},
			file_size_limit : "100 MB",
			file_types : "*.jpg;*.gif;*.bmp;*.jpeg;*.png",
			file_types_description : "Image Files",
			file_upload_limit : 2,
			file_queue_limit : 1,
			custom_settings : {
				progressTarget : "fsUploadProgress2",
				cancelButtonId : "btnCancel"
			},
			debug: false,

			// Button settings
			button_image_url: "images/btn/btn_upload.gif",
			button_width: "60",
			button_height: "20",
			button_placeholder_id: "spanButtonPlaceHolder2",
			button_text: "<span class='theFont'>" + arApplMsg['cmd_upload'] + "</span>",
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
		});

	}

	if (member_file.use_markimg == "1"){

		var upload3 = new SWFUpload({
			flash_url : "js/swfupload/swfupload.swf",
			flash9_url : "js/swfupload/swfupload_fp9.swf",
			upload_url: "action/?Act=swfupload_member",
			post_params: {"userpath" : "member/mark", "memberSrl" : $("#intSeq").val(), "file_type" : "mark"},
			file_size_limit : "100 MB",
			file_types : "*.jpg;*.gif;*.bmp;*.jpeg;*.png",
			file_types_description : "Image Files",
			file_upload_limit : 2,
			file_queue_limit : 1,
			custom_settings : {
				progressTarget : "fsUploadProgress3",
				cancelButtonId : "btnCancel"
			},
			debug: false,

			// Button settings
			button_image_url: "images/btn/btn_upload.gif",
			button_width: "60",
			button_height: "20",
			button_placeholder_id: "spanButtonPlaceHolder3",
			button_text: "<span class='theFont'>" + arApplMsg['cmd_upload'] + "</span>",
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
		});

	}

		function uploadSuccessUser(file, serverData){
			try {
				var progress = new FileProgress(file, this.customSettings.progressTarget);
				progress.setComplete();
				progress.setStatus("Complete.");
				progress.toggleCancel(false);
		
				if (serverData == "ERROR"){
					alert(arApplMsg['error_file_upload']);
				}else{
					$.memberImageUploadComplate(serverData);
				}
			} catch (ex) {
				this.debug(ex);
			}
		}

	});

</script>
<link rel="stylesheet" href="daum/css/editor_<%=GetEditorUtfCode(CONF_strSkinLang)%>.css" type="text/css" charset="utf-8"/>
<script src="/bbs/daum/js/editor_<%=GetEditorUtfCode(CONF_strSkinLang)%>.js" type="text/javascript" charset="utf-8"></script>
<script src="daum/js/editor_config.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="js/Calendar.js"></script>
<script type="text/javascript" src="js/jquery.zip.js"></script>