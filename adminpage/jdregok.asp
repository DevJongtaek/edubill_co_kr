<!--#include virtual="/db/db.asp" -->
<%
	checkid = request("val")
	gubun   = request("gubun")

	select case gubun
		case "1"	'회원사등록
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select isnull(count(idx),0) from tb_company where flag='1' and tcode = '"& checkid &"' "
			rs.Open sql, db, 1
			if rs(0)=0 then
				msg = checkid & " 회원사코드는 사용 가능한 코드입니다."
			else
				msg = checkid & " 회원사코드는 사용이 불가능한 코드입니다.\n다른 회원사코드를 사용 하세요."
			end if
			rs.close
		case "2"	'지사등록
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select isnull(count(idx),0) from tb_company where ((bidxsub = '"& left(session("Ausercode"),5) &"') or (idx = '"& left(session("Ausercode"),5) &"')) and tcode = '"& checkid &"' "
			rs.Open sql, db, 1
			if rs(0)=0 then
				msg = checkid & " 지사코드는 사용 가능한 코드입니다."
			else
				msg = checkid & " 지사코드는 사용이 불가능한 코드입니다.\n다른 지사코드를 사용 하세요."
			end if
			rs.close
		case "3"	'체인점등록
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select isnull(count(idx),0) from tb_company where ((bidxsub = '"& left(session("Ausercode"),5) &"') or (idx = '"& left(session("Ausercode"),5) &"')) and tcode = '"& checkid &"' "
			rs.Open sql, db, 1
			if rs(0)=0 then
				msg = checkid & " 체인점코드는 사용 가능한 코드입니다."
			else
				msg = checkid & " 체인점코드는 사용이 불가능한 코드입니다.\n다른 체인점코드를 사용 하세요."
			end if
			rs.close
		case "4"	'상품등록
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select count(idx) from tb_product where usercode = '"& session("Ausercode") &"' and pcode = '"& checkid &"' "
			rs.Open sql, db, 1
			if rs(0)=0 then
				msg = checkid & " 상품코드는 사용 가능한 코드입니다."
			else
				msg = checkid & " 상품코드는 사용이 불가능한 코드입니다.\n다른 상품코드를 사용 하세요."
			end if
			rs.close
	end select

	response.write "<Script language=javascript>"
	response.write "	alert('" & msg & "');"
	response.write "</Script>"
%>