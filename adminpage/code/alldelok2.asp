<!--#include virtual="/db/db.asp"-->
<%
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	searcha = request("searcha")
	imsiday = left(now(),10)
	companycode    = replace(trim(request("companycode"))," ","")
'response.write companycode
'response.end
	companycodeArr = split(companycode,",")
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if companycode<>"" then
		if searcha="6" then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select datadel from tb_company where flag = '1' and idx = "& companycode
			rs.Open sql, db, 1
			datadel = rs(0)
			rs.close
			searcha = datadel
		end if
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if searcha="1" then	'일주일전
		sday = replace(cdate(imsiday)-7,"-","")
	elseif searcha="2" then	'2주일전
		sday = replace(cdate(imsiday)-14,"-","")
	elseif searcha="3" then	'3주일전
		sday = replace(cdate(imsiday)-21,"-","")
	elseif searcha="4" then	'1개월전
		sday = replace(DateAdd("m",-1,imsiday),"-","")
	elseif searcha="5" then	'2개월전
		sday = replace(DateAdd("m",-2,imsiday),"-","")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if companycode<>"" then
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	for i=0 to ubound(companycodeArr)
		companycode = int(trim(companycodeArr(i)))
		SQL = "delete tb_download "
		SQL = SQL & " where bidxsub = "& companycode &" and (start_date < '"& sday &"' or end_date < '"& sday &"') "
		db.Execute SQL
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = "delete tb_order_product "
		SQL = SQL & " where idx in ( select idx from tb_order where substring(usercode,1,5) = '"& companycode &"' and substring(idx,1,8) < '"& sday &"' ) "
		db.Execute SQL
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = "delete tb_order "
		SQL = SQL & " where substring(usercode,1,5) = '"& companycode &"' and substring(idx,1,8) < '"& sday &"' "
		db.Execute SQL
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = "update tb_company set datadelday = getdate() where flag='1' and idx = "& companycode
		db.Execute SQL
	next
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = "delete tb_download "
		SQL = SQL & " where (start_date < '"& sday &"' or end_date < '"& sday &"') "
		db.Execute SQL
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = "delete tb_order_product "
		SQL = SQL & " where idx in ( select idx from tb_order where substring(idx,1,8) < '"& sday &"' ) "
		db.Execute SQL
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		SQL = "delete tb_order "
		SQL = SQL & " where substring(idx,1,8) < '"& sday &"' "
		db.Execute SQL
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	db.close
%>

	<Script language=javascript>
		alert("데이타가 성공적으로 삭제 되었습니다.");
		location.href = "alldel2.asp";
	</Script>