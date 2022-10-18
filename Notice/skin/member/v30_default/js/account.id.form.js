
	jQuery(function($){

		var form = "#theForm";

		$(form).submit(function(){

			if ($("#username", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_user_name']);$("#username", form).focus();return false;
			}

			if ($("#email", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_mail']);$("#email", form).focus();return false;
			}

			if ($("#ssnCheck", "#extform").val() == "1"){
				if ($("#ssn1", form).val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg['isnull_ssn']);$("#ssn1", form).focus();return false;
				}
				if ($("#ssn2", form).val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg['isnull_ssn']);$("#ssn2", form).focus();return false;
				}
				$("#strSSN", "#extForm").val($("#ssn1", form).val() + $("#ssn2", form).val());
			}

			$("#strUserName", "#extForm").val($("#username", form).val());
			$("#strEmail", "#extForm").val($("#email", form).val());

			$.doExtFormSubmit("?act=member&subAct=findidresult", "post");

			return false;

		});

	});