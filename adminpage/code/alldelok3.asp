<!--#include virtual="/db/db.asp"-->
<%
	gubun = request("gubun")	'1:��ǰ 2:����/ü����
	bcode = request("bcode")	'ȸ�����ڵ�

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
		alert("����Ÿ�� ���������� ���� �Ǿ����ϴ�.");
		location.href = "alldel2.asp";
	</Script>