
	$(document).ready(function() {

		window.self.resizeTo(500, 400);

		$.ajax({type: "POST", url: "action/?Act=friendgrouplist", data: "intMemberSrl=" + $("#extForm #member_srl").val(), dataType: "json", success: function(responseText){

			if (responseText.length > 0){
				for(var i = 0; i < responseText.length; i++){
					$("#theForm #group_name").append($("<option value=\"" + responseText[i].group_srl + "\">" + responseText[i].title + "</option>"));
				}
				if ($("#extForm #group_srl").val() != "")
					$("#theForm #group_name").val($("#extForm #group_srl").val()).prop("selected", true);
			}
		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

		if ($("#extForm #subAct").val() == "friendmodify"){
			$("#search_target").hide();
			$("#btn_search").hide();
			$("#search_keyword").prop("readonly", true);
		}

		$("#btn_search").click(function(){

			if ($("#search_keyword").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_search_keyword']);$("#search_keyword").focus();return false;
			}

			$.ajax({type: "POST", url: "action/?Act=membersearch", data: "strSearchTarget=" + $("#theForm #search_target").val() + "&strSearchKeyword=" + $("#theForm #search_keyword").val(), dataType: "json", success: function(responseText){

				if (responseText.length > 0){
					$("#search_result").show();
					$("#search_result ul").remove();
					$("#search_result").append("<ul></ul>");
					for(var i = 0; i < responseText.length; i++){
						if (i == 0)
							$("#search_result ul").append("<li><input type=\"radio\" id=\"member_seq\" name=\"member_seq\" value=\"" + responseText[i].member_seq + "\" checked>" + responseText[i].userid + " (" + responseText[i].nick_name + ")</li>");
						else
							$("#search_result ul").append("<li><input type=\"radio\" id=\"member_seq\" name=\"member_seq\" value=\"" + responseText[i].member_seq + "\">" + responseText[i].userid + " (" + responseText[i].nick_name + ")</li>");
						
					}
				}else{
					alert(arApplMsg['isnull_search_result']);
					$("#theForm #search_keyword").val("");
					$("#theForm #search_keyword").focus();
					return false;
				}
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

		});

		$("#theForm").submit(function() {

			if ($("#extForm #subAct").val() == "friendadd"){
				if ($(':radio[name="member_seq"]:checked').length == 0){
					alert(arApplMsg['isnull_search_member']);
					$("#theForm #search_keyword").focus();
					return false;
				}
				$("#extForm #friend_srl").val($(':radio[name="member_seq"]:checked').val());
			}

			$("#extForm #group_srl").val($("#theForm #group_name").val());
			$("#extForm #friend_memo").val($("#theForm #memo").val());

			if (confirm(arApplMsg['confirm_regist'])){

				$("#extForm").ajaxSubmit({
					success: function(responseText){
						switch(responseText){
							case "ERROR01" : alert(arApplMsg['popmenu_error']); break;
							case "ERROR02" : alert(arApplMsg['popmenu_already_friend']); break;
							default :
								if ($("#extForm #subAct").val() == "friendadd"){
									alert(arApplMsg['popmenu_success_friend']);
								}else{
									alert(arApplMsg['success_modify']);
								}
								opener.location.reload(); self.close();
								break;
						}
					}, 
				 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=' + $("#extForm #subAct").val()
				});
	
				}

			return false;			

		});

		$("#btn_close").click(function(){
			self.close();
		});

	});