<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%

	Response.Expires = 0   
	Response.AddHeader "Pragma","no-cache"   
	Response.AddHeader "Cache-Control","no-cache,must-revalidate"  

	call ordertimechb(left(session("AAusercode"),5))	'주문차단시간 체크

	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")

	pcode = request("pcode")
	pcnt  = request("pcnt")

	Spcode = split(pcode,",")
	Spcnt  = split(pcnt,",")
	snum   = ubound(Spcode)

	wdate = replace(left(now(),10),"-","")
	usercode = session("AAusercode")

 
    Rcc = request("creturnchoice")
  
    Returncomment  = split(Rcc,",")
 ' response.write Rcc
	for i=0 to snum

		if trim(Spcnt(i))="" or isnull(trim(Spcnt(i))) or trim(Spcnt(i))="0"  then
		else
			imsipcode = trim(Spcode(i))
			imsipcnt  = trim(Spcnt(i))
            imsireturncomment = trim(Returncomment(i))

    
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select pprice "
			SQL = sql & " from tb_product "
			SQL = sql & " where usercode = '"& left(session("AAusercode"),5) &"' "
			SQL = sql & " and pcode = '"& imsipcode &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				imsipprice = rs(0)
			else
				imsipprice = ""
			end if
			rs.close

			if imsipprice <> "" then
				SQL = "insert into tb_product_cart_Return (usercode,pcode,pprice,pcnt,wdate,Returncomment) values ( '"& usercode &"' , '"& imsipcode &"' , "& imsipprice &" , "& imsipcnt &" , '"& wdate &"',"& imsireturncomment &" ) "


				db.Execute SQL
			end if
		end if

	next

	db.close
	set db=Nothing
	If searche = "" Then 
		response.redirect "AgencyReturnOrderCartFRM.asp"
	Else
		response.redirect "AgencyReturnOrderFRM.asp?searcha=" & searcha & "&searchb=" & searchb & "&searchc=" & searchc 
	End If 
%>

