
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_prev_month").click(function(){

			$("#year > option[value=" + $("#intPrevYear").val() + "]").prop("selected", true);
			$("#month > option[value=" + $("#intPrevMonth").val() + "]").prop("selected", true);

			if(document.getElementById('year').refresh!=undefined)
				document.getElementById('year').refresh();

			if(document.getElementById('month').refresh!=undefined)
				document.getElementById('month').refresh();

			$("#theForm").submit();

		});

		$("#btn_next_month").click(function(){

			$("#year > option[value=" + $("#intNextYear").val() + "]").prop("selected", true);
			$("#month > option[value=" + $("#intNextMonth").val() + "]").prop("selected", true);

			if(document.getElementById('year').refresh!=undefined)
				document.getElementById('year').refresh();

			if(document.getElementById('month').refresh!=undefined)
				document.getElementById('month').refresh();

			$("#theForm").submit();

		});

		$("#btn_search").click(function(){
			$("#theForm").submit();
		});

	});