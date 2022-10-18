
	$(document).ready(function() {

		if ($("#extForm #bid").val() == ""){

			switch (strLogoutAct_){
				case "0" : 
				if (strLogoutActMsg_!=""){alert(strLogoutActMsg_);}
					document.location.href = strLogoutActUrl_;
					return false;
					break;
				case "1" : logoutActScript(); break;
				case "2" : 
					if ($("#strPrevUrl").val()!=""){
						document.location.href = $("#strPrevUrl").val();
						return false;
					}else{
						document.location.href = strLogoutActUrl_;
						return false;
					}
					break;
			}
		} else {
			$("#extForm #strPrevUrl").remove();
			$("#extForm").attr("method", "get");
			$("#extForm").submit();
		}
		
	});