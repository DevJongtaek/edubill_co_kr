
	$(document).ready(function() {

		$("#content select").msDropDown();
		$("textarea.resizable:not(.processed)").TextAreaResizer();

		$("#theForm").submit(function() {

			if ($("#strName").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_name"]);$("#strName").focus();return false;
			}

			if ($("#strEmail").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_email"]);$("#strEmail").focus();return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					var msg = "";

					switch (responseText){
						case "SW" : msg = arApplMsg["success_saved"]; break;
						case "SE" : msg = arApplMsg["success_updated"]; break;
						case "ERROR" : document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}
					alert(msg);
					$("#extForm").attr("action","?act=mailingetclist&intPage=" + $("#intPage").val());
					$("#extForm").submit();
			 }, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
			
			return false;

    });

		$("#btn_cancel").click(function(){
			$("#extForm").attr("action","?act=mailingetclist&intPage=" + $("#intPage").val());
			$("#extForm").submit();
		});

	});

	var Post = function() {}

	Post.SearchForm = function(obj) {
		$("#addrForm_" + obj + "1").show();
		$("#addrForm_" + obj + "3").hide();
	}

	Post.SearchFormCancel = function(obj) {
		$("#addrForm_" + obj + "1").hide();
		$("#addrForm_" + obj + "3").show();
	}

	Post.SearchFormAddr = function(obj) {

		if ($("#" + obj + "1").val().length == ""){
			alert(arApplMsg["success_saved"]);$("#" + obj + "1").focus();return;
		}

			$.ajax({type: "POST", url: "action/?subAct=zipcode", data: "searchword=" + $("#" + obj + "1").val(), dataType: "json", success: function(responseText){

				if (responseText.length == 0){
					alert(arApplMsg["success_saved"]);$("#" + obj + "1").focus();return;
				}

				$("#addrForm_" + obj + "1").hide();
				$("#addrForm_" + obj + "2").show();

				for(var i = 0; i < responseText.length; i++){
					
					optText = '(' + responseText[i].dispcode + ') ' + responseText[i].sido + ' ' + responseText[i].gugun;

					if (responseText[i].dong!="")
						optText = optText + ' ' + responseText[i].dong;

					if (responseText[i].ri!="")
						optText = optText + ' ' + responseText[i].ri;

					if (responseText[i].apt!="")
						optText = optText + ' ' + responseText[i].apt;

					if (responseText[i].bunji!="")
						optText = optText + ' ' + responseText[i].bunji;

					optVal = responseText[i].dispcode + '$$$' + responseText[i].sido + '$$$' + responseText[i].gugun + '$$$' + responseText[i].dong + '$$$' + responseText[i].ri + '$$$' + responseText[i].apt + '$$$' + responseText[i].bunji;

					document.getElementById(obj + '2').options[i] = new Option(optText, optVal);
				}

				document.getElementById(obj + '2').selectedIndex =0;
	
				if(document.getElementById(obj + '2').refresh!=undefined)
					document.getElementById(obj + '2').refresh();

		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

	}

	Post.SearchFormListCancel = function(obj) {
		$("#addrForm_" + obj + "1").show();
		$("#addrForm_" + obj + "2").hide();
	}

	Post.SearchFormSelect = function(obj) {

		$("#addrForm_" + obj + "2").hide();
		$("#addrForm_" + obj + "3").show();
		var addrArr = $("#" + obj + "2").val().split("$$$");
		$("#" + obj + "3").val(addrArr[0]);

		var addr1 = addrArr[1] + ' ' + addrArr[2] + ' ' + addrArr[3];
		var addr2 = "";

		if (addrArr[4]!="")
			addr2 = addr2 + addrArr[4];

		if (addrArr[5]!="")
			addr2 = addr2 + addrArr[5];

		$("#" + obj + "4").val(addr1);
		$("#" + obj + "5").val(addr2);
		$("#" + obj + "5").focus();

	}