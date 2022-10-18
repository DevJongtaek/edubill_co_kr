
	var dbCateCode = "C000000001";

	$(document).ready(function() {

		$("#theForm").submit(function() {

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_title"]);$("#strTitle").focus();return false;
			}

			var _validator = new Trex.Validator();
			var _content = Editor.getContent();
			if(!_validator.exists(_content)) {
				alert(arApplMsg["is_null_content"]);Editor.focus();
				return false;
			}
			$("#strContent").val(_content);

			$(this).ajaxSubmit({
				success:function(responseText){
					switch (responseText){
						case "SW" : alert(arApplMsg["success_saved"]);break;
						case "SE" : alert(arApplMsg["success_updated"]);break;
						case "ERROR" : document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}

					$("#extForm").attr("action","?act=boarddocument&intPage=" + $("#intPage").val());
					$("#extForm").submit();
		
				}, 
				error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
			return false;

    });

	});