
	$(document).ready(function() {

		$(".tx-canvas iframe").css("height", "400px");

		$("textarea.resizable:not(.processed)").TextAreaResizer();

		if ($("#strContentType1").is(':checked')){
			$("#contentHtml").hide();
		}else{
			$("#contentEditor").hide();
		}

		$("input[name=strContentType]").click(function() {
			if ($(this).val() == "1"){
				$("#contentEditor").show();
				$("#contentHtml").hide();
			}else{
				$("#contentEditor").hide();
				$("#contentHtml").show();
			}
		});

		if ($("#strPosition11").is(':checked')){
			$("#position_set2").hide();
		}else{
			$("#position_set1").hide();
		}

		$("input[name=strPosition1]").click(function() {
			if ($(this).val() == "1"){
				$("#position_set1").show();
				$("#position_set2").hide();
			}else{
				$("#position_set1").hide();
				$("#position_set2").show();
			}
		});

		$("#theForm").submit(function() {

			if ($("#strContentType1").is(':checked')){
				if ($("#strPosition2").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["is_null_x"]);$("#strPosition2").focus();return false;
				}
				if ($("#strPosition3").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["is_null_y"]);$("#strPosition3").focus();return false;
				}
			}

			if ($("#intWidth").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_width"]);$("#intWidth").focus();return false;
			}

			if ($("#intHeight").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_height"]);$("#intHeight").focus();return false;
			}

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_title"]);$("#strTitle").focus();return false;
			}

			if ($("#strContentType1").is(':checked')){
				var _validator = new Trex.Validator();
				var _content = Editor.getContent();
				if(!_validator.exists(_content)) {
					alert(arApplMsg["is_null_content"]);Editor.focus();
					return false;
				}
				$("#strContent").val(_content);
			}else{
				if ($("#strContentHtml").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["is_null_content"]);$("#strContentHtml").focus();return false;
				}
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href; return false;
					}else{
						switch (responseText){
							case "SW" : alert(arApplMsg["success_saved"]); break;
							case "SE" : alert(arApplMsg["success_updated"]); break;
						}						
						$("#extForm").attr("action","?act=popup&intPage=" + $("#intPage").val());
						$("#extForm").submit();
					}
				}, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post'
			});
			
			return false;

    });

		$("#btn_cancel").click(function(){
			$("#extForm").attr("action","?act=popup&intPage=" + $("#intPage").val());
			$("#extForm").submit();
		});

	});