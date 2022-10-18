
	$(document).ready(function() {

		$("#intPageSize").msDropDown();

		$("#checkall").click(function(){
			if ($(this)[0].cid == "n" || $(this)[0].cid == null){
				$('#theForm input[type=checkbox]').attr("checked", "checked");
				$(this)[0].cid = "y";
			}else{
				$('#theForm input[type=checkbox]').attr("checked", "");
				$(this)[0].cid = "n";
			}
			return false;
		});

		$("#btn_layout_add").click(function(){
			$("#theForm").attr("action","?act=layoutadd&intPage=" + $("#intPage").val());
			$("#theForm").submit();
		});

		$("a[name=btn_modify]").bind("click",function() { 
			$("#theForm").attr("action","?act=layoutedit&strLayoutCode=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
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
							$("#theForm").attr("action","?act=layout");$("#theForm").submit();
						}
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=layout&Act=layoutremove'
				});
			}

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=layout&intPage=" + page);
		$("#theForm").submit();
	}