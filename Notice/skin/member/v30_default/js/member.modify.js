
	var form = "#theForm";
	var email_check = true;

	jQuery(function($){

		if ($("#isNameModify", "#extForm").val() == "0")
			$("#strUserName", form).prop('disabled', true);

		$(".certified1, .certified2, .certified3", form).hide();

		$("#strEmail1, #strEmail2, #email_list", form).change(function(){
			email_check = false;
			$("#change_email", form).val('1');
			if ($("#isEmailCheck", "#extForm").val() == "1"){
				$(".certified1, .certified3", form).show();
			}
		});

		$("#email_list", form).change(function(){
			if ($(this).val() == ""){
				$("#strEmail2", form).val('');
				$("#strEmail2", form).focus();
			}else{
				$("#strEmail2", form).val($(this).val());
				$("#strEmail1", form).focus();
			}
		});

		$("#strNickName", form).change(function(){
			$("#change_nick", form).val('1');
		});

		$.memberEmailCertifiedComplate = function(ret_obj, responseText){
			switch (ret_obj){
				case "get" :
					if (responseText == "ERROR01"){
						alert(arApplMsg['already_mail']);$("#strEmail1", form).focus();return false;
					}
					alert(arApplMsg['success_certified_send']);
					$(".certified1", form).hide();
					$(".certified2, .btn_get_re_auth", form).show();
					$("#authCode", form).val('');
					$("#authCode", form).focus();
					break;
				case "put" :
					if (responseText == "N"){
						alert(arApplMsg['invalid_certified']);$("#authCode", form).focus();return false;
					}
					alert(arApplMsg['success_certified']); email_check = true; $(".certified2, .certified3", form).hide();
					break;
				case "reset" :
					$(".certified2", form).hide();
					$(".certified1", form).show();
					$("#strEmail1", form).focus();
					break;
			}
		}

		$(".btn_get_auth", form).click(function(){
			if (!$.email_check( $("#strEmail1", form).val() + "@" + $("#strEmail2", form).val())){
				alert(arApplMsg['invalid_mail']);$("#strEmail1", form).focus();return false;
			}
			$.doMemberEmailCertified('get', 'action/?Act=joinauth', 'subAct=send&checkType=email&checkData=' + $("#strEmail1", form).val() + "@" + $("#strEmail2", form).val());
		});

		$(".btn_put_auth", form).click(function(){
			if ($("#authCode", form).val() == ""){
				alert(arApplMsg['isnull_certified_input']);$("#authCode", form).focus();return false;
			}
			$.doMemberEmailCertified('put', 'action/?Act=joinauth', 'subAct=auth&checkType=email&checkData=' + $("#strEmail1", form).val() + "@" + $("#strEmail2", form).val() + "&inputData=" + $("#authCode", form).val());
		});

		$(".btn_get_re_auth", form).click(function(){
			$.doMemberEmailCertified('reset', 'action/?Act=joinauth', 'subAct=cancel&checkType=email&checkData=' + $("#strEmail1", form).val() + "@" + $("#strEmail2", form).val());
		});

		$("#tx_canvas_wysiwyg").css("height","150px");

		$("#strMarry1", form).change(function() {
			if ($(this).val() == "0")
				$("#strMarry2").val('');
		});

		$(".btn_remove_photofile, .btn_remove_namefile, .btn_remove_markfile").click(function(){
			var uploadType = $(this).attr("id").split("_")[1];
			if (confirm(arApplMsg['confirm_delete'])){
				$.doMemberUploadRemove(uploadType, "subAct=" + uploadType + "&intSeq=" + $("#intSeq", form).val());
			}
		});

		$.memberImageUploadComplate = function(serverData){
			serverData = serverData.split(",");
			switch (serverData[1]){
				case "profile" : $(".photofile_img", form).attr("src", serverData[0]); $(".memberUploadImage1 li:first").show(); break;
				case "name" : $(".namefile_img", form).attr("src", serverData[0]); $(".memberUploadImage2 li:first").show(); break;
				case "mark" : $(".markfile_img", form).attr("src", serverData[0]); $(".memberUploadImage3 li:first").show(); break;
			}
		}

		$.memberImageRemoveComplate = function(responseText){
			switch (responseText){
				case "profile" : $(".memberUploadImage1 li:first").hide(); break;
				case "name" : $(".memberUploadImage2 li:first").hide(); break;
				case "mark" : $(".memberUploadImage3 li:first").hide(); break;
			}
		}

		$(form).submit(function(){

			$.memberFormInputErr = function(fType, fName, msg){

				if (fType == "email_check"){
					alert(arApplMsg['invalid_mail']);return false;
				}

				if (fType == "editor"){
					alert(msg);fName.focus();fName.focus();return false;
				}

				if (msg != ""){alert(msg);}
				if (fName != ""){fName.focus();}

				return false;
			}

			if ($.doMemberFormCheck("modify", form) == true){

				$.memberUpdateComplate = function(responseText){
					switch (responseText){
						case "ERROR01" : alert(arApplMsg['isnull_login']);return false; break;
						case "ERROR02" : alert(arApplMsg['already_mail']);return false; break;
						case "ERROR03" : alert(arApplMsg['already_nick']);return false; break;
						case "ERROR04" : alert(arApplMsg['invalid_nick_name']);return false; break;
						default :
							$.memberModifyComplate(); break;
					}
				}

				$.doMemberFormSubmit("modify", form);
			}

			return false;

		});

	});