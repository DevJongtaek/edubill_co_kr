
	$(document).ready(function() {

		$("#strLayoutCode, #strLinkTarget, #strSkinName, #strSkinLang").msDropDown();

		Skin.ColorSet($("#strSkinName").val());

		$("#btn_preview").click(function(){
			window.open("../?act=search");
		});

		if ($("input[name=bitSearchBoardTotal]:checked").val() == "1")
			$("#boardSelectList").hide();
		else
			$("#boardSelectList").show();

		$("input[name=bitSearchBoardTotal]").click(function(){
			if ($(this).val() == "1")
				$("#boardSelectList").hide();
			else
				$("#boardSelectList").show();
		});

		$("#menuRemove").click(function(){
			$("#strSearchBoard").find("option:selected").each(function(){
				$("#strBoardList").append("<option value='" + $(this).val() + "'>" + $(this).text() + "</option>");
				$(this).remove();
			});
		});

		$("#menuAdd").click(function(){
			$("#strBoardList").find("option:selected").each(function(){
				$("#strSearchBoard").append("<option value='" + $(this).val() + "'>" + $(this).text() + "</option>");
				$(this).remove();
			});
		});

		$("#theForm").submit(function(){

			if ($("#strBrowserTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_browser_msg"]);$("#strBrowserTitle").focus();return false;
			}

			if ($("input[name=bitSearchDocument]:checked").length == "0" && $("input[name=bitSearchComment]:checked").length == "0" && $("input[name=bitSearchImage]:checked").length == "0" && $("input[name=bitSearchFile]:checked").length == "0"){
				alert(arApplMsg["is_null_search_item"]);return false;
			}

			if ($("input[name=bitSearchBoardTotal]:checked").val() == "0"){
				if ($("#strSearchBoard").find("option").length == "0"){
					alert(arApplMsg["is_null_search_board"]);$("#strBoardList option:eq(0)").prop("selected", true);return false;
				}
			}

			$("#strSearchBoard").find("option").each(function(){
				$(this).prop("selected", true);
			});

			if ($("#intCutTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_cut_title"]);$("#intCutTitle").focus();return false;
			}

			if ($("#intCutContent").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_cut_content"]);$("#intCutContent").focus();return false;
			}

			if ($("#intImageWidth").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_image_width"]);$("#intImageWidth").focus();return false;
			}

			if ($("#intImageHeight").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_image_height"]);$("#intImageHeight").focus();return false;
			}

			if ($("#intDefaultListCount").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_default_count"]);$("#intDefaultListCount").focus();return false;
			}

			if ($("#intListCount").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_count"]);$("#intListCount").focus();return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href.replace("&", "--**--");
						return false;
					}
					alert(arApplMsg["success_saved"]);
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?subAct=searchconfig'});
			return false;

		});

	});
	
	var Skin = function() {}

	Skin.ColorSet = function(fn) {
		$.ajax({type: "POST", url: "action/?subAct=colorset", data: "skin=search&folder=" + fn, 
			success: function(responseText){
				$("#skinColorSet").html(responseText);
			 },
			 error: function(response){
				 alert('error\n\n' + response.responseText);
				 return false;
			 }
		});
	}

	Skin.LangSet = function(fn) {
		$.ajax({ 
			type: "GET", url: "../skin/search/" + fn + "/skin.xml", dataType: "xml",
			complete: function(data) { 
				var json = $.xmlToJSON(data.responseXML);
				
				for(i = document.getElementById('strSkinLang').options.length;i>-0;i--){
					document.getElementById('strSkinLang').options[i] = null;
				}
				if(document.getElementById('strSkinLang').refresh!=undefined)
					document.getElementById('strSkinLang').refresh();

				for(var i = 0; i < json.languages[0].title.length; i++) {
					document.getElementById('strSkinLang').options[i] = new Option(json.languages[0].title[i].Text, json.languages[0].title[i].lang);
					document.getElementById('strSkinLang').selectedIndex = 0;

				} 

				if(document.getElementById('strSkinLang').refresh!=undefined)
					document.getElementById('strSkinLang').refresh();
			} 
		}); 
	}
