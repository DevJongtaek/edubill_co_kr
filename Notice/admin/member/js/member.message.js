
	$(document).ready(function() {

		$(".tx-canvas iframe").css("height", "300px");

		$("#theForm").submit(function() {

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_title"]);$("#strTitle").focus();return false;
			}

			if ($("#theForm input:checked").length == 0){
				alert(arApplMsg["is_null_group"]);return false;
			}

			var _validator = new Trex.Validator();
			var _content = Editor.getContent();
			if(!_validator.exists(_content)) {
				alert(arApplMsg["is_null_content"]);Editor.focus();
				return false;
			}
			$("#strContent").val(_content);

			if (confirm(arApplMsg["confirm_send"])){

				$(this).ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
						}else{
							alert(arApplMsg["success_send"]);
						}
					}, 
					error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
				return false;

			}

    });
	});