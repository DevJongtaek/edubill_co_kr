
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("a[name=btn_view]").click(function() {
			if ($("#memo_" + $(this).attr("id")).css("display") == "none"){
				$("#memo_" + $(this).attr("id")).show();
			}else{
				$("#memo_" + $(this).attr("id")).hide();
			}
    }); 

		$('#btn_remove').click(function(){

			if ($("#theForm input:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete"])){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						$("#theForm").attr("action","?act=memberout");
						$("#theForm").submit();
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=memberout&Act=remove'
				});
			}

		});

		$("#btn_out_cancel").click(function(){

			if ($("#theForm input:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}

			if (confirm(arApplMsg["confirm_cancel"])){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						$("#theForm").attr("action","?act=memberout");$("#theForm").submit();
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=memberout&Act=outcancel'
				});
			}

		});

	});

	function goPage(page){
		$("#theForm").attr("action","?act=memberout&intPage=" + page);
		$("#theForm").submit();
	}

	function changeViewList(){
		$("#theForm").attr("action","?act=memberout");
		$("#theForm").submit();
	}
