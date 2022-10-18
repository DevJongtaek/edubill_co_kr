<%if session("Auserid") = "" then%>

	<Script language=javascript>
		alert("로그인후 사용하세요!!");
		window.open("/", "_top")
	</Script>

<%end if%>

