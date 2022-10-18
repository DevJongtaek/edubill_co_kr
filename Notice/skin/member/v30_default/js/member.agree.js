
	jQuery(function($){

		var form = "#theForm";

		$(".btn_join").click(function(){

			$("#extForm #checkMemberType").val($(this).attr("id"));

			if ($("input[name=agree_check]:checked", form).length != $("input[name=agree_check]", form).length){
				alert(arApplMsg['isnull_agree']); return false;
			}
			var is_check = false;
			if ($("#checkMemberType", "#extForm").val() == "K"){
				if (confirm(arApplMsg['info_kids']))
					$.doMemberAgreeCheck();
			}else{
				$.doMemberAgreeCheck();
			}

		});

	});