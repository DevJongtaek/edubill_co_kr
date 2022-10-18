
	$(document).ready(function() {

		$("#theForm").submit(function() {

			if ($("input[name=outmemo]:checked").length == 0){
				alert(arApplMsg['invalid_out_memo']);
				return false;
			}

			$("input[name=outmemo]:checked").each(function(){
				if ($(this).val() == "1"){
					if ($("#outmemouser").val().replace(/\s/g, "").length == 0) {
						alert(arApplMsg['invalid_out_memo_input']);$("#outmemouser").focus();return false;
					}
					$("#extForm #strLeaveMemo").val($("#outmemouser").val());
				}else{
					$("#extForm #strLeaveMemo").val($(this).val());
				}
			});

			if ($("#password").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_password']);$("#password").focus();return false;
			}

			$("#extForm #strPassword").val($("#theForm #password").val());

			switch (strOutOption_){
				case "0" : var msg = arApplMsg['confirm_withdraw_message1'] + "\n" + arApplMsg['confirm_withdraw']; break;
				case "1" : var msg = arApplMsg['confirm_withdraw_message2'] + "\n" + arApplMsg['confirm_withdraw']; break;
			}

			if (confirm(msg)){

				$("#extForm").ajaxSubmit({
					success: function(responseText){
						switch (responseText){
							case "ERROR01" : alert(arApplMsg['after_login']); return false; break;
							case "ERROR02" : alert(arApplMsg['user_not_match']); return false; break;
							case "ERROR03" : alert(arApplMsg['managers_not_withdraw']); return false; break;
							default :
							switch (strOutAct_){
								case "0" :
									alert(strOutActMsg_);document.location.href = strOutActUrl_;
									break;
								case "1" :
									outActScript();
									break;
								case "2" :
									$("#extForm").attr("action", "?act=member&subAct=outresult");
									$("#extForm").submit();
									break;
							}
								break;
						}
	
					}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=memberout'
				});

			}

			return false;

    });

	});