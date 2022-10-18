
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#theForm").submit(function() {

			$(this).ajaxSubmit({
				success: function(responseText){
					alert(arApplMsg["success_updated"]);
			 }, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url:'action/?subAct=pointconfig&Act=config'});
			
			return false;

    });

	});

	function chgGroupLevel(obj){

		$.ajax({ 
			type: "post", url: "action/?subAct=pointconfig&Act=grouplevel", data : "groupcode=" + obj.attr("id") + "&level=" + obj.val(), 
			success:function(responseText){
				if (responseText == "ERROR"){
					document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
				}
			}, error:function(response){alert('error\n\n' + response.responseText);}
		});

	}