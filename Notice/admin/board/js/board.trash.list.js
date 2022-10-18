
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_restore").click(function(){
			
			if ($("#theForm input[id=intSeq]:checked").length == 0){
				alert(arApplMsg["select_not_document"]);return false;
			}

			if (confirm(arApplMsg["confirm_board_restore"])){

				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}else{
							$("#theForm").attr("action","?act=boardtrash");
							$("#theForm").submit();
						}
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?Act=restore&subAct=boardtrash'
				});
				
			}

		});

		$("#btn_remove").click(function(){

			if ($("#theForm input[id=intSeq]:checked").length == 0){
				alert(arApplMsg["select_not_document"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete_completely"])){

				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}else{
							$("#theForm").attr("action","?act=boardtrash");
							$("#theForm").submit();
						}
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?Act=remove&subAct=boardtrash'
				});
				
			}

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=boardtrash&intPage=" + page);
		$("#theForm").submit();
	}

	function dispContent(seq){
		$("#" + seq).toggle();
	}