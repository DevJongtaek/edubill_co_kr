
	$(document).ready(function() {

		$("#content select").msDropDown();
		$("textarea.resizable:not(.processed)").TextAreaResizer();

		$("#strEmail1, #strEmail2").change(function(){
			$("#change_email").val('1');
		});

		$("#strNickName").change(function(){
			$("#change_nick").val('1');
		});

		$("#btnList").click(function(){
			$("#extForm").attr("action","?act=memberlist");
			$("#extForm").attr("method","post");
			$("#extForm").submit();
		});

		$("#btnLoginNoDateReset").click(function(){
			$("#strLoginNoDate").val('');
		});

		$("#theForm").submit(function() {

			for ( var i = 0; i < arApplForm.length; i++ ){
				if (arApplForm[i].type != ""){
					switch (arApplForm[i].type){
						case "nick" :
							if ($("#" + arApplForm[i].field).val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field).focus();return false;
							}
							break;
						case "text" :
							if ($("#" + arApplForm[i].field).val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field).focus();return false;
							}
							break;
						case "email" :
							if ($("#" + arApplForm[i].field + "1").val().length == 0 ){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "1").focus();return false;
							}
							if ($("#" + arApplForm[i].field + "2").val().length == 0 ){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "2").focus();return false;
							}
							if (!Member.CheckEmail($("#" + arApplForm[i].field + "1").val() + "@" + $("#" + arApplForm[i].field + "2").val())){
								alert(arApplMsg["invalid_email"]);$("#" + arApplForm[i].field + "1").focus();return false;
							}
							break;

						case "radio" :
							if ($("input[name=" + arApplForm[i].field + "]:checked").length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field).focus();return false;
							}
							break;
						case "birthday" :
							if ($("#" + arApplForm[i].field + "1").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "1").focus();return false;
							}
							if ($("#" + arApplForm[i].field + "2").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "2").focus();return false;
							}
							break;
						case "select" :
							if ($("#" + arApplForm[i].field).val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field).focus();return false;
							}
							break;
						case "addr" :
							if ($("#" + arApplForm[i].field + "4").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "4").focus();return false;
							}
							if ($("#" + arApplForm[i].field + "5").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "5").focus();return false;
							}
							break;
						case "url" :
							if ($("#" + arApplForm[i].field).val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field).focus();return false;
							}
							break;
						case "tel" :
							if ($("#" + arApplForm[i].field + "1").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "1").focus();return false;
							}
							if ($("#" + arApplForm[i].field + "2").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "2").focus();return false;
							}
							if ($("#" + arApplForm[i].field + "3").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "3").focus();return false;
							}
							break;
						case "mobile" :
							if ($("#" + arApplForm[i].field + "1").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "1").focus();return false;
							}
							if ($("#" + arApplForm[i].field + "2").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "2").focus();return false;
							}
							if ($("#" + arApplForm[i].field + "3").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "3").focus();return false;
							}
							break;
						case "date" :
							if ($("#" + arApplForm[i].field).val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field).focus();return false;
							}
							break;
						case "marry" :
							if ($("#" + arApplForm[i].field + "1").val() == "1"){
								if ($("#" + arApplForm[i].field + "2").val().length == 0){
									alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "2").focus();return false;
								}
							}
							break;
						case "textarea" :
							if ($("#" + arApplForm[i].field).val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field).focus();return false;
							}
							break;
						case "sign" :
							var _validator = new Trex.Validator();
							var _content = Editor.getContent();
							if(!_validator.exists(_content)) {
								alert(arApplForm[i].msg);Editor.focus();
								return false;
							}
							$("#strUserSign").val(_content);
							break;
						case "checkbox" :
							if ($("input[name=" + arApplForm[i].field + "]:checked").length == 0){
								alert(arApplForm[i].msg);$("input[name=" + arApplForm[i].field + "]")[0].focus();return false;
							}
							break;
						case "corpnum" :
							if ($("#" + arApplForm[i].field + "1").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "1").focus();return false;
							}
							if ($("#" + arApplForm[i].field + "2").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "2").focus();return false;
							}
							if ($("#" + arApplForm[i].field + "3").val().length == 0){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "3").focus();return false;
							}
							
							if (!Member.CheckCorpNum($("#" + arApplForm[i].field + "1").val()+$("#" + arApplForm[i].field + "2").val()+$("#" + arApplForm[i].field + "3").val())){
								alert(arApplForm[i].msg);$("#" + arApplForm[i].field + "1").focus();return false;
							}
							break;
					}
				}
			}

			for ( var i = 0; i < arApplForm.length; i++ ){
				if (arApplForm[i].type != ""){
					Member.AddFieldCheck(arApplForm[i].field, arApplForm[i].field + "_", arApplForm[i].type);
				}
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;
						return false;
					}

					if (responseText == "ERROR02"){
						alert(arApplMsg["exists_email"], $("#strEmail1"));
						return false;
					}
					if (responseText == "ERROR03"){
						alert(arApplMsg["exists_nick_name"], $("#strNickName"));
						return false;
					}
					alert(arApplMsg["success_updated"]);

					$("#extForm").attr("action","?act=memberdisp&intSeq=" + $("#intSeq").val());
					$("#extForm").attr("method","post");
					$("#extForm").submit();
		
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?subAct=membermodify&Act=modify'});
			return false;

		});

		$("#tx_canvas_wysiwyg").css("height","150px");

		var upload1 = new SWFUpload({
			flash_url : "../js/swfupload/swfupload.swf",
			flash9_url : "../js/swfupload/swfupload_fp9.swf",
			upload_url: "action/?subAct=membermodifyupload",
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
			button_image_url: "images/btn_upload.gif",
			button_width: "60",
			button_height: "20",
			button_placeholder_id: "spanButtonPlaceHolder1",
			button_text: "<span class='theFont'>Upload</span>",
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

		var upload2 = new SWFUpload({
			flash_url : "../js/swfupload/swfupload.swf",
			flash9_url : "../js/swfupload/swfupload_fp9.swf",
			upload_url: "action/?subAct=membermodifyupload",
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
			button_image_url: "images/btn_upload.gif",
			button_width: "60",
			button_height: "20",
			button_placeholder_id: "spanButtonPlaceHolder2",
			button_text: "<span class='theFont'>Upload</span>",
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
		
		var upload3 = new SWFUpload({
			flash_url : "../js/swfupload/swfupload.swf",
			flash9_url : "../js/swfupload/swfupload_fp9.swf",
			upload_url: "action/?subAct=membermodifyupload",
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
			button_image_url: "images/btn_upload.gif",
			button_width: "60",
			button_height: "20",
			button_placeholder_id: "spanButtonPlaceHolder3",
			button_text: "<span class='theFont'>Upload</span>",
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

		$("#btn_remove_photofile, #btn_remove_namefile, #btn_remove_markfile").click(function(){
			var url = "action/?subAct=membermodify&Act=fileremove";
			var data = "";
			var act_id = $(this).attr("id");
			switch (act_id){
				case "btn_remove_photofile" : data = "filetype=profile&intSeq=" + $("#intSeq").val(); break;
				case "btn_remove_namefile" : data = "filetype=name&intSeq=" + $("#intSeq").val(); break;
				case "btn_remove_markfile" : data = "filetype=mark&intSeq=" + $("#intSeq").val(); break;
			}
			if (confirm(arApplMsg["confirm_delete"])){
				$.ajax({type: "POST", url: url, data: data, 
					success: function(responseText){
						switch (act_id){
							case "btn_remove_photofile" : $("#photofile_view, #photofile_remove").hide(); break;
							case "btn_remove_namefile" : $("#namefile_view, #namefile_remove").hide(); break;
							case "btn_remove_markfile" : $("#markfile_view, #markfile_remove").hide(); break;
						}
					},
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
				});
			}
		});

	});

	function uploadSuccessUser(file, serverData){
		try {
			var progress = new FileProgress(file, this.customSettings.progressTarget);
			progress.setComplete();
			progress.setStatus("Complete.");
			progress.toggleCancel(false);

			if (serverData == "ERROR"){
				alert(arApplMsg['err_fileupload']);
			}else{
				serverData = serverData.split(",");
				switch (serverData[1]){
					case "profile" : $("#photofile_img").attr("src", serverData[0]); $("#photofile_view, #photofile_remove").show(); break;
					case "name" : $("#namefile_img").attr("src", serverData[0]); $("#namefile_view, #namefile_remove").show(); break;
					case "mark" : $("#markfile_img").attr("src", serverData[0]); $("#markfile_view, #markfile_remove").show(); break;
				}
			}
		} catch (ex) {
			this.debug(ex);
		}
	}

	var Member = function() {}

	Member.CheckEmail = function(email) {

		var pattern = /^(\w+)@(\w+)[.](\w+)$/;
		var pattern2 = /^(\w+)@(\w+)[.](\w+)[.](\w+)$/;
	
		if (email.match(pattern) == null && email.match(pattern2) == null){
			return false;
		}else{
			return true;
		}

	}

	Member.CheckCorpNum = function (vencod) {

		var sum = 0;
		var getlist =new Array(10);
		var chkvalue =new Array("1","3","7","1","3","7","1","3","5");
        
		for(var i=0; i<10; i++) {
			getlist[i] = vencod.substring(i, i+1);
		}

		for(var i=0; i<9; i++) {
			sum += getlist[i]*chkvalue[i];
		}

		sum = sum + parseInt((getlist[8]*5)/10);
		sidliy = sum % 10;
		sidchk = 0;
        
		if(sidliy != 0) {
			sidchk = 10 - sidliy;
		}else {
			sidchk = 0;
		}

		if(sidchk != getlist[9]) {
			return false;
		}
		return true;

	}

	Member.PostStep1 = function(obj) {

		$("#addrForm_" + obj + "1").show();
		$("#addrForm_" + obj + "3").hide();

	}

	Member.PostStep2 = function(obj) {

		if ($("#" + obj + "1").val().length == ""){
			alert(arApplMsg["null_input_addr"]);$("#" + obj + "1").focus();return;
		}

			$.ajax({type: "POST", url: "action/?subAct=zipcode", data: "searchword=" + $("#" + obj + "1").val(), dataType: "json", success: function(responseText){

				if (responseText.length == 0){
					alert(arApplMsg["null_search_addr"]);$("#" + obj + "1").focus();return;
				}

				$("#addrForm_" + obj + "1").hide();
				$("#addrForm_" + obj + "2").show();

				$("#" + obj + "2 option").remove();

				for(var i = 0; i < responseText.length; i++){
					
					optText = '(' + responseText[i].dispcode + ') ' + responseText[i].sido + ' ' + responseText[i].gugun;

					if (responseText[i].dong!="")
						optText = optText + ' ' + responseText[i].dong;

					if (responseText[i].ri!="")
						optText = optText + ' ' + responseText[i].ri;

					if (responseText[i].apt!="")
						optText = optText + ' ' + responseText[i].apt;

					if (responseText[i].bunji!="")
						optText = optText + ' ' + responseText[i].bunji;

					optVal = responseText[i].dispcode + '$$$' + responseText[i].sido + '$$$' + responseText[i].gugun + '$$$' + responseText[i].dong + '$$$' + responseText[i].ri + '$$$' + responseText[i].apt + '$$$' + responseText[i].bunji;

					document.getElementById(obj + '2').options[i] = new Option(optText, optVal);
					
				}

				document.getElementById(obj + '2').selectedIndex =0;
	
				if(document.getElementById(obj + '2').refresh!=undefined)
					document.getElementById(obj + '2').refresh();

		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

	}

	Member.PostStep2Cancel = function(obj) {

		$("#addrForm_" + obj + "1").hide();
		$("#addrForm_" + obj + "3").show();

	}

	Member.PostStep3 = function(obj) {

		$("#addrForm_" + obj + "2").hide();
		$("#addrForm_" + obj + "3").show();
		var addrArr = $("#" + obj + "2").val().split("$$$");
		$("#" + obj + "3").val(addrArr[0]);

		var addr1 = addrArr[1] + ' ' + addrArr[2] + ' ' + addrArr[3];
		var addr2 = "";

		if (addrArr[4]!="")
			addr2 = addr2 + addrArr[4];

		if (addrArr[5]!="")
			addr2 = addr2 + addrArr[5];

		$("#" + obj + "4").val(addr1);
		$("#" + obj + "5").val(addr2);
		$("#" + obj + "5").focus();

	}

	Member.PostStep3Cancel = function(obj) {

		$("#addrForm_" + obj + "2").hide();
		$("#addrForm_" + obj + "3").show();

	}

	Member.AddFieldCheck = function(obj1, obj2, fieldtype) {

		switch (fieldtype){
			case "text"     : $("#" + obj2).val($("#" + obj1).val()); break;
			case "url"      : $("#" + obj2).val($("#" + obj1).val()); break;
			case "tel"      : $("#" + obj2).val($("#" + obj1 + "1").val() + "-" + $("#" + obj1 + "2").val() + "-" + $("#" + obj1 + "3").val()); break;
			case "mobile"   : $("#" + obj2).val($("#" + obj1 + "1").val() + "-" + $("#" + obj1 + "2").val() + "-" + $("#" + obj1 + "3").val()); break;
			case "textarea" : $("#" + obj2).val($("#" + obj1).val()); break;
			case "checkbox" : 
				$("#" + obj2).val("");
				for ( var j = 0; j < $("input[name=" + obj1 + "]").length; j++ ){
					if ($("input[id=" + obj1 + eval(j+1) + "]:checked").val()!=null){
						if ($("#" + obj2).val() != ""){
							$("#" + obj2).val($("#" + obj2).val() + ",");
						}
						$("#" + obj2).val($("#" + obj2).val() + $("input[id=" + obj1 + eval(j+1) + "]:checked").val());
					}
				}
				break;
			case "select"   : $("#" + obj2).val($("#" + obj1).val()); break;
			case "radio"    : $("#" + obj2).val($("input[name=" + obj1 + "]:checked").val()); break;
			case "addr"     :
				var str = $("#" + obj1 + "3").val();
				str = str.replace("-", "");
				$("#" + obj2).val(str + "$$$" + $("#" + obj1 + "4").val() + "$$$" + $("#" + obj1 + "5").val());
				break;
			case "date" :
				var str = $("#" + obj1).val();
				str = str.replace(".", "");
				str = str.replace(".", "");
				$("#" + obj2).val(str);
				break;
		}

	}

	Member.MarryDateReset = function(obj, set){
		if (set == "0")
			$("#" + obj).val('');		
	}

	Member.EmailListSet = function() {

		if ($("#email_list").val() == ""){
			$("#strEmail2").val("");
			$("#strEmail2").focus();
		}else{
			$("#strEmail2").val($("#email_list").val());
			$("#strEmail1").focus();
		}

	}