
	$(document).ready(function() {

		$("#theForm").submit(function() {

			if ($("#theForm #password").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_password']);$("#theForm #password").focus();return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					switch (responseText){
						case "ERROR" : alert(arApplMsg['invalid_password']); break; return false;
						case "SUCCESS" : 
							$("#extForm #subAct").val($("#passwordForm #nextAct").val());
							if ($("#passwordForm #comment_seq").val() != "")
								$("#extForm").append($(document.createElement("input")).attr("type","hidden").attr("id","comment_seq").attr("name","comment_seq").attr("value",$("#passwordForm #comment_seq").val()));
				
							if ($("#passwordForm #comment_page").val() != "")
								$("#extForm").append($(document.createElement("input")).attr("type","hidden").attr("id","comment_page").attr("name","comment_page").attr("value",$("#passwordForm #comment_page").val()));
				
							$("#extForm #subAct").val($("#passwordForm #nextAct").val());
							$("#extForm").attr("method", "get");
							$("#extForm").submit();							
							break;
					}
				}, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=boardpassword&board_srl=' + set_bbs_default.srl + '&board_seq=' + $("#extForm #seq").val() + '&comment_seq=' + $("#passwordForm #comment_seq").val()
			});

			return false;

		});

	});