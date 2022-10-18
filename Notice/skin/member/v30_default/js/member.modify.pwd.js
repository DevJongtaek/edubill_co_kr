
	$(document).ready(function() {

		$("#btn_cancel").click(function(){
			history.back(-1);
		});

		$("#theForm").submit(function() {


			if ($("#password").val().length == 0 ){
				alert(arApplMsg['isnull_password']);$("#password").focus();return false;
			}

			if ($("#password1").val().length == 0 ){
				alert(arApplMsg['isnull_new_password']);$("#password1").focus();return false;
			}

			if ($("#password1").val().length < 6 ){
				alert(arApplMsg['invalid_password_input']);$("#password1").focus();return false;
			}

			if ($("#password2").val().length == 0 ){
				alert(arApplMsg['isnull_re_password']);$("#password2").focus();return false;
			}

			if ($("#password1").val() != $("#password2").val()){
				alert(arApplMsg['invalid_password']);$("#password2").focus();return false;
			}

			$("#extForm #strPassword").val($("#password").val());
			$("#extForm #strPassword2").val($("#password1").val());

			$("#extForm").ajaxSubmit({
				success: function(responseText){
					switch (responseText){
						case "ERROR01" :
							alert(arApplMsg['after_login']);
							$("#extForm").attr("action", "?act=login");
							$("#extForm").submit();
							return false;
							break;
						case "ERROR02" : alert(arApplMsg['invalid_password'] + "\n" + arApplMsg['invalid_password_re']); $("#password").focus(); return false; break;
						default :
							alert(arApplMsg['success_modify_password']);
							break;
					}
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=modifypwd'
			});
			
			return false;


		});

	});