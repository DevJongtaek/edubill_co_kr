
	jQuery(function($){

		var form = "#theForm";

		$(".btn_cancel", form).click(function(){
			history.back(-1);
			return false;
		});

		$(form).submit(function(){

			if ($("#password", form).val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_password']);$("#password", form).focus();return false;
			}

			$("#memberPwd", "#extForm").val($("#password", form).val());
			$.doExtFormSubmit('?act=member&subAct=modifyform', 'post');
			return false;

		});

	});