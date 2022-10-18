
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
				alert(arApplMsg["select_not_file"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete_file"])){
				$("#theForm").ajaxSubmit({
					success: function(responseText){
						$("#theForm").attr("action","?act=filesearch");
						$("#theForm").submit();
					}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=remove&subAct=filesearch'});
			}

		});


	});

	function goPage(page){
		$("#theForm").attr("action","?act=filesearch&intPage=" + page);
		$("#theForm").submit();
	}