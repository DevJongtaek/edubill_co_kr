<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")

	gotopage = request("gotopage")
	idx = request("idx")
	flag = request("flag")

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	orderflag   = request("orderflag")

	SQL = "update tb_company set "
	SQL = SQL & " orderflag = '"& orderflag  &"' "
	SQL = SQL & " where bidxsub = '"& left(session("Ausercode"),5) &"' "


	SQL = SQL & " and idxsub = '"& mid(session("Ausercode"),6,5) &"' "


	SQL = SQL & " and flag = '3' "
	db.Execute SQL
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	linksql = "idx="&idx&"&flag="&flag&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg
	'response.redirect "list.asp?flag="&flag&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg
%>

<Script language=javascript>
	alert("해당 체인점 모두에 적용 하였습니다.");
	location.href = "write.asp?<%=linksql%>";
</Script>
