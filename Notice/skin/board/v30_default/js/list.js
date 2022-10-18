
	$(document).ready(function() {

		if (set_bbs_default.use_category == "1"){
			$.ajax({type: "POST", url: "action/?Act=boardcategorylist", data: "board_srl=" + set_bbs_default.srl + "&member_srl=" + set_member_srl + "&staff=" + set_bbs_default.staff_user + "&space=0", dataType: "json", success: function(responseText){

			var cate_cnt = 0;

				if (responseText.length > 0){
					$(".board_category").append("<ul></ul>");
					var select_css = "";

					for(var i = 0; i < responseText.length; i++){
						cate_cnt = cate_cnt + Number(responseText[i].board_count);
					}

					$(".board_category ul").append("<li><a href=\"#\" id=\"0\" onclick=\"return false;\">" + arApplMsg['total'] + "</a> <span>(" + cate_cnt + ")</span></li>");
					
					for(var i = 0; i < responseText.length; i++){
						$(".board_category ul").append("<li><a href=\"#\" id=\"" + responseText[i].code + "\" onclick=\"return false;\">" + responseText[i].title + "</a> <span>(" + responseText[i].board_count + ")</span></li>");
					}
				}

				$(".board_category li:first").addClass("first");

				if ($("#extForm #category").val() == "" || $("#extForm #category").val() == "0"){
					$(".board_category li:first").addClass("selected");
				}else{
					$(".board_category li").each(function(){
						if ($(this).children("a").attr("id") == $("#extForm #category").val())
							$(this).addClass("selected");
					});
				}

				$(".board_category li a").bind({
					click: function() {
						$("#extForm #category").val($(this).attr("id"));
						$("#extForm").attr("method", "get");
						$("#extForm").submit();
					}
				});

			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

		}

		$("#btn_select_all").click(function(){
			if ($("#chkAll").is(":checked") == true){
				$("#chkAll").prop("checked", false);
			}else{
				$("#chkAll").prop("checked", true);
			}
			if ($("#chkAll").is(":checked") == true){
				$("input[name=bbs_seq]:checkbox").prop("checked", true);
			}else{
				$("input[name=bbs_seq]:checkbox").prop("checked", false);
			}
		});

		$("#btn_board_manage").click(function(){

			if ($("input[id=bbs_seq]:checked").length == 0){
				alert(arApplMsg['isnull_select_board']);return false;
			}

			var seq = "";

			$("input[id=bbs_seq]:checked").each(function(){
				if (seq != "")
					seq += ",";
				seq += $(this).val();
			});

			var x = screen.width;
			var y = screen.height;
			var wid = (x / 2) - (500 / 2);
			var hei = (y / 2) - (320 / 2);
		
			window.open("admin/?Act=boardmanage&seq=" + seq, "board_manage", "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,width=500,height=320,top=" + hei + ",left=" + wid + ",scrolbar=no"); 

		});

		var arr = new Array("no","update","regdate","voted_count","blamed_count","readed_count","comment_count","title");

		$(arr).each(function(n,p){
			if ($("#extForm #order_index").val() == p){
				$("#th_" + p).children("a").append("<img src='" + set_bbs_default.skinapth + "images/" + set_bbs_default.skincolor + "/icon_" + $("#extForm #order_type").val() + ".gif'");
				$("#th_" + p + " img").attr("src", set_bbs_default.skinapth + "images/" + set_bbs_default.skincolor + "/icon_" + $("#extForm #order_type").val() + ".gif").removeClass("none").css({'vertical-align' : 'middle', 'margin-left' : '5px'});
			}
		});

		$(set_extra_form.config).each(function(n, p){
			if (p.search == "True")
				$("#searchForm #target").append("<option value=\"" + p.field + "\">" + p.title + "</option>");
		});

		$("#searchForm #target").val($("#extForm #search_target").val());
		$("#searchForm #keyword").val($("#extForm #search_keyword").val());

		$("#searchForm").submit(function(){

			if ($("#searchForm #target").val().replace(/\s/g, "").length == 0){
				alert(arApplMsg['isnull_search_target']);$("#searchForm #target").focus();return false;
			}
			if ($("#searchForm #keyword").val().replace(/\s/g, "").length == 0){
				alert(arApplMsg['isnull_search_keyword']);$("#searchForm #keyword").focus();return false;
			}
			$("#extForm #search_target").val($("#searchForm #target").val());
			$("#extForm #search_keyword").val($("#searchForm #keyword").val());
		
			$.ajax({type: "POST", url: "action/?Act=searchkeyword", data :"intSrl=" + set_bbs_default.srl + "&strKeyword=" + $("#searchForm #keyword").val(), dataType: "text", success: function(responseText){
				$("#extForm").attr("method","get");
				$("#extForm #page").val('1');
				$("#extForm").submit();
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

			return false;

		});

	});