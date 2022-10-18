
	$(document).ready(function() {

		$("#btn_login").click(function(){

			$("#extForm #act").val('login');

			if ($("#msgForm #comment_seq").val() != "")
				$("#extForm").append("<input name=\"comment_seq\" type=\"hidden\" id=\"comment_seq\" id=\"" + $("#msgForm #comment_seq").val() + "\" />");

			if ($("#msgForm #comment_page").val() != "")
				$("#extForm").append("<input name=\"comment_page\" type=\"hidden\" id=\"comment_page\" id=\"" + $("#msgForm #comment_page").val() + "\" />");

			$("#extForm").attr("method", "get");
			$("#extForm").submit();

		});

	});