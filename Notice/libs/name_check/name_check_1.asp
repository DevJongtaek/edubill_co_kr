<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	Response.CharSet = "utf-8"

	DIM r_name, r_ssn

	r_name = REQUEST.FORM("r_name")
	r_ssn  = REQUEST.FORM("r_ssn1") & REQUEST.FORM("r_ssn2")
%>
<script type="text/javascript" src="../../js/jquery-1.3.2.js"></script>
<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.msg.js"></script>
<script type="text/javascript" src="http://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>
<script type="text/javascript">

	$(document).ready(function() {

		$("#SendInfo").val(makeSendInfo( $("#r_name").val(), $("#r_ssn").val(), "10", "1" ));
//		$("#theForm").attr("action","name_check_1_ok.asp");$("#theForm").submit();
		document.getElementById("theForm").submit();
//		$("#theForm").submit();

/*
		$.ajax({ 
			type: "post", url: "name_check_1_ok.asp", data : "SendInfo=" + $("#SendInfo").val(), 
			success:function(responseText){
				switch (responseText){
					case "SUCCESS" :
						alert("성공");
//						$("#theForm").attr("action","../../?act=join&subAct=ssncheck");$("#theForm").submit();
						break;
					case "ERR01" :
						alert("실패");
//						$("#theForm").attr("action","../../?act=join&subAct=ssncheck");$("#theForm").submit();
						break;
				}
			}, error:function(response){alert('error\n\n' + response.responseText);}
		});
*/

	});

</script>
<form name="theForm" method="post" action="name_check_1_ok.asp">
<input type="hidden" id="SendInfo" name="SendInfo">
<input type="hidden" id="r_name" value="<%=r_name%>">
<input type="hidden" id="r_ssn" value="<%=r_ssn%>">
</form>