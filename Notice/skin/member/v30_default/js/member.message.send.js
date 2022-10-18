
	$(document).ready(function() {

		window.self.resizeTo(660, 650);

		if ($("#bitMailing").val() == ""){
			$("#mail_send").hide();
		}

		$.ajax({type: "POST", url: "action/?Act=friendlist", data: "member_srl=" + $("#extForm #intSenderSrl").val(), dataType: "json", success: function(responseText){

			if (responseText.length > 0){
				for(var i = 0; i < responseText.length; i++){
					$("#theForm #friend").append($("<option value=\"" + responseText[i].nick_name + "\">" + responseText[i].nick_name + "</option>"));
				}

			}
		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

		$("#friend").change(function(){
			if ($("#theForm #nick_name").val() != "")
				$("#theForm #nick_name").val($("#theForm #nick_name").val() + ",");
			$("#theForm #nick_name").val($("#theForm #nick_name").val() + $(this).val());
		});

		$("#btn_close").click(function(){
			self.close()
		});

		$("#theForm").submit(function() {

			if ($("#extForm #intReceiverSrl").val() == ""){
				if ($("#theForm #nick_name").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg['isnull_message_user']);
					$("#theForm #nick_name").focus();
					return false;
				}
			}

			if ($("#theForm #title").val().length == 0){
				alert(arApplMsg['isnull_title']);$("#theForm #title").focus();return false;
			}

			var _validator = new Trex.Validator();
			var _content = Editor.getContent();

			if(!_validator.exists(_content)) {
				alert(arApplMsg['isnull_content']);
				Editor.focus();
				return false;
			}

			if ($("#theForm #send_mail").is(':checked'))
				$("#extForm #bitSendMail").val("1");
			else
				$("#extForm #bitSendMail").val("0");

			$("#extForm #strNickName").val($("#theForm #nick_name").val());
			$("#extForm #strTitle").val($("#theForm #title").val());
			$("#extForm #strContent").val(_content);

			$("#extForm").ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						alert(arApplMsg['after_login']);
						return false;
					}else{
						alert(arApplMsg['success_send']);self.close();
					}
				}, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=message&subAct=send'
			});
			
			return false;

		});

	});