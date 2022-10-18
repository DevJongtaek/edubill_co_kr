	var clickAreaCheck = false;

	$(document).ready(function() {

		switch ($("#extForm #list_style").val()){
			case "list" : $(".list").addClass("on"); break;
			case "webzine" : $(".webzine").addClass("on"); break;
			case "gallery" : $(".gallery").addClass("on"); break;
			default : $(".list").addClass("on"); break;
		}

	});