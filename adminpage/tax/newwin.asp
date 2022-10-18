<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	idx = request("idx")
	flag = request("flag")
%>

<%if flag="1" then%>
	<!--#include virtual="/adminpage/tax/listinc1.asp"-->
<%else%>
	<!--#include virtual="/adminpage/tax/listinc2.asp"-->
<%end if%>