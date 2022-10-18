
	$(document).ready(function() {

		$("#strFormType").msDropDown();
		$(".integer").numeric();
		$("input:checkbox").checkbox();
		$("input:radio").checkbox({cls:"jquery-radio"});

		if ($("#strFieldName").val() == "strSex" || $("#strFieldName").val() == "bitMailing" || $("#strFieldName").val() == "bitOpenInfo" || $("#strFieldName").val() == "bitMemo"){
			$("#strFormData").prop("disabled", true);
		}

		if ($("#strFieldName").val() == "strLoginID" || $("#strFieldName").val() == "strUserName" || $("#strFieldName").val() == "strEmail" || $("#strFieldName").val() == "strNickName" || $("#strFieldName").val() == "strSex" || $("#strFieldName").val() == "strPassword" || $("#strFieldName").val() == "strCorpNum" || $("#strFieldName").val() == "strCorpName" || $("#strFieldName").val() == "strCorpJob1" || $("#strFieldName").val() == "strCorpJob2" || $("#strFieldName").val() == "strCorpAddr"){
			$("#bitUse1").prop("disabled", true);
			$("#bitUse2").prop("disabled", true);
			$("#bitRquired1").prop("disabled", true);
			$("#bitRquired2").prop("disabled", true);
		}

		MemberForm.FormType();

		$("#theForm").submit(function() {

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_title"]);$("#strTitle").focus();return false;
			}

			if ($("#strFormType").val() == "radio" || $("#strFormType").val() == "select" || $("#strFormType").val() == "checkbox"){
				if ($("#strFieldName").val() != "strCountry"){
					if ($("#strFormData").val().replace(/\s/g, "").length == 0) {
						alert(arApplMsg["is_null_option"]);$("#strFormData").focus();return false;
					}
				}
			}

			if ($("#strAlertMsg").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_option"]);$("#strAlertMsg").focus();return false;
			}

			if ($("#strFormType").val() == "text" || $("#strFormType").val() == "email" || $("#strFormType").val() == "url" || $("#strFormType").val() == "userid" || $("#strFormType").val() == "textarea" || $("#strFormType").val() == "password" || $("#strFormType").val() == "sign"){
				if ($("#intWidth").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["is_null_width"]);$("#intWidth").focus();return false;
				}
			}

			$("#strFormData, #bitUse1, #bitUse2, #bitRquired1, #bitRquired2").removeProp("disabled");

			if ($("#theForm #strFieldName").val() != "strLoginID" && $("#theForm #strFieldName").val() != "strUserName" && $("#theForm #strFieldName").val() != "strEmail" && $("#theForm #strFieldName").val() != "strNickName" && $("#theForm #strFieldName").val() != "strSex" && $("#theForm #strFieldName").val() != "strPassword" && $("#theForm #strFieldName").val() != "strCorpNum" && $("#theForm #strFieldName").val() != "strCorpName" && $("#theForm #strFieldName").val() != "strCorpJob1" && $("#theForm #strFieldName").val() != "strCorpJob2" && $("#theForm #strFieldName").val() != "strCorpAddr"){

				switch ($("input[name=bitUse]:checked").val()){
					case "1" :
						$("#menu_container #" + $("#theForm #strFieldName").val() + " div").removeClass("point3");
						$("#menu_container #" + $("#theForm #strFieldName").val() + " div").addClass("point2");
						break;
					case "0" :
						$("#menu_container #" + $("#theForm #strFieldName").val() + " div").removeClass("point2");
						$("#menu_container #" + $("#theForm #strFieldName").val() + " div").addClass("point3");
						break;
				}
	
				switch ($("input[name=bitRquired]:checked").val()){
					case "1" : $("#menu_container #" + $("#theForm #strFieldName").val() + " div").addClass("b"); break;
					case "0" : $("#menu_container #" + $("#theForm #strFieldName").val() + " div").removeClass("b"); break;
				}

			}

			$(this).ajaxSubmit({
				success:function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}

					alert(arApplMsg["success_updated"]);
				}, 
				error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
			return false;

    });

	});