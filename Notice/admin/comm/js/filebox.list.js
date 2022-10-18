
	var arApplMsg = new Array();
	var dbCateCode = "C000000002";

	$(document).ready(function() {

		$.ajax({
			url: langUrl, data: "xml",
			success: function(xml){
				$(xml).find("alert").find("item").each(function(idx) {
					arApplMsg[$(this).attr("name")] = $(this).text();
				});
			}, error: function(xhr){alert(xhr.status);}
		});

		$("body select").msDropDown();

		$("#fileUploader").hide();

		FileBox.FileList('', '');

		$("#btn_img_upload").click(function(){
			$("#fileUploader").show();
		});

    $("#theForm").ajaxForm({
        beforeSubmit: function(a,f,o) {
					o.dataType = "html";
					if ($("#filename").val() == ""){
						alert(arApplMsg["select_file"]);
						$("#filename").focus();
						return false;
					}
        },
        success: function(data) {
					switch (data){
						case "error" :
							alert(arApplMsg["error_upload"]);
							break;
						case "success" :
							alert(arApplMsg["success_upload"]);
							FileBox.FileList('', $("#strSearchCateCode").val());
							$('#theForm').resetForm();
							break;
						case "noimage" :
							alert(arApplMsg["only_image_file"]);
							break;
					}
        }, url:'action/?subAct=fileboxupload&Act=upload'
    });

		$("#btn_cancel").click(function(){
			$('#theForm').resetForm();
			$("#fileUploader").hide();
		});

		$("#btn_cate_config").click(function(){
			$("#cateDiv").toggle();
		});

		$("#btn_select_all").click(function(){

			if ($(this)[0].cid == "n" || $(this)[0].cid == null){
				$("input[type=checkbox]").prop("checked", true);
				$(this)[0].cid = "y";
			}else{
				$("input[type=checkbox]").prop("checked", false);
				$(this)[0].cid = "n";
			}
			return false;
		});

		$("#btn_remove").click(function(){

			var msg = ""
	
			if ($("#listForm input:checked").length == 0){
				alert(arApplMsg["select_file"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete"])){
				$("#listForm").ajaxSubmit({
					success:function(msg){
						FileBox.FileList('', $("#strSearchCateCode").val());
						$("#fileUploader").hide();
					}, 
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=fileboxupload&Act=remove'});
			}

		});

		$("#btn_cate_add").click(function(){

			if ($("#cateInput").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_category"]);$("#cateInput").focus();return false;
			}

			$.ajax({type: "POST", url: "action/?subAct=syscode&Act=add&strFirstCode=" + dbCateCode, data: "strName=" + $("#cateInput").val(), 
				success: function(response){
	
					if (response == "error"){
						alert(arApplMsg["exists_category"]);$("#cateInput").focus();return false;
					}else{
						$("#cateList").append("<li id=\"" + response + "\"><label class=\"fl\">" + $("#cateInput").val() + "</label><input type=\"text\" class=\"fl\" value=\"" + $("#cateInput").val() + "\" style=\"display:none;\"><a name=\"btn_cate_remove\" class=\"hand\"><IMG src=\"images/btn_x2.gif\" class=\"fr\"></a></li>");
						$("#cateInput").val("");
						FileBox.Category();
						FileBox.CategoryReset();
					}
	
				 },
				 error: function(response){
					 alert('error\n\n' + response.responseText);
					 return false;
				 }
			});
		});

	});

	var FileBox = function() {}

	FileBox.Category = function() {

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
							alert(arApplMsg["exists_category_id"]);
							objInput.prev("label").text(prevCateTxt);
							objInput.val(prevCateTxt);
						}else{
							objInput.prev("label").text(objInput.val());
							FileBox.CategoryReset();
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
					FileBox.CategoryReset();
				 },
				 error: function(response){
					 alert('error\n\n' + response.responseText);
				 }
			});

		});

	}

	FileBox.CategoryReset = function() {

		$.ajax({type: "POST", url: "action/?subAct=syscode&Act=list&strFirstCode=" + dbCateCode, data:'', dataType: "json", 
			success: function(responseText){
				if (responseText == ""){
					document.getElementById("strCateCode").options.length = 1;
					document.getElementById("strSearchCateCode").options.length = 1;
				}else{
					document.getElementById("strCateCode").options.length = 1;
					document.getElementById("strSearchCateCode").options.length = 1;
					for(var i = 0; i < responseText.length; i++){
						document.getElementById("strCateCode").options[i+1] = new Option(responseText[i].name.toString(), responseText[i].code.toString());
						document.getElementById("strSearchCateCode").options[i+1] = new Option(responseText[i].name.toString(), responseText[i].code.toString());
					}
				}
				
				if(document.getElementById("strCateCode").refresh!=undefined)
					document.getElementById("strCateCode").refresh();

				if(document.getElementById("strSearchCateCode").refresh!=undefined)
					document.getElementById("strSearchCateCode").refresh();

			 },
			 error: function(response){
				 alert('error\n\n' + response.responseText);
			 }
		});

	}

	FileBox.FileList = function(page, cateCode) {

		$.ajax({type: "POST", url: "action/?subAct=fileboxbody&intPage=" + page + "&strCateCode=" + cateCode, 
			success: function(responseText){
				$("#listBody").html(responseText);
			 },
			 error: function(response){
				 alert('error\n\n' + response.responseText);
				 return false;
			 }
		});

	}

	function goPage(page){
		FileBox.FileList(page, $("#strSearchCateCode").val());
	}