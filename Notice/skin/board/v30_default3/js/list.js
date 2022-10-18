
	$(document).ready(function() {

		$(".board_list thead th:first").addClass("lineL");
		$(".board_list thead th:last").addClass("lineR");

		$(".board_list thead th").each(function(n){
			if (n > 1)
				$(this).addClass("bar");
		});

		$(".board_list tr").bind({
			mouseover: function() {
				$(this).addClass("over");
			},
			mouseout: function() {
				$(this).removeClass("over");
			}
		});

		$(".move_page").keypress(function(n){
			var move_page = $(this).val();
			if (last_page_count < move_page){
				move_page = last_page_count;
			}
			if (n.which == "13"){
				$("#extForm #page").val(move_page);
				$("#extForm").submit();
			}
		});

		$("#check_all").click(function(){
			if ($(this).is(":checked")){
				$("input[name=bbs_seq]").prop("checked", false);
			}else{
				$("input[name=bbs_seq]").prop("checked", true);
			}
		});

		$(".bbsList th").each(function(){
			
		});

		if ($("#extForm #order_index").val() != ""){
			var arr = new Array("update","regdate","voted_count","blamed_count","readed_count","comment_count","title");
			$(arr).each(function(n,p){
			if ($("#extForm #order_index").val() == p){
				if ($("#extForm #order_type").val() == "desc")
					$(".order_" + p + " img").addClass("order_down");
				else
					$(".order_" + p + " img").addClass("order_up");
			}
		});
		}

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

	});