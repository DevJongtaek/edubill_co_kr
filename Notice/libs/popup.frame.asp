<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<!-- #include file = "../files/config/db.config.asp" --> 
<!-- #include file = "dbconn.asp" --> 
<!-- #include file = "function.asp" -->
<%
	DIM intSeq, strPopupType

	intSeq       = REQUEST.QueryString("seq")
	strPopupType = REQUEST.QueryString("popup")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_POPUPS_READ] 'R', '" & intSeq & "' ")

	DIM strTitle, strContent, strFooter

	strTitle = RS("strTitle")

	IF RS("strContentType") = "1" THEN
		strContent = RS("strContent")
	ELSE
		strContent = RS("strContentHtml")
	END IF

	strFooter = RS("strFooter")
%>
<title><%=strTitle%></title>
</head>
<link rel="stylesheet" href="../style/base.css" type="text/css">
<body>
<script type="text/javascript">

	$(document).ready(function() {

		var popup_type = "<%=LCASE(strPopupType)%>";

		$("#btn_close").click(function(){
			var options = { path: '/', expires: 1};
			$.cookie("arty30_popup_<%=intSeq%>", "<%=intSeq%>", options);
			if (popup_type == "layer"){
				$("#DivPopup_<%=intSeq%>", parent.document).hide();
			}else{
				self.close();
			}
		});

	});

</script>
<div><%=strContent%></div>
<div><%=strFooter%></div>
<% SET RS = NOTHING : DBCON.CLOSE %>
</body>
</html>
