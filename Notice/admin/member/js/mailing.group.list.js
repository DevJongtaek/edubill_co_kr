
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_mailing_group_add").click(function(){
			$("#theForm").attr("action","?act=mailinggroupadd&intPage=" + $("#intPage").val());
			$("#theForm").submit();
		});

		$("a[name=btn_modify]").click(function(){
			$("#theForm").attr("action","?act=mailinggroupedit&strGroupCode=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
			$("#theForm").submit();
    }); 

		$("a[name=btn_set]").click(function(){
			$("#theForm").attr("action","?act=mailinggroupmember&strGroupCode=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
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
						}
						$("#theForm").attr("action","?act=mailinggrouplist");$("#theForm").submit();
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=mailinggroup&Act=mailinggroupremove'
				});
			}

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=mailinggrouplist&intPage=" + page);
		$("#theForm").submit();
	}
