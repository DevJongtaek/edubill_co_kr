
	jQuery(function($){

		var form = "#theForm";

		$("#userid").val($("#strLoginID", "#extForm").val());

		$(form).submit(function(){

			if ($("#userid", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_user_id']);$("#userid", form).focus();return false;
			}

			if ($("#username", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_user_name']);$("#username", form).focus();return false;
			}

			if ($("#email", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_mail']);$("#email", form).focus();return false;
			}

			if ($("#extForm #ssnCheck").val() == "1"){
				if ($("#ssn1", form).val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg['invalid_ssn']);$("#ssn1", form).focus();return false;
				}
				if ($("#ssn2", form).val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg['invalid_ssn']);$("#ssn2", form).focus();return false;
				}
			}

			$("#strLoginID", "#extForm").val($("#userid", form).val());
			$("#strUserName", "#extForm").val($("#username", form).val());
			$("#strEmail", "#extForm").val($("#email", form).val());

			if ($("#ssnCheck", "#extForm").val() == "1")
				$("#strSSN", "#extForm").val($("#ssn1", form).val() + $("#ssn2", form).val());

			$.doExtFormSubmit('?act=member&subAct=findpwdresult', 'post');

			return false;

		});

	});