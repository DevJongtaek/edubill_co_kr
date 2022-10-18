
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_level_add").click(function(){

			if ($("#intAddLevel").val() == ""){
				alert(arApplMsg["is_null_add_level"]);$("#intAddLevel").focus();return false;
			}

			if (confirm(arApplMsg["confirm_level_add"])){
				$.ajax({ 
					type: "post", url: "action/?subAct=memberlevel&Act=leveladd", data : "intAddLevel=" +$("#intAddLevel").val(), 
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
						}
						$("#theForm").attr("action","?act=memberlevel");
						$("#theForm").submit();
					}, error:function(response){alert('error\n\n' + response.responseText);}
				});
			}

		});

		$("#btn_remove").click(function(){

			if ($("#theForm input:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete"].replace("<br>", "\n").replace("<br>", "\n"))){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						$("#theForm").attr("action","?act=memberlevel");
						$("#theForm").submit();
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=memberlevel&Act=levelremove'
				});
			}

		});

		$("#btn_modify").click(function(){

			if ($("#theForm input:checked").length == 0){
				alert(arApplMsg["select_modify_level"]);return false;
			}

			if (confirm(arApplMsg["confirm_modify"])){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						$("#theForm").attr("action","?act=memberlevel");
						$("#theForm").submit();
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=memberlevel&Act=levelmodify'
				});
			}

		});

		$("#btn_apply").click(function(){

			var point = $("#applyPoint").val();
			if (point == "0" || point.length == 0){
				alert(arApplMsg["is_null_point"]);$("#applyPoint").focus();return false;
			}

			$("input[name='intPoint']").each(function(i){
				$(this).val((i+1)*(i+1)*$("#applyPoint").val());
			});

		});

	});