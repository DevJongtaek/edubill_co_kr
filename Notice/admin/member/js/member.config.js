
	$(document).ready(function() {

		$("#content select").msDropDown();
		$("textarea.resizable:not(.processed)").TextAreaResizer();

		$("#theForm").submit(function() {

			if ($("#strMasterName").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_admin_name"]);$("#strMasterName").focus();return false;
			}

			if ($("#strMasterEmail").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_admin_email"]);$("#strMasterEmail").focus();return false;
			}

			if ($("#skinColorSet input:checked").length == 0){
				alert(arApplMsg["select_skin_color"]);return false;
			}

			if ($("#strLevelIconFolder").val() == "") {
				alert(arApplMsg["null_level_icon_folder"]);$("#strLevelIconFolder").focus();return false;
			}

			if ($("#intJoinPoint").val() != "" && $("#intJoinPoint").val() != "0"){
				if ($("#strJoinPointTitle").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_join_point"]);$("#strJoinPointTitle").focus();return false;
				}
			}

			if ($("#strJoinAct1").is(':checked')){
				if ($("#strJoinActUrl").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_join_page"]);$("#strJoinActUrl").focus();return false;
				}
			}

			if ($("#strJoinAct2").is(':checked')){
				if ($("#strJoinActScript").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_join_script"]);$("#strJoinActScript").focus();return false;
				}
			}

			if ($("#strEditAct1").is(':checked')){
				if ($("#strEditActUrl").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_modify_page"]);$("#strEditActUrl").focus();return false;
				}
			}

			if ($("#strEditAct2").is(':checked')){
				if ($("#strEditActScript").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_modify_script"]);$("#strEditActScript").focus();return false;
				}
			}

			if ($("#strOutAct1").is(':checked')){
				if ($("#strOutActUrl").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_out_page"]);$("#strOutActUrl").focus();return false;
				}
			}

			if ($("#strOutAct2").is(':checked')){
				if ($("#strOutActScript").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_out_script"]);$("#strOutActScript").focus();return false;
				}
			}


			if ($("#intLoginPoint").val() != "" && $("#intLoginPoint").val() != "0"){
				if ($("#strLoginPointTitle").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_login_point"]);$("#strLoginPointTitle").focus();return false;
				}
			}

			if ($("#strLoginAct1").is(':checked')){
				if ($("#strLoginActUrl").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_login_page"]);$("#strLoginActUrl").focus();return false;
				}
			}

			if ($("#strLoginAct2").is(':checked')){
				if ($("#strLoginActScript").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_login_script"]);$("#strLoginActScript").focus();return false;
				}
			}

			if ($("#strLogoutAct1").is(':checked')){
				if ($("#strLogoutActUrl").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_logout_page"]);$("#strLogoutActUrl").focus();return false;
				}
			}

			if ($("#strLogoutAct2").is(':checked')){
				if ($("#strLogoutActScript").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["null_logout_script"]);$("#strLogoutActScript").focus();return false;
				}
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					switch (responseText){
						case "ERROR" : document.location.href = "?act=login&strPrevUrl=" + location.href; return false; return false;
						case "ERR01" : alert(arApplMsg["null_ssn_use1"].replace("<br>","\n")); break;
						case "ERR02" : alert(arApplMsg["null_ssn_use2"]); break;
						default : alert(arApplMsg["success_saved"]); break;
					}
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?subAct=memberconfig'});
			return false;

    });

		Skin.ColorSet($("#strSkinName").val());
		$("input:checkbox").checkbox();

		$.memActDisp = function(divName1, divName2, act){
			switch (act){
				case "0" : $(divName1).show(); $(divName2).hide(); break;
				case "1" : $(divName1).hide(); $(divName2).show(); break;
				case "2" : $(divName1).hide(); $(divName2).hide(); break;
			}
		}

		$("input[name=strJoinAct]:checked, input[name=strEditAct]:checked, input[name=strOutAct]:checked, input[name=strLoginAct]:checked, input[name=strLogoutAct]:checked").each(function() {
			$.memActDisp("." + $(this)[0].name + "Page", "." + $(this)[0].name + "Script", $(this).val());
		});

		$("input[name=strJoinAct], input[name=strEditAct], input[name=strOutAct], input[name=strLoginAct], input[name=strLogoutAct]").click(function() {
			$.memActDisp("." + $(this)[0].name + "Page", "." + $(this)[0].name + "Script", $(this).val());
    });

	});

	var Skin = function() {}

	Skin.ColorSet = function(fn) {
		$.ajax({type: "POST", url: "action/?subAct=colorset", data: "skin=member&folder=" + fn, 
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
			url: "../skin/member/" + fn + "/skin.xml", data: "xml",
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
