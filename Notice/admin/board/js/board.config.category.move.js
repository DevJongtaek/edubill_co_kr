
	$(document).ready(function() {

		$("select").msDropDown();

		if ($("#moveForm #intDocumentCode").val() == "0"){
			alert(arApplMsg["is_null_move_document"]);
			CategoryDetail($("#moveForm #intCode").val());
		}

		$("#moveForm").submit(function() {

			if (confirm(arApplMsg["confirm_move_Category"])){

				$(this).ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href.replace("&", "--**--");
							return false;
						}
						
						alert(arApplMsg["success_moved"]);
						$("#frameCategoryList").attr("src", "?Act=boardconfigcategorytree&intSrl=" + $("#intSrl").val());
						CategoryDetail($("#moveForm #intCode").val());
						
					}, 
					error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});

			}

			return false;

    });

	});