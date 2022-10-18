
	$(document).ready(function() {

		$("#content select").msDropDown();

		if ($("#strDateType1").is(':checked')){
			$("#term_search").hide();
		}

		$("#strDateType1").click(function(){
			$("#term_search").hide();
		});

		$("#strDateType2").click(function(){
			$("#term_search").show();
		});

		$("#btn_search").click(function(){
			$("#theForm").submit();
		});

		$("#btn_remove").click(function(){

			if ($("#theForm input[id=intSeq]:checked").length == 0){
				alert(arApplMsg["select_not_comment"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete_comment"])){
				$("#theForm").ajaxSubmit({
					success: function(responseText){
						alert(responseText + arApplMsg["success_comment_delete"]);
						$("#theForm").attr("action","?act=commentsearch");
						$("#theForm").submit();
					}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=remove&subAct=commentsearch'});
			}

		});


	});

	function goPage(page){
		$("#theForm").attr("action","?act=commentsearch&intPage=" + page);
		$("#theForm").submit();
	}