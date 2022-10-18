
	$(document).ready(function() {

		$("#content select").msDropDown();

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
						$("#theForm").attr("action","?act=memberdeniedid");
						$("#theForm").submit();
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=memberdeniedid&Act=memberdeniedidremove'
				});
			}
		});

		$("#btn_deniedid_add").click(function(){
			$.ajax({type: "POST", url: "action/?subAct=memberdeniedidadd&act=deniedidadd",
				success: function(responseText){
					$("#memberdeniedIdAddBody").html(responseText);
					$("#userid").focus();
				 },
				 error: function(response){
					 alert('error\n\n' + response.responseText);
					 return false;
				 }
			});
		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=memberdeniedid&intPage=" + page);
		$("#theForm").submit();
	}