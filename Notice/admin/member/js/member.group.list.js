	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_group_add").click(function(){
			$("#theForm").attr("action","?act=membergroupadd");
			$("#theForm").submit();
		});

		$("a[name=btn_modify]").click(function() {
			$("#theForm").attr("action","?act=membergroupmodify&strGroupCode=" + $(this).attr("id"));
			$("#theForm").submit();
    });
		
		$("a[name=btn_delete]").click(function() {

			if ($(this)[0].member != "0"){
				alert(arApplMsg["exists_members"].replace("<br>", "\n"));return false;
			}

			if (confirm(arApplMsg["confirm_delete"])){

				var code = $(this).attr("id");

				$.ajax({type: "POST", url: "action/?subAct=membergroup&Act=groupremove", data: "strGroupCode=" + code, 
					success: function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
						}
						document.location.href = "?act=membergroup";
						return false;
					 },
					 error: function(response){
						 alert('error\n\n' + response.responseText);
					 }
				});
			}

		});

		$("#btn_select_move").click(function(){

			if ($("#theForm input:checked").length == 0){alert(arApplMsg["select_group"]);return;}
	
			if ($("#strMoveGroup").val() == ""){alert(arApplMsg["select_move_group"]);return;}
	
			if (confirm(arApplMsg["confirm_move"])){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						$("#theForm").attr("action","?act=membergroup");
						$("#theForm").submit();
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=membergroup&act=groupmove'
				});
			}
		});

	});