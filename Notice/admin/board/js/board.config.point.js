
	$(document).ready(function() {

		$("#confBoard").msDropDown();

		$("#theForm").submit(function() {

			if ($("#strReadPoint").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_point_memo"]);$("#strReadPoint").focus();return false;
			}

			if ($("#strWritePoint").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_point_memo"]);$("#strWritePoint").focus();return false;
			}

			if ($("#strCmtWritePoint").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_point_memo"]);$("#strCmtWritePoint").focus();return false;
			}

			if ($("#strUploadPoint").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_point_memo"]);$("#strUploadPoint").focus();return false;
			}

			if ($("#strDownPoint").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_point_memo"]);$("#strDownPoint").focus();return false;
			}

			if ($("#strVotePoint").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_point_memo"]);$("#strVotePoint").focus();return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href.replace("&", "--**--");
						return false;
					}
					alert(arApplMsg["success_saved"]);
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?subAct=boardconfigpoint&intSrl=' + $("#intSrl").val()});
			return false;

    });

	});