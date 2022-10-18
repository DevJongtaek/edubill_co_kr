<!--#include virtual="/db/db.asp"-->
<%
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	dflag = request("dflag")
	imsiday = left(now(),10)
	if dflag="1" then	'6개월
		sday = replace(DateAdd("m",-6,imsiday),"-","")
	elseif dflag="2" then	'1년
		sday = replace(DateAdd("m",-12,imsiday),"-","")
	elseif dflag="3" then	'2년
		sday = replace(DateAdd("m",-24,imsiday),"-","")
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "delete tb_virtual_acnt "
	SQL = SQL & " where tr_il < '"& sday &"' "
	db.Execute SQL
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	db.close

%>

	<Script language=javascript>
		alert("데이타가 성공적으로 삭제 되었습니다.");
		location.href = "alldel2.asp";
	</Script>