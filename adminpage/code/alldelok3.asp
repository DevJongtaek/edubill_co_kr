<!--#include virtual="/db/db.asp"-->
<%
	gubun = request("gubun")	'1:상품 2:지사/체인점
	bcode = request("bcode")	'회원사코드

	if gubun="1" then

		SQL = "delete tb_product "
		SQL = SQL & " where usercode = '"& bcode &"' "
		db.Execute SQL

	elseif gubun="2" then

		SQL = "delete tb_company "
		SQL = SQL & " where flag = '3' and bidxsub = "& bcode &" "
		db.Execute SQL

	end if

	db.close

%>

	<Script language=javascript>
		alert("데이타가 성공적으로 삭제 되었습니다.");
		location.href = "alldel2.asp";
	</Script>