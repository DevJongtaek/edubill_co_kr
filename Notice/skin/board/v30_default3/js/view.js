
	$(document).ready(function() {

		$.ajax({type: "POST", url: "action/?Act=boardfilelist", data: "board_srl=" + set_bbs_default.srl + "&board_seq=" + $("#extForm #seq").val() + "&comment_seq=0&list_type=B&image=0", dataType: "json", success: function(responseText){

			if (responseText.length > 0){
				$(".read_footer .file_list a span").html(responseText.length);

					for(var i = 0; i < responseText.length; i++){
						if (responseText[i].downlevel == "0"){
							$(".read_footer .files").append("<li><a href=\"#file\" onClirk=\"return false;\">" + responseText[i].filename + " <span>(" + responseText[i].filesize1 + " / Download : " + responseText[i].filedown + ")</span></a> </li>");
						}else{
							$(".read_footer .files").append("<li><a href=\"?Act=bbs&subAct=filedown&bid=" + $("#extForm #bid").val() + "&seq=" + $("#extForm #seq").val() + "&file_seq=" +responseText[i].seq + "\" class=\"AFFileName attach_ext_" + responseText[i].fileext + "\">" + responseText[i].filename + " <span>(" + responseText[i].filesize1 + " / Download : " + responseText[i].filedown + ")</span></a></li>");
						}
					}
					
			}else{
				$(".read_footer .file_list").hide();
			}

		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

		$(".read_footer .toggle_file").toggle(
			function () {
				$(".read_footer .files").show();
			},
			function () {
				$(".read_footer .files").hide();
			}
		);

	});