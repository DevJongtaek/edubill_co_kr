
	$(document).ready(function() {

		$("#confBoard, #searchMode, #strListLevel, #strReadLevel, #strWriteLevel, #strCmtWriteLevel, #strCmtRepleLevel, #strUploadLevel, #strDownLevel").msDropDown();

		if ($("#strListLevel").val() == "2"){$("#strListGroupDiv").show();}else{$("#strListGroupDiv").hide();}
		if ($("#strReadLevel").val() == "2"){$("#strReadGroupDiv").show();}else{$("#strReadGroupDiv").hide();}
		if ($("#strWriteLevel").val() == "2"){$("#strWriteGroupDiv").show();}else{$("#strWriteGroupDiv").hide();}
		if ($("#strCmtWriteLevel").val() == "2"){$("#strCmtWriteGroupDiv").show();}else{$("#strCmtWriteGroupDiv").hide();}
		if ($("#strUploadLevel").val() == "2"){$("#strUploadGroupDiv").show();}else{$("#strUploadGroupDiv").hide();}
		if ($("#strDownLevel").val() == "2"){$("#strDownGroupDiv").show();}else{$("#strDownGroupDiv").hide();}

		$("#admin_search").hide();

		$("#btn_remove").click(function(){
			if ($("#strAdminList").val() == null){
				alert(arApplMsg["select_not_admin"]);$("#strAdminList").focus();return false;
			}

			$.ajax({ 
				type: "post", url: "action/?subAct=boardconfiggrantinfo&Act=adminremove", data : "intSrl=" + $("#intSrl").val() + "&memberSrl=" + $("#strAdminList").val(), 
				success:function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href.replace("&", "--**--");
						return false;
					}
					
					$("#strAdminList option[value='" + $('#strAdminList option:selected').val() + "']").remove();
					
				}, error:function(response){alert('error\n\n' + response.responseText);}
			});

		});

		$("#theForm").submit(function() {

			if ($("#strListLevel").val() == "2" && $("#strListGroupDiv input:checked").length == 0){
				alert(arApplMsg["select_not_list_group"]);return false;
			}

			if ($("#strReadLevel").val() == "2" && $("#strReadGroupDiv input:checked").length == 0){
				alert(arApplMsg["select_not_read_group"]);return false;
			}

			if ($("#strWriteLevel").val() == "2" && $("#strWriteGroupDiv input:checked").length == 0){
				alert(arApplMsg["select_not_write_group"]);return false;
			}

			if ($("#strCmtWriteLevel").val() == "2" && $("#strCmtWriteGroupDiv input:checked").length == 0){
				alert(arApplMsg["select_not_comment_group"]);return false;
			}

			if ($("#strUploadLevel").val() == "2" && $("#strUploadGroupDiv input:checked").length == 0){
				alert(arApplMsg["select_not_upload_group"]);return false;
			}

			if ($("#strDownLevel").val() == "2" && $("#strDownGroupDiv input:checked").length == 0){
				alert(arApplMsg["select_not_down_group"]);return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;
						return false;
					}
					alert(arApplMsg["success_saved"]);
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?subAct=boardconfiggrantinfo&Act=config&intSrl=' + $("#intSrl").val()});
			return false;

    });

	});

	function dispAccGroup(data, form){
		if (data.value == "2")
			$("#" + form).show();
		else
			$("#" + form).hide();
	}

	function addMember(){

		if ($("#admin_search input:checked").length == 0){
			alert(arApplMsg["select_not_member"]);return;
		}

		var tmpAdminInfo = "";

		$("input[name=memberSrl]:checked").each(function() {

			tmpAdminInfo = $(this).val();
			tmpAdminInfo = tmpAdminInfo.split("$$$");
			
			document.getElementById('strAdminList').options[$('#strAdminList option').length] = new Option(tmpAdminInfo[1] + ' (' + tmpAdminInfo[2] + ') / ' + adminListMsgItem[0] + ' ' + tmpAdminInfo[3] + ' / ' + adminListMsgItem[1] + ' ' + tmpAdminInfo[4] + ' / ' + adminListMsgItem[2] + ' ' + tmpAdminInfo[5] + ' / ' + adminListMsgItem[3] +' ' + tmpAdminInfo[6], tmpAdminInfo[0]);

			$.ajax({ 
				type: "post", url: "action/?subAct=boardconfiggrantinfo&Act=adminadd", data : "intSrl=" + $("#intSrl").val() + "&memberSrl=" + tmpAdminInfo[0], 
				success:function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}
				}, error:function(response){alert('error\n\n' + response.responseText);}
			});

		});

		$("#admin_search").html('');
		$("#admin_search").hide();
		$("#searchWord").val("");

	}