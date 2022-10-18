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
	GotoPage = Request("GotoPage")
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	idx    = trim(request("idx"))
	bigo   = trim(request("bigo"))
	taxReg = trim(request("taxReg")) '선택만 idx값으로 넘어옴
	seq    = trim(request("seq"))	 '세금계산서 키값
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if seq<>"" then 
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		arr_seq  = split(seq,",")
		for i=0 to ubound(arr_seq)
			'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			imsival = trim(arr_seq(i))
			if imsival<>"" then
				arr_imsival = split(imsival,"&")
				imsiseq     = trim(arr_imsival(0))
				imsiidx     = trim(arr_imsival(1))
				imsitr_il   = trim(arr_imsival(2))
				imsidep_amt = trim(arr_imsival(3))
				if imsidep_amt="" or isnull(imsidep_amt) then imsidep_amt=0
				'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				if imsiseq>0 then
					set rs = server.CreateObject("ADODB.Recordset")
					sql = " select Aym from tAccountM where seq = "& imsiseq
					rs.Open sql, db, 1
					if not rs.eof then
						Aym = rs(0)
						Aym = mid(Aym,1,4) &"/"& mid(Aym,5,2)
					end if
					rs.close
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					imsibigo = Aym
					imsitaxReg = "y"
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					SQL = "update tb_virtual_acnt set "
					SQL = SQL & " bigo = '"& imsibigo &"', "
					SQL = SQL & " taxReg = '"& imsitaxReg &"' "
					SQL = SQL & " where idx = "& imsiidx
					db.Execute SQL
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					SQL = "update tAccountM set idate = '"& imsitr_il &"', "
					SQL = SQL & " imoney = "& imsidep_amt &" "
					SQL = SQL & " where seq = "& imsiseq
					db.Execute SQL
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				else
					SQL = "update tb_virtual_acnt set "
					SQL = SQL & " bigo = '미적용', "
					SQL = SQL & " taxReg = 'y' "
					SQL = SQL & " where idx = "& imsiidx
					db.Execute SQL
				end if
			end if
		next
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if taxReg<>"" then
		SQL = "update tb_virtual_acnt set taxReg = 'y' where idx in ( "& taxReg &" ) "
		db.Execute SQL
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	db.close
	set db=nothing
	response.redirect "cyberNum.asp?gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg
%>
