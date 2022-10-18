	$(document).ready(function() {

		$("input.input_text, textarea").focus(function(){
			$(this).addClass("input_inFocus");
		});

		$("input.input_text, textarea").blur(function(){
			$(this).removeClass("input_inFocus");
		});

	});


