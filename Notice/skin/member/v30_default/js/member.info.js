	$(document).ready(function() {

		$("#btn_member_modify").click(function(){
			document.location.href = "?act=member&subAct=modify";
			return false;
		});
		
		$("#btn_prev_page").click(function(){
			history.back();
			return false;
		});
		
	});