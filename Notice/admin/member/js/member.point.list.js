
	var nowSortID = "thReg";
	var nowSortDsc = "dsc";
	var nowPage = 1

	$(document).ready(function() {

		$("#content select").msDropDown();

		Point.MakeListHead();
		Point.MakeListBody(nowPage);

		$("#" + nowSortID + " div").addClass("on hand");
		$("#" + nowSortID + " div img").attr("src", "images/btn_arrow_click.gif");

		$("#thReg div, #thPoint div").bind({
			click : function(){
				Point.ListSort(nowSortID, $(this).parent().attr("id"));
				Point.MakeListBody(nowPage);
				
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

		$("#btn_search").click(function(){
			if (!checkStringLength($("#searchText").val(), 3)){
				alert(arApplMsg["is_null_search_keyword"]);$("#searchText").focus();return false;
			}
			Point.MakeListBody('1');
		});

		$("#btn_remove").click(function(){

			if ($("#theForm input:checked").length == 0){
				alert(arApplMsg["cart_is_null"]);return false;
			}
	
			if (confirm(arApplMsg["confirm_delete"])){
				$("#theForm").ajaxSubmit({
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;
							return false;
						}
						Point.MakeListBody(1);
					},
					error:function(response){alert('error\n\n' + response.responseText);}, 
					type:'post', url:'action/?subAct=pointconfig&Act=remove'
				});
			}

		});

		swfobject.embedSWF("images/loding.swf", "loadingIcon", "16", "16", "9.0.0","../images/etc/expressInstall.swf");

	});

	var Point = function() {}
	
	Point.MakeListHead = function() {
		var tableHeader = "#pointListHead tr th"
		for(var i = 0; i < 9; i++){
			if (i == 8 || i == 7){
				$(tableHeader + ":eq(" + i + ")").addClass("sort");
				$(tableHeader + ":eq(" + i + ") div").append("<img src='images/blank.gif' width='7' height='4'>");
			}
		}
	}

	Point.MakeListBody = function(page) {

		Point.LoadingBox('');

			$.ajax({type: "POST", url: "action/?subAct=pointlistbody", data: "pagemode=list&intPage=" + page + "&sortid=" + nowSortID + "&sortdsc=" + nowSortDsc + "&searchMode=" + $("#searchMode").val() + "&searchText=" + $("#searchText").val() + "&intYear=" + $("#intYear").val() + "&intMonth=" + $("#intMonth").val() + "&intDay=" + $("#intDay").val() + "&pointType=" + $("#pointType").val() + "&intPageSize=" + $("#intPageSize").val(), dataType: "json", success: function(responseText){

				if (responseText.length == 0){
					$("#totalCnt").text('0');
					$("#noDataDiv").show();
				}else{
					$("#totalCnt").text(responseText[0].total);
					$("#noDataDiv").hide();
				}

				var html = "";
	
				for(var i = 0; i < responseText.length; i++){
					html += "<tr>";
					html += "<td></td>";
					html += "<td class=\"chk\"><input name=\"intSeq\" type=\"checkbox\" id=\"intSeq\" value=\"" + responseText[i].seq + "\"></td>";
					html += "<td class=\"detail num\">" + responseText[i].number + "</td>";
					html += "<td class=\"detail\">" + responseText[i].userid + "</td>";
					html += "<td class=\"detail\">" + responseText[i].username + "</td>";
					html += "<td class=\"detail\">" + responseText[i].nickname + "</td>";
					html += "<td class=\"detail\">" + responseText[i].description + "</td>";
					html += "<td class=\"detail num\">" + responseText[i].point + "</td>";
					html += "<td class=\"detail num\">" + responseText[i].regdate + "</td>";
					html += "</tr>";
				}
	
				$("#pointListBody").html(html);
				$("input:checkbox").checkbox();
	
		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

		$.ajax({type: "POST", url: "action/?subAct=pointlistbody", data: "pagemode=page&intPage=" + page + "&sortid=" + nowSortID + "&sortdsc=" + nowSortDsc + "&searchMode=" + $("#searchMode").val() + "&searchText=" + $("#searchText").val() + "&intYear=" + $("#intYear").val() + "&intMonth=" + $("#intMonth").val() + "&intDay=" + $("#intDay").val() + "&pointType=" + $("#pointType").val() + "&intPageSize=" + $("#intPageSize").val(), 
			success: function(responseText){
				$("#pagingArea").html(responseText);
				Point.LoadingBox('c');
			 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

	}

	Point.ListSort = function(pid, id) {

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

	Point.LoadingBox = function(c){

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
		Point.MakeListBody(page);
	}