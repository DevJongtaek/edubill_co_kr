
	$(document).ready(function() {

		$("select").msDropDown();

		if ($("#strReadLevel").val() == "2"){$("#strReadGroupDiv").show();}else{$("#strReadGroupDiv").hide();}
		if ($("#strWriteLevel").val() == "2"){$("#strWriteGroupDiv").show();}else{$("#strWriteGroupDiv").hide();}

		$("#theForm").submit(function() {

			if ($("#strFieldName").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_item"]);$("#strFieldName").focus();return false;
			}

			if ($("#strFieldType").val() == "checkbox" || $("#strFieldType").val() == "radio" || $("#strFieldType").val() == "select"){
				if ($("#strDefaultValue").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["is_null_default"]);$("#strDefaultValue").focus();return false;
				}
			}

			if ($("#strReadLevel").val() == "2" && $("#strReadGroupDiv input:checked").length == 0){
				alert(arApplMsg["select_not_read_group"]);return false;
			}

			if ($("#strWriteLevel").val() == "2" && $("#strWriteGroupDiv input:checked").length == 0){
				alert(arApplMsg["select_not_write_group"]);return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){

					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href.replace("&", "--**--");
						return false;
					}

					switch (responseText){
						case "SW" : alert(arApplMsg["success_saved"]); break;
						case "SE" : alert(arApplMsg["success_updated"]); break;
					}

					$("#extForm").attr("action","?act=boardconfigfield&intSrl=" + $("#intSrl").val());
					$("#extForm").submit();
					
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=' + $("#Act").val() + '&subAct=boardconfigfield&intSrl=' + $("#intSrl").val()});
			return false;

    });

	});

	function dispAccGroup(data, form){
		if (data.value == "2")
			$("#" + form).show();
		else
			$("#" + form).hide();
	}