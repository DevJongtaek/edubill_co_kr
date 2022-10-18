
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#checkall1").click(function(){
			if (this.cid == "n"){
				$('#theForm input[type=checkbox]').prop("checked", true);
				this.cid = "y";
			}else{
				$('#theForm input[type=checkbox]').prop("checked", false);
				this.cid = "n";
			}
			return false;
		});

		$("#checkall2").click(function(){
			if (this.cid == "n"){
				$('#theForm2 input[type=checkbox]').prop("checked", true);
				this.cid = "y";
			}else{
				$('#theForm2 input[type=checkbox]').prop("checked", false);
				this.cid = "n";
			}
			return false;
		});

		$("#btn_search1").click(function(){
			if ($("#searchText1").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_search_keyword"]);$("#searchText1").focus();return false;
			}
			if (!checkStringLength($("#searchText1").val(), 3)){
				alert(arApplMsg["invalid_search_keyword"]);$("#searchText1").focus();return false;
			}
			Member.List('1', '1');
		});

		$("#btn_search2").click(function(){
			if ($("#searchText2").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_search_keyword"]);$("#searchText2").focus();return false;
			}
			if (!checkStringLength($("#searchText2").val(), 3)){
				alert(arApplMsg["invalid_search_keyword"]);$("#searchText2").focus();return false;
			}
			Member.List('1', '2');
		});

		$("#btn_cancel1").click(function(){
			$("#searchText1").val('');
			Member.List('1', '1');
		});

		$("#btn_cancel2").click(function(){
			$("#searchText2").val('');
			Member.List('1', '2');
		});

		$("#btn_mailing_group_list").click(function(){
			$("#extForm").attr("action","?act=mailinggrouplist&intPage=" + $("#intPage").val());
			$("#extForm").submit();
		});

		$("#btn_remove").click(function() {

			if ($("#theForm input:checked").length == 0){
				alert(arApplMsg["select_delete_member"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete_member"])){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						Member.List(1, "1");
						Member.List(1, "2");
						$("#checkall1").prop("checked", false);
						$("#checkall1").cid = "n";
						
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=mailinggroupmember&Act=groupremove&strGroupCode=' + SET_strGroupCode
				});
			}

		});

		$("#btn_add").click(function(){

			if ($("#theForm2 input:checked").length == 0){
				alert(arApplMsg["select_add_member"]);return false;
			}

			if (confirm(arApplMsg["confirm_add_member"])){
				$("#theForm2").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						Member.List(1, "1");
						Member.List(1, "2");
						$("#checkall2").prop("checked", false);
						$("#checkall2").cid = "n";
						
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=mailinggroupmember&Act=groupadd&strGroupCode=' + SET_strGroupCode
				});
			}

		});

		Member.List(1, "1");
		Member.List(1, "2");

	});

	var Member = function() {}

	Member.List = function(page, listType) {

		var url = "action/?subAct=mailinggroupmemberbody";
		var data = "pagemode=list" + listType + "&strGroupCode=" + SET_strGroupCode + "&intPage=" + page + "&intPageSize=" + $("#intPageSize" + listType).val() + "&strGradeCode=" + $("#viewGradeList" + listType).val() + "&intLevel=" + $("#viewLevelList" + listType).val() + "&searchMode=" + $("#searchMode" + listType).val() + "&searchText=" + $("#searchText" + listType).val();

		$.ajax({type: "POST", url: url, data: data, dataType: "json", success: function(responseText){

		if (responseText.length == 0){
			$("#totalCnt" + listType).text('0');$("#noDataDiv" + listType).show();
		}else{
			$("#totalCnt" + listType).text(responseText[0].total);$("#noDataDiv" + listType).hide();
		}

		var html = "";

		for(var i = 0; i < responseText.length; i++){
			html += "<tr>";
			html += "<td></td>";
			html += "<td class=\"chk\"><input name=\"strUserID\" type=\"checkbox\" id=\"strUserID\" value=\"" + responseText[i].userid + "\"></td>";
			html += "<td class=\"detail num\">" + responseText[i].number + "</td>";
			html += "<td class=\"detail\">" + responseText[i].groupname + "</td>";
			html += "<td class=\"detail\">" + responseText[i].level + "</td>";
			html += "<td class=\"detail\">" + responseText[i].userid + "</td>";
			html += "<td class=\"detail\">" + responseText[i].username + "</td>";
			html += "<td class=\"detail\">" + responseText[i].nickname + "</td>";
			html += "<td class=\"detail\">" + responseText[i].regdate + "</td>";
			html += "<td class=\"detail num\">" + responseText[i].visitdate + "</td>";
			html += "<td class=\"detail num\">" + responseText[i].visit + "</td>";
			html += "</tr>";
		}

		$("#memberList" + listType).html(html);
		$("input:checkbox").checkbox();
	
		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

		var data = "pagemode=page" + listType + "&strGroupCode=" + SET_strGroupCode + "&intPage=" + page + "&intPageSize=" + $("#intPageSize" + listType).val() + "&strGradeCode=" + $("#viewGradeList" + listType).val() + "&intLevel=" + $("#viewLevelList" + listType).val() + "&searchMode=" + $("#searchMode" + listType).val() + "&searchText=" + $("#searchText" + listType).val();

		$.ajax({type: "POST", url: url, data: data, 
			success: function(responseText){
				switch (listType){
					case "1" :
						$("#pagingArea").html(responseText);
						break;
					case "2" :
						$("#pagingArea2").html(responseText);
						break;
				}	
				$("#pagingArea" + listType).html(responseText);
			 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

	}

	function goPage1(page){
		Member.List(page, "1");
	}

	function goPage2(page){
		Member.List(page, "2");
	}