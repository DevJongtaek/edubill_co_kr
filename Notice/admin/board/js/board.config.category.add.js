
	$(document).ready(function() {

		$("input:checkbox").checkbox();

		$('#strFontColor').ColorPicker({
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


		$("#addForm").submit(function() {

			if ($("#strTitle").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["is_null_category_title"]);$("#strTitle").focus();return false;
			}

			$(this).ajaxSubmit({
				success:function(responseText){
					if (responseText == "ERROR"){
						document.location.href = "?act=login&strPrevUrl=" + location.href.replace("&", "--**--");
						return false;
					}
					
					alert(arApplMsg["success_updated"]);
					$("#frameCategoryList").attr("src", "?Act=boardconfigcategorytree&intSrl=" + $("#intSrl").val());
					
				}, 
				error:function(response){alert('error\n\n' + response.responseText);}, type:'post'});
			return false;

    });

	});