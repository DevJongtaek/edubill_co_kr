
	$(document).ready(function() {

		$("#content select").msDropDown();

		$("#theForm").submit(function(){

			if ($("#theForm #strDataType").val() == ""){
				alert(arApplMsg["is_null_disp_type"]); $("#theForm #strDataType").focus(); return false;
			}

			if ($("input[name=strBoardSrl]:checked").length == 0){
				alert(arApplMsg["is_null_board"]); return false;
			}

			if ($("#theForm #intListCount").val() == "" || $("#theForm #intListCount").val() == "0"){
				alert(arApplMsg["is_null_list_count"]); $("#theForm #intListCount").focus(); return false;
			}

			if ($("#theForm #strDesign").val() == ""){
				alert(arApplMsg["is_null_design_style"]); $("#theForm #strDesign").focus(); return false;
			}

			var board_srl = "";
			$("input[name=strBoardSrl]:checked").each(function(){
				if (board_srl != "")
					board_srl+= ",";
				board_srl+= $(this).val();
			});

			$.ajax({type: "POST", url: "action/?subAct=boardnotice", data: "strSourceType=code&strDataType=" + $("#theForm #strDataType").val() + "&strFolder=" + $("#theForm #strDesign").val() + "&strBoardSrl=" + board_srl + "&intListCount=" + $("#theForm #intListCount").val() + "&strCutText=" + $("#theForm #strCutText1").val() + "," + $("#theForm #strCutText2").val() + "&bitUseThrum=" + $("#theForm input[name=bitUseThrum]:checked").val(), dataType: "html", success: function(responseText){

				$("#codecontainer1").val("");
				$("#codecontainer1").val(responseText);

				$.ajax({type: "POST", url: "action/?subAct=boardnotice", data: "strSourceType=css&strDataType=" + $("#theForm #strDataType").val() + "&strFolder=" + $("#theForm #strDesign").val(), dataType: "html", success: function(responseText){
	
					$("#codecontainer2").val("");
					$("#codecontainer2").val(responseText);

					$.ajax({type: "POST", url: "action/?subAct=boardnotice", data: "strSourceType=preview&strDataType=" + $("#theForm #strDataType").val() + "&strFolder=" + $("#theForm #strDesign").val(), dataType: "html", success: function(responseText){
		
						$("#codecontainer3").html(responseText);

						$.ajax({type: "POST", url: "action/?subAct=boardnotice", data: "strSourceType=extend&strDataType=" + $("#theForm #strDataType").val() + "&strFolder=" + $("#theForm #strDesign").val(), dataType: "html", success: function(responseText){
			
							$("#codecontainer4").html(responseText);
							$(".codeArea").show();
			
						 },
							 error: function(response){alert('error\n\n' + response.responseText);return false;}
						});
		
					 },
						 error: function(response){alert('error\n\n' + response.responseText);return false;}
					});

				 },
					 error: function(response){alert('error\n\n' + response.responseText);return false;}
				});


			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

			return false;
		});

		$("a[name=btn_markup], a[name=btn_css], a[name=btn_preview], a[name=btn_extend").click(function(){
			$("a[name=btn_markup], a[name=btn_css], a[name=btn_preview], a[name=btn_extend").removeClass("on");
			$(this).addClass("on");
			$("#markup3, #css3, #preview3, #extend3").hide();
			$("#" + $(this).attr("id").split("_")[0] + "3").show();
		});

		$("#select_code1").click(function(){
			$("#codecontainer1").select();
		});

		$("#select_code2").click(function(){
			$("#codecontainer2").select();
		});

	});

	function datatype(s){

		for(i = document.getElementById('strDesign').options.length;i>-0;i--){
			document.getElementById('strDesign').options[i] = null;
		}

		if(document.getElementById('strDesign').refresh!=undefined)
			document.getElementById('strDesign').refresh();

		if (s.value != ""){

			$("#use_thrum").hide();

			switch (s.value){
				case "document" :
					var set_list = set_list_1;
					break;
				case "gallery" :
					$("#use_thrum").show();
					var set_list = set_list_2;
					break;
				case "comment" :
					var set_list = set_list_3;
					break;
				case "file" :
					var set_list = set_list_4;
					break;
			}

			var list_idx = 1;

			for(var i = 0; i < set_list.options.length; i++){
				path = "board/main_design/" + s.value + "/" + set_list.options[i].folder + "/skin.xml";
				f = set_list.options[i].folder;

				$.ajax({
					url: path, data: "xml",
					success: function(xml){

					document.getElementById('strDesign').options[list_idx] = new Option($(xml).find("root").find("title").text() + " [" + $(xml).find("root").find("dec").text() + "]", $(xml).find("root").find("folder").text());
					
					list_idx++;
					
					if(document.getElementById('strDesign').refresh!=undefined)
						document.getElementById('strDesign').refresh();
						
					}, error: function(xhr){alert(xhr.status);}
				});
			}

			document.getElementById('strDesign').selectedIndex = 0;

		}

	}