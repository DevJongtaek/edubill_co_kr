
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#termSearch, #yearSearch, #monthSearch, #daySearch").hide();

		if ($("#strSearchType2").is(':checked')){
			$("#termSearch").show();
		}

		if ($("#strSearchType3").is(':checked')){
			$("#yearSearch").show();
		}

		if ($("#strSearchType4").is(':checked')){
			$("#monthSearch").show();
		}

		if ($("#strSearchType5").is(':checked')){
			$("#daySearch").show();
		}

		$("input[name=strSearchType]").click(function(){

			$("#termSearch").hide();
			$("#yearSearch").hide();
			$("#monthSearch").hide();
			$("#daySearch").hide();

			switch ($(this).attr("id")) {
				case "strSearchType2" : $("#termSearch").show(); break;
				case "strSearchType3" : $("#yearSearch").show(); break;
				case "strSearchType4" : $("#monthSearch").show(); break;
				case "strSearchType5" : $("#daySearch").show(); break;
			}
		});

		$("a[name=btn_search]").click(function(){
			$("#theForm").submit();
		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=statsearch&intPage=" + page);
		$("#theForm").submit();
	}
