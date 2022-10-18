
	var form = "#theForm";
	var id_check = false;

	jQuery(function($){

		$(".btn_id_check", form).click(function(){

			if ($("#strLoginID").val().length < 3){
				alert(arApplMsg['invalid_user_id']);$("#strLoginID").focus();return false;
			}

			$.memberIdCheckComplate = function(responseText){
				switch (responseText){
					case "SUCCESS"  : alert(arApplMsg['usable_user_id']);id_check = true; break;
					case "ERROR01" : alert(arApplMsg['invalid_user_id_text']);id_check = false; $("#strLoginID", form).focus();return false; break;
					case "ERROR02" : alert(arApplMsg['already_user_id']);id_check = false; $("#strLoginID", form).focus();return false; break;
					case "ERROR03" : alert(arApplMsg['invalid_user_id_not']);id_check = false; $("#strLoginID", form).focus();return false; break;
				}
			}

			$.doMemberIdCheck($("#strLoginID", form).val());

		});

		if ($("#checkMemberAuth", "#extForm").val() == "1"){
			if ($("#checkMemberAuthEmail", "#extForm").val()!=""){
				$("#strEmail1", form).val($("#checkMemberAuthEmail", "#extForm").val().split("@")[0]);
				$("#strEmail2", form).val($("#checkMemberAuthEmail", "#extForm").val().split("@")[1]);
				$("#strEmail1, #strEmail2, #email_list", form).prop("disabled", true);
			}
		}

		$("#email_list", form).change(function(){
			if ($(this).val() == ""){
				$("#strEmail2", form).val('');
				$("#strEmail2", form).focus();
			}else{
				$("#strEmail2", form).val($(this).val());
				$("#strEmail1", form).focus();
			}
		});

		$("#strMemberType", form).val($("#checkMemberType", "#extForm").val());

		if ($("#checkMemberSsn", "#extForm").val() == "1"){
			$("#strUserName", form).val($("#checkMemberSsnData1", "#extForm").val());
			$("#strUserName", form).prop("disabled", true);
			$("#strSSN", form).val($("#checkMemberSsnData2", "#extForm").val());
		}

		$("#strMarry1", form).change(function() {
			if ($(this, form).val() == "0")
				$("#strMarry2", form).val('');
		});

		$("#tx_canvas_wysiwyg", form).css("height","150px");

		$(form).submit(function(){

			$.memberFormInputErr = function(fType, fName, msg){

				if (fType == "userid_check"){
					alert(arApplMsg['invalid_user_id_check']);return false;
				}

				if (fType == "password_check"){
					alert(arApplMsg['invalid_password']);return false;
				}

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

			if ($.doMemberFormCheck("join", form) == true){

				$.memberUpdateComplate = function(responseText){
					switch (responseText){
						case "ERROR01" : alert(arApplMsg['already_ssn']); return false; break;
						case "ERROR02" : alert(arApplMsg['already_mail']);return false; break;
						case "ERROR03" : alert(arApplMsg['already_nick']);return false; break;
						case "ERROR04" : alert(arApplMsg['invalid_nick_name']);return false; break;
						default :
							$.memberJoinComplate(); break;
					}
				}

				$.doMemberFormSubmit("join", form);
			}

			return false;

		});

	});