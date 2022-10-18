
	$(document).ready(function() {

		$.ajax({type: "POST", url: "action/?Act=boardfilelist", data: "board_srl=" + set_bbs_default.srl + "&board_seq=" + $("#extForm #seq").val() + "&comment_seq=0&list_type=B&image=0", dataType: "json", success: function(responseText){

			if (responseText.length > 0){
				$("#attachCountDisp").html(responseText.length);
					for(var i = 0; i < responseText.length; i++){
						if (responseText[i].downlevel == "0"){
							$("#attachFileList").append("<li><a class=\"attach_ext_doc AFFileName\">" + responseText[i].filename + " (" + responseText[i].filesize1 + " / Download : " + responseText[i].filedown + ")</a> <a class=\"txt_sub p11\">다운로드</a></li>");
						}else{
							$("#attachFileList").append("<li><a href=\"?Act=bbs&subAct=filedown&bid=" + $("#extForm #bid").val() + "&seq=" + $("#extForm #seq").val() + "&file_seq=" +responseText[i].seq + "\" class=\"AFFileName attach_ext_doc\">" + responseText[i].filename + " (" + responseText[i].filesize1 + " / Download : " + responseText[i].filedown + ")</a> <a href=\"?Act=bbs&subAct=filedown&bid=" + $("#extForm #bid").val() + "&seq=" + $("#extForm #seq").val() + "&file_seq=" +responseText[i].seq + "\" class=\"txt_sub p11\">다운로드</a></li>");
						}
					}
					
			}else{
				$("#attachFile").addClass("none");
			}

		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

		$("#link_attachFile").click(function(){
			$("#attachFileList").toggle();
		});

	});