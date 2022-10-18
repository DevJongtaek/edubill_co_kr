
	jQuery(function($){

		var form = "#theForm";

		if (set_sub_act == "friend"){

			$.doMemberFriendGroupGet(set_member_srl);
	
			$.memberFriendGroupGetComplate = function(responseText){
				if (responseText.length > 0){
					for(var i = 0; i < responseText.length; i++){
						$("#group_name", form).get(0).options[i+1] = new Option(responseText[i].title, responseText[i].group_srl);
					}
					if ($("#intGroupSrl", "#extForm").val() != "")
						$("#group_name", form).val($("#intGroupSrl", "#extForm").val()).prop("selected", true);
				}
			}

		}

		$(".btn_group_select", form).click(function(){
			document.location.href = "?act=" + set_act + "&subAct=" + set_sub_act + "&group_srl=" + $("#group_name", form).val();
			return false;
		});

		$(".btn_friend_move", form).click(function(){

			if ($("input[name=seq]:checked", form).length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}
			
			if ($("#group_name", form).val() == ""){
				alert(arApplMsg["isnull_group"]);$("#group_name", form).focus();return false;
			}

			$.memberFriendMoveComplate = function(){
				$.doExtFormSubmit("?act=member&subAct=friend&group_srl=" + $("#group_name", form).val(), 'post');
			}
			
			if (confirm(arApplMsg['confirm_move'])){
				$.doMemberFriendMove(form, $("#group_name", form).val());
			}

		});

		$("#btn_friend_remove").click(function(){
			if ($("#theForm input[name=seq]:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}
			if (confirm(arApplMsg['confirm_delete'])){
				$("#theForm").ajaxSubmit({
					success: function(responseText){
						$("#extForm").attr("action", "?act=member&subAct=friend");
						$("#extForm").submit();
					}, 
				 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=friendremove'
				});
			}
		});

		$("#chkAll").click(function(){

			if ($("#chkAll").is(":checked") == true){
				$("input[name=seq]:checkbox").prop("checked", true);
			}else{
				$("input[name=seq]:checkbox").prop("checked",false);
			}
		});

		var wid = (screen.width / 2) - (660 / 2);
		var hei = (screen.height / 2) - (650 / 2);

		$("#btn_friend_add").click(function(){

			window.open("?act=member&subAct=friendadd", "", "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,scrollbars=3,width=660,height=650,top=" + hei + ",left=" + wid + ",scrolbar=no");

		});

		$("a[name=btn_modify]").click(function(){

			window.open("?act=member&subAct=friendmodify&seq=" + $(this).attr("id").split("_")[1], "", "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,scrollbars=3,width=660,height=650,top=" + hei + ",left=" + wid + ",scrolbar=no");

		});

		$("#btn_group_maneger").click(function(){

			window.open("?act=member&subAct=friendgroup", "", "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,scrollbars=3,width=660,height=650,top=" + hei + ",left=" + wid + ",scrolbar=no");

		});

		$("#btn_message").click(function(){

			if ($("#theForm input[name=seq]:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}

			var s_srl = ""

			$("#theForm input[name=seq]").each(function(n){
				if ($(this).prop("checked") == true){
					if (s_srl != "")
						s_srl += ",";
					s_srl += $("#theForm #member_srl:eq(" + n + ")").val();
				}
			});

			window.open("?act=member&subAct=messagesend&member_srl=" + s_srl, "", "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,scrollbars=3,width=660,height=650,top=" + hei + ",left=" + wid + ",scrolbar=no");
		
		});

		$("a[name=link_page]").click(function(){
			document.location.href = "?act=" + set_act + "&subAct=" + set_sub_act + "&group_srl=" + $("#group_name").val() + "&page=" + $(this).attr("id").split("_")[1];
			return false;
		});

	});
