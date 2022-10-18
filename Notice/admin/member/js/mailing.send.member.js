
	$(document).ready(function() {

		$("textarea.resizable:not(.processed)").TextAreaResizer();

		$("#theForm").submit(function() {

			var chkCnt = 0;

			$("input[name=strMemberGroup]:checked, input[name=strMailGroup]:checked").each(function() {
				chkCnt++;
			});

			if ($("#strMemberID").val().replace(/\s/g, "").length != 0)
				chkCnt++;

			if ($("#strMemberEmail").val().replace(/\s/g, "").length != 0)
				chkCnt++;

			if ($("input:checkbox[name=strMemberEtc]")[0].checked)
				chkCnt++;

			if (chkCnt == 0){
				alert(arApplMsg["is_null_target"]);return false;
			}

			if (confirm(arApplMsg["confirm_new_make"].replace("<br>", "\n"))){
				$("#theForm").ajaxSubmit({
					success: function(responseText){
						switch (responseText){
							case "SW" : msg = arApplMsg["success_saved"]; break;
							case "SR" : msg = arApplMsg["not_exists_target"]; break;
						}
						alert(msg);
						if (responseText == "SW"){
							$("#extForm").attr("action","?act=mailingsendlist&intPage=" + $("#intPage").val());
							$("#extForm").submit();
						}
				 }, 
				 error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
			}

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
