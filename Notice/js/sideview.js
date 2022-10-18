	var clickAreaCheck = false;

	$(document).ready(function() {

		$("a[name=popup_menu_area]").click(function(e){

			var class_name = $(this).prop('className');
			if(class_name.indexOf('_') <= 0) return;
			var class_name_list = class_name.split(' ');

			var menu_id = '';
			var menu_id_regx = /^([a-zA-Z]+)_([0-9]+)$/;

			for(var i = 0, c = class_name_list.length; i < c; i++) {
				if(menu_id_regx.test(class_name_list[i]))
					menu_id = class_name_list[i];
			}

			if(!menu_id) return;

			menu_id = menu_id.split("_");

			var html = "";

			switch (menu_id[0]){
				case "member" :
					if (menu_id[1] != "0"){
						if (set_member_srl != "0" && set_member_srl != ""){
							if (set_member_srl == menu_id[1]){
								html +="		<li class=\"icon_memo\"><a href=\"#popmenu_memo_list\" id=\"popmenu_memo_list\" class=\"member_" + menu_id[1] + "\">" + arApplMsg['popmenu_memo_list'] + "</a></li>";
								html +="		<li class=\"icon_friend\"><a href=\"#popmenu_friend_list\" id=\"popmenu_friend_list\" class=\"member_" + menu_id[1] + "\">" + arApplMsg['popmenu_friend_list'] + "</a></li>";
							}else{
								html +="		<li class=\"icon_memo\"><a href=\"#popmenu_memo_send\" id=\"popmenu_memo_send\" class=\"member_" + menu_id[1] + "\">" + arApplMsg['popmenu_memo_send'] + "</a></li>";
								if (set_sub_act != "friend")
									html +="		<li class=\"icon_friend\"><a href=\"#popmenu_friend_add\" id=\"popmenu_friend_add\" class=\"member_" + menu_id[1] + "\">" + arApplMsg['popmenu_friend_add'] + "</a></li>";
							}

						}

							$.ajax({type: "POST", url: "action/?Act=memberinfo", data: "memberSrl=" + menu_id[1], dataType: "json", success: function(responseText){
								var t = "";
								if (responseText[0].email != "")
									t +="		<li class=\"icon_email\"><a href=\"mailto:" + responseText[0].email + "\">" + arApplMsg['popmenu_email'] + "</a></li>";
								if (responseText[0].homepage != "")
									t +="		<li class=\"icon_homepage\"><a href=\"" + responseText[0].homepage + "\" target=\"_blank\">" + arApplMsg['popmenu_homepage'] + "</a></li>";

								if (set_member_srl != "0" && set_member_srl != "" && set_act == "bbs")
									t +="		<li class=\"icon_board\"><a href=\"#\" id=\"popmenu_user_board\" class=\"member_" + responseText[0].userid + "\" onclick=\"return false;\">" + arApplMsg['popmenu_document'] + "</a></li>";
								
								$(".popup_menu_area ul").append(t);

								$("#popmenu_user_board").click(function(){
									var user_id = $(this).prop("className").split("_");
									$("#extForm #search_target").val("user_id");
									$("#extForm #search_keyword").val(user_id[1]);
									$("#extForm").attr("method", "get");
									$("#extForm").submit();
								});

							 },
								 error: function(response){alert('error\n\n' + response.responseText);return false;}
							});

						}
					break;

				case "document" :

					if (set_member_srl !="" && set_member_srl !="0"){
						html +="		<li class=\"icon_vote\"><a href=\"#\" id=\"popmenu_document_vote\" onclick=\"return false;\">" + arApplMsg['popmenu_vote'] + "</a></li>";
						html +="		<li class=\"icon_blamed\"><a href=\"#\" id=\"popmenu_document_blamed\" onclick=\"return false;\">" + arApplMsg['popmenu_blamed'] + "</a></li>";
						html +="		<li class=\"icon_declare\"><a href=\"#\" id=\"popmenu_document_declare\" onclick=\"return false;\">" + arApplMsg['popmenu_declare'] + "</a></li>";
						html +="		<li class=\"icon_scrap\"><a href=\"#\" id=\"popmenu_document_scrap\" onclick=\"return false;\">" + arApplMsg['popmenu_scrap'] + "</a></li>";
					}
					html +="		<li class=\"icon_print\"><a href=\"#\" id=\"popmenu_document_print\" onclick=\"return false;\">" + arApplMsg['popmenu_print'] + "</a></li>";
					break;

				case "comment" :

					if (set_member_srl !="" && set_member_srl !="0"){
						html +="		<li class=\"icon_vote\"><a href=\"#\" id=\"popmenu_comment_vote\" class=\"comment_" + menu_id[1] + "\" onclick=\"return false;\">" + arApplMsg['popmenu_vote'] + "</a></li>";
						html +="		<li class=\"icon_blamed\"><a href=\"#\" id=\"popmenu_comment_blamed\" class=\"comment_" + menu_id[1] + "\" onclick=\"return false;\">" + arApplMsg['popmenu_blamed'] + "</a></li>";
						html +="		<li class=\"icon_declare\"><a href=\"#\" id=\"popmenu_comment_declare\" class=\"comment_" + menu_id[1] + "\" onclick=\"return false;\">" + arApplMsg['popmenu_declare'] + "</a></li>";
					}
					break;
			}

			html = "<div class=\"popup_menu_area\"><ul>" + html;
			html +="	</ul>";
			html +="</div>";

			if (menu_id[0] == "member")
				$("#popup_user_menu").css("width","130px");
			else
				$("#popup_user_menu").css("width","90px");

			var posX = "";
			var posY = "";

			if (e.pageY + $("#popup_user_menu").height() > Number($(window).height() + $(window).scrollTop()))
				posY = Number($(window).height() + $(window).scrollTop()) - Number($("#popup_user_menu").height());
			else
				posY = e.pageY;

			if(e.pageX + $("#popup_user_menu").width() > Number($(window).width()+$(window).scrollLeft()))
				posX = Number($(window).width()+$(window).scrollLeft()) - Number($("#popup_user_menu").width());
			else
				posX = e.pageX;
	
			$("#popup_user_menu").html(html).css({ top:posY, left:posX}).show();
			clickAreaCheck = true;

			$("#popmenu_memo_list").click(function(){
				document.location.href = "?act=member&subAct=message";
				return false;
			});

			$("#popmenu_memo_send").click(function(){

				var wid = (screen.width / 2) - (660 / 2);
				var hei = (screen.height / 2) - (650 / 2);
			
				window.open("?act=member&subAct=messagesend&member_srl=" + $(this).prop("className").split("_")[1], "", "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,scrollbars=3,width=660,height=650,top=" + hei + ",left=" + wid + ",scrolbar=no"); 
			
			});

			$("#popmenu_friend_add").click(function(){
				if (confirm(arApplMsg['popmenu_confirm_friend'])){
					var user_id = $(this).prop("className").split("_");

					$.ajax({
						type: "post", url: "action/?Act=friendadd", data : "friend_srl=" + user_id[1], 
						success:function(responseText){
							switch(responseText){
								case "ERROR01" : alert(arApplMsg['popmenu_error']); break;
								case "ERROR02" : alert(arApplMsg['popmenu_already_friend']); break;
								default : alert(arApplMsg['popmenu_success_friend']); break;
							}							
						}, error:function(response){alert('error\n\n' + response.responseText);}
					});

				}
			});

			$("#popmenu_friend_list").click(function(){
				document.location.href = "?act=member&subAct=friend";
				return false;
			});

			$("#popmenu_document_vote, #popmenu_comment_vote, #popmenu_document_blamed, #popmenu_comment_blamed").click(function(){

				var data = "boardSrl=" + set_bbs_default.srl + "&boardSeq=" + $("#extForm #seq").val();

				switch($(this).attr("id")){
					case "popmenu_document_vote" :
						var url = "action/?Act=boardvote";
						data += "&blamed=0";
						break;
					case "popmenu_comment_vote" :
						var url = "action/?Act=commentvote";
						data += "&commentSeq=" + $(this).prop("className").split("_")[1] + "&blamed=0";
						break;
					case "popmenu_document_blamed" :
						var url = "action/?Act=boardblamed";
						data += "&blamed=1";
						break;
					case "popmenu_comment_blamed" :
						var url = "action/?Act=commentblamed";
						data += "&commentSeq=" + $(this).prop("className").split("_")[1] + "&blamed=1";
						break;
				}

				$.ajax({
					type: "post", url: url, data : data, 
					success:function(responseText){
						switch(responseText){
							case "ERROR01" : alert(arApplMsg['popmenu_error']); break;
							case "ERROR02" : alert(arApplMsg['popmenu_fail_vote']); break;
							case "ERROR03" : alert(arApplMsg['popmenu_fail_blamed']); break;
							default :
								alert(arApplMsg['popmenu_success_vote']);
								$("#extForm").attr("method", "get");
								$("#extForm").submit();
								break;
						}							
					}, error:function(response){alert('error\n\n' + response.responseText);}
				});

			});

			$("#popmenu_document_declare, #popmenu_comment_declare").click(function(){

				var data = "board_srl=" + set_bbs_default.srl + "&board_seq=" + $("#extForm #seq").val();

				switch($(this).attr("id")){
					case "popmenu_document_declare" :
						var url = "action/?Act=boarddeclare";
						data += "&comment_seq=0";
						break;
					case "popmenu_comment_declare" :
						var url = "action/?Act=commentdeclare";
						data += "&comment_seq=" + $(this).prop("className").split("_")[1];
						break;
				}
				
				$.ajax({
					type: "post", url: url, data : data, 
					success:function(responseText){
						switch(responseText){
							case "ERROR01" : alert(arApplMsg['popmenu_error']); break;
							case "ERROR02" : alert(arApplMsg['popmenu_fail_declare']); break;
							default :
								alert(arApplMsg['popmenu_success_declare']);
								$("#extForm").attr("method", "get");
								$("#extForm").submit();
								break;
						}							
					}, error:function(response){alert('error\n\n' + response.responseText);}
				});

			});

			$("#popmenu_document_scrap").click(function(){
				$.ajax({
					type: "post", url: "action/?Act=scrapadd", data : "board_seq=" + $("#extForm #seq").val(), 
					success:function(responseText){
						switch(responseText){
							case "ERROR01" : alert(arApplMsg['popmenu_error']); break;
							case "ERROR02" : alert(arApplMsg['popmenu_already_scrap']); break;
							default : alert(arApplMsg['popmenu_success_scrap']); break;
						}							
					}, error:function(response){alert('error\n\n' + response.responseText);}
				});
			});

			$("#popmenu_document_print").click(function(){
				window.open("?Act=document&bid=" + $("#extForm #bid").val() + "&seq=" + $("#extForm #seq").val());
				return false;
			});

		});

		$(document.body).append($('<div>').attr('id', 'popup_user_menu').css({display:'none', zIndex:9999, position:'absolute', width:'130px'}));

		$(document).click(function(){
			if (!clickAreaCheck) {
				$("#popup_user_menu").hide();
				$("#popup_document_menu").hide();
			}else{
				clickAreaCheck = false;
			}
		});

	});