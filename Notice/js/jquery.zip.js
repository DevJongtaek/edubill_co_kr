
jQuery(function($){

	var zipText = $('.krZip>.item>.zipLabel').next('.zipText');
	$('.krZip>.item>.zipLabel').css('position','absolute');
	zipText
		.focus(function(){
			$(this).prev('.zipLabel').hide();
		})
		.blur(function(){
			if($(this).val() == '')
				$(this).prev('.zipLabel').show();
			else
				$(this).prev('.zipLabel').hide();
		})
		.change(function(){
			if($(this).val() == '')
				$(this).prev('.zipLabel').show();
			else
				$(this).prev('.zipLabel').hide();
		})
		.blur();

	$.krzip = function(column_name, path) {
	var $search_zone, $select_zone;

	($search_zone = $('#zone_address_search_'+column_name))
		.find(':text')
			.keypress(function(event){
				if(event.keyCode!=13) return;
				$search_zone.find('input[type=button]').click();
				return false;
			})
			.end()
		.find('input[type=button]')
			.click(function(){

				var val = $.trim($search_zone.find(':text').val());
				var fd  = $search_zone.find(':text');

				if (!val){
					alert("검색하실 주소의 읍, 면, 동 이름을 입력하세요. "); fd.focus(); return false;
				}

				var url = "action/?Act=zipcode";

				if (path != "" && path != null)
					url = path + url;

				$.ajax({type: "POST", url: url, data: "searchword=" + val, dataType: "json", success: function(responseText){
	
					if (responseText.length == 0){
						alert("검색된 정보가 없습니다.");fd.focus();return;
					}

					$('#zone_address_search_' + column_name).hide();
					$('#zone_address_list_' + column_name).show();
					$("#address_list_" + column_name + " option").remove();

					for(var i = 0; i < responseText.length; i++){
						
						optText = '(' + responseText[i].dispcode + ') ' + responseText[i].sido + ' ' + responseText[i].gugun + ' ' + responseText[i].dong;
	
						if (responseText[i].ri != "")
							optText += ' ' + responseText[i].ri;
	
						if (responseText[i].apt != "")
							optText += ' ' + responseText[i].apt;
	
						if (responseText[i].bunji != "")
							optText += ' ' + responseText[i].bunji;
	
						optVal = responseText[i].dispcode + '$$$' + responseText[i].sido + ' ' + responseText[i].gugun + ' ' + responseText[i].dong;

						if (responseText[i].ri != "")
							optVal += ' ' + responseText[i].ri;
	
						if (responseText[i].apt != "")
							optVal += ' ' + responseText[i].apt;
	
						if (responseText[i].bunji != "")
							optVal += ' ' + responseText[i].bunji;

						$("#address_list_" + column_name).get(0).options[i] = new Option(optText, optVal);

					}
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

		return false;

	});

	($select_zone = $('#zone_address_list_'+column_name))
		.find('input[type=button]')
			.click(function(){
				$search_zone.show().find(':text').val('').focus();
				$select_zone.hide();
			});
	}

});