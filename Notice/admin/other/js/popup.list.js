
	$(document).ready(function() {

		$("#intPageSize").msDropDown();

		$("#btn_popup_add").click(function(){
			$("#theForm").attr("action","?act=popupadd&intPage=" + $("#intPage").val());
			$("#theForm").submit();
		});

		$("a[name=btn_modify]").bind("click",function() { 
			$("#theForm").attr("action","?act=popupmodify&intSeq=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
			$("#theForm").submit();
    }); 

		$("#btn_remove").click(function(){

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
							$("#theForm").attr("action","?act=popup");$("#theForm").submit();
						}
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=popup&Act=popupremove'
				});
			}

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=popup&intPage=" + page);
		$("#theForm").submit();
	}