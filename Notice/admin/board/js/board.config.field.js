
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_field_add").click(function(){
			$("#theForm").attr("action","?act=boardconfigfieldadd&intSrl=" + $("#confBoard").val());
			$("#theForm").submit();
		});

		$("a[name=btn_modify]").bind("click",function() { 
			$("#theForm").attr("action","?act=boardconfigfieldmodify&strFieldRecord=" + $(this).attr("id") + "&intSrl=" + $("#confBoard").val());
			$("#theForm").submit();
    }); 

		$("a[name=btn_move_up], a[name=btn_move_down]").click(function() {
																																	 
			switch ($(this)[0].name){
				case "btn_move_up" : var url = "action/?subAct=boardconfigfield&Act=moveup"; break;
				case "btn_move_down" : var url = "action/?subAct=boardconfigfield&Act=movedown"; break;
			}

			$.ajax({ 
				type: "post", url: url, data : "intSrl=" + $("#confBoard").val() + "&strFieldRecord=" + $(this).attr("id"), 
				success:function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}
					$("#theForm").attr("action","?act=boardconfigfield&intSrl=" + $("#confBoard").val());
					$("#theForm").submit();
					return false;
				}, error:function(response){alert('error\n\n' + response.responseText);}
			});

		});

		$("#btn_remove").click(function(){

			if ($("#theForm input:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete_field"].replace("<br>", "\n"))){
	
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						$("#theForm").attr("action","?act=boardconfigfield&intSrl=" + $("#confBoard").val());
						$("#theForm").submit();
						return false;
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=boardconfigfield&Act=remove&intSrl=' + $("#confBoard").val()
				});
			}
		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=page&intPage=" + page);
		$("#theForm").submit();
	}