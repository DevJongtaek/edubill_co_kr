
	jQuery(function($){

		var isCheck = false;
		var form = "#theForm";

		$.memberEmailCertifiedComplate = function(ret_obj, responseText){
			switch (ret_obj){
				case "get" :
					if (responseText == "ERROR01"){
						alert(arApplMsg['already_mail']);$("#email", form).focus();return false;
					}
					alert(arApplMsg['success_certified_send']);
					$("#email", form).prop("disabled", true);
					$(".btn_get_auth", form).prop("disabled", true);
					$(".btn_get_re_auth", form).show();					
					break;
				case "put" :
					if (responseText == "N"){
						alert(arApplMsg['invalid_certified']);$("#authCode", form).focus();return false;
					}
					alert(arApplMsg['success_certified']);
					isCheck = true;
					$("#authCode", form).prop("disabled", true);
					$(".btn_put_auth", form).prop("disabled", true);
					break;
				case "reset" :
					$("#email", form).val(""); $(".btn_get_re_auth", form).hide();
					break;
			}
		}

		$(".btn_get_auth", form).click(function(){
			if (!$.email_check($("#email", form).val())){
				alert(arApplMsg['invalid_mail']);$("#email", form).focus();return false;
			}
			$.doMemberEmailCertified('get', 'action/?Act=joinauth', 'subAct=send&checkType=email&checkData=' + $('#email', form).val());
		});

		$(".btn_put_auth").click(function(){
			if ($("#authCode", form).val() == ""){
				alert(arApplMsg['isnull_certified_input']);$("#authCode", form).focus();return false;
			}
			$.doMemberEmailCertified('put', 'action/?Act=joinauth', 'subAct=auth&checkType=email&checkData=' + $('#email', form).val() + "&inputData=" + $("#authCode").val());
		});

		$(".btn_get_re_auth").click(function(){
			$("#email", form).prop("disabled", false);
			$(".btn_get_auth", form).prop("disabled", false);
			$.doMemberEmailCertified('reset', 'action/?Act=joinauth', 'subAct=cancel&checkType=email&checkData=' + $('#email', form).val());
		});

		$(form).submit(function(){
			if (isCheck == false){
				alert(arApplMsg['isnull_certified_key']); return false;
			}else{
				$("#extForm #checkMemberAuthEmail").val($("#email", form).val());
				$("#extForm").attr("action","?act=member&subAct=dispform");
				$("#extForm").submit();
				return false;
			}
		});

	});
