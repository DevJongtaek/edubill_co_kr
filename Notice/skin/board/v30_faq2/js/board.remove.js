
	$(document).ready(function() {

		$("#theForm #btn_remove").click(function(){
			$("#removeForm").ajaxSubmit({
				success: function(responseText){
					switch (responseText){
						case "ERROR01" : alert(arApplMsg['error']); break; return false;
						case "SUCCESS" :
							$("#extForm").attr("method", "get");
							$("#extForm #subAct").val("list");
							$("#extForm #seq").val("");
							$("#extForm").submit();
							break;
					}
				}, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=boardremove&board_srl=' + set_bbs_default.srl + '&board_seq=' + $("#extForm #seq").val()
			});

		});

	});