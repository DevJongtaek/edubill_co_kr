
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_remove").click(function(){

			if ($("#theForm input[id=intSeq]:checked").length == 0){
				alert(arApplMsg["select_not_comment"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete_comment"])){
				$("#theForm").ajaxSubmit({
					success: function(responseText){
						alert(responseText + arApplMsg["success_comment_delete"]);
						$("#theForm").attr("action","?act=commentdeclared");
						$("#theForm").submit();
					}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=remove&subAct=commentdeclared'});
			}

		});

		$("#btn_declared_cancel").click(function(){
			if ($("#theForm input[id=intSeq]:checked").length == 0){
				alert(arApplMsg["select_not_comment"]);return false;
			}

			if (confirm(arApplMsg["confirm_cancel_comment_declared"])){

				var seq = "";

				$("#theForm input[id=intSeq]").each(function(n){
					if ($(this).prop('checked') == true){
						if (seq != "")
							seq += ",";
						seq += $(this).attr("class").split("_")[1];
					}
				});

				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}else{
							$("#theForm").attr("action","?act=commentdeclared");
							$("#theForm").submit();
						}
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?Act=declaredcanecel&subAct=commentdeclared&seq=' + seq
				});
			}

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=commentdeclared&intPage=" + page);
		$("#theForm").submit();
	}