
	$(document).ready(function() {

		$("#confBoard, #strListStyle, #strOrderField, #strOrderDescAsc, #strImgDisp, #strDateStyle, #strDocumentCode").msDropDown();

		$("#strCommentEditorBgColor, #strWriteEditorBgColor").ColorPicker({
			onSubmit: function(hsb, hex, rgb, el) {
				$(el).val(hex);
				$(el).ColorPickerHide();
			},
			onBeforeShow: function () {
				$(this).ColorPickerSetColor(this.value);
			}
		})
		.bind('keyup', function(){
			$(this).ColorPickerSetColor(this.value);
		});

		$("#menuRemove").click(function(){
			if ($("#strDispListField option").length != "1"){
				$("#strDispListField option[value='" + $('#strDispListField option:selected').val() + "']").remove();
				document.getElementById("strDispListField").selectedIndex = $("#strDispListField option").length-1;
			}
		});

		$("#menuAdd").click(function(){
			if ($("#strDispListFieldTotal option:selected").val()){
				if ($("#strDispListField option[value='" + $('#strDispListFieldTotal option:selected').val() + "']").length == "0"){
					document.getElementById("strDispListField").options[$('#strDispListField option').length] = new Option($("#strDispListFieldTotal option:selected").text(), $("#strDispListFieldTotal option:selected").val());
				}
			}
		});

		$("#menuMoveUp").click(function(){
			if ($("#strDispListField").attr("selectedIndex") != "0"){
				var inx = $("#strDispListField").attr("selectedIndex");
				var tmpText = $("#strDispListField")[0].options[inx-1].text;
				var tmpVal = $("#strDispListField")[0].options[inx-1].value;
				document.getElementById("strDispListField").options[eval(inx)-1] = new Option($("#strDispListField option:selected").text(), $("#strDispListField option:selected").val());
				document.getElementById("strDispListField").options[inx] = new Option(tmpText, tmpVal);
				document.getElementById("strDispListField").selectedIndex = inx - 1;
			}
		});

		$("#menuMoveDown").click(function(){
			if ($("#strDispListField").attr("selectedIndex") > -1){
				if ($("#strDispListField").attr("selectedIndex") + 1 != $('#strDispListField option').length){
					var inx = $("#strDispListField").attr("selectedIndex");
					var tmpText = $("#strDispListField")[0].options[inx+1].text;
					var tmpVal = $("#strDispListField")[0].options[inx+1].value;
					document.getElementById("strDispListField").options[eval(inx)+1] = new Option($("#strDispListField option:selected").text(), $('#strDispListField option:selected').val());
					document.getElementById("strDispListField").options[inx] = new Option(tmpText, tmpVal);
					document.getElementById("strDispListField").selectedIndex = inx + 1;
				}
			}
		});

		$("#theForm").submit(function() {

			$("#strDispListFieldSet").val("");

			$("#strDispListField option").each(function(){
				if ($("#strDispListFieldSet").val() != "")
					$("#strDispListFieldSet").val($("#strDispListFieldSet").val() + ",");
				$("#strDispListFieldSet").val($("#strDispListFieldSet").val() + $(this).val())
			});

			if ($("#theForm input[name=strWriteMoveOpt]:checked").val() == "2"){
				if ($("#theForm #strWriteMoveOptUrl").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["is_null_write_move_url"]);
					$("#theForm #strWriteMoveOptUrl").focus();
					return false;
				}
			}

			if ($("#theForm input[name=strModifyMoveOpt]:checked").val() == "2"){
				if ($("#theForm #strModifyMoveOptUrl").val().replace(/\s/g, "").length == 0) {
					alert(arApplMsg["is_null_modify_move_url"]);
					$("#theForm #strModifyMoveOptUrl").focus();
					return false;
				}
			}

			$(this).ajaxSubmit({
				success: function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href.replace("&", "--**--");
						return false;
					}
					alert(arApplMsg["success_saved"]);
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=modify&subAct=boardconfigaddition&intSrl=' + $("#intSrl").val()});
			return false;

    });

		$("#usePreviewFile").click(function() {
			if ($(this).is(':checked')){
				$('#uploadedFile').hide();
			}else{
				$('#uploadedFile').show();
			}
		});

		Watermark.BackFile();

	});

	function uploadSuccessUser(file, serverData) {
		try {
			var progress = new FileProgress(file, this.customSettings.progressTarget);
			progress.setComplete();
			progress.setStatus("Complete.");
			progress.toggleCancel(false);

			var file_info = serverData.split(",");

			if (file_info[0] != ""){
				$("#uploadedFile").append("<li><a name=\"file_list\" class=\"hand\">" + file_info[0] + "</a><a name=\"file_remove\" class=\"hand ml5\"><img src=\"images/btn_x.gif\"></a></li>");
				Watermark.BackFile();
			}
	
		} catch (ex) {
			this.debug(ex);
		}
	}

	var Watermark = function() {}

	Watermark.BackFile = function() {

		$("#uploadedFile li a[name=file_list]").bind({
			click : function(){
				$("#strWaterMarkOption1").val($(this).text());
			},
			mouseover: function() {
				$(this).css("text-decoration","underline");
			},
			mouseout: function() {
				$(this).css("text-decoration","none");
			}			
		});

		$("#uploadedFile li a[name=file_remove]").click(function(){

			var listObj = $(this);
			var listFile = $(this).parent().text();

			$.ajax({ 
				type: "post", url: "action/?subAct=boardconfigaddition&Act=fileremove", data : "filename=" + $(this).parent().text() + "&path=board|" + $("#intSrl").val() + "|config", 
				success:function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href;return false;
					}
					listObj.parent().remove();
					if ($("#strWaterMarkOption1").val() == listFile){
						$("#strWaterMarkOption1").val("");
					}
				}, error:function(response){alert('error\n\n' + response.responseText);}
			});

		});

	}