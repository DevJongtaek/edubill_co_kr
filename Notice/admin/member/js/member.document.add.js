
	$(document).ready(function() {

		$("#content select").msDropDown();

		$(".tx-canvas iframe").css("height", "400px");

		$("#theForm").submit(function() {

			if ($("#strCateCode").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["select_category"]);$("#strCateCode").focus();return false;
			}

			if ($("#strSubject").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_title"]);$("#strSubject").focus();return false;
			}

			var _validator = new Trex.Validator();
			var _content = Editor.getContent();
			if(!_validator.exists(_content)) {
				alert(arApplMsg["is_null_content"]);Editor.focus();
				return false;
			}
			$("#strContent").val(_content);

			$("#strCateCode").prop("disabled", false);

			$(this).ajaxSubmit({
				success: function(responseText){
					var msg = "";
					switch (responseText){
						case "SW" : msg = arApplMsg["success_saved"]; break;
						case "SE" : msg = arApplMsg["success_updated"]; break;
						case "ERROR" : document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}
					alert(msg);
					$("#extForm").attr("action","?act=memberdoc&intPage=" + $("#intPage").val());
					$("#extForm").submit();
			 }, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
			
			return false;

    });

		$("#btn_cancel").click(function(){
			$("#extForm").attr("action","?act=memberdoc&intPage=" + $("#intPage").val());
			$("#extForm").submit();
		});

	});

		function populateCombo(val){

			var cmbOption = new Object();
			var cmbText = new Object();

			cmbOption["D001"] = userDim1.split(",");
			cmbOption["D002"] = userDim2.split(",");
			cmbOption["D003"] = userDim3.split(",");
			cmbOption["D004"] = userDim4.split(",");
			cmbOption["D005"] = userDim5.split(",");

			cmbText["D001"] = userDim1_.split(",");
			cmbText["D002"] = userDim2_.split(",");
			cmbText["D003"] = userDim3_.split(",");
			cmbText["D004"] = userDim4_.split(",");
			cmbText["D005"] = userDim5_.split(",");

			var targetCombo = "strUserDim";	
			var target_array1 = cmbOption[val];
			var target_array2 = cmbText[val];

			document.getElementById(targetCombo).options.length = 0;

			for(var i=0;i<target_array1.length;i++) {
				document.getElementById(targetCombo).options[i] = new Option(target_array2[i].toString(), target_array1[i].toString());
			}

			document.getElementById(targetCombo).selectedIndex = 0;

			if(document.getElementById(targetCombo).refresh!=undefined)
				document.getElementById(targetCombo).refresh();

		}

		function setUserDim(val){
			Editor.modify({content: Editor.getContent() + "{{" + val + "}}"});
		}