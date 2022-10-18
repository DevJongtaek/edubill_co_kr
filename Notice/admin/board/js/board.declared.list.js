
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_manage").click(function(){
			if ($("#theForm input[id=intSeq]:checked").length == 0){
				alert(arApplMsg["select_not_document"]);return false;
			}

			var seq = "";

			$("#theForm input[id=intSeq]:checked").each(function(){
				if (seq != "")
					seq += ",";
				seq += $(this).val();
			});

			openWindows("?Act=boardmanage&seq=" + seq,"boardmanage", 520, 340,3);

		});

		$("#btn_declared_cancel").click(function(){
			if ($("#theForm input[id=intSeq]:checked").length == 0){
				alert(arApplMsg["select_not_document"]);return false;
			}

			if (confirm(arApplMsg["confirm_cancel_board_declared"])){

				var seq = "";

				$("#theForm input[id=intSeq]").each(function(n){
					if ($(this).prop('checked') == true){
						if (seq != "")
							seq += ",";
						seq += $(this).attr("class").split("_")[1];
					}
				});

				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}else{
							$("#theForm").attr("action","?act=boarddeclared");
							$("#theForm").submit();
						}
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=boarddeclared&seq=' + seq
				});
			}

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=boarddeclared&intPage=" + page);
		$("#theForm").submit();
	}