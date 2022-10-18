// JavaScript Document

	;(function($) {

		$.ssn_check = function(j1, j2){

			var sum = 0;
		
			for (i=0; i<j1.length; i++) {
				if (j1.charAt(i) >= 0 || j1.charAt(i) <= 9) { 
					if (i == 0)
						sum = (i+2) * j1.charAt(i);
					else
						sum = sum + (i+2) * j1.charAt(i);
				}else{
					return false;
				}
			}
		
			for (i=0; i<2; i++) {
				if (j2.charAt(i) >= 0 || j2.charAt(i) <= 9)
					sum = sum + (i+8) * j2.charAt(i);
				else
					return false;
			}
		
			for(i=2; i<6; i++) {
				if (j2.charAt(i) >= 0 || j2.charAt(i) <= 9)
					sum = sum + (i) * j2.charAt(i);
				else
					return false;
			}
		
			var checkSUM = sum % 11;
		
			if(checkSUM == 0) {
					var checkCODE = 10;
			} else if(checkSUM ==1) {
				var checkCODE = 11;
			} else {
				var checkCODE = checkSUM;
			}
		
			var check1 = 11 - checkCODE;
		
			if (j2.charAt(6) >= 0 || j2.charAt(6) <= 9)
				var check2 = parseInt(j2.charAt(6))
			else
				return false;
		
			if(check1 != check2)
				return false;
			else
				return true; 
		};

		$.corpnum_check = function(vencod){

			var sum = 0;
			var getlist =new Array(10);
			var chkvalue =new Array("1","3","7","1","3","7","1","3","5");
					
			for(var i=0; i<10; i++)
				getlist[i] = vencod.substring(i, i+1);
	
			for(var i=0; i<9; i++)
				sum += getlist[i]*chkvalue[i];
	
			sum = sum + parseInt((getlist[8]*5)/10);
			sidliy = sum % 10;
			sidchk = 0;
					
			if(sidliy != 0)
				sidchk = 10 - sidliy;
			else
				sidchk = 0;
	
			if(sidchk != getlist[9])
				return false;

			return true;

		};

		// 로그인 처리
		$.doMemberLogin = function(form){

			$("#extForm").ajaxSubmit({
				success: function(responseText){
					if (responseText == "SUCCESS"){
						var options = { path: '/', expires: 31 };
						if ($("#bitIdSave", "#extForm").val() == "1")
							$.cookie("arty30_userid", $("#strLoginID", "#extForm").val(), options);
						else
							$.cookie("arty30_userid", "", options);

						if ($("#bid", "#extForm").val() == ""){
							$.memberLoginComplate();
						} else {
							$("#strLoginID, #strPassword, #bitIdSave, #strPrevUrl", "#extForm").remove();
							$("#extForm").attr("method", "get");
							$("#extForm").submit();
						}
					}else{
						$.memberLoginErr(responseText);
					}
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=login'});

		};

		$.doMemberAgreeCheck = function(){

			$("#extForm").ajaxSubmit({
				success: function(responseText){
					$("#extForm").attr("action","?act=member&subAct=" + responseText);$("#extForm").submit();
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=memberagree'}
			);

		};

		$.doMemberEmailCertified = function(ret_obj, url, data){
			$.ajax({type: "post", url: url, data: data, 
				success: function(responseText){
					$.memberEmailCertifiedComplate(ret_obj, responseText);
			 	},
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});
		}

		$.doMemberIdCheck = function(userid){
			$.ajax({type: "POST", url: "action/?Act=joincheck", data: "subAct=userid&checkData=" + userid, 
				success: function(responseText){
					$.memberIdCheckComplate(responseText);
			 	},
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});
		};

		$.doMemberFormCheck = function(checkType, form){
			for (var n = 0; n < arrMemberForm.options.length; n++ ){
				if (arrMemberForm.options[n].rquired == "True"){
					switch (arrMemberForm.options[n].formtype){
						case "userid" :
							if (checkType == "join"){
								if ($("#" + arrMemberForm.options[n].field, form).val().replace(/\s/g, "").length < 3){
									$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field, form), arrMemberForm.options[n].message); return false;
								}
								if (id_check == false){
									$.memberFormInputErr('userid_check', '', '');
									return false;
								}
							}
							break;
						case "password" :
							if (checkType == "join"){
								if ($("#" + arrMemberForm.options[n].field, form).val().replace(/\s/g, "").length < 6){
									$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field, form), arrMemberForm.options[n].message); return false;
								}
								if ($("#" + arrMemberForm.options[n].field, form).val() != $("#" + arrMemberForm.options[n].field + "2", form).val()){
									$.memberFormInputErr('password_check', $("#" + arrMemberForm.options[n].field + "2", form), ''); return false;
								}
							}
							break;
						case "nick" :
							if ($("#" + arrMemberForm.options[n].field, form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field, form), arrMemberForm.options[n].message); return false;
								alert(arrMemberForm.options[n].message);$("#" + arrMemberForm.options[n].field, form).focus();return false;
							}
							break;
						case "text" :
							if ($("#" + arrMemberForm.options[n].field, form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field, form), arrMemberForm.options[n].message); return false;
							}
							break;
						case "email" :
							if ($("#" + arrMemberForm.options[n].field + "1", form).val().replace(/\s/g, "").length == 0 ){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "1", form), arrMemberForm.options[n].message); return false;
							}
							if ($("#" + arrMemberForm.options[n].field + "2", form).val().replace(/\s/g, "").length == 0 ){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "2", form), arrMemberForm.options[n].message); return false;
							}
							
							if (!$.email_check($("#" + arrMemberForm.options[n].field + "1", form).val() + "@" + $("#" + arrMemberForm.options[n].field + "2", form).val())){
								$.memberFormInputErr('email_check', $("#" + arrMemberForm.options[n].field + "1", form), ''); return false;
							}
							break;
						case "radio" :
							if ($("input[name=" + arrMemberForm.options[n].field + "]:checked", form).length == 0){
								$.memberFormInputErr('', $("input[name=" + arrMemberForm.options[n].field + "]", form)[0], arrMemberForm.options[n].message); return false;
							}
							break;
						case "birthday" :
							if ($("#" + arrMemberForm.options[n].field + "1", form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "1", form), arrMemberForm.options[n].message); return false;
							}
							if ($("#" + arrMemberForm.options[n].field + "2", form).val() == ""){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "2", form), arrMemberForm.options[n].message); return false;
							}
							break;
						case "select" :
							if ($("#" + arrMemberForm.options[n].field + " option:selected", form).val() == ""){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field, form), arrMemberForm.options[n].message); return false;
							}
							break;
						case "addr" :
							if ($("#address_list_" + arrMemberForm.options[n].field + " option", form).length == 0){
								$.memberFormInputErr('', $("#krzip_address1_" + arrMemberForm.options[n].field, form), arrMemberForm.options[n].message); return false;
							}

							if ($("#krzip_address2_" + arrMemberForm.options[n].field, form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#krzip_address2_" + arrMemberForm.options[n].field, form), arrMemberForm.options[n].message); return false;
							}
							break;
						case "url" :
							if ($("#" + arrMemberForm.options[n].field, form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field, form), arrMemberForm.options[n].message); return false;
							}
							break;
						case "tel" :
							if ($("#" + arrMemberForm.options[n].field + "1", form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "1", form), arrMemberForm.options[n].message); return false;
							}
							if ($("#" + arrMemberForm.options[n].field + "2", form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "2", form), arrMemberForm.options[n].message); return false;
							}
							if ($("#" + arrMemberForm.options[n].field + "3", form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "3", form), arrMemberForm.options[n].message); return false;
							}
							break;
						case "mobile" :
							if ($("#" + arrMemberForm.options[n].field + "1", form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "1", form), arrMemberForm.options[n].message); return false;
							}
							if ($("#" + arrMemberForm.options[n].field + "2", form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "2", form), arrMemberForm.options[n].message); return false;
							}
							if ($("#" + arrMemberForm.options[n].field + "3", form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "3", form), arrMemberForm.options[n].message); return false;
							}
							break;
						case "date" :
							if ($("#" + arrMemberForm.options[n].field, form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field, form), arrMemberForm.options[n].message); return false;
							}
							break;
						case "marry" :
							if ($("#" + arrMemberForm.options[n].field + "1 option:selected", form).val() == "1"){
								if ($("#" + arrMemberForm.options[n].field + "2", form).val().replace(/\s/g, "").length == 0){
									$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "2", form), arrMemberForm.options[n].message); return false;
								}
							}
							break;
						case "textarea" :
							if ($("#" + arrMemberForm.options[n].field, form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field, form), arrMemberForm.options[n].message); return false;
							}
							break;
						case "sign" :
							var _validator = new Trex.Validator();
							var _content = Editor.getContent();
							if(!_validator.exists(_content)) {
								$.memberFormInputErr('editor', Editor, arrMemberForm.options[n].message); return false;
							}
							break;
						case "checkbox" :
							if ($("input[name=" + arrMemberForm.options[n].field + "]:checked", form).length == 0){
								$.memberFormInputErr('', $("input[name=" + arrMemberForm.options[n].field + "]", form)[0], arrMemberForm.options[n].message); return false;
							}
							break;
						case "corpnum" :
							if ($("#" + arrMemberForm.options[n].field + "1", form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "1", form), arrMemberForm.options[n].message); return false;
							}
							if ($("#" + arrMemberForm.options[n].field + "2", form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "2", form), arrMemberForm.options[n].message); return false;
							}
							if ($("#" + arrMemberForm.options[n].field + "3", form).val().replace(/\s/g, "").length == 0){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "3", form), arrMemberForm.options[n].message); return false;
							}
							
							if (!$.corpnum_check($("#" + arrMemberForm.options[n].field + "1", form).val() + $("#" + arrMemberForm.options[n].field + "2", form).val()+$("#" + arrMemberForm.options[n].field + "3", form).val())){
								$.memberFormInputErr('', $("#" + arrMemberForm.options[n].field + "1", form), arrMemberForm.options[n].message); return false;
							}
							break;
					}
				}
			}
			return true;
		};

		$.doMemberFormAddFieldInput = function(sourceField, targetField, fieldType, form){
			switch (fieldType){
				case "text"     : $("#" + targetField, form).val($("#" + sourceField, form).val()); break;
				case "url"      : $("#" + targetField, form).val($("#" + sourceField, form).val()); break;
				case "tel"      : $("#" + targetField, form).val($("#" + sourceField + "1", form).val() + "-" + $("#" + sourceField + "2", form).val() + "-" + $("#" + sourceField + "3", form).val()); break;
				case "mobile"   : $("#" + targetField, form).val($("#" + sourceField + "1", form).val() + "-" + $("#" + sourceField + "2", form).val() + "-" + $("#" + sourceField + "3", form).val()); break;
				case "textarea" : $("#" + targetField, form).val($("#" + sourceField, form).val()); break;
				case "checkbox" : 
					$("#" + targetField, form).val("");
					$("input[name=" + sourceField + "]:checked").each(function(){
						if ($("#" + targetField, form).val() != "")
							$("#" + targetField, form).val($("#" + targetField, form).val() + ",");
						$("#" + targetField, form).val($("#" + targetField, form).val() + $(this).val());
					});
					break;
				case "select"   : $("#" + targetField, form).val($("#" + sourceField, form).val()); break;
				case "radio"    : $("#" + targetField, form).val($("input[name=" + sourceField + "]:checked", form).val()); break;
				case "addr"     :
					if ($("#address_list_" + sourceField + " option", form).length != 0)
						$("#" + targetField).val($("#address_list_" + sourceField, form).val().split("$$$")[0].split("-")[0] + $("#address_list_" + sourceField, form).val().split("$$$")[0].split("-")[1] + "$$$" + $("#address_list_" + sourceField, form).val().split("$$$")[1] + "$$$" + $("#krzip_address2_" + sourceField, form).val());
					break;
				case "date" :
					var str = $("#" + sourceField, form).val();
					str = str.replace(".", "");
					str = str.replace(".", "");
					$("#" + targetField, form).val(str);
					break;
			}
		};

		$.doMemberFormSubmit = function(update_type, form){

			$("#strUserName", form).prop("disabled", false);
			$("#strEmail1", form).prop("disabled", false);
			$("#strEmail2", form).prop("disabled", false);

			$.each(arrMemberForm.options, function(n, i){
				if (arrMemberForm.options[n].fieldtype == "1"){
					switch (arrMemberForm.options[n].formtype){
						case "addr" :
							if ($("#address_list_" + arrMemberForm.options[n].field + " option", form).length != 0){
								$("#strHomeAddr", form).val($("#address_list_" + arrMemberForm.options[n].field, form).val().split("$$$")[0].split("-")[0] + $("#address_list_" + arrMemberForm.options[n].field, form).val().split("$$$")[0].split("-")[1] + "$$$" + $("#address_list_" + arrMemberForm.options[n].field, form).val().split("$$$")[1] + "$$$" + $("#krzip_address2_" + arrMemberForm.options[n].field, form).val());
							}
						break;
						case "sign" :
							$("#strUserSign", form).val(Editor.getContent());
						break;
					}
				}
				if (arrMemberForm.options[n].fieldtype == "2")
					$.doMemberFormAddFieldInput(arrMemberForm.options[n].field, arrMemberForm.options[n].field + "_", arrMemberForm.options[n].formtype, form);
			});

			if (update_type == "join"){
				var url = "action/?Act=memberjoin";
			}else{
				var url = "action/?Act=membermodify";
			}

			$(form).ajaxSubmit({
				success: function(responseText){
					$.memberUpdateComplate(responseText);
				}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: url
			});

		};

		$.doMemberUploadRemove = function(uploadType, data){
			$.ajax({type: "POST", url: "action/?Act=memberfileremove", data: data, 
				success: function(responseText){
					$.memberImageRemoveComplate(uploadType);
				},
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});
		};

		$.doMemberFriendGroupGet = function(member_srl){
			$.ajax({type: "POST", url: "action/?Act=friendgrouplist", data: "intMemberSrl=" + member_srl, dataType: "json", success: function(responseText){
				$.memberFriendGroupGetComplate(responseText);
			 },
				 error: function(response){alert('error\n\n' + response.responseText);return false;}
			});
		}

		$.doMemberFriendMove = function(form, group_srl){
			alert(group_srl);
			$(form).ajaxSubmit({
				success: function(responseText){
					$.memberFriendMoveComplate();
				}, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=friendgroup&group_srl=' + group_srl
			});
		}

		$.doExtFormSubmit = function(url, method){

			$("#extForm").attr("action", url);
			$("#extForm").attr("method", method);
			$("#extForm").submit();

		};

	})(jQuery);