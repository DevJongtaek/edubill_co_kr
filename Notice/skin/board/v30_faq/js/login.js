
	$(document).ready(function() {

		$("#theForm").submit(function() {

			if ($("#theForm #loginid").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_loginid']);$("#loginid").focus();return false;
			}

			if ($("#theForm #loginpwd").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg['isnull_password']);$("#loginpwd").focus();return false;
			}

			$("#loginForm #strLoginID").val($("#theForm #loginid").val());
			$("#loginForm #strPassword").val($("#theForm #loginpwd").val());

			$("#loginForm").ajaxSubmit({
			success: function(responseText){
				switch (responseText){
					case "ERROR01" : alert(arApplMsg['login_no1']); return false; break;
					case "ERROR02" : alert(arApplMsg['login_no2']); return false; break;
					case "ERROR03" : alert(arApplMsg['login_no3']); return false; break;
					default :
						if ($("#theForm #idsave").is(":checked")) {
							var options = { path: '/', expires: 31 };
							$.cookie("arty30_userid", $("#loginid").val(), options);
						}else{
							var options = { path: '/', expires: 31 };
							$.cookie("arty30_userid", "", options);
						}

						var url = "?Act=bbs&subAct=" + $("#loginForm #nextAct").val() + "&bid=" + set_bbs_default.bid + "&page=" + set_bbs_default.page + "&category=" + set_bbs_default.category + "&seq=" + set_bbs_default.seq;

						if ($("#comment_seq").val() != "")
							url+= "&comment_seq=" + $("#comment_seq").val();
			
						if ($("#comment_page").val != "")
							url+= "&comment_page=" + $("#comment_page").val();

						$("#extForm").attr("action", url);
						$("#extForm").submit();
						break;
				}
			}, error:function(response){alert('error\n\n' + response.responseText);}, type: 'post', url: 'action/?Act=login'});
		return false;

		});

	});