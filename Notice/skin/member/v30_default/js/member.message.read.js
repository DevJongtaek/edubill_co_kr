
	$(document).ready(function() {

		window.self.resizeTo(660, 650);

		if ($("#extForm #strMessageType").val() == "S"){
			$("#sender").hide();
			$("#button_reply").hide();
			$("#button_save").hide();
		}else{
			$("#receiver").hide();
			if ($("#extForm #strMessageType").val() == "T"){
				$("#button_save").hide();
			}
		}

		$("#btn_reply").click(function(){
			document.location.href = "?act=member&subAct=messagesend&member_srl=" + $("#extForm #intSenderSrl").val();
			return false;
		});

		$("#btn_save").click(function(){

			$.ajax({
				type: "post", url: "action/?Act=message&subAct=save", data : "seq=" + $("#extForm #intSeq").val(), 
				success:function(responseText){
					opener.document.location.href = "?act=member&subAct=message&message_type=" + $("#extForm #strMessageType").val();
					self.close();
					return false;
				}, error:function(response){alert('error\n\n' + response.responseText);}
			});

		});

		$("#btn_remove").click(function(){
			if (confirm(arApplMsg['confirm_delete'])){
				$.ajax({
					type: "post", url: "action/?Act=message&subAct=remove", data : "seq=" + $("#extForm #intSeq").val(), 
					success:function(responseText){
						opener.document.location.href = "?act=member&subAct=message&message_type=" + $("#extForm #strMessageType").val();
						self.close();
						return false;
					}, error:function(response){alert('error\n\n' + response.responseText);}
				});
			}

		});

		$("#btn_close").click(function(){
			self.close()
		});

	});