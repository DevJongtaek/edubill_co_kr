
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_cancel").click(function(){
			document.location.href = "?act=membergroup";
			return false;
		});

		if ($("#strMarkFile").val() != "")
			$("#btn_delete").show();
		else
			$("#btn_delete").hide();

		$("#btn_delete").click(function(){
			$.ajax({ 
				type: "post", url: "action/?subAct=membergroup&Act=fileremove", data : "strGroupCode=" + $("#strGroupCode").val(), 
				success:function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}
					$("#strMarkFile").val("");
					$("#btn_delete").hide();
				}, error:function(response){alert('error\n\n' + response.responseText);}
			});
		});

		$("#theForm").submit(function() {

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["isnull_group_name"]);$("#strTitle").focus();return false;
			}

			$(this).ajaxSubmit({
				success:function(responseText){

					var msg = "";
			
					switch (responseText){
						case "SW" : msg = arApplMsg["success_saved"]; break;
						case "SE" : msg = arApplMsg["success_updated"]; break;
						case "ERROR" : document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}

					alert(msg);
					document.location.href = "?act=membergroup";
					return false;

				}, 
				error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});

			return false;

    });

		var swfu;

			var settings = {
				flash_url : "../js/swfupload/swfupload.swf",
				flash9_url : "../js/swfupload/swfupload_fp9.swf",
				upload_url: "action/?subAct=swfupload",
				post_params: {"userpath" : "member/group/" + $("#strGroupCode").val(), "fileremove" : "1"},
				file_size_limit : "100 MB",
				file_types : "*.jpg;*.gif;*.bmp;*.jpeg;*.png",
				file_types_description : "Image Files",
				file_upload_limit : 0,
				file_queue_limit : 1,
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
				button_text: "<span class='theFont'>Upload</span>",
				button_text_style: ".theFont {text-align:center; color:#333333;}",
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

	function uploadSuccessUser(file, serverData) {
		try {
			var progress = new FileProgress(file, this.customSettings.progressTarget);
			progress.setComplete();
			progress.setStatus("Complete.");
			progress.toggleCancel(false);

			var file_info = serverData.split(",");

			$("#strMarkFile").val(file_info[0]);
			$("#btn_delete").show();

		} catch (ex) {
			this.debug(ex);
		}
	}