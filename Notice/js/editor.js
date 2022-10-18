
	jQuery(function($){

		new Editor({
			txHost: '',
			txPath: set_editor.config.path + 'daum/',
			txVersion: '5.4.0',
			txService: 'sample',
			txProject: 'sample',
			initializedId: "",
			wrapper: "tx_trex_container"+"",
			form: form.replace('#', ''),
			txIconPath: set_editor.config.path + "daum/images/icon/" + set_editor.config.iconpath + "/",
			txDecoPath: set_editor.config.path + "daum/images/deco/",
			events: {
				preventUnload: false
			},
			canvas: {
				styles: {color: "#666666", fontFamily: "gulim", fontSize: "12px", backgroundColor: "#FFFFFF", lineHeight: "1.5", padding: "8px", height: "400px"}
			},
			sidebar: {
				attachbox: {show:true},
				attacher: {
					image: {
						objattr: {width: set_editor.config.imagewidth}
					},
					file: {boxonly: true}
				}
			}
		}).focusOnForm();

		if (set_editor.config.usefile == false){
			$("#editor_file_upload").hide();
		}

		if (set_editor.config.useimage == false){
			$("#editor_image_upload").hide();
		}

		var useSignEditor = false;

		$.each(arrMemberForm.options, function(n, i){
			if (arrMemberForm.options[n].field == "strUserSign")
				useSignEditor = true;
		});

		Editor.modify({
			"content": $tx("strUserSign")
		});
		
	});