
	$(document).ready(function() {

		$("#btn_cancel").click(function(){
			$("#memberdeniedIdAddBody").empty();
		});

		$("#theAddForm").submit(function() {

			if ($("#strUserID").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_id"]);$("#strUserID").focus();return false;
			}

			if (!chkEngNumber($("#strUserID").val())){
				alert(arApplMsg["invalid_id"]);$("#strUserID").focus();return false;
			}

			$(this).ajaxSubmit({
				success:function(responseText){
						switch (responseText){
						case "SW" : alert(arApplMsg["success_saved"]);$("#theForm").submit();break;
						case "E1" : alert(arApplMsg["exists_id"]);$("#strUserID").focus();return false;break;
						case "ERROR" : document.location.href = "?act=login&strPrevUrl=" + location.href;return false;break;
					}
				}, 
				error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
			return false;

    });

	});