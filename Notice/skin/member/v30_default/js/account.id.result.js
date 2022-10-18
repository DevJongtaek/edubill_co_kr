
	jQuery(function($){

		var form = "#theForm";

		$(form).submit(function(){

			var form = $(this).attr("id");

			$("#strUserID", "#extForm").val($("input[name=userid]:checked", form).val());

			$.doExtFormSubmit('?act=member&subAct=findpwd', 'post');

			return false;

		});

	});