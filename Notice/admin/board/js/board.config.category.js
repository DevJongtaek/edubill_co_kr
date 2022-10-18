
	$(document).ready(function() {

		$("#confBoard").msDropDown();

		$("#theForm").submit(function() {

			$(this).ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;
						return false;
					}
					alert(arApplMsg["success_updated"]);
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?subAct=boardconfigcategory&Act=config&intSrl=' + $("#intSrl").val()});
			return false;

    });

	});

	function CategoryDetail(node){

		$("#notice_default", parent.document).hide();

		$.ajax({type: "POST", url: "action/?subAct=boardcategorydetail", data: "intSrl=" + $("#intSrl").val() + "&intCode=" + node, dataType: "html", success: function(responseText){
			if (responseText == "ERROR"){
				document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
			}
				$("#detail_table").html(responseText);
			},
			error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

	}

	function CategoryDocumentMove(node){

		$("#notice_default", parent.document).hide();

		$.ajax({type: "POST", url: "action/?subAct=boardcategorymove", data: "intSrl=" + $("#intSrl").val() + "&intCode=" + node, dataType: "html", success: function(responseText){
			if (responseText == "ERROR"){
				document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
			}
			$("#detail_table").html(responseText);
			},
			error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

	}