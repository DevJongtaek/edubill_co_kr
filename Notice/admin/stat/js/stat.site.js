
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#termSearch, #yearSearch, #monthSearch, #daySearch").hide();

		if ($("#strSearchType2").is(':checked')){
			$("#yearSearch").show();
			$("#monthSearch").hide();
		}

		if ($("#strSearchType3").is(':checked')){
			$("#yearSearch").show();
			$("#monthSearch").show();
		}

		if ($("#strSearchType4, #strSearchType5").is(':checked')){
			$("#termSearch").show();
		}

		$("input[name=strSearchType]").click(function(){

			$("#termSearch").hide();
			$("#yearSearch").hide();

			switch ($(this).attr("id")) {
				case "strSearchType2" : $("#yearSearch").show(); $("#monthSearch").hide(); break;
				case "strSearchType3" : $("#yearSearch").show(); $("#monthSearch").show(); break;
				case "strSearchType4" : $("#termSearch").show(); break;
				case "strSearchType5" : $("#termSearch").show(); break;
			}
		});

		$("a[name=btn_search]").click(function(){
			$("#theForm").submit();
		});

	});
