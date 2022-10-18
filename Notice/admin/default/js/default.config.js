
	$(document).ready(function() {

		$("#CONF_strUploadComponet, #CONF_strLangType, #CONF_strUseSSL").msDropDown();

		$("#theForm").submit(function() {

			if ($("#CONF_strSiteUrl").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_default_url"]);$("#CONF_strSiteUrl").focus();return false;
			}
			
			if ($("#CONF_strBbsUrl").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_board_url"]);$("#CONF_strBbsUrl").focus();return false;
			}

			if ($("#CONF_strFilePath").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_file_path"]);$("#CONF_strFilePath").focus();return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;
						return false;
					}else{
						alert(arApplMsg["success_saved"]);
					}
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?subAct=defaultconfig'});
			return false;

    });
	});