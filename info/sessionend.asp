<%if session("info") = "" then%>
	<Script language=javascript>
		alert("로그인후 사용하세요!!");
		window.open("/info/", "_top")
	</Script>
<%end if%>

