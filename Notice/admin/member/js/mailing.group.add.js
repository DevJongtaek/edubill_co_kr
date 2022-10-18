
	$(document).ready(function() {

		$("#theForm").submit(function() {

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_title"]);$("#strTitle").focus();return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					var msg = "";
			
					switch (responseText){
						case "SW" : msg = arApplMsg["success_saved"]; break;
						case "SE" : msg = arApplMsg["success_updated"]; break;
						case "ERROR" : document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}
			
					alert(msg);
					$("#extForm").attr("action","?act=mailinggrouplist&intPage=" + $("#intPage").val());
					$("#extForm").submit();

			 }, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
			
			return false;

    });

		$("#btn_cancel").click(function(){
			$("#extForm").attr("action","?act=mailinggrouplist&intPage=" + $("#intPage").val());
			$("#extForm").submit();
		});

	});
