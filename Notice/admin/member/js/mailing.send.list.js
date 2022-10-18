
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_mailing_add").click(function(){
			$("#theForm").attr("action","?act=mailingsendadd&intPage=" + $("#intPage").val());
			$("#theForm").submit();
		});

		$("a[name=btn_modify]").bind("click",function() { 
			$("#theForm").attr("action","?act=mailingsendedit&strCode=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
			$("#theForm").submit();
    }); 

		$("a[name=btn_member_set]").bind("click",function() { 
			$("#theForm").attr("action","?act=mailingsendmember&strCode=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
			$("#theForm").submit();
    }); 

		$("a[name=btn_send_mail]").bind("click",function() { 
			$("#theForm").attr("action","?act=mailingsend&strCode=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
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
						$("#theForm").attr("action","?act=mailingsendlist");$("#theForm").submit();
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=mailingsend&Act=mailingremove'
				});
			}

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=mailingsendlist&intPage=" + page);
		$("#theForm").submit();
	}
