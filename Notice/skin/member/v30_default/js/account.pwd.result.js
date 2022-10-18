
	$(document).ready(function() {

		$("#theForm").submit(function() {

			$("#theForm").attr("action", "?act=member&subAct=findpwd");
			$("#theForm").attr("method", "post");

    });
		
	});