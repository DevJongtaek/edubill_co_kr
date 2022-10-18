<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	idx = request("idx")
	bidx = request("bidx")
	bname = request("bname")
	dflag = request("dflag")

	if bidx="" then
		SQL = "INSERT INTO tb_company_Retrurn(idx,bname) VALUES "
		SQL = SQL & " ("& idx &","
		SQL = SQL & " '"& bname &"')"
		db.Execute SQL
	else
		if dflag="" then
			SQL = "update tb_company_Retrurn set "
			SQL = SQL & " bname = '"& bname &"' "
			SQL = SQL & " where bidx = "&bidx
			db.Execute SQL
		else
			'브랜드삭제시는 체인점,상품에 있는 브랜드초기화
			SQL = "delete tb_company_Retrurn "
			SQL = SQL & " where bidx = "&bidx
			db.Execute SQL

		'	SQL = "update tb_company set "
		'	SQL = SQL & " cbrandchoice = '' "
		'	SQL = SQL & " where bidxsub = "& idx &" and cbrandchoice = '"& bidx &"' "
		'	db.Execute SQL

		'	SQL = "update tb_product set "
		'	SQL = SQL & " cbrandchoice = '' "
		'	SQL = SQL & " where usercode = "& idx &" and cbrandchoice = '"& bidx &"' "
		'	db.Execute SQL
		end if
	end if

	response.redirect "rwrite.asp?idx="&idx

%>