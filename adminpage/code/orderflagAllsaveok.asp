<!--#include virtual="/db/db.asp" -->
<!--#include virtual="/adminpage/account/dataup/fun.asp"-->
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	searchi = request("searchi")
	GotoPage = Request("GotoPage")
	flag = request("flag")
	orderflag = request("orderflag")
	idx  = request("idx")

	if idx <> "" then
		array_idx       = split(idx,",")
		array_orderflag = split(orderflag,",")
		array_idxint    = ubound(array_idx)
	else
		array_idx       = ""
		array_orderflag = ""
		array_idxint    = ""
	end if

	if array_idxint<>"" then
		for i=0 to array_idxint
			imsiidx       = trim(array_idx(i))
			imsiorderflag = trim(array_orderflag(i))

			SQL = " update tb_company set "
			SQL = SQL & " orderflag = '"& imsiorderflag &"' "
			SQL = SQL & " where flag='3' and idx = "& imsiidx
			db.Execute SQL
		next
	end if
	db.close
	response.redirect "list.asp?flag="&flag&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg&"&searchh="&searchh&"&searchi="&searchi
%>

