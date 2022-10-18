<!--#include virtual="/db/db.asp"-->
<%
	searcha = request("searcha")
	imsiday = left(now(),10)

	if searcha="1" then	'일주일전
		sday = replace(cdate(imsiday)-7,"-","")
	elseif searcha="2" then	'3주일전
		sday = replace(cdate(imsiday)-21,"-","")
	elseif searcha="3" then	'1개월전
		sday = replace(DateAdd("m",-1,imsiday),"-","")
	elseif searcha="4" then	'2개월전
		sday = replace(DateAdd("m",-2,imsiday),"-","")

	elseif searcha="5" then	'2주일전
		sday = replace(cdate(imsiday)-14,"-","")
	elseif searcha="6" then	'4주일전
		sday = replace(cdate(imsiday)-28,"-","")
	end if
	eday = replace(imsiday,"-","")

	SQL = "delete tb_download "
	SQL = SQL & " where bidxsub = '"& left(session("Ausercode"),5) &"' "
	SQL = SQL & " and (start_date < '"& sday &"' or end_date < '"& sday &"' )"
	db.Execute SQL

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'set rs = server.CreateObject("ADODB.Recordset")
	'SQL = " select idx "
	'SQL = sql & " from tb_order "
	'SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	'SQL = sql & " and substring(idx,1,8) < '"& sday &"' "
	'rs.Open sql, db, 1
	'do until rs.eof
	'	SQL = "delete tb_order_product "
	'	SQL = SQL & " where idx = '"& rs(0) &"' "
	'	db.Execute SQL
	'rs.movenext
	'loop
	'rs.close
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "delete tb_order_product "
	SQL = SQL & " where idx in ( select idx from tb_order where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' and substring(idx,1,8) < '"& sday &"' ) "
	db.Execute SQL
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "delete tb_order "
	SQL = SQL & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' and substring(idx,1,8) < '"& sday &"' "
	db.Execute SQL

	db.close

%>

	<Script language=javascript>
		alert("데이타가 성공적으로 삭제 되었습니다.");
		location.href = "alldel.asp";
	</Script>