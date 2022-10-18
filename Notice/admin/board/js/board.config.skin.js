
	$(document).ready(function() {

		$("body select").msDropDown();

		$('#theForm').ajaxForm( { beforeSubmit: validate } ); 

	});

	function validate(formData, jqForm, options) { 

		$.ajax({ 
			type: "post", url: "action/?subAct=boardconfigskin&act=remove&intSrl=" + formData[0].value, 
			success:function(responseText){
				if (responseText == "ERROR"){
					document.location.href = "?act=login&strPrevUrl=" + location.href.replace("&", "--**--");
					return false;
				}

				for (var i=2; i < formData.length; i++) { 
					if (formData[i].name!="submit"){
						$.ajax({ 
							type: "post", url: "action/?subAct=boardconfigskin&act=add&intSrl=" + formData[0].value, data : "fieldname=" + formData[i].name + "&fieldvalue=" + formData[i].value, 
							success:function(responseText){
								if (responseText == "ERROR"){
									document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
								}
							}, error:function(response){alert('error\n\n' + response.responseText);}
						});
					}
				} 

			}, error:function(response){alert('error\n\n' + response.responseText);}
		});

		alert(arApplMsg["success_saved"]);

	}