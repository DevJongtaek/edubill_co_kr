	var clickAreaCheck = false;

	$(document).ready(function() {

		$("input:checkbox").checkbox({cls:"jquery-checkbox", empty: "images/input/empty.png"});
		$("input:radio").checkbox({cls:"jquery-radio", empty: "images/input/empty.png"});
		$(".integer").numeric();

		if (set_bbs_default.use_category == "1"){

			$.ajax({type: "POST", url: "action/?Act=boardcategorylist", data: "board_srl=" + set_bbs_default.srl + "&member_srl=" + set_member_srl + "&staff=" + set_bbs_default.staff_user + "&space=0", dataType: "json", success: function(responseText){

				var cate_cnt = 0;

				if (responseText.length > 0){
					for(var i = 0; i < responseText.length; i++){
						cate_cnt = cate_cnt + Number(responseText[i].board_count);
					}

				$("#board_category_data").append("<li class=\"cate_0\"><a id=\"cate_0\" href=\"#\" class=\"first\" onclick=\"return false;\">전체<span>(" + cate_cnt + ")</span></a></li>");

				for(var i = 0; i < responseText.length; i++){
					$("#board_category_data").append("<li><a id=\"cate_" + responseText[i].sys_code + "\" href=\"#\" onclick=\"return false;\">" + responseText[i].title + "<span>(" + responseText[i].board_count + ")</span></a></li>");
				}


				if ($("#extForm #category").val() == "" || $("#extForm #category").val() == "0"){
					$("#board_category_data li a:eq(0)").addClass("on");
				}else{
					$("#board_category_data li").each(function(){
						if ($(this).children("a").attr("id").split("_")[1] == $("#extForm #category").val())
							$(this).children("a").addClass("on");
					});
				}

				$("#board_category_data li a").bind({
					click: function() {
						$("#extForm #category").val($(this).attr("id").split("_")[1]);
						$("#extForm").attr("method", "get");
						$("#extForm").submit();
					}
				});

				}

			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

		} else {
			$(".board_category").remove();
		}

	});