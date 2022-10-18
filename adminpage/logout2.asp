<!--#include virtual="/db/db.asp"-->
<%
	SQL = "delete tb_product_cart where usercode = '"& session("AAusercode") &"' AND Wdate != CONVERT(CHAR(8), GETDATE(), 112) "
    SQL2 = "delete tb_product_cart_Return where usercode = '"& session("AAusercode") &"' AND Wdate != CONVERT(CHAR(8), GETDATE(), 112) "	'장바구니삭제
	db.Execute SQL
    db.Execute SQL2

	session("AAcomname") = ""
	session("AAusercode") = ""
	session("AAfilename") = ""
	session("AAtel") = ""
	session("Aordertimeout")=""
	session("ymflag") = ""
	session("AAproflag") = ""
	session("AAtcode") = ""
%>

<Script language=javascript>
	window.open("/adminpage/", "_top")
</Script>