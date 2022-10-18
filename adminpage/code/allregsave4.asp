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

	value = request("value")

	gotopage = request("gotopage")
	idx = request("idx")
	flag = request("flag")

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	orderflag   = request("orderflag")

	SQL = "update tb_product set "
	SQL = SQL &  "Order_WeekChoice = '" & value & "' "
	SQL = SQL & " where usercode = '"& left(session("Ausercode"),5) &"' "
	db.Execute SQL
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	linksql = "idx="&idx&"&flag="&flag&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc
	'response.redirect "list.asp?flag="&flag&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg
%>

<Script language=javascript>
	alert("해당 상품 모두에 적용 하였습니다.");
	location.href = "pwrite.asp?<%=linksql%>";
</Script>
