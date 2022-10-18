
	$(document).ready(function() {

			$.ajax({type: "POST", url: popup_path + "action/?Act=popup", dataType: "json", success: function(responseText){

				if (responseText.length > 0){
					for(var i = 0; i < responseText.length; i++){

						if ($.cookie("arty30_popup_" + responseText[i].seq) == null){

						var popup_x = "";
						var popup_y = "";
						var popup_width = "";
						var popup_height = "";
						var popup_scroll = responseText[i].scroll;

						if (responseText[i].position.split(",")[0] == "1"){
							popup_x = responseText[i].position.split(",")[1];
							popup_y = responseText[i].position.split(",")[2];
						}else{
							switch (responseText[i].position.split(",")[3]){
								case "1" :
									popup_x = 10;
									popup_y = 10;
									break;
								case "2" :
									popup_x = parseInt((screen.availWidth / 2) - (responseText[i].width / 2));
									popup_y = 10;
									break;
								case "3" :
									popup_x = parseInt(screen.availWidth - responseText[i].width );
									popup_y = 10;
									break;
								case "4" :
									popup_x = (screen.width) ? (screen.width-responseText[i].width)/2 : 0;
									popup_y = (screen.height) ? (screen.height-responseText[i].width)/2 : 0;
									break;
							}
						}

						var popup_width = responseText[i].width;
						var popup_height = responseText[i].height;

						switch (responseText[i].popup_type){
							case "1" :
								window.open(popup_path + "action/?Act=popupframe&seq=" + responseText[i].seq, "iPopup_" + responseText[i].seq, "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,scrollbars=" + popup_scroll + ",width=" + popup_width + ",height=" + popup_height + ",top=" + popup_y + ",left=" + popup_x); 
								break;
							case "2" :
								if (popup_scroll == "0")
									popup_scroll = "no";
								else
									popup_scroll = "yes";
								window.showModalDialog(popup_path + "action/?Act=popupframe&seq=" + responseText[i].seq, "", "dialogWidth:" + popup_width + "px;dialogHeight:" +popup_height + "px;toolbar:no;location:no;help:no;directories:no;status:no;menubar:no;scroll:" + popup_scroll + ";resizable:no;dialogLeft:" + popup_x + ";dialogTop:" + popup_y);
								break;
							case "3" :

								$("#layout_popup").append("<div id='DivPopup_" + responseText[i].seq + "' style=\"width:" + popup_width + "px; height:" + popup_height + "px; display:block; position:absolute; top:" + popup_y + "px; left:" + popup_x + "px; z-index:120;\"></div>");

								var frm = "<iframe id='abc' src='" + popup_path + "action/?Act=popupframe&seq=" + responseText[i].seq + "&popup=layer' frameborder=0 width=" + popup_width + " height=" + popup_height + " scrolling="
								if (responseText[i].scroll == "1")
									frm += "yes";
								else
									frm += "no";
								frm += "></iframe>";

								$("#DivPopup_" + responseText[i].seq).append(frm);

								break;
							}
	
						}
					}
			}
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});

	});