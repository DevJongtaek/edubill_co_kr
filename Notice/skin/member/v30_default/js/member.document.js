
	jQuery(function($){

		$("#page_size").change(function(){
			document.location.href = "?act=" + set_act + "&subAct=" + set_sub_act;
			return false;
		});

		$("a[name=link_page]").click(function(){
			document.location.href = "?act=" + set_act + "&subAct=" + set_sub_act + "&page=" + $(this).attr("id").split("_")[1];
			return false;
		});

	});
