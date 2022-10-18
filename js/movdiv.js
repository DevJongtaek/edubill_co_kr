var intervalJMapVal;
$(document).ready( function() {
	$("<div id='_jNavi'></div>").css("position", "relative").css("display", "none")
	.appendTo("#jNavi");
		
	$("img[jimg]").each( function() {
		$(this).css("margin-right", "5")
		.bind("mouseover", function() {
			$(this).attr('src', $(this).attr("src").substr(0, $(this).attr("src").lastIndexOf("."))+'_on.gif'); 
		})
		.bind("mouseout", function() {
			$(this).attr('src', $(this).attr("src").substr(0, $(this).attr("src").lastIndexOf("_on"))+'.gif'); })
		.bind("click", function() { goJMap( $(this).attr("jimg") )} )
		.appendTo("#_jNavi")
	});
	
	$("#_jNavi")
	.show()
	//.css("left", ($("#jOutLine").width()/2)-($("img[jimg]").length)*$("img[jimg]").width()/2 )
	.css("left", ($("#jOutLine").width())-($("img[jimg]").length)*$("img[jimg]").width() - 40 )
	.css("top", $("#jOutLine").height()-30)
	.css("width", $("#jOutLine").width())
	.css("height", $("#jOutLine").height());
	
	$("#jItems")
	.css("width", $("#jOutLine").width()*$("img[jimg]").length )
	.css("height", $("#jOutLine").height());
	
	$("#jOutLine")
	.bind("mouseover", function() { clearTimeout(intervalJMapVal); } );
	
	intervalJMapVal = setTimeout("intervalJMap()", 1500);
});
var goJMap = function(index) {
	$("#jItems").each( function() {
		var position = $(this).position();
		$(this).css({position:'absolute', top:position.top, left:position.left})
		.animate({left:-$("#jOutLine").width()*(index-1)}, 'slow')
	});
	$("#jNaviCurrentVal").attr("value", index);
}
var intervalJMap = function() {
	if( $("#jNaviCurrentVal").attr("value") == $("img[jimg]").length ) $("#jNaviCurrentVal").attr("value", 0);
	goJMap( parseInt($("#jNaviCurrentVal").attr("value"))+1 );
	
	intervalJMapVal = setTimeout("intervalJMap()", 3000);
}