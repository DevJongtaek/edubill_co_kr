
	jQuery(function($){

		var form = "#theForm";

		$(form).submit(function(){

			if ($("#name", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_user_name']);$("#name", form).focus();return false;
			}
	
			if ($("#ssn1", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_ssn']);$("#ssn1", form).focus();return false;
			}
	
			if ($("#ssn2", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_ssn']);$("#ssn2", form).focus();return false;
			}

			if ($.ssn_check($("#ssn1", form).val(), $("#ssn2", form).val()) == false){
				alert(arApplMsg['invalid_ssn']);$("#ssn1", form).focus();return false;
			}

			$("#extForm #c_name").val($("#name", form).val());
			$("#extForm #c_ssn").val($("#ssn1", form).val() + $("#ssn2", form).val());
	
			if ($("#extForm #bitUseNameCheck").val() == "1"){
				switch ($("#extForm #strNameCheckCorp").val()){
					case "1" :
						$("#extForm #SendInfo").val(makeSendInfo($("#name", form).val(), $("#ssn1", form).val() + $("#ssn2", form).val(), "10", "1" ));break;
				}
			}

			$.doExtFormSubmit('action/?Act=ssncheck', 'post');

			return false;

		});

	});