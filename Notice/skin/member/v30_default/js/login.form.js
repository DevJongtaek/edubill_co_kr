
	jQuery(function($){

		var form = "#theForm";

		if ($.cookie("arty30_userid") != null){
			$("#loginid", form).val($.cookie("arty30_userid"));
			$("#idsave", form).prop("checked", true);
			$("#bitIdSave", "#extForm").val('1');
		}

		$("#idsave", form).click(function(){
			if ($(this).is(":checked"))
				$("#bitIdSave", "#extForm").val('1');
			else
				$("#bitIdSave", "#extForm").val('0');
		});

		$(form).submit(function(){

			if ($("#loginid", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_user_id']);$("#loginid", form).focus();return false;
			}

			if ($("#loginpwd", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_password']);$("#loginpwd", form).focus();return false;
			}

			$("#extForm #strLoginID").val($("#loginid", form).val());
			$("#extForm #strPassword").val($("#loginpwd", form).val());

			$.memberLoginErr = function(responseText){
				switch(responseText){
					case "ERROR01" : alert(arApplMsg['user_not_match']); return false; break;
					case "ERROR02" : alert(arApplMsg['user_not_authed']); return false; break;
					case "ERROR03" : alert(arApplMsg['user_denied']); return false; break;
				}
			}

			$.doMemberLogin(form);

			return false;

		});

	});