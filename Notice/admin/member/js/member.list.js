
	var columns = [

			{ id:"thCheck", display: "", width:15, sort:false},
			{ id:"thNumber", display: "", width:50, sort:false},
			{ id:"thGrade", display: "", width:100, sort:false},
			{ id:"thLevel", display: "", width:60, sort:false},
			{ id:"thId", display: "", sort:false},
			{ id:"thName", display: "", width:100, sort:false},
			{ id:"thNick", display: "", width:100, sort:false},
			{ id:"thReg", display: "", width:85, sort:true},
			{ id:"thLast", display: "", width:85, sort:true},
			{ id:"thVisit", display: "", width:60, sort:true},
			{ id:"thArticle", display: "", width:80, sort:true},
			{ id:"thComment", display: "none", width:60, sort:true},
			{ id:"thGender", display: "none", width:60, sort:false},
			{ id:"thBirth", display: "none", width:100, sort:false},
			{ id:"thArea", display: "none", width:60, sort:false},
			{ id:"thMail", display: "none", width:80, sort:false},
			{ id:"thAuth", display: "none", width:45, sort:false},
			{ id:"thPoint", display: "none", width:80, sort:false},
			{ id:"thStop", display: "none", width:80, sort:false},
			{ id:"thNoLogin", display: "none", width:85, sort:false},
			{ id:"thSet", display: "", width:20, sort:false}
			
		];

	$(document).ready(function() {

		$("#content select").msDropDown();

		Member.GetColumnsCookie();
		Member.MakeHeader();
		Member.MakeBody(nowPage);

		$("#columnSetLayer").click(function(){
			clickAreaCheck = true;
		});

		$("#columnSetLayer input:checkbox").click(function(){

			if ($(this).is(':checked')){
				$(this).prop("checked", false);
			}else{
				$(this).prop("checked", true);
			}

			if ($(this).is(':checked')){
				if ($("#columnSetLayer input:checkbox:checked").length > 4){
					alert(arApplMsg["invalid_search_count"]);
					$(this).prop("checked", false);
					return false;
				}else{
					columns[$(this).val()].display = "";
				}
			}else{
				columns[$(this).val()].display = "none";
			}

			var cookieColumns = ""
			for (var j = 0; j < columns.length; j++){
				if (cookieColumns != "")
					cookieColumns += "|";
				if (columns[j].display == ""){
					cookieColumns += "block"
				}
			}

			var options = { path: '/', expires: 31 };
			$.cookie("arty30_member", cookieColumns, options);

			$("#memberListHead tr th:eq(" + $(this).val() + ")").css({"width":columns[$(this).val()].width, "display":columns[$(this).val()].display});

			for (var j = 0; j < $("#memberListBody tr").length; j++){
				$("#memberListBody tr:eq(" + j + ") td:eq(" + $(this).val()  + ")").css("display", columns[$(this).val()].display);
			}

			return false;

		});

		$("#thReg div, #thLast div, #thVisit div, #thArticle div, #thComment div").bind({
			click : function(){
				Member.ListSort(nowSortID, $(this).parent().attr("id"));
				Member.MakeBody(nowPage);
			},
			mouseover: function() {
				obj = "#" + $(this).parent().attr("id") + " div";
				if ($(obj + ".on").length == 0){
					$(this).toggleClass("listDefaultOver");
					$(this).children("div img").attr("src","images/btn_arrow_click.gif");
				}
			},
			mouseout: function() {
				obj = "#" + $(this).parent().attr("id") + " div";
				if ($(obj + ".on").length == 0){
					$(this).toggleClass("listDefaultOver");
					$(this).children("div img").attr("src","images/btn_arrow.gif");
				}
			}			
		});

		$("#btn_column_set").click(function(){
			$(this).addClass("close_column");
			$("#btn_column_set").removeClass("open_column");
			clickAreaCheck = true;
			$("#columnSetLayer").show();
			$("#columnSetLayer").css({"top":$(this).position().top + 28 + "px", "left":"835px"});
		});

		if ($("#search_option").val() == "detail"){
			$("#detailSearchDiv").show();
		}else{
			$("#detailSearchDiv").hide();
		}

		$("input[name=detail_search]:checked").each(function() {

			switch($(this).val()){
				case "0" : $("#etcSearch").hide();$("#pointSearch").hide();$("#birthSearch").hide();break;
				case "1" : $("#termSearch").hide();$("#pointSearch").hide();$("#birthSearch").hide();break;
				case "2" : $("#termSearch").hide();$("#etcSearch").hide();$("#birthSearch").hide();break;
				case "3" : $("#termSearch").hide();$("#etcSearch").hide();$("#pointSearch").hide();break;
			}
		});

		$("#memberPointDiv").toggle();

		$("#btn_search_detail").click(function(){
			$("#btn_search_detail span").toggleClass("add");
			$("#btn_search_detail span").toggleClass("add");
			$("#detailSearchDiv").toggle();
		});

		$("#detailSearcForm input:radio").click(function() {
			$("#termSearch").hide();$("#etcSearch").hide();$("#pointSearch").hide();$("#birthSearch").hide();
			switch ($(this).val()){
				case "0" : $("#termSearch").show();break;
				case "1" : $("#etcSearch").show();break;
				case "2" : $("#pointSearch").show();break;
				case "3" : $("#birthSearch").show();break;
			}
		});

		/* search */

		$("#btn_search").click(function(){
			if ($("#searchText").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_search_keyword"]);$("#searchText").focus();return false;
			}
			
			if (!checkStringLength($("#searchText").val(), 3)){
				alert(arApplMsg["invalid_search_keyword"]);$("#searchText").focus();return false;
			}

			searchOption = "default";
			Member.MakeBody('1');
		});

		$("#btn_term_search").click(function(){
			searchOption = "detail";
			Member.MakeBody('1');
		});

		$("#btn_etc_search").click(function(){
			if ($("#etcAuth").val() == "" && $("#etcSex").val() == ""){
				alert(arApplMsg["select_auth_sex"]);$("#searchText").focus();return false;
			}
			searchOption = "detail";
			Member.MakeBody('1');
		});

		$("#btn_point_search").click(function(){
			if ($("#startPoint").val().length == 0){
				alert(arApplMsg["null_search_point"]);$("#startPoint").focus();return false;
			}
			if ($("#endPoint").val().length == 0){
				alert(arApplMsg["null_search_point"]);$("#endPoint").focus();return false;
			}
			searchOption = "detail";
			Member.MakeBody('1');
		});

		$("#btn_birth_search").click(function(){
			searchOption = "detail";
			Member.MakeBody('1');
		});

		$("#btn_change").click(function(){

			if ($("#gradeList").val().length == 0 && $("#levelList").val().length == 0){
				alert(arApplMsg["select_group_level"]);$("#gradeList").focus();return false;
			}

			if ($("#theForm #memberListBody input:checked").length == 0){
				var msg = arApplMsg["confirm_change_group1"].replace("<br>","\n");
			}else{
				var msg = arApplMsg["confirm_change_group2"];
			}
	
			if (confirm(msg)){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						Member.MakeBody(nowPage);
						$("#checkall").prop("checked", false);
						$("#checkall")[0].cid = "n";
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=memberlist&Act=grouplevel'
				});
			}

		});

		$("#btn_member_remove").click(function(){

			if ($("#theForm #memberListBody input:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}

			if (confirm(arApplMsg["confirm_delete_member"].replace("<br>", "\n"))){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						if (responseText != "0"){
							alert(arApplMsg["amin_not_delete"]);
						}
						Member.MakeBody(nowPage);
						$("#checkall").prop("checked", false);
						$("#checkall")[0].cid = "n";
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=memberlist&Act=remove'
				});				
			}

		});

		$("#btn_withdraw").click(function(){

			if ($("#theForm #memberListBody input:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}

			if (confirm(arApplMsg["confirm_out_member"].replace("<br>", "\n").replace("<br>", "\n"))){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						if (responseText != "0"){
							alert(arApplMsg["invalid_admin_out"]);
						}
						Member.MakeBody(nowPage);
						$("#checkall").prop("checked", false);
						$("#checkall")[0].cid = "n";
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=memberlist&Act=leave'
				});
			}
		});

		$("#btn_point_toggle").click(function(){
			$("#memberPointDiv").toggle();
		});

		$("#btn_point_add").click(function(){

			if ($("#addpoint").val().length == 0){
				alert(arApplMsg["null_give_point"]);$("#addpoint").focus();return false;
			}

			if ($("#pointMemo").val().length == 0){
				alert(arApplMsg["null_give_point_memo"]);$("#pointMemo").focus();return false;
			}

			if ($("#theForm #memberListBody input:checked").length == 0){
				var msg = arApplMsg["give_point_all"];
			}else{
				var msg = arApplMsg["give_point_memmber"];
			}

			if (confirm(msg)){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						Member.MakeBody(nowPage);
						$("#memberPointDiv").toggle();
						$("#addpoint").val('');
						$("#pointMemo").val('');
						document.getElementById('addminus').refresh();
						$("#checkall").prop("checked", false);
						$("#checkall")[0].cid = "n";
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=memberlist&Act=point'
				});
			}

		});

		$("#btn_excel_down").click(function(){

			var url = "action/?subAct=memberlist&Act=excel&intPage=" + $("#excelCount").val() + "&sortid=" + nowSortID + "&sortdsc=" + nowSortDsc;

			if (searchOption!="")
				url += "&searchOption=" + searchOption;

			$("#theForm").attr("action",url);
			$("#theForm").submit();

		});

		swfobject.embedSWF("images/loding.swf", "loadingIcon", "16", "16", "9.0.0","../images/etc/expressInstall.swf");

	});

	var Member = function() {}

	Member.GetColumnsCookie = function() {
		if ($.cookie("arty30_member") == null)
			cookieColumns = "block|block|block|block|block|block|block|block|block|block|block||||||||||block"
		else
			cookieColumns = $.cookie("arty30_member");

		cookieColumns = cookieColumns.split("|") ;
		for(var i = 0; i < cookieColumns.length; i++){
			if (cookieColumns[i] == "block")
				columns[i].display = "";
			else
				columns[i].display = "none";
		}
	}

	Member.MakeHeader = function() {
		for(var i = 0; i < columns.length; i++){
			$("#memberListHead tr th:eq(" + i + ")").css({"width":columns[i].width, "display":columns[i].display});
			if (columns[i].sort == true){
				$("#memberListHead tr th:eq(" + i + ")").addClass("sort");
				$("#memberListHead tr th:eq(" + i + ") div").append("<img src='images/blank.gif' width='7' height='4'>");
			}
		}

		$("#columnSetLayer input:checkbox").each(function(j){
			if (columns[$("#columnSetLayer input:checkbox:eq(" + j + ")").val()].display == "")
				$("#columnSetLayer input:checkbox:eq(" + j + ")").prop("checked", true);
			else
				$("#columnSetLayer input:checkbox:eq(" + j + ")").prop("checked", false);
		});

		$("#" + nowSortID + " div").addClass("on hand");
		$("#" + nowSortID + " div img").attr("src","images/btn_arrow_click.gif");

	}

	Member.MakeBody = function(page) {

		Member.LoadingBox('');

		var data = "";

		if (searchOption!=""){
			data += "&searchOption=" + searchOption;
			switch (searchOption){
			case "default" :
				data += "&searchMode=" + $("#searchMode").val() + "&searchText=" + $("#searchText").val();
				break;
			case "detail" :
				data += "&detail_search=" + $("#detailSearcForm input:checked").val();
				switch ($("#detailSearcForm input:checked").val()){
				case "0" : data += "&startTermDate=" + $("#startTermDate").val() + "&endTermDate=" + $("#endTermDate").val() + "&termType=" + $("#termType").val(); break;
				case "1" : data += "&etcAuth=" + $("#etcAuth").val() + "&etcSex=" + $("#etcSex").val(); break;
				case "2" : data += "&startPoint=" + $("#startPoint").val() + "&endPoint=" + $("#endPoint").val(); break;
				case "3" : 	data += "&birthType=" + $("#birthType").val(); break;
				}
				break;
			}
		}

		$.ajax({type: "POST", url: "action/?subAct=memberlistbody", data: "pagemode=list&intPage=" + page + "&sortid=" + nowSortID + "&sortdsc=" + nowSortDsc + "&memberType="  + $("#viewMemberType").val() + "&groupCode=" + $("#viewGradeList").val() + "&memberLevel=" + $("#viewLevelList").val() + "&intPageSize=" + $("#intPageSize").val() + data, dataType: "json", success: function(responseText){

			if (responseText.length == 0){
				$("#totalCnt").text('0');$("#noDataDiv").show();
			}else{
				$("#totalCnt").text(responseText[0].total);$("#noDataDiv").hide();
			}

			var html = "";

			for(var i = 0; i < responseText.length; i++){

				html += "<tr>";
				html += "<td class=\"chk\"><input name=\"intSeq\" type=\"checkbox\" id=\"intSeq\" value=\"" + responseText[i].seq + "\"></td>";
				html += "<td class=\"detail num\">" + responseText[i].number + "</td>";
				html += "<td class=\"detail\">" + responseText[i].groupcode + "</td>";
				html += "<td class=\"detail\">" + responseText[i].level + "</td>";
				html += "<td class=\"detail\">" + responseText[i].userid + "</td>";
				html += "<td class=\"detail\"><a href=\"javascript:;\" onClick=\"Member.DispMember('" + responseText[i].seq + "');return false;\">" + responseText[i].username + "</a></td>";
				html += "<td class=\"detail\">" + responseText[i].nickname + "</td>";
				html += "<td class=\"detail num\">" + responseText[i].regdate + "</td>";
				html += "<td class=\"detail num\">" + responseText[i].visitdate + "</td>";
				html += "<td class=\"detail num\">" + responseText[i].visit + "</td>";
				html += "<td class=\"detail num\">" + responseText[i].article + "</td>";
				html += "<td class=\"detail num\">" + responseText[i].comment + "</td>";
				html += "<td class=\"detail\">" + responseText[i].sex + "</td>";
				html += "<td class=\"detail num\">" + responseText[i].birthday + "</td>";
				html += "<td class=\"detail\">" + responseText[i].sido + "</td>";
				html += "<td class=\"detail\">" + responseText[i].mailing + "</td>";
				html += "<td class=\"detail\">" + responseText[i].auth + "</td>";
				html += "<td class=\"detail num\">" + responseText[i].point + "</td>";
				html += "<td class=\"detail\">" + responseText[i].usestop + "</td>";
				html += "<td class=\"detail num\">" + responseText[i].nologin + "</td>";
				html += "<td></td>";
				html += "</tr>";
			}

			$("#memberListBody").html(html);
			$("input:checkbox").checkbox();

			$("#memberListBody tr").each( function(j){
				for(var i = 0; i < columns.length; i++){
					$("#memberListBody tr:eq(" + j + ") td:eq(" + i + ")").css("display", columns[i].display);
				}
			});

		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

		$.ajax({type: "POST", url: "action/?subAct=memberlistbody", data: "pagemode=page&intPage=" + page + "&intPageSize=" + $("#intPageSize").val() + "&memberType="  + $("#viewMemberType").val() + "&groupCode=" + $("#viewGradeList").val() + "&memberLevel=" + $("#viewLevelList").val() + data, 
			success: function(responseText){
				$("#pagingArea").html(responseText);Member.LoadingBox('c');
			 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

		$.ajax({type: "POST", url: "action/?subAct=memberlistbody",  data: "pagemode=excel&intPage=1&intPageSize=2000" + "&memberType="  + $("#viewMemberType").val() + "&groupCode=" + $("#viewGradeList").val() + "&memberLevel=" + $("#viewLevelList").val() + data, dataType: "json", success: function(responseText){

			document.getElementById("excelCount").options.length = 0;

			for(var i = 0; i < responseText.length; i++){

				document.getElementById('excelCount').options[i] = new Option(responseText[i].exceltitle, responseText[i].excelpage);
				document.getElementById('excelCount').selectedIndex =0;

				if(document.getElementById('excelCount').refresh!=undefined)
					document.getElementById('excelCount').refresh();

			}

		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

	}

	Member.ListSort = function(pid, id){

		if (pid == id){
			if (nowSortDsc == "dsc"){
				$("#" + nowSortID + " div img").attr("src","images/btn_arrow_click02.gif");
				nowSortDsc = "asc";
			}else{
				$("#" + nowSortID + " div img").attr("src","images/btn_arrow_click.gif");
				nowSortDsc = "dsc";
			}
		}else{
			$("#" + pid + " div").removeClass("on");
			$("#" + pid + " div img").attr("src","images/btn_arrow.gif");
			$("#" + pid + " div").removeClass("listDefaultOver");
			$("#" + id + " div").addClass("on");
			$("#" + id + " div img").attr("src","images/btn_arrow_click.gif");
			nowSortID = id;
			nowSortDsc = "dsc";
		}

	}

	Member.DispMember = function(seq){
		$("#search_option").val(searchOption);
		$("#theForm").attr("action","?act=memberdisp&intSeq=" + seq);
		$("#theForm").submit();		
	}

	Member.LoadingBox = function(c){

		var w = ($(document.body).width() / 2) - 92;
		var h = ($(document.body).height() / 2) - 22;

		$("#loadingBox").css({"top":h, "left":w});
		$("#loadingLayer").css({"top":h, "left":w});

		if (c == ""){
			$("#loadingBox").toggle();
			$("#loadingLayer").toggle();
		}else{
			$("#loadingBox").toggle();
			$("#loadingLayer").toggle();
		}		

	}

	function goPage(page){
		nowPage = page;
		Member.MakeBody(page);
	}

	document.onclick = function() {
		if (!clickAreaCheck) {
			$("#columnSetLayer").hide();
			$("#btn_column_set").removeClass("close_column");
			$("#btn_column_set").addClass("open_column");
		} else {
			clickAreaCheck = false;
		}
	
	}