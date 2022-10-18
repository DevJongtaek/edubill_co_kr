<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	pgubun = request("pgubun")
	comname2 = request("comname2")
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	printflag = request("printflag")
	saveflag = request("saveflag")
%>

<%if pgubun="1" then%>
	<!--#include virtual="/adminpage/tax/tax1.asp"-->
<%elseif pgubun="2" then%>
	<!--#include virtual="/adminpage/tax/tax2.asp"-->
<%elseif pgubun="3" then%>
	<!--#include virtual="/adminpage/tax/tax3.asp"-->
<%end if%>