<!--#include virtual="/db/db.asp"-->
<%
'response.write "yes"
'response.end
	delgubun1 = request("delgubun1")
	delgubun3 = request("delgubun3")

	select case delgubun1
		case "2"
			flag = "상품"
		case "3"
			flag = "체인"
	end select

	select case delgubun3
		case "2"
			gubun = "추가"
		case "3"
			gubun = "수정"
		case "4"
			gubun = "삭제"
	end select

	SQL = "delete tb_log where wdate<>''"
	if delgubun1<>"1" then
		SQL = SQL & " and flag = '"& flag &"' "
	end if
	if delgubun3<>"1" then
		SQL = SQL & " and gubun = '"& gubun &"' "
	end if
	db.Execute SQL

'response.write sql
'response.end

	response.redirect "updel.asp?gotopage="&gotopage
%>