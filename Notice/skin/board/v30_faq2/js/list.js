
	$(document).ready(function() {

		if (set_bbs_default.use_category == "1"){

			$.ajax({type: "POST", url: "action/?Act=boardcategorylist", data: "board_srl=" + set_bbs_default.srl + "&member_srl=" + set_member_srl + "&staff=" + set_bbs_default.staff_user, dataType: "json", success: function(responseText){

				if (responseText.length > 0){

					$("#category_list").append("<li class=\"first\"></li>");
					$("#category_list").append("<li id=\"category_0\" class=\"on\"><a href=\"#\" id=\"\" onclick=\"return false;\">" + arApplMsg['total'] + "</a></li>");

					for(var i = 0; i < responseText.length; i++){
						$("#category_list").append("<li class=\"space\"></li>");
						$("#category_list").append("<li id=\"category_" + responseText[i].code + "\" class=\"off\"><a href=\"#\" id=\"" + responseText[i].code + "\" onclick=\"return false;\">" + responseText[i].title + "</a></li>");
					}

					$("#category_list li").addClass(function(n, c) {
						if ($(this).prop("className") != "first" && $(this).prop("className") != "space"){
							if ($(this).attr("id").split("_")[1] == $("#extForm #category").val()){
								$("#category_list li").each(function(){
									if ($(this).prop("className") != "first" && $(this).prop("className") != "space"){
										$(this).removeClass("on"); $(this).addClass("off");
									}
								});
								$(this).removeClass("off");
								$(this).addClass("on");
							}
						}
					});

				}

				$("#category_list li a").bind({
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

		$(".bbsList a").click(function(){

			if ($("#hDesc_" + $(this).attr("id").split("_")[1]).hasClass("on") == true){
				$("#hDesc_" + $(this).attr("id").split("_")[1]).removeClass("on");
				$("#hDesc_" + $(this).attr("id").split("_")[1]).hide();
			} else {
				$("#hDesc_" + $(this).attr("id").split("_")[1]).show();
				$("#hDesc_" + $(this).attr("id").split("_")[1]).addClass("on");
				window.blankFrame.location.href = $(this)[0].href;
			}

		});

		$.ajax({type: "POST", url: "action/?Act=boardmainlist", data: "board_srl=" + set_bbs_default.srl + "&category_srl=" + $("#extForm #category").val() + "&count=8&order_field=intRead&order_desc=desc", dataType: "json", success: function(responseText){

			if (responseText.length > 0){

				var tmpCnt = 0;
				var html = "";

				for(var i = 0; i < responseText.length; i++){
					tmpCnt++;
					if (tmpCnt == "1"){
						html+= "<tr>";
					}

					html+= "<td>";
					html+= "<img src=\"images/etc/blank.gif\" class=\"allow\" /><span style=\"color:#ff8500;\">[" + responseText[i].category_title + "]</span>";
					html+= " <a href=\"?act=bbs&bid=" + responseText[i].bid + "&category=" + responseText[i].category + "&order_index=no&order_type=desc&list_style=list&seq=" + responseText[i].seq + "\">" + responseText[i].title + "</a>";
					html+= "</td>";

					if (tmpCnt == "2"){
						html+= "</tr>";
						tmpCnt = 0;
					}
				}

				if (tmpCnt != 0){
					html+= "<td></td></tr>";
				}

				$("#bestFaq").append(html);

			}
		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});
		
		$("#chkAll").click(function(){
			if ($(this).is(":checked") == true){
				$("input[name=bbs_seq]:checkbox").prop("checked", true);
			}else{
				$("input[name=bbs_seq]:checkbox").prop("checked", false);
			}
		});

		$("#searchForm").submit(function() {
			return false;
		});

		$("#searchForm #keyword").keypress(function(event) {
			if (event.keyCode == '13')
				boardSearch();
		});

		$("#searchForm #keyword").val($("#extForm #search_keyword").val());

		$("#searchForm #btn_search").click(function(){
			boardSearch();
		});

		var boardSearch = function(){
			
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
		}

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