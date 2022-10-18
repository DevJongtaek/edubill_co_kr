
	var dbCateCode = "C000000001";

	$(document).ready(function() {

		$("#strCateCode, #strLayoutCode, #strAccessType").msDropDown();

		$(".tx-canvas iframe").css("height", "400px");

		switch ($("#pageTypeDiv input:checked").val()){
			case "0" : $("#pageEditor").show();$("#pageLink").hide();break;
			case "1" : $("#pageEditor").hide();$("#pageLink").show();break;
		}

		$("#pageTypeDiv input:radio").click(function() {
			switch ($(this).val()){
				case "0" : $("#pageEditor").show();$("#pageLink").hide();break;
				case "1" : $("#pageEditor").hide();$("#pageLink").show();break;
			}
		});

		$("#btn_cate_config").click(function(){
			$("#cateDiv").toggle();
		});

		$("#btn_cancel").click(function(){
			$("#extForm").attr("action","?act=page&intPage=" + $("#intPage").val());
			$("#extForm").submit();
		});

		$("#btn_file_find").click(function(){
			$("#fileTreeList").toggle();
		});

		if ($("#strAccessType").val() == "2")
			$("#groupDiv, #groupMessage").show();
		else
			$("#groupDiv, #groupMessage").hide();

		$('#fileTreeList').fileTree({ root: '/', script: 'action/?subAct=jquerytree', folderEvent: 'click', expandSpeed: 750, collapseSpeed: 750, multiFolder: false }, function(file) { 
			$("#strContentFile").val(file);
		});

		$("#theForm").submit(function() {

			if ($("#strPid").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_page_id"]);$("#strPid").focus();return false;
			}

			if (!chkEngNumber($("#strPid").val())){
				alert(arApplMsg["invalid_page_id"]);$("#strPid").focus();return false;
			}

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_page_title"]);$("#strTitle").focus();return false;
			}

			switch ($("#pageTypeDiv input:checked").val()){
				case "0" :
					var _validator = new Trex.Validator();
					var _content = Editor.getContent();
					if(!_validator.exists(_content)) {
						alert(arApplMsg["null_page_content"]);Editor.focus();
						return false;
					}
					$("#strContent").val(_content);
					break;
				case "1" :
					if ($("#strContentFile").val().replace(/\s/g, "").length == 0) {
						alert(arApplMsg["null_page_file"]);$("#strContentFile").focus();return false;
					}
					break;
			}

			if ($("#strAccessType").val() == "2"){
				if ($("#groupDiv input:checked").length == 0){
					alert(arApplMsg["select_group"]);
					return false;
				}
				if ($("#strMessage").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_message"]);$("#strMessage").focus();return false;
				}
			}

			$(this).ajaxSubmit({
				success:function(responseText){
					switch (responseText){
						case "SW" : alert(arApplMsg["success_saved"]);break;
						case "SE" : alert(arApplMsg["success_updated"]);break;
						case "EC" : alert(arApplMsg["exists_page_id"]);break;
						case "ERROR" : document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}

					if (responseText != "EC"){
						$("#extForm").attr("action","?act=page&intPage=" + $("#intPage").val());
						$("#extForm").submit();
					}
				}, 
				error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
			return false;

    });

		$("#btn_cate_add").click(function(){

			if ($("#cateInput").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_page_content"]);$("#cateInput").focus();return false;
			}

			$.ajax({type: "POST", url: "action/?subAct=syscode&Act=add&strFirstCode=" + dbCateCode, data: "strName=" + $("#cateInput").val(), 
				success: function(response){
	
					if (response == "error"){
						alert(arApplMsg["category_name_exists"]);$("#cateInput").focus();return false;
					}else{
						$("#cateList").append("<li id=\"" + response + "\"><label class=\"fl\">" + $("#cateInput").val() + "</label><input type=\"text\" class=\"fl\" value=\"" + $("#cateInput").val() + "\" style=\"display:none;\"><a name=\"btn_cate_remove\" class=\"hand\"><IMG src=\"images/btn_x2.gif\" class=\"fr\"></a></li>");
						$("#cateInput").val("");
						Page.Category();
						Page.CategoryReset();
					}
	
				 },
				 error: function(response){
					 alert('error\n\n' + response.responseText);
					 return false;
				 }
			});
	
		});

		Page.Category();

	});

	var Page = function() {}

	Page.Category = function() {

		$("#cateList li").bind({
			dblclick : function(){
				$(this).children("label").hide();
				$(this).children("input").show();
				$(this).children("input").focus();
			}
		});

		$("#cateList input").blur(function(){

			if ($(this).prev("label").text()!=$(this).val()){

				var objInput = $(this);
				var prevCateTxt = $(this).prev("label").text();
				
				$.ajax({type: "POST", url: "action/?subAct=syscode&Act=edit&strFirstCode=" + dbCateCode, data: "strSecondCode=" + objInput.parent().attr("id") + "&strName=" + objInput.val(), 
					success: function(response){
						if (response == "error"){
							alert(arApplMsg["category_name_exists"]);
							objInput.prev("label").text(prevCateTxt);
							objInput.val(prevCateTxt);
						}else{
							objInput.prev("label").text(objInput.val());
							Page.CategoryReset();
						}
						objInput.hide();
						objInput.prev("label").show();
					},
					 error: function(response){
						 alert('error\n\n' + response.responseText);
						 return false;
					 }
				});
			}else{
				$(this).hide();
				$(this).prev("label").show();
			}
		});

		$("#cateList li a[name=btn_cate_remove]").click(function(){

			var objList = $(this);

			$.ajax({type: "POST", url: "action/?subAct=syscode&Act=remove&strFirstCode=" + dbCateCode, data: "strSecondCode=" + objList.parent().attr("id"), 
				success: function(response){
					objList.parent().remove();
					Page.CategoryReset();
				 },
				 error: function(response){
					 alert('error\n\n' + response.responseText);
				 }
			});

		});

	}

	Page.CategoryReset = function() {

		$.ajax({type: "POST", url: "action/?subAct=syscode&Act=list&strFirstCode=" + dbCateCode, data:'', dataType: "json", 
			success: function(responseText){
				if (responseText == ""){
					document.getElementById("strCateCode").options.length = 1;
				}else{
					document.getElementById("strCateCode").options.length = 1;
					for(var i = 0; i < responseText.length; i++){
						document.getElementById("strCateCode").options[i+1] = new Option(responseText[i].name.toString(), responseText[i].code.toString());
					}
				}
				if(document.getElementById("strCateCode").refresh!=undefined)
					document.getElementById("strCateCode").refresh();
			 },
			 error: function(response){
				 alert('error\n\n' + response.responseText);
			 }
		});

	}

	function dispAccGroup(data){
		if (data.value == "2")
			$("#groupDiv, #groupMessage").show();
		else
			$("#groupDiv, #groupMessage").hide();
	}