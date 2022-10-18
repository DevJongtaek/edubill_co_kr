
	$(document).ready(function() {

		if ($("#writeForm #intMemberSrl").val() != "" && $("#writeForm #intMemberSrl").val() != "0"){

			$("#comment_write_member").remove();

		} else {

			$("#theForm .comment_message").remove();

			if ($("#writeForm #writeAct").val() == "view" || $("#writeForm #writeAct").val() == "comment_reply"){

				if ($("#writeForm #intMemberSrl").val() == "" || $("#writeForm #intMemberSrl").val() == "0"){
	
					$("#theForm #nickname").val(arApplMsg['nickname']);
					$("#theForm #password").val(arApplMsg['password']);
					$("#theForm #email").val(arApplMsg['email']);
					$("#theForm #homepage").val(arApplMsg['homepage']);
	
					$("#theForm #nickname, #theForm #password, #theForm #email, #theForm #homepage").focus(function() {
						if ($(this).val() == arApplMsg[$(this).attr("id")]){
							$(this).val("");
						}
					});
			
					$("#theForm #nickname, #theForm #password, #theForm #email, #theForm #homepage").blur(function() {
						if ($(this).val() == ""){
							$(this).val(arApplMsg[$(this).attr("id")]);
						}
					});
				}
	
			}
	
			if ($("#writeForm #writeAct").val() == "comment_modify"){
				if ($("#writeForm #intMemberSrl").val() == "" || $("#writeForm #intMemberSrl").val() == "0"){
					$("#theForm #nickname").val($("#writeForm #strNickName").val());
					$("#theForm #email").val($("#writeForm #strEmail").val());
					$("#theForm #homepage").val($("#writeForm #strHomepage").val());
				}
			}

		}

		if ($("#writeForm #writeAct").val() == "comment_modify"){

			if ($("#writeForm #bitSecret").val() == "1")
				$("#theForm #secret").prop("checked", true);

			if ($("#writeForm #bitMessage").val() == "1")
				$("#theForm #message").prop("checked", true);

		}

		$("#theForm").submit(function() {

			if ($("#writeForm #intMemberSrl").val() == "" || $("#writeForm #intMemberSrl").val() == "0"){

				if ($("#theForm #nickname").val().replace(/\s/g, "").length == 0 || $("#theForm #nickname").val() == arApplMsg['nickname']) {
					alert(arApplMsg['isnull_nickname']);$("#theForm #nickname").focus();return false;
				}
				
				if ($("#writeForm #writeAct").val() != "comment_modify"){
					if ($("#theForm #password").val().replace(/\s/g, "").length == 0 || $("#theForm #password").val() == arApplMsg['password']) {
						alert(arApplMsg['isnull_password']);$("#theForm #password").focus();return false;
					}
				}

				if ($("#theForm #email").val() == arApplMsg['email']) {
					$("#theForm  #email").val("");
				}

				if ($("#homepage").val() == arApplMsg['homepage']) {
					$("#theForm  #homepage").val("");
				}

				$("#writeForm #strPassword").val($("#theForm #password").val());
				$("#writeForm #strUserName").val($("#theForm #nickname").val());
				$("#writeForm #strNickName").val($("#theForm #nickname").val());

			}

			var _validator = new Trex.Validator();
			var _content = Editor.getContent();
			if(!_validator.exists(_content)) {
				alert(arApplMsg['isnull_content']);
				Editor.focus();
				return false;
			}else{
				$("#writeForm #strContent").val(_content);
			}

			$("#writeForm #strUploadFile").val("");
			var _attachments = Editor.getAttachments('file', true);
			for(var i=0,len=_attachments.length;i<len;i++) {
				if (attacher_list.files.length < _attachments[i].data.dataSeq){
					if ($("#writeForm #strUploadFile").val() != "")
						$("#writeForm #strUploadFile").val($("#writeForm #strUploadFile").val() + ",");
					$("#writeForm #strUploadFile").val($("#writeForm #strUploadFile").val() + _attachments[i].data.filename + "$" + _attachments[i].data.originalurl + "$" + _attachments[i].data.filesize);
				}
			}

			$("#writeForm #strUploadImg").val("");
			var _attachments = Editor.getAttachments('image');
			for(var i=0,len=_attachments.length;i<len;i++) {
				if (_attachments[i].existStage) {
					if (attacher_list.files.length < _attachments[i].data.dataSeq){
						if ($("#writeForm #strUploadImg").val() != "")
							$("#writeForm #strUploadImg").val($("#writeForm #strUploadImg").val() + ",");
						$("#writeForm #strUploadImg").val($("#writeForm #strUploadImg").val() + _attachments[i].data.filename + "$" + _attachments[i].data.filesize);
					}
				}
			}

			if ($("#theForm #secret").is(':checked'))
				$("#writeForm #bitSecret").val("1");
			else
				$("#writeForm #bitSecret").val("0");
			
			if ($("#theForm #message").is(':checked'))
				$("#writeForm #bitMessage").val("1");
			else
				$("#writeForm #bitMessage").val("0");

			$("#writeForm #strTempFiles").val("");
			$("#writeForm #strTempImages").val("");

			$("#writeForm").ajaxSubmit({
				success: function(responseText){
					switch (responseText){
						case "ERROR01" : alert(arApplMsg['isnull_nickname']); break; return false;
						case "ERROR02" : alert(arApplMsg['not_permitted']); break; return false;
						case "ERROR03" : alert(arApplMsg['disallow_by_point']); break; return false;
						default :
							$("#extForm").attr("method", "get");
							if ($("#extForm #subAct").val() == "comment_modify"){
								$("#extForm").append($(document.createElement("input")).attr("type","hidden").attr("id","comment_page").attr("name","comment_page").attr("value",set_comment_default.page));
							}
							$("#extForm #subAct").val("view");
							$("#extForm").submit();
							break;
					}
				}, 
			 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=commentwrite'
			});
			
			return false;

		});

	});