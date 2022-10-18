
	var dbCateCode = "C000000003";

	$(document).ready(function() {

		$("#content select").msDropDown();
		$("textarea.resizable:not(.processed)").TextAreaResizer();

		$("#btn_cate_config").click(function(){$("#cateDiv").toggle();});

		$("#theForm").submit(function() {

			if ($("#strBoardID").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_board_id"]);$("#strBoardID").focus();return false;
			}

			if (!chkEngNumber($("#strBoardID").val())){
				alert(arApplMsg["invalid_board_id"]);$("#strBoardID").focus();return false;
			}

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_title"]);$("#strTitle").focus();return false;
			}

			if ($("#skinColorSet input:checked").length == 0){
				alert(arApplMsg["is_null_skin"]);return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href.replace("&", "--**--");
						return false;
					}
					if (responseText == "ER"){
						alert(arApplMsg["exists_board_id"]);$("#strBoardID").focus();return false;
					}
					alert(arApplMsg["success_maked"]);
					document.location.href = "?act=boardlist";
					return false;
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?subAct=boardmake'});
			return false;

    });

		$("#btn_cate_add").click(function(){

			if ($("#cateInput").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_category"]);$("#cateInput").focus();return false;
			}

			$.ajax({type: "POST", url: "action/?subAct=syscode&Act=add&strFirstCode=" + dbCateCode, data: "strName=" + $("#cateInput").val(), 
				success: function(response){
	
					if (response == "error"){
						alert(arApplMsg["exists_category_name"]);$("#cateInput").focus();return false;
					}else{
						$("#cateList").append("<li id=\"" + response + "\"><label class=\"fl\">" + $("#cateInput").val() + "</label><input type=\"text\" class=\"fl\" value=\"" + $("#cateInput").val() + "\" style=\"display:none;\"><a name=\"btn_cate_remove\" class=\"hand\"><IMG src=\"images/btn_x2.gif\" class=\"fr\"></a></li>");
						$("#cateInput").val("");
						Board.Category();
						Board.CategoryReset();
					}
	
				 },
				 error: function(response){
					 alert('error\n\n' + response.responseText);
					 return false;
				 }
			});
	
		});

		Board.Category();
		Skin.ColorSet($("#strSkinName").val());

	});

	var Board = function() {}

	Board.Category = function() {

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
							Board.CategoryReset();
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
					Board.CategoryReset();
				 },
				 error: function(response){
					 alert('error\n\n' + response.responseText);
				 }
			});

		});

	}

	Board.CategoryReset = function() {

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

	var Skin = function() {}

	Skin.ColorSet = function(fn) {
		$.ajax({type: "POST", url: "action/?subAct=colorset", data: "skin=board&folder=" + fn + "&intSrl=" + $("#intSrl").val(), 
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
			url: "../skin/board/" + fn + "/skin.xml", data: "xml",
			error: function(xhr){alert(xhr.status);},
			success: function(xml){

				for(i = document.getElementById('strSkinLang').options.length;i>-0;i--){
					document.getElementById('strSkinLang').options[i] = null;
				}

				if(document.getElementById('strSkinLang').refresh!=undefined)
					document.getElementById('strSkinLang').refresh();

				$(xml).find("skin").find("languages").find("title").each(function(idx) {
					document.getElementById('strSkinLang').options[idx] = new Option($(this).text(), $(this).attr("lang"));
					document.getElementById('strSkinLang').selectedIndex = 0;
	
					if(document.getElementById('strSkinLang').refresh!=undefined)
						document.getElementById('strSkinLang').refresh();

				});
			}
		});

	}