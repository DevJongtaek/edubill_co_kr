
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#termSearch, #yearSearch, #monthSearch, #daySearch").hide();

		if ($("#strSearchType2").is(':checked')){
			$("#termSearch").show();
		}

		$("input[name=strSearchType]").click(function(){

			if ($(this).attr("id") == "strSearchType1")
				$("#termSearch").hide();
			else
				$("#termSearch").show();

		});

		$("a[name=btn_search]").click(function(){
			$("#theForm").submit();
		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=statsitelog&intPage=" + page);
		$("#theForm").submit();
	}
