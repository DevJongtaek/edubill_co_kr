
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_board_document_add").click(function(){
			document.location.href = "?act=boarddocumentadd";
			return false;
		});

		$("a[name=btn_modify]").bind("click",function() { 
			$("#theForm").attr("action","?act=boarddocumentmodify&strDocCode=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
			$("#theForm").submit();
    }); 

		$("a[name=btn_remove]").bind("click",function() { 

			if ($("#theForm input:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete"])){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}else{
							$("#theForm").attr("action","?act=boarddocument");
							$("#theForm").submit();
						}
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=boarddocument&Act=boarddocumentremove'
				});
			}

    }); 

	});

	function goPage(page){
		$("#theForm").attr("action","?act=boarddocument&intPage=" + page);
		$("#theForm").submit();
	}