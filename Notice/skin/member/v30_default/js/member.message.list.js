
	$(document).ready(function() {

		$("#btn_move").click(function(){
			$("#extForm").attr("action", "?act=member&subAct=message&message_type=" + $("#theForm #message_type").val());
			$("#extForm").submit();
		});

		$("#theForm #message_type").val($("#extForm #strMessageType").val()).prop("selected", true);

		var wid = (screen.width / 2) - (660 / 2);
		var hei = (screen.height / 2) - (650 / 2);

		$(".message_read").click(function(){

			window.open("?act=member&subAct=messageread&seq=" + $(this).attr("id"), "", "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,scrollbars=3,width=660,height=650,top=" + hei + ",left=" + wid + ",scrolbar=no"); 

		});

		$("#btn_send").click(function(){

			window.open("?act=member&subAct=messagesend", "", "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,scrollbars=3,width=660,height=650,top=" + hei + ",left=" + wid + ",scrolbar=no");

		});

		$("#chkAll").click(function(){

			if ($("#chkAll").is(":checked") == true){
				$("input[name=seq]:checkbox").prop("checked", true);
			}else{
				$("input[name=seq]:checkbox").prop("checked", false);
			}
		});

		$("#btn_save").click(function(){

			if ($("#theForm input[name=seq]:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}

			$("#theForm").ajaxSubmit({
				success: function(responseText){
					alert(responseText);
					return false;
					$("#extForm").attr("action", "?act=member&subAct=message&message_type=" + $("#theForm #message_type").val());
					$("#extForm").submit();
				}, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=message&subAct=save'
			});

		});

		$("#btn_remove").click(function(){
			if ($("#theForm input[name=seq]:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}
			if (confirm(arApplMsg['confirm_delete'])){
				$("#theForm").ajaxSubmit({
					success: function(responseText){
						$("#extForm").attr("action", "?act=member&subAct=message&message_type=" + $("#theForm #message_type").val());
						$("#extForm").submit();
					}, 
				 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=message&subAct=remove'
				});
			}
		});

	});
