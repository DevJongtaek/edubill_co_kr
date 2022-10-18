
	$(document).ready(function() {

		$("#theForm #is_keyword").val($("#extForm #search_keyword").val());

		if ($("#extForm #subAct").val() == ""){
			$("#pagingArea").hide();
		}

		switch ($("#extForm #search_target").val()){
			case "title_content" :
				$(".subNavigation li:eq(0)").addClass("on");
				break;
			case "title" : 
				$(".subNavigation li:eq(1)").addClass("on");
				break;
			case "content" : 
				$(".subNavigation li:eq(2)").addClass("on");
				break;
			case "tag" :
				$(".subNavigation li:eq(3)").addClass("on");
				break;
			default :
				$(".subNavigation li:eq(1)").addClass("on");
				break;
		}

		$("a[name=document_search_target]").click(function(){
			$("#extForm #search_target").val($(this).attr("id"));
			$("#extForm #intPage").val("1");
			$("#extForm").submit();
		});

		$("#document_more, #comment_more, #image_more, #file_more").click(function(){

			$("#extForm #subAct").val($(this).attr("id").split("_")[0]);
			$("#extForm").submit();

		});

		$("a[name=search_paging]").click(function(){
			$("#extForm #intPage").val($(this).attr("id").split("_")[1]);
			$("#extForm").submit();
		});

		$("#theForm").submit(function() {
			if ($("#is_keyword").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_keyword']);$("#is_keyword").focus();return false;
			}
			
			$("#extForm #search_keyword").val($("#is_keyword").val());
			$("#extForm #subAct").val("");
			$("#extForm").submit();
			
			return false;
		});

	});