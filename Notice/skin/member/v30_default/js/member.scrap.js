
	$(document).ready(function() {

		$("#chkAll").click(function(){

			if ($("#chkAll").is(":checked") == true){
				$("input[name=seq]:checkbox").prop("checked", true);
			}else{
				$("input[name=seq]:checkbox").prop("checked", false);
			}
		});

		$("#btn_remove").click(function(){
			if ($("#theForm input[name=seq]:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}
			if (confirm(arApplMsg['confirm_delete'])){
				$("#theForm").ajaxSubmit({
					success: function(responseText){
						$("#extForm").attr("action", "?act=member&subAct=scrap");
						$("#extForm").submit();
					}, 
				 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=scrapremove'
				});
			}
		});

		$("#page_size").change(function(){
			document.location.href = "?act=member&subAct=scrap&page_size=" + $(this).val();
			return false;
		});

		$("a[name=link_page]").click(function(){
			document.location.href = "?act=member&subAct=scrap&page=" + $(this).attr("id").split("_")[1] + "&page_size=" + $("#extForm #intPageSize").val();
			return false;
		});

	});