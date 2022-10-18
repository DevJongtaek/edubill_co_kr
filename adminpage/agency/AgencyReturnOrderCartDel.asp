<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	idx = request("idx")
	pcnt = request("pcnt")
	btnname = request("btnname")

	if idx="" then
		SQL = "delete tb_product_cart_Return where usercode = '"& session("AAusercode") &"' "
		db.Execute SQL
	else
		if btnname="¼öÁ¤" then
			SQL = "update tb_product_cart_Return set pcnt = "& pcnt &" where idx = "& idx
			db.Execute SQL
		else
			SQL = "delete tb_product_cart_Return where idx = "& idx
			db.Execute SQL
		end if
	end if

	db.close
	set db=nothing
	response.redirect "AgencyReturnOrderCartFRM.asp"
%>

