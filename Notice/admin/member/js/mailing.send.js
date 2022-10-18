
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#btn_send_mailing").click(function(){

			Mailing.SendBox('');

			$("#submitButton").hide();
			if ($("#intSendPage").val() == "0"){
				Mailing.SendMail();
				$("#sendGrp").attr("width","160");
				$("#sendPercent").html("100");
			}else{
				$("#intPageCount").val(parseInt(((eval($("#intTotalCount").val()) - 1) / eval($("#intSendPage").val())) + 1, 10));
				$("#intPageCountTemp").val(parseInt(((eval($("#intTotalCount").val()) - 1) / eval($("#intSendPage").val())) + 1, 10));
				Mailing.Timer();
			}
		});

		$("#btn_cancel").click(function(){
			$("#extForm").attr("action","?act=mailingsendlist&intPage=" + $("#intPage").val());
			$("#extForm").submit();
		});

		swfobject.embedSWF("images/loding.swf", "loadingIcon", "16", "16", "9.0.0","../images/etc/expressInstall.swf");

	});

	var Mailing = function() {}

	Mailing.SendBox = function(c) {
		var w = ($(document.body).width() / 2) - 92;
		var h = ($(document.body).height() / 2) - 22;

		$("#mailsendBox").css({"top":h, "left":w});

		if (c == "")
			$("#mailsendBox").toggle();
		else
			$("#mailsendBox").toggle();
	}

	Mailing.Timer = function() {
		if ($("#intPageCount").val() == 0){
			Mailing.SendEnd();
		}else{
			$("#intPageCount").val(eval($("#intPageCount").val())-1);
			perc = (eval($("#intPageCountTemp").val()) - eval($("#intPageCount").val())) / eval($("#intPageCountTemp").val()) * 100;
			perc = parseInt(perc, 10);
			grpWidth = parseInt(perc / 100 * 160, 10)
			$("#sendGrp").attr("width",grpWidth);
			$("#sendPercent").text(perc);
			Mailing.SendMail();
			setTimeout("Mailing.Timer()",1000);
		}
	}

	Mailing.SendEnd = function() {
		$("#sendGrp").attr("width","160");
		$("#sendPercent").text("100");
		$("#sendCnt").text($("#intTotalCount").val());
		setTimeout("Mailing.SendEndMsg()",3000);
	}

	Mailing.SendMail = function() {

		$.ajax({ 
			type: "post", url: "action/?subAct=mailingsend&Act=sendmail", data: "strCode=" + $("#strCode").val() + "&intSendPage=" + $("#intSendPage").val() + "&intPage=" + (eval($("#intPageCountTemp").val()) - eval($("#intPageCount").val())),
			success:function(responseText){
				if (responseText == "ERROR"){
					document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
				}
				if ($("#intSendPage").val() != "0"){
					if (eval($("#sendCnt").html())+eval($("#intSendPage").val()) > eval($("#intTotalCount").val())){
						$("#sendCnt").text($("#intTotalCount").val());
					}else{
						$("#sendCnt").text(eval($("#sendCnt").html())+eval($("#intSendPage").val()));
					}
				}else{
					$("#sendCnt").text($("#intTotalCount").val());
					Mailing.SendEnd();
				}
			}, error:function(response){alert('error\n\n' + response.responseText);}
		});

	}

	Mailing.SendEndMsg = function() {

		Mailing.SendBox('c');
		alert(arApplMsg["success_send"]);
		$("#extForm").attr("action","?act=mailingsendlist&intPage=" + $("#intPage").val());
		$("#extForm").submit();		
		
	}
