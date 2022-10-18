
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

		$("#btn_manage").click(function(){
			if ($("#theForm input[id=intSeq]:checked").length == 0){
				alert(arApplMsg["select_not_document"]);return false;
			}

			var seq = "";

			$("#theForm input[id=intSeq]:checked").each(function(){
				if (seq != "")
					seq += ",";
				seq += $(this).val();
			});

			openWindows("?Act=boardmanage&seq=" + seq,"boardmanage", 500, 320,0);

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=boardsearch&intPage=" + page);
		$("#theForm").submit();
	}