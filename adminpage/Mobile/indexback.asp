<%

	session("AAcomname")  = ""	'회원사+체인점명
	session("AAusercode") = ""	'본사+지점+체인점코드
	session("AAfilename") = ""
	response.redirect "/adminpage/index.asp"
%>