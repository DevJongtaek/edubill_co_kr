
	jQuery(function($){

		$(".btn_modify").click(function(){
			$.doExtFormSubmit('?act=member&subAct=modifyform', 'post');
		});

	});