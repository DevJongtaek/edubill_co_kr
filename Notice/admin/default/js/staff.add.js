
	$(document).ready(function() {

		$("#searchTarget").msDropDown();

		$("#btn_search").click(function(){

			if ($("#searchText").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["no_keyword"]);$("#searchText").focus();return false;
			}

			$.ajax({type: "POST", url: "action/?subAct=staffsearch", data: "searchTarget=" + $("#searchTarget").val() + "&searchText=" + $("#searchText").val(), dataType: "json", success: function(responseText){

				if (responseText.length == 0){
					alert(arApplMsg["no_member"]);$("#search_list").html('');return false;
				}else{

					var html = "";

					for(var i = 0; i < responseText.length; i++){

						html += '<p class="admin"><input type="radio" name="memberSrl" id="memberSrl' + i + '" value="' + responseText[i].seq + '"><label for="memberSrl' + i + '">' + responseText[i].username + ' (' + responseText[i].userid + ') | ' + responseText[i].nickname + ' | ' + responseText[i].regdate + '</label></p>';

					}

				}

				$("#search_list").html(html);
				$("input:radio").checkbox({cls:"jquery-radio"});
	
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

		});

		$("#btn_select_all").click(function(){
			if ($(this)[0].cid == "n" || $(this)[0].cid == null){
				$('#theForm input[type=checkbox]').prop("checked", true);
				$(this)[0].cid = "y";
			}else{
				$('#theForm input[type=checkbox]').prop("checked", false);
				$(this)[0].cid = "n";
			}
			return false;
		});

		$("a[name=select_sub_all").click(function(){
			var select_id = $(this).attr("id");
			$("input[name=menuID]").each(function(a){
				if ($(this).attr("id").substring(0, 1) == select_id){
					if ($(this).prop('checked'))
						$(this).prop("checked", false);
					else
						$(this).prop("checked", true);
				}
			});
		});

		$("#theForm").submit(function() {

			if ($("#theForm #Act").val() == "staffadd"){
				if ($("#theForm input[name=memberSrl]:checked").length == 0){
					alert(arApplMsg["select_member"]);return false;
				}
			}

			if ($("#theForm input[name=menuID]:checked").length == 0){
				alert(arApplMsg["select_menu"]);return false;
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;
						return false;
					}else{
						alert(arApplMsg["success_saved"]);
						if ($("#theForm #Act").val() == "staffadd"){
							$("#extForm").attr("action","?act=stafflist");
						}else{
							$("#extForm").attr("action","?act=stafflist&intPage=" + $("#extForm #intPage").val());
						}
						$("#extForm").submit();
					}
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?subAct=staff'});
			return false;

    });
	});