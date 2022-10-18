
	$(document).ready(function() {

		$("input:checkbox").checkbox();
		$("input:radio").checkbox({cls:"jquery-radio"});

		$("a[name=urlCopy]").bind("click",function() {
			$("#filelink").val("http://" + document.location.host + $(this).attr("id"));
			var doc = document.theForm.filelink.createTextRange();
			doc.execCommand( 'copy' );
			alert(arApplMsg["success_copy"]);
		});

	});