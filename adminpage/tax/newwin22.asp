<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	pgubun = request("pgubun")
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
%>

<%if pgubun="1" then%>
	<!--#include virtual="/adminpage/tax/tax11.asp"-->
<%elseif pgubun="2" then%>
	<!--#include virtual="/adminpage/tax/tax22.asp"-->
<%elseif pgubun="3" then%>
	<!--#include virtual="/adminpage/tax/tax33.asp"-->
<%end if%>