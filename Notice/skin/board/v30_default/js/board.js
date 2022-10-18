	var clickAreaCheck = false;

	$(document).ready(function() {

		switch ($("#extForm #list_style").val()){
			case "list" : $(".default a").addClass("active"); break;
			case "webzine" : $(".webzine a").addClass("active"); break;
			case "gallery" : $(".gallery a").addClass("active"); break;
		}

	});