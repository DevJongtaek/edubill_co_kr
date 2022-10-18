
	$(document).ready(function() {

		window.self.resizeTo(500, 400);

		$("input.input_text, textarea").unbind('focus');
		$("input.input_text, textarea").unbind('blur');

		$.fn.groupMake = function(){

			$("#group_list li").remove();

			$.ajax({type: "POST", url: "action/?Act=friendgrouplist", data: "intMemberSrl=" + $("#extForm #intMemberSrl").val(), dataType: "json", success: function(responseText){
	
				if (responseText.length > 0){
					for(var i = 0; i < responseText.length; i++){
						$("#group_list").append("<li id=\"group_" + responseText[i].group_srl + "\"><div id=\"group_text_" + responseText[i].group_srl + "\" class=\"group_text\">" + responseText[i].title + "</div><div id=\"group_input_" + responseText[i].group_srl + "\" class=\"group_input\"><input type=\"text\" class=\"input_text group_name\" /></div><a href=\"#\" name=\"btn_group_delete\" id=\"group_" + responseText[i].group_srl + "\"><img src=\"images/etc/blank.gif\" class=\"btn_delete\" /></li></a>");
					}
				}
				
				$("#group_list .group_input").hide();
	
				$("#group_list li").bind({
					dblclick: function() {
						$(this).children("#group_input_" + $(this).attr("id").split("_")[1]).children().val($(this).children("#group_text_" + $(this).attr("id").split("_")[1]).text());
						$(this).children("#group_text_" + $(this).attr("id").split("_")[1]).hide();
						$(this).children("#group_input_" + $(this).attr("id").split("_")[1]).show();
						$(this).children("#group_input_" + $(this).attr("id").split("_")[1]).children().focus();
					},
					click: function() {
						$("#group_list li").removeClass("click_bg");
						$(this).addClass("click_bg")
					},
					mouseover: function(){
						$(this).addClass("list_over");
					},
					mouseout: function(){
						$(this).removeClass("list_over");
					}
				});

				$("a[name=btn_group_delete]").click(function(){
					if (confirm(arApplMsg['confirm_delete'])){
						$.ajax({type: "POST", url: "action/?Act=friendgroupremove", data: "intMemberSrl=" + $("#extForm #intMemberSrl").val() + "&intGroupSrl= " + $(this).attr("id").split("_")[1], success: function(responseText){
							$().groupMake();
						 },
							 error: function(response){alert('error\n\n' + response.responseText);return false;}
						});
					}
				});

				$("#group_list li div.group_input").dblclick(function(){
					return false;
				});
	
				$("#group_list .group_input").focusout(function(){
					if ($(this).children().val().replace(/\s/g, "").length == 0) {
						alert(arApplMsg['isnull_group_name']);$(this).children().focus();return false;
					}

					var n_group = $(this);

					if ($(this).parent().children(".group_text").text() != $(this).children().val()){

						$.ajax({type: "POST", url: "action/?Act=friendgroupmodify", data: "intMemberSrl=" + $("#extForm #intMemberSrl").val() + "&intGroupSrl= " + $(this).attr("id").split("_")[2] + "&strGroupName=" + $(this).children().val(), success: function(responseText){

							n_group.parent().children(".group_text").text(n_group.children().val());
							n_group.hide();
							n_group.parent().children(".group_text").show();
							
						 },
							 error: function(response){alert('error\n\n' + response.responseText);return false;}
						});

					}else{
						$(this).hide();
						$(this).parent().children(".group_text").show();
					}
					
				});
	
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

		}

		$().groupMake();

		$("#btn_regist").click(function(){

			if ($("#group_name").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_group_name']);$("#group_name").focus();return false;
			}

			if (confirm(arApplMsg['confirm_regist'])){

				$.ajax({type: "POST", url: "action/?Act=friendgroupadd", data: "intMemberSrl=" + $("#extForm #intMemberSrl").val() + "&strGroupName=" + $("#theForm #group_name").val(), success: function(responseText){

					$().groupMake();
					
				 },
					 error: function(response){alert('error\n\n' + response.responseText);return false;}
				});

			}

		});

		$("#btn_close").click(function(){
			self.close();
		});

	});