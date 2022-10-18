
	$(document).ready(function() {

		$(".list_default th:first div").addClass("no_line");

		$(".list_default tr:even").addClass("bg");

		if ($("#extForm #list_style").val() == "webzine" && $("#extForm #page").val() == "1" && disp_notice == "1")
			$(".webZine li:first").css("border", "none");

		if (set_bbs_default.use_category == "1"){
			$.ajax({type: "POST", url: "action/?Act=boardcategorylist", data: "board_srl=" + set_bbs_default.srl + "&member_srl=" + set_member_srl + "&staff=" + set_bbs_default.staff_user, dataType: "json", success: function(responseText){

				if (responseText.length > 0){

					$("#bbsCategory").append($("<option value=\"0\">" + arApplMsg['total'] + "</option>"));

					for(var i = 0; i < responseText.length; i++){
						$("#bbsCategory").append($("<option value=\"" + responseText[i].code + "\">" + responseText[i].title + "</option>").prop("disabled", responseText[i].disable).prop("selected", responseText[i].selected));
					}

				}

				$("#bbsCategory").change(function(){
					$("#extForm #category").val($(this).val());
					$("#extForm").attr("method", "get");
					$("#extForm").submit();
				});

				$("#bbsCategory").val($("#extForm #category").val());

			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

		}

		var arr = new Array("no","update","regdate","voted_count","blamed_count","readed_count","comment_count","title");

		$(arr).each(function(n,p){
			if ($("#extForm #order_index").val() == p){
				$("#th_" + p).css("font-weight", "bold");
			}
		});

		$("#check_all").click(function(){
			$("input[name=bbs_seq]").prop("checked",$("#check_all").prop("checked"));
		});

		$(set_extra_form.config).each(function(n, p){
			if (p.search == "True")
				$("#searchForm #target").append("<option value=\"" + p.field + "\">" + p.title + "</option>");
		});

		$("#searchForm #target").val($("#extForm #search_target").val());
		$("#searchForm #keyword").val($("#extForm #search_keyword").val());

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

		$(".boardModule .thrum_img").each(function(n){

			if ($(this).attr("width") > 120){

				var width = $(this).attr("width");
				var height = $(this).attr("height");
				var ratio = 120 / width;

				$(this).attr("width", "120");
				$(this).attr("height", height*ratio);

			}

			if ($(this).attr("height") > 120){

				var width = $(this).attr("width");
				var height = $(this).attr("height");
				var ratio = 120 / height;

				$(this).attr("width", width*ratio);
				$(this).attr("height", 120);

			}
		});

	});