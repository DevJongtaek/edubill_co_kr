
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("a[name=btn_modify]").bind("click",function() { 
			$("#theForm").attr("action","?act=memberdocedit&strDocCode=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
			$("#theForm").submit();
    }); 

		$("#btn_document_add").click(function(){
			$("#theForm").attr("action","?act=memberdocadd&intPage=" + $("#intPage").val());
			$("#theForm").submit();
		});

		$("#btnRemoveSelect").click(function(){
			if ($("#theForm input:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return;
			}
			if (confirm(arApplMsg["confirm_delete"])){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "E"){
							alert(arApplMsg["least_one_document"]);return false;
						}else{
							$("#theForm").attr("action","?act=memberdoc");
							$("#theForm").submit();
						}
					}, 
					error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url:'action/?subAct=memberdoc&Act=memberdocremove'
				});
			}
		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=memberdoc&intPage=" + page);
		$("#theForm").submit();
	}