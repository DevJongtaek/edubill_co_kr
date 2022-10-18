
	$(document).ready(function() {

		$("#strLayoutAlign, #strLayoutWidth, #strBackImgRepeat").msDropDown();

		$("#strBackColor").ColorPicker({
			onSubmit: function(hsb, hex, rgb, el) {
				$(el).val(hex);
				$(el).ColorPickerHide();
			},
			onBeforeShow: function () {
				$(this).ColorPickerSetColor(this.value);
			}
		})
		.bind('keyup', function(){
			$(this).ColorPickerSetColor(this.value);
		});

		$("#fileTreeList1").fileTree({ root: '/', script: 'action/?subAct=jquerytree', folderEvent: 'click', expandSpeed: 750, collapseSpeed: 750, multiFolder: false }, function(file) { 
			$("#strHeaderFile").val(file);
		});

		$("#fileTreeList2").fileTree({ root: '/', script: 'action/?subAct=jquerytree', folderEvent: 'click', expandSpeed: 750, collapseSpeed: 750, multiFolder: false }, function(file) { 
			$("#strFooterFile").val(file);
		});

		$("#btn_file_find1").click(function(){
			$("#fileTreeList1").toggle();
		});

		$("#btn_file_find2").click(function(){
			$("#fileTreeList2").toggle();
		});

		$("#theForm").submit(function() {

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_title"]);$("#strTitle").focus();return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href; return false;
					}else{
						switch (responseText){
							case "SW" : alert(arApplMsg["success_saved"]); break;
							case "SE" : alert(arApplMsg["success_updated"]); break;
						}						
						$("#extForm").attr("action","?act=layout&intPage=" + $("#intPage").val());
						$("#extForm").submit();
					}
				}, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post'
			});
			
			return false;

    });

		$("#btn_cancel").click(function(){
			$("#extForm").attr("action","?act=layout&intPage=" + $("#intPage").val());
			$("#extForm").submit();
		});

		$("input[name=strBackType]:radio").click(function() {
			backStyleDisp($(this).val());
		});

		$("input[name=strBackType]:checked").each(function() {
			backStyleDisp($(this).val());
		});

		var swfu;

			var settings = {
				flash_url : "../js/swfupload/swfupload.swf",
				flash9_url : "../js/swfupload/swfupload_fp9.swf",
				upload_url: "action/?subAct=swfupload",
				post_params: {"userpath" : "site/layout"},
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
				button_text: "<span class='theFont'>upload</span>",
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

		$("#usePreviewFile").click(function() {
			if ($(this).is(':checked')){
				$('#layoutBackUploadedFile').hide();
			}else{
				$('#layoutBackUploadedFile').show();

			}
		});

		Layout.BackFile();

	});

	var Layout = function() {}

	Layout.BackFile = function() {

		$("#layoutBackUploadedFile li a[name=file_list]").bind({
			click : function(){
				$("#strBackImg").val($(this).text());
			},
			mouseover: function() {
				$(this).css("text-decoration","underline");
			},
			mouseout: function() {
				$(this).css("text-decoration","none");
			}			
		});

		$("#layoutBackUploadedFile li a[name=file_remove]").click(function(){

			var listObj = $(this);
			var listFile = $(this).parent().text();

			$.ajax({ 
				type: "post", url: "action/?subAct=layout&Act=fileremove", data : "filename=" + $(this).parent().text() + "&path=|site|layout", 
				success:function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}
					listObj.parent().remove();
					if ($("#strBackImg").val() == listFile){
						$("#strBackImg").val("");
					}
				}, error:function(response){alert('error\n\n' + response.responseText);}
			});

		});

	}

	function backStyleDisp(str){
		switch (str){
			case "0" : $("#backColorLayer").hide(); $("#backImgLayer").hide(); break;
			case "1" : $("#backColorLayer").show(); $("#backImgLayer").hide(); break;
			case "2" : $("#backColorLayer").hide(); $("#backImgLayer").show(); break;
		}
	}

	function check_colorpicker(el, hex){
		$(el).val(hex.toUpperCase());
		$(el).ColorPickerHide();
		$(el).parent().parent().find(".colorpicker_holder").css('backgroundColor', '#' + hex);
		var pos = el.id;
	}

	function uploadSuccessUser(file, serverData) {
		try {
			var progress = new FileProgress(file, this.customSettings.progressTarget);
			progress.setComplete();
			progress.setStatus("Complete.");
			progress.toggleCancel(false);

			var file_info = serverData.split(",");

			if (file_info[0] != ""){
				$("#layoutBackUploadedFile").append("<li><a name=\"file_list\" class=\"hand\">" + file_info[0] + "</a><a name=\"file_remove\" class=\"hand ml5\"><img src=\"images/btn_x.gif\"></a></li>");
				Layout.BackFile();
			}
	
		} catch (ex) {
			this.debug(ex);
		}
	}