
	$(document).ready(function() {

		$("#btnModify").click(function(){
			$("#theForm").attr("action","?act=membermodify");
			$("#theForm").attr("method","post");
			$("#theForm").submit();
		});

		$("#btnList").click(function(){
			$("#theForm").attr("action","?act=memberlist");
			$("#theForm").attr("method","post");
			$("#theForm").submit();
		});

	});