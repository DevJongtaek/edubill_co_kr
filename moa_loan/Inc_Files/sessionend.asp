
<%if session("Auserid") = "" then%>

	<Script language=javascript>
	    alert("로그인후 사용하세요!!");
		window.open("index.asp", "_top")
	</Script>

<%end if%>

