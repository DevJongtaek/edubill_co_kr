
	$(document).ready(function() {

		$("#intPageSize, #strCateCode").msDropDown();

		$('#btn_page_Add').click(function(){
			$("#theForm").attr("action","?act=pageadd&intPage=" + $("#intPage").val());
			$("#theForm").submit();
		});

		$("a[name=btn_modify]").bind("click",function() { 
			$("#theForm").attr("action","?act=pageedit&strPid=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
			$("#theForm").submit();
    }); 

		$('#btn_remove').click(function(){

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
							$("#theForm").attr("action","?act=page");$("#theForm").submit();
						}
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=page&Act=pageremove'
				});
			}

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=page&intPage=" + page);
		$("#theForm").submit();
	}