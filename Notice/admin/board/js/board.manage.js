
	$(document).ready(function() {

		$("body select").msDropDown();
		$("textarea.resizable:not(.processed)").TextAreaResizer();

		$("#btn_move").click(function(){

			if ($("#intSrl").val() == ""){
				alert(arApplMsg["select_not_board"]);
				return false;
			}
			
			if (confirm(arApplMsg["confirm_move"])){

				$("#theForm").ajaxSubmit({
					success: function(responseText){
						alert(arApplMsg["success_moved"]);
						opener.document.location.href = opener.document.location.href;
						self.close();
						return false;
					}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=move&subAct=boardmanage'});

			}
		});

		$("#btn_remove, #btn_trash").click(function(){

			switch ($(this).attr("id")){
				case "btn_remove" : $("#bitTrash").val('0'); var msg = arApplMsg["confirm_delete"]; break;
				case "btn_trash" : $("#bitTrash").val('1'); var msg = arApplMsg["confirm_trash"]; break;
			}
			
			if (confirm(msg)){
				$("#theForm").ajaxSubmit({
					success: function(responseText){
						opener.document.location.href = opener.document.location.href;
						self.close();
						return false;
					}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=boardremove&subAct=boardmanage'});
			}
		});

		$("#btn_close").click(function(){
			self.close();
		});

	});

	function boardCategorySet(obj){
		if (obj.value == ""){

			$("#intCategory option[value!='']").remove();

			if(document.getElementById("intCategory").refresh != undefined)
				document.getElementById("intCategory").refresh();

		}else{

			$.ajax({type: "POST", url: "../action/?Act=boardcategorylist", data: "board_srl=" + obj.value, dataType: "json", success: function(responseText){
	
				if (responseText.length > 0){
					for(var i = 0; i < responseText.length; i++){
						$("#intCategory").append($("<option value=\"" + responseText[i].code + "\">" + responseText[i].title + "</option>").prop("disabled", responseText[i].disable));
					}
				}

				if(document.getElementById("intCategory").refresh != undefined)
					document.getElementById("intCategory").refresh();
	
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

		}
	}