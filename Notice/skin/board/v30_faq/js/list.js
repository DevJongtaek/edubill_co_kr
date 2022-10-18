
	$(document).ready(function() {

		if (set_bbs_default.use_category == "1"){

			$.ajax({type: "POST", url: "action/?Act=boardcategorylist", data: "board_srl=" + set_bbs_default.srl + "&member_srl=" + set_member_srl + "&staff=" + set_bbs_default.staff_user + "&space=0", dataType: "json", success: function(responseText){

				$(".faqTab").append("<ul></ul>");

				if (responseText.length > 0){
					$(".faqTab ul").append("<li id=\"c_0\"><a href=\"#\" id=\"0\" onclick=\"return false;\">" + arApplMsg['total'] + "</a></li>");
					for(var i = 0; i < responseText.length; i++){
						$(".faqTab ul").append("<li id=\"c_" + responseText[i].code + "\"><a href=\"#\" id=\"" + responseText[i].code + "\" onclick=\"return false;\">" + responseText[i].title + "</a></li>");
					}

					$('.faqTab ul li').addClass(function(n, c) {
						if ($("#extForm #category").val() == "" || $("#extForm #category").val() == "0"){
							if (n == 0)
								$(this).addClass("noLine selected");
						}else{
							if ($(this).attr("id").split("_")[1] == $("#extForm #category").val())
								$(this).addClass("noLine selected");
						}
					});
				}

				$(".faqTab li a").bind({
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

		$(".list_body .document_read, .list_body .document_print").click(function(){

			if ($(this).attr("id") == "document_print"){
				window.open("?Act=document&bid=" + $("#extForm #bid").val() + "&seq=" + $(this).attr("href").split("#")[1]);
			}else{
				if ($($(this).attr('href')).hasClass('on') == true){
					$($(this).attr('href')).removeClass("on");
					$("#hDesc_" + $(this).attr('href').split("_")[1]).hide();;
				}else{
					$($(this).attr('href')).addClass("on");
					$("#hDesc_" + $(this).attr('href').split("_")[1]).show();;
				}
			}

		});


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

		$("#searchForm").submit(function() {

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

		$("#searchForm #keyword").val($("#extForm #search_keyword").val());

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

	});