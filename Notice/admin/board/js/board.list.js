
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_board_add").click(function(){
			document.location.href = "?act=boardmake";
			return false;
		});

		$("a[name=btn_config]").bind("click",function() { 
			$("#theForm").attr("action","?act=boardconfigdefault&intSrl=" + $(this).attr("id") + "&intPage=" + $("#intPage").val());
			$("#theForm").submit();
    }); 

		$("a[name=btn_remove]").bind("click",function() { 
			if (confirm(arApplMsg["confirm_delete"].replace("<br>","\n"))){
				$.ajax({ 
					type: "post", url: "action/?subAct=boardremove", data : "intSrl=" + $(this).attr("id"), 
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
						}
						$("#theForm").submit();
					}, error:function(response){alert('error\n\n' + response.responseText);}
				});
			}
    }); 

	});

	function goPage(page){
		$("#theForm").attr("action","?act=boardlist&intPage=" + page);
		$("#theForm").submit();
	}