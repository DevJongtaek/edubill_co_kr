
	$(document).ready(function() {

		$(".tx-canvas iframe").css("height", "400px");

		$("input[name=bitUseEditor]:checked").each(function() {
			switch ($(this).val()){
				case "1" : $("#inputMode1").show();$("#inputMode2").hide();break;
				case "0" : $("#inputMode1").hide();$("#inputMode2").show();break;
			}
		});

		$("input[name=bitUseEditor]").bind("click",function() {
			switch ($(this).val()){
				case "1" : $("#inputMode1").show();$("#inputMode2").hide();break;
				case "0" : $("#inputMode1").hide();$("#inputMode2").show();break;
			}
    });

		$("#theForm").submit(function() {

			if ($("#strName").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_send_name"]);$("#strName").focus();return false;
			}

			if ($("#strEmail").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_send_email"]);$("#strEmail").focus();return false;
			}

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_title"]);$("#strTitle").focus();return false;
			}

			if ($("#bitUseEditor1").is(':checked')){

				var _validator = new Trex.Validator();
				var _content = Editor.getContent();
				if(!_validator.exists(_content)) {
					alert(arApplMsg["is_null_content"]);Editor.focus();	return false;
				}
				$("#strContent").val(_content);

			}

			if ($("#bitUseEditor2").is(':checked')){
				if ($("#strContentHtml").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["is_null_content"]);$("#strContentHtml").focus();return false;
				}
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
					$("#extForm").attr("action","?act=mailingsendlist&intPage=" + $("#intPage").val());
					$("#extForm").submit();

			 }, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
			
			return false;

    });

		$("#btn_save").click(function(){
			$("#theForm").submit();
		});

		$("#btn_cancel").click(function(){
			$("#extForm").attr("action","?act=mailingsendlist&intPage=" + $("#intPage").val());
			$("#extForm").submit();
		});

	});
