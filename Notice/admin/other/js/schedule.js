
	$(document).ready(function() {

		$(".schedule_day, #btn_schedule_add").click(function(e){

			var now = new Date();

			if ($(this).attr("id") == "btn_schedule_add"){
				var iYear = String(now.getFullYear());
				var iMonth = String(now.getMonth()+1);
				var iDay = String(now.getDate());
			}else{
				var date = $(this).attr("id").split(".");
				var iYear = date[0];
				var iMonth = date[1];
				var iDay = date[2];
			}

			var sDate = iYear + ".";
			if (iMonth.length == 1)
				sDate += "0";
			sDate += iMonth + ".";

			if (iDay.length == 1)
				sDate += "0";
			sDate += iDay;

			var iHour = String(now.getHours());
			var iMinute = String(now.getMinutes());

			$("#strStartDate").val(sDate);
			$("#strEndDate").val(sDate);

			$("#strStartHour > option[value=" + iHour + "]").prop("selected", true);
			$("#strStartMinute > option[value=" + iMinute + "]").prop("selected", true);

			$("#strEndHour > option[value=" + iHour + "]").prop("selected", true);
			$("#strEndMinute > option[value=" + iMinute + "]").prop("selected", true);

			$("#strTitle").val("");
			$("#strContent").val("");
			$("#strAct").val("add");
			$("#btn_remove_area").hide();
			$("#btn_icon_select").removeClass();
			$("#btn_icon_select").addClass("icon_select_off");
			$("#set_icon").removeClass();
			$("#strIcon").val('');

			$("#repeat").show();

			var posX = (Number($(window).width()) - Number($("#schedule_input").width())) / 2;
			var posY = (Number($(window).height()) - Number($("#schedule_input").height())) / 2;

			$("#schedule_input").css({ top:posY, left:posX}).show();

		});


		$("a[name=schedule_user]").click(function(){

			$("#theForm #intSeq").val($(this).attr("id"));
			$("#theForm #strAct").val("modify");

			$.ajax({ 
				type: "post", url: "action/?subAct=schedule&Act=read", data : "intSeq=" + $(this).attr("id"), 
				success:function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}
				}, error:function(response){alert('error\n\n' + response.responseText);}
			});

			$.ajax({type: "POST", url: "action/?subAct=schedule&Act=read", data: "intSeq=" + $(this).attr("id"), dataType: "json", success: function(responseText){
	
				if (responseText.length > 0){

					$("#strStartDate").val(responseText[0].sdate);
					$("#strEndDate").val(responseText[0].edate);
					$("#strStartHour > option[value=" + responseText[0].shour + "]").prop("selected", true);
					$("#strStartMinute > option[value=" + responseText[0].sminute + "]").prop("selected", true);
					$("#strEndHour > option[value=" + responseText[0].ehour + "]").prop("selected", true);
					$("#strEndMinute > option[value=" + responseText[0].eminute + "]").prop("selected", true);
					$("#strTitle").val(responseText[0].title);
					$("#strContent").val(responseText[0].content);
					$("#strContent").val(document.getElementById("strContent").innerHTML.replace(/&lt;BR&gt;/gi,"\n"));
					if (responseText[0].icon != ""){
						$("#btn_icon_select").removeClass();
						$("#btn_icon_select").addClass("icon_select_off2");
						$("#set_icon").removeClass();
						$("#set_icon").addClass("schedule_icon");
						$("#set_icon").addClass("schedule_" + responseText[0].icon);
						$("#strIcon").val(responseText[0].icon);
					}
					$("#repeat").hide();

					var posX = (Number($(window).width()) - Number($("#schedule_input").width())) / 2;
					var posY = (Number($(window).height()) - Number($("#schedule_input").height())) / 2;
		
					$("#schedule_input").css({ top:posY, left:posX}).show();
					$("#btn_remove_area").show();

				}
	
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});


		});

		$("#btn_save").click(function(){

			if ($("#strStartDate").val().replace("-","").replace("-","") > $("#strEndDate").val().replace("-","").replace("-","")){
				alert(arApplMsg["invalid_date"]);return false;
			}

			if ($("#strStartHour").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_time"]);$("#strStartHour").focus();return false;
			}

			if ($("#strStartMinute").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_time"]);$("#strStartMinute").focus();return false;
			}

			if ($("#strEndHour").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_time"]);$("#strEndHour").focus();return false;
			}

			if ($("#strEndMinute").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_time"]);$("#strEndMinute").focus();return false;
			}

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_title"]);$("#strTitle").focus();return false;
			}

			if ($("#strContent").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_content"]);$("#strContent").focus();return false;
			}

			$("#theForm").ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href.replace("&", "--**--");
						return false;
					}
					switch(responseText){
						case "SW" : alert(arApplMsg["success_saved"]); break;
						case "SE" : alert(arApplMsg["success_updated"]); break;
						case "RM" : alert(arApplMsg["success_deleted"]); break;
					}
					$("#extForm").attr("action", "?act=schedule&intYear=" + $("#nowYear").val() + "&intMonth=" + $("#nowMonth").val());
					$("#extForm").submit();
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?subAct=schedule&Act=' + $("#strAct").val()});
			return false;

		});

		$("#btn_close, #btn_cancel").click(function(){
			$("#set_icon").removeClass();
			$("#set_icon").text('ICON');
			$("#schedule_input").hide();
		});

		$("#btn_remove").bind("click",function() { 
			if (confirm(arApplMsg["confirm_delete"])){
				$.ajax({ 
					type: "post", url: "action/?subAct=schedule&Act=remove", data : "intSeq=" + $("#theForm #intSeq").val(), 
					success:function(responseText){
						if (responseText == "ERROR"){
							document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
						}
						$("#extForm").attr("action", "?act=schedule");
						$("#extForm").submit();
					}, error:function(response){alert('error\n\n' + response.responseText);}
				});
			}
    }); 

		$("#btn_prev_month").click(function(){

			$("#extForm #nowYear").val($("#extForm #prevYear").val());
			$("#extForm #nowMonth").val($("#extForm #prevMonth").val());

			$("#extForm").attr("action", "?act=schedule");
			$("#extForm").submit();

		});

		$("#btn_next_month").click(function(){

			$("#extForm #nowYear").val($("#extForm #nextYear").val());
			$("#extForm #nowMonth").val($("#extForm #nextMonth").val());

			$("#extForm").attr("action", "?act=schedule");
			$("#extForm").submit();

		});

		$("#btn_icon_select").click(function(){

			if ($("#strIcon").val() == ""){
				if ($("#btn_icon_select").hasClass("icon_select_off") == true){
					$("#btn_icon_select").removeClass("icon_select_off");
					$("#btn_icon_select").addClass("icon_select_on");
				}else{
					$("#btn_icon_select").addClass("icon_select_off");
					$("#btn_icon_select").removeClass("icon_select_on");
				}
			}else{
				if ($("#btn_icon_select").hasClass("icon_select_off2") == true){
					$("#btn_icon_select").removeClass("icon_select_off2");
					$("#btn_icon_select").addClass("icon_select_on2");
				}else{
					$("#btn_icon_select").addClass("icon_select_off2");
					$("#btn_icon_select").removeClass("icon_select_on2");
				}
			}
			
			$("#icon_list").toggle();
		});

	});

	function icon_select(icon){

		if (icon == "schedule_icon33"){
			$("#set_icon").removeClass();
			$("#set_icon").text('ICON');
			$("#strIcon").val('');
			$("#btn_icon_select").removeClass("icon_select_on2");
			$("#btn_icon_select").removeClass("icon_select_off2");
			$("#btn_icon_select").removeClass("icon_select_on");
			$("#btn_icon_select").addClass("icon_select_off");
		}else{
			$("#set_icon").removeClass();
			$("#set_icon").addClass("schedule_icon");
			$("#set_icon").addClass(icon);
			$("#strIcon").val(icon.split("_")[1]);
			$("#btn_icon_select").removeClass("icon_select_on2");
			$("#btn_icon_select").addClass("icon_select_off2");
		}
		$("#icon_list").toggle();
	}
