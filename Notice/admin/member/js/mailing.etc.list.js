
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_mailinfo_add").click(function() {
			$("#theForm").attr("action","?act=mailingetcadd&intPage=" + $("#intPage").val());
			$("#theForm").submit();
		});

		$("a[name=btn_modify]").click(function() {
			$("#theForm").attr("action","?act=mailingetcedit&intSeq=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
			$("#theForm").submit();
    }); 

		$("#btn_search").click(function(){

			if ($("#searchText").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_search_keyword"]);$("#searchText").focus();return false;
			}
			if (!checkStringLength($("#searchText").val(), 3)){
				alert(arApplMsg["invalid_search_keyword"]);$("#searchText").focus();return false;
			}

			$("#theForm").attr("action","?act=mailingetclist");
			$("#theForm").submit();

		});

		$("#btn_cancel").click(function(){
			$("#theForm").attr("action","?act=mailingetclist");
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
						$("#theForm").attr("action","?act=mailingetclist");$("#theForm").submit();
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=mailingetc&Act=mailingetcremove'
				});
			}

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=mailingetclist&intPage=" + page);
		$("#theForm").submit();
	}
