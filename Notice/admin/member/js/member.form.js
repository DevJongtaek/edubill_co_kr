
	var selectMenuID = "";

	$(document).ready(function() {

		$("#menu_container_fix li").click(function(){

			$(this).removeClass("menu_container_over");
			$("#menu_container li").removeClass("menu_container_selected");
			$("#menu_container_fix li").removeClass("menu_container_selected");
			$(this).addClass("menu_container_selected");

			$("#notice_default").addClass("none");

			$.ajax({type: "POST", url: "action/?subAct=memberformadd&Act=formedit", data: "fieldName=" + $(this).attr("id"), dataType: "html", success: function(responseText){
				if (responseText == "ERROR"){
					document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
				}
				$("#detail_table").html(responseText);
				},
				error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

		});

		$("#menu_container_fix li").mouseover(function(){
			$(this).addClass("menu_container_over");
		}).mouseout(function(){
			$(this).removeClass("menu_container_over");
		});

		MemberForm.PageInit();

		$("#notice_default").removeClass("none");

		$("#btn_order_reset").click(function(){

			if (confirm(arApplMsg["confirm_reset"])){
				$.ajax({type: "POST", url: "action/?subAct=memberform&Act=formreset", dataType: "html", success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}
					$("#menu_container").html(responseText);
					MemberForm.PageInit();
					},
					error: function(response){alert('error\n\n' + response.responseText);return false;}
				});
			}

		});

	});

	var MemberForm = function () {}

	MemberForm.PageInit = function() {

		$("#menu_container li").bind({
			mouseover: function() {
				$(this).addClass("menu_container_over");
			},
			mouseout: function() {
				$(this).removeClass("menu_container_over");
			}			
		});

		$("#menu_container").dragsort({ dragSelector: "div", dragBetween: true, placeHolderTemplate: "<li class='placeHolder'><div style='border:dashed 1px #CCC; height:16px;'></div></li>", dragEnd: function() {
			$(this).removeClass("menu_container_over");
			$("#menu_container li").removeClass("menu_container_selected");
			$("#menu_container_fix li").removeClass("menu_container_selected");
			$(this).addClass("menu_container_selected");

			selectMenuID = $(this).attr("id");

			for(var i = 0; i < $("#menu_container li").length; i++) {
				if($(this).attr("id") == $("#menu_container li")[i].id){
					var change_order = i + 1;
				}
			}

			if ($(this)[0].order != change_order){
				$.ajax({type: "POST", url: "action/?subAct=memberform&Act=formorder", data: "jfield=" + $(this).attr("id") + "&ordernum=" + change_order, dataType: "html", success: function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
						}
					},
					error: function(response){alert('error\n\n' + response.responseText);return false;}
				});
			}
				
			$("#notice_default").addClass("none");

			$.ajax({type: "POST", url: "action/?subAct=memberformadd&Act=formedit", data: "fieldName=" + $(this).attr("id"), dataType: "html", success: function(responseText){
				if (responseText == "ERROR"){
					document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
				}
				$("#detail_table").html(responseText);
				},
				error: function(response){alert('error\n\n' + response.responseText);return false;}
			});
				
			}
		});

	}

	MemberForm.MenuMove = function(m) {

		if (selectMenuID == ""){
			alert(arApplMsg["select_move_item"]);return false;
		}

		for(var i = 0; i < $("#menu_container li").length; i++) {
			if(selectMenuID == $("#menu_container li")[i].id){
				var change_order = i + 1;
			}
		}

		switch (m){
			case "m"  : change_order = change_order - 1; break;
			case "p"  : change_order = change_order + 1; break;
			case "me" : change_order = 1; break;
			case "pe" : change_order = $("#menu_container li").length; 	break;
		}

		$.ajax({type: "POST", url: "action/?subAct=memberform&Act=formorder", data: "jfield=" + selectMenuID + "&ordernum=" + change_order+ "&resetlist=yes", dataType: "html", success: function(responseText){
			if (responseText == "ERROR"){
				document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
			}
			$("#menu_container").html(responseText);
			MemberForm.PageInit();
		},
			error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

	}
	
	MemberForm.FormType = function () {

		if ($("#strFormType").val() == "email" || $("#strFormType").val() == "radio" || $("#strFormType").val() == "select" || $("#strFormType").val() == "checkbox")
			$("#dispFormOption").show();
		else
			$("#dispFormOption").hide();

		if ($("#strFormType").val() == "text" || $("#strFormType").val() == "email" || $("#strFormType").val() == "url" || $("#strFormType").val() == "userid" || $("#strFormType").val() == "textarea" || $("#strFormType").val() == "password" || $("#strFormType").val() == "sign")
			$("#dispWidth").show();
		else
			$("#dispWidth").hide();

	}