	$(document).ready(function() {

		$("#theForm #nickname").val(arApplMsg['nickname']);
		$("#theForm #password").val(arApplMsg['password']);
		$("#theForm #email").val(arApplMsg['email']);
		$("#theForm #homepage").val(arApplMsg['homepage']);

		if (set_bbs_default.use_category == "1"){
			$.ajax({type: "POST", url: "action/?Act=boardcategorylist", data: "board_srl=" + $("#writeForm #intSrl").val() + "&category_srl=" + $("#writeForm #intCategory").val() + "&member_srl=" + $("#writeForm #intMemberSrl").val() + "&staff=" + set_bbs_write.staff_user, dataType: "json", success: function(responseText){
				if (responseText.length > 0){
					for(var i = 0; i < responseText.length; i++){
						$("#theForm #category_form").append($("<option value=\"" + responseText[i].code + "\">" + responseText[i].title + "</option>").prop("disabled", responseText[i].disable).prop("selected", responseText[i].selected));
					}
				}
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});
		}else{
			$("#theForm #write_category").remove();
		}

		$("#theForm #nickname, #theForm #password, #theForm #email, #theForm #homepage").bind({
			focus : function(){
				if ($(this).val() == arApplMsg[$(this).attr("id")])
					$(this).val("");
			},
			blur : function(){
				if ($(this).val() == "")
					$(this).val(arApplMsg[$(this).attr("id")]);
			}
		});

		$("#theForm #btn_cancel").click(function(){
			if ($("#extForm #seq").val() == "")
				$("#extForm #subAct").val("");
			else
				$("#extForm #subAct").val("view");
				
			$("#extForm").attr("method", "get");
			$("#extForm").submit();
		});

		if ($("#writeForm #intMemberSrl").val() != "" && $("#writeForm #intMemberSrl").val() != "0"){
			$("#write_guest").remove();
		}

		if (set_bbs_write.use_notice == "0")
			$("#theForm #opt_notice").remove();

		if (set_bbs_write.use_secret == "0")
			$("#theForm #opt_secret").remove();

		if ($("#writeForm #intMemberSrl").val() == "0" || $("#writeForm #intMemberSrl").val() == "")
			$("#theForm #opt_message").remove();

		$("#btnCaptcha").click(function(){
			var objImage = document.images['imgCaptcha'];
			if (objImage == undefined) {
				return;
			}
			var now = new Date();
			objImage.src = objImage.src.split('&')[0] + '&x=' + now.toUTCString();
		});

		if ($("#writeForm #intMemberSrl").val() != "" && $("#writeForm #intMemberSrl").val() != "0"){
			$("#theForm #write_captcha").remove();
		}else{
			if (set_bbs_default.staff_user == "1" || $("#writeForm #writeAct").val() == "modify")
				$("#theForm #write_captcha").remove();
		}

		if ($("#writeForm #writeAct").val() == "modify"){

			$("#theForm #nickname").val($("#writeForm #strUserName").val());
			$("#theForm #email").val($("#writeForm #strEmail").val());
			$("#theForm #homepage").val($("#writeForm #strHomepage").val());
			$("#theForm #title").val($("#writeForm #strTitle").val());
			$("#theForm #password").val($("#writeForm #strPassword").val());

			if ($("#writeForm #strTitleSize").val() != ""){
				$("#theForm #title").css("font-size", $("#writeForm #strTitleSize").val());
				$("#btn_fontsize span").text($("#writeForm #strTitleSize").val());
			}
				
			if ($("#writeForm #strTitleColor").val() != ""){
				$("#theForm #title").css("color", $("#writeForm #strTitleColor").val());
				$("#title_font_color").css("background-color",$("#writeForm #strTitleColor").val());
			}

			if ($("#writeForm #bitTitleBold").val() != ""){
				$("#theForm #title").css("font-weight","bold");
				$("#btn_fontbold").addClass("font_bold_on");
			}

			$("#theForm #tag").val($("#writeForm #strTag").val());

			if ($("#writeForm #bitNotice").val() == "1")
				$("#theForm #notice").prop("checked", true);

			if ($("#writeForm #bitSecret").val() == "1")
				$("#theForm #secret").prop("checked", true);

			if ($("#writeForm #bitMessage").val() == "1")
				$("#theForm #message").prop("checked", true);

			if ($("#writeForm #bitAllowComment").val() == "1")
				$("#theForm #allow_comment").prop("checked", true);

			if ($("#writeForm #bitAllowScrap").val() == "1")
				$("#theForm #allow_scrap").prop("checked", true);

			if (set_extra_form.config.length != 0){
				for (var i = 0; i < set_extra_form.config.length; i++) {
					if (set_extra_form.config[i].use == "True"){
						Board.AddFieldValue(set_extra_form.config[i].field, set_extra_form.config[i].field + "_", set_extra_form.config[i].formType);
					}
				}
			}

		}

		$("#theForm").submit(function() {

			if ($("#writeForm #intMemberSrl").val() == "" || $("#writeForm #intMemberSrl").val() == "0"){

				if ($("#nickname").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg['isnull_nickname']);$("#nickname").focus();return false;
				}

				if ($("#writeForm #writeAct").val() != "modify"){
					if ($("#password").val().replace(/\s/g, "").length == 0) {
						alert(arApplMsg['isnull_password']);$("#password").focus();return false;
					}
				}

				$("#writeForm #strPassword").val($("#theForm #password").val());
				$("#writeForm #strUserName").val($("#theForm #nickname").val());
				$("#writeForm #strNickName").val($("#theForm #nickname").val());
				$("#writeForm #strEmail").val($("#theForm #email").val());
				$("#writeForm #strHomepage").val($("#theForm #homepage").val());

			}

			if ($("#title").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_title']);$("#title").focus();return false;
			}
			
			$("#writeForm #strTitle").val($("#theForm #title").val());

			var _validator = new Trex.Validator();
			var _content = Editor.getContent();
			if(!_validator.exists(_content)) {
				alert(arApplMsg['isnull_content']);
				Editor.focus();
				return false;
			}else{
				$("#writeForm #strContent").val(_content);
			}

			if (set_bbs_default.use_category == "1"){
				if ($("#theForm #category_form").val().replace(/\s/g, "").length == 0){
					alert(arApplMsg['isnull_category']);$("#theForm #category_form").focus();return false;
				}
				$("#writeForm #intCategory").val($("#theForm #category_form").val());
			}else{
				$("#writeForm #intCategory").val("0");
			}

			$("#writeForm #strTag").val($("#theForm #tag").val());

			$("#writeForm #strUploadFile").val("");
			var _attachments = Editor.getAttachments('file', true);
			for(var i=0,len=_attachments.length;i<len;i++) {
				if (attacher_list.files.length < _attachments[i].data.dataSeq){
					if ($("#writeForm #strUploadFile").val() != "")
						$("#writeForm #strUploadFile").val($("#writeForm #strUploadFile").val() + ",");
					$("#writeForm #strUploadFile").val($("#writeForm #strUploadFile").val() + _attachments[i].data.filename + "$" + _attachments[i].data.originalurl + "$" + _attachments[i].data.filesize);
				}
			}

			$("#writeForm #strUploadImg").val("");
			var _attachments = Editor.getAttachments('image');
			for(var i=0,len=_attachments.length;i<len;i++) {
				if (_attachments[i].existStage) {
					if (attacher_list.files.length < _attachments[i].data.dataSeq){
						if ($("#writeForm #strUploadImg").val() != "")
							$("#writeForm #strUploadImg").val($("#writeForm #strUploadImg").val() + ",");
						$("#writeForm #strUploadImg").val($("#writeForm #strUploadImg").val() + _attachments[i].data.filename + "$" + _attachments[i].data.filesize);
					}
				}
			}

			if ($("#theForm #notice").is(':checked'))
				$("#writeForm #bitNotice").val("1");
			else
				$("#writeForm #bitNotice").val("0");
			
			if ($("#theForm #secret").is(':checked'))
				$("#writeForm #bitSecret").val("1");
			else
				$("#writeForm #bitSecret").val("0");
			
			if ($("#theForm #message").is(':checked'))
				$("#writeForm #bitMessage").val("1");
			else
				$("#writeForm #bitMessage").val("0");

			if ($("#theForm #allow_comment").is(':checked'))
				$("#writeForm #bitAllowComment").val("1");

			if ($("#theForm #allow_scrap").is(':checked'))
				$("#writeForm #bitAllowScrap").val("1");

			if (set_extra_form.config.length != 0){
				for (var i = 0; i < set_extra_form.config.length; i++) {
					if (set_extra_form.config[i].use == "True" && set_extra_form.config[i].rquired == "True"){
						switch (set_extra_form.config[i].formType){
							case "text" :
								if ($("#theForm #" + set_extra_form.config[i].field).val().length == 0){
									alert(set_extra_form.config[i].title + arApplMsg['isnull_field']);
									$("#theForm #" + set_extra_form.config[i].field).focus();
									return false;
								}
								break;
							case "url" :
								if ($("#theForm #" + set_extra_form.config[i].field).val().length == 0){
									alert(set_extra_form.config[i].title + arApplMsg['isnull_field']);
									$("#theForm #" + set_extra_form.config[i].field).focus();
									return false;
								}
								break;
							case "email" :
								if ($("#theForm #" + set_extra_form.config[i].field).val().length == 0){
									alert(set_extra_form.config[i].title + arApplMsg['isnull_field']);
									$("#theForm #" + set_extra_form.config[i].field).focus();
									return false;
								}
								break;
							case "tel" :
								if ($("#theForm #" + set_extra_form.config[i].field + "1").val().length == 0){
									alert(set_extra_form.config[i].title + arApplMsg['isnull_field']);
									$("#" + set_extra_form.config[i].field + "1").focus();
									return false;
								}
								if ($("#theForm #" + set_extra_form.config[i].field + "2").val().length == 0){
									alert(set_extra_form.config[i].title + arApplMsg['isnull_field']);
									$("#" + set_extra_form.config[i].field + "2").focus();
									return false;
								}
								if ($("#theForm #" + set_extra_form.config[i].field + "3").val().length == 0){
									alert(set_extra_form.config[i].title + arApplMsg['isnull_field']);
									$("#" + set_extra_form.config[i].field + "3").focus();
									return false;
								}
								break;
							case "textarea" :
								if ($("#theForm #" + set_extra_form.config[i].field).val().length == 0){
									alert(set_extra_form.config[i].title + arApplMsg['isnull_field']);
									$("#theForm #" + set_extra_form.config[i].field).focus();
									return false;
								}
								break;
						case "checkbox" :
							if ($("#theForm input[name=" + set_extra_form.config[i].field + "]:checked").length == 0){
								alert(set_extra_form.config[i].title + arApplMsg['isnull_field_select']);$("#theForm input[name=" + set_extra_form.config[i].field + "]")[0].focus();return false;
							}
							break;
						case "select" :
							if ($("#theForm #" + set_extra_form.config[i].field).val().length == 0){
								alert(set_extra_form.config[i].title + arApplMsg['isnull_field_select']);$("#theForm #" + set_extra_form.config[i].field).focus();return false;
							}
							break;
						case "radio" :
							if ($("#theForm input[name=" + set_extra_form.config[i].field + "]:checked").length == 0){
								alert(set_extra_form.config[i].title + arApplMsg['isnull_field_select']);$("#theForm #" + set_extra_form.config[i].field).focus();return false;
							}
							break;
						case "addr" :
							if ($("#address_list_" + set_extra_form.config[i].field + " option").length == 0){
								alert(set_extra_form.config[i].title + arApplMsg['isnull_field']);$("#krzip_address1_" + set_extra_form.config[i].field).focus();return false;
							}
							if ($("#krzip_address2_" + set_extra_form.config[i].field).val().length == 0){
								alert(set_extra_form.config[i].title + arApplMsg['isnull_field']);$("#krzip_address2_" + set_extra_form.config[i].field).focus();return false;
							}
							break;
						case "date" :
							if ($("#theForm #" + set_extra_form.config[i].field).val().length == 0){
								alert(set_extra_form.config[i].title + arApplMsg['isnull_field']);$("#theForm #" + set_extra_form.config[i].field).focus();return false;
							}
							break;

						}
					}
				}
			}

			if ($("#writeForm #intMemberSrl").val() == "" || $("#writeForm #intMemberSrl").val() == "0"){
				if (set_bbs_default.staff_user != "1"){
					if ($("#writeForm #writeAct").val() != "modify"){
						if ($("#theForm #captcha").val().replace(/\s/g, "").length == 0){
							alert(arApplMsg['isnull_captcha']);$("#theForm #captcha").focus();return false;
						}
						$("#writeForm #strCaptcha").val($("#theForm #captcha").val());
					}
				}
			}

			if (set_extra_form.config.length != 0){
				for (var i = 0; i < set_extra_form.config.length; i++) {
					if (set_extra_form.config[i].use == "True"){
						Board.AddFieldCheck(set_extra_form.config[i].field, set_extra_form.config[i].field + "_", set_extra_form.config[i].formType);
					}
				}
			}

			$("#writeForm #strTempFiles").val("");
			$("#writeForm #strTempImages").val("");

return false;

			$("#writeForm").ajaxSubmit({
				success: function(responseText){
					switch (responseText){
						case "ERROR01" : alert(arApplMsg['invalid_captcha']); break; return false;
						case "ERROR02" : alert(arApplMsg['invalid_nickname']); break; return false;
						case "ERROR03" : alert(arApplMsg['not_permitted']); break; return false;
					}

					if ($("#extForm #subAct").val() == "write"){
						switch (set_bbs_write.write_move_opt){
							case "0" :
								$("#extForm #subAct, #extForm #search_target, #extForm #search_keyword").val("");
								$("#extForm").attr("method","get");
								$("#extForm").submit();
								break;
							case "1" :
								$("#extForm #subAct").val("view");
								$("#extForm #seq").val(responseText);
	
								if (set_bbs_write.use_category == "1")
									$("#extForm #category").val($("#theForm #category_form").val());

								$("#extForm #search_target, #extForm #search_keyword").val("");
								$("#extForm").attr("method","get");
								$("#extForm").submit();
								break;
							case "2" :
								document.location.href = set_bbs_write.write_move_url;
								return false;
								break;
						}
					}

					if ($("#extForm #subAct").val() == "modify"){
						switch (set_bbs_write.modify_move_opt){
							case "0" :
								$("#extForm #subAct").val("");
								$("#extForm #seq").val("");
								$("#extForm").attr("method","get");
								$("#extForm").submit();
								break;
							case "1" :
								$("#extForm #subAct").val("view");
								$("#extForm").attr("method","get");
								$("#extForm").submit();
								break;
							case "2" :
								document.location.href = set_bbs_write.write_move_url;
								return false;
								break;
						}
					}
				}, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=boardwrite'
			});
			
			return false;

		});

	});

	var Board = function() {}

	Board.AddFieldCheck = function(obj1, obj2, fieldtype) {

		switch (fieldtype){
			case "text"     : $("#" + obj2).val($("#" + obj1).val()); break;
			case "url"      : $("#" + obj2).val($("#" + obj1).val()); break;
			case "email"    : $("#" + obj2).val($("#" + obj1).val()); break;
			case "tel"      : $("#" + obj2).val($("#" + obj1 + "1").val() + "-" + $("#" + obj1 + "2").val() + "-" + $("#" + obj1 + "3").val()); break;
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
				if ($("#address_list_" + obj1).val()!= "" && $("#address_list_" + obj1).val()!= null && $("#" + obj1).val() != "")
					$("#" + obj2).val($("#address_list_" + obj1).val().split("$$$")[0].split("-")[0] + $("#address_list_" + obj1).val().split("$$$")[0].split("-")[1] + "$$$" + $("#address_list_" + obj1).val().split("$$$")[1] + "$$$" + $("#krzip_address2_" + obj1).val());
				break;
			case "date" :
				var str = $("#" + obj1).val();
				str = str.replace(".", "");
				str = str.replace(".", "");
				$("#" + obj2).val(str);
				break;
			case "datetime" :
				var str = $("#" + obj1 + "1").val() + "$$$" + $("#" + obj1 + "2").val() + "$$$" + $("#" + obj1 + "3").val() + "$$$" + $("#" + obj1 + "4").val() + "$$$" + $("#" + obj1 + "5").val();
				$("#" + obj2).val(str);
				break;
		}

	}
	
	Board.AddFieldValue = function(obj1, obj2, fieldtype) {

		switch (fieldtype){
			case "text"     : $("#" + obj1).val($("#" + obj2).val()); break;
			case "url"      : $("#" + obj1).val($("#" + obj2).val()); break;
			case "email"    : $("#" + obj1).val($("#" + obj2).val()); break;
			case "tel"      :
				$("#" + obj1 + "1").val($("#" + obj2).val().split("-")[0]);
				$("#" + obj1 + "2").val($("#" + obj2).val().split("-")[1]);
				$("#" + obj1 + "3").val($("#" + obj2).val().split("-")[2]);
				break;
			case "textarea" : $("#" + obj1).val($("#" + obj2).val()); break;
			case "checkbox" : 
				if ($("#" + obj2).val() != ""){
					$("#" + obj2).val().split(",").each(function(e){
						for ( var j = 0; j < $("input[name=" + obj1 + "]").length; j++ ){
							if ($("input[id=" + obj1 + (j+1) + "]").val() == e)
								$("input[id=" + obj1 + (j+1) + "]").prop("checked", true);
						}
					});
				}
				break;
			case "select"   : $("#" + obj1).val($("#" + obj2).val()); break;
			case "radio"    :
				if ($("#" + obj2).val() != ""){
					for ( var j = 0; j < $("input[name=" + obj1 + "]").length; j++ ){
						if ($("input[id=" + obj1 + (j+1) + "]").val() == $("#" + obj2).val())
							$("input[id=" + obj1 + (j+1) + "]").prop("checked", true);
					}
				}
				break;
			case "addr"     :
				if ($("#" + obj2).val() != ""){
					$("#zone_address_search_" + obj1).hide();
					$("#zone_address_list_" + obj1).show();
					$("#address_list_" + obj1).get(0).options[0] = new Option("(" + $("#" + obj2).val().split("$$$")[0].substring(0, 3) + "-" + $("#" + obj2).val().split("$$$")[0].substring(3, 6) + ") " + $("#" + obj2).val().split("$$$")[1], $("#" + obj2).val().split("$$$")[0].substring(0, 3) + "-" + $("#" + obj2).val().split("$$$")[0].substring(3, 6) + "$$$" + $("#" + obj2).val().split("$$$")[1]);
					$("#krzip_address2_" + obj1).val($("#" + obj2).val().split("$$$")[2]);
					$('.krZip>.item>.zipLabel').hide();
				}
				break;
			case "date" :
				if ($("#" + obj2).val() != ""){
					$("#" + obj1).val($("#" + obj2).val().substring(0,4) + "." + $("#" + obj2).val().substring(4,6) + "." + $("#" + obj2).val().substring(6,8));
				}
				break;
			case "datetime" :
				if ($("#" + obj2).val() != ""){
					$("#" + obj1 + "1 > option[value=" + $("#" + obj2).val().split("$$$")[0] + "]").prop("selected", true);
					$("#" + obj1 + "2 > option[value=" + $("#" + obj2).val().split("$$$")[1] + "]").prop("selected", true);
					$("#" + obj1 + "3 > option[value=" + $("#" + obj2).val().split("$$$")[2] + "]").prop("selected", true);
					$("#" + obj1 + "4 > option[value=" + $("#" + obj2).val().split("$$$")[3] + "]").prop("selected", true);
					$("#" + obj1 + "5 > option[value=" + $("#" + obj2).val().split("$$$")[4] + "]").prop("selected", true);
				}
				break;
		}

	}