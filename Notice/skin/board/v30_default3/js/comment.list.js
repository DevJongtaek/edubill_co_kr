
	$(document).ready(function() {

		$("a[name=comment_file]").click(function(){

			var comment_id = $(this).attr("id");

			$("#files_" + comment_id).toggle();

			if ($("#files_" + comment_id + " li").length == 0){

				$.ajax({type: "POST", url: "action/?Act=boardfilelist", data: "board_srl=" + set_bbs_default.srl + "&board_seq=" + $("#extForm #seq").val() + "&comment_seq=" + comment_id + "&list_type=C&image=0", dataType: "json", success: function(responseText){
					if (responseText.length > 0){
						for(var i = 0; i < responseText.length; i++){
							if (responseText[i].downlevel == "0"){
								$("#files_" + comment_id).append("<li><a hre=\"#comment_file\" onClirk=\"return false;\">" + responseText[i].filename + " <span>(" + responseText[i].filesize1 + " / Download : " + responseText[i].filedown + ")</span></a></li>");
							}else{
									$("#files_" + comment_id).append("<li><a href=\"?Act=bbs&subAct=filedown&bid=" + $("#extForm #bid").val() + "&seq=" + $("#extForm #seq").val() + "&comment_seq=" + comment_id + "&file_seq=" +responseText[i].seq + "\">" + responseText[i].filename + " <span>(" + responseText[i].filesize1 + " / Download : " + responseText[i].filedown + ")</span></a></li>");
							}
						}
							
					}		
				 },
					 error: function(response){alert('error\n\n' + response.responseText);return false;}
				});

			}

		});

	});
	
	function secretCommentCheck(obj, seq){

		if (obj.password.value.replace(/\s/g, "").length == 0) {
			alert(arApplMsg['isnull_password']);
			obj.password.focus();
			return false;
		}

		$(obj).ajaxSubmit({
		success: function(responseText){
			switch(responseText){
				case "ERROR" :
					alert(arApplMsg['invalid_password']);
					return false;
					break;
				case "SUCCESS" :
					$("#extForm").attr("method","get");
					$("#extForm").append($(document.createElement("input")).attr("type","hidden").attr("id","comment_page").attr("name","comment_page").attr("value",set_comment_default.page));
					$("#extForm").submit();
					break;
			}
		}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=boardpassword&board_srl=' + set_bbs_default.srl + '&board_seq=' + $("#extForm #seq").val() + '&comment_seq=' + seq});
		return false;
	}