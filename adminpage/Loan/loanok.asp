<!--#include virtual="/db/db.asp"-->
<%
	loanName = replace(request("loanName"),"'","''")
	loanBirthDay1 = replace(request("loanBirthDay1"),"'","''")
	loanBirthDay2 = replace(request("loanBirthDay2"),"'","''")
	loanBirthDay3 = replace(request("loanBirthDay3"),"'","''")
	loanTel1 = replace(request("loanTel1"),"'","''")
	loanTel2 = replace(request("loanTel2"),"'","''")
	loanTel3 = replace(request("loanTel3"),"'","''")
	loanHP1 = replace(request("loanHP1"),"'","''")
	loanHP2 = replace(request("loanHP2"),"'","''")
	loanHP3 = replace(request("loanHP3"),"'","''")
	WishMoney = replace(request("WishMoney"),"'","''")
	contents = replace(request("contents"),"'","''")
	
	If Len(loanBirthDay2) < 2 Then
	loanBirthDay2 = "0" & loanBirthDay2
	End If 

	If Len(loanBirthDay3) < 2 Then
	loanBirthDay3 = "0" & loanBirthDay3
	End If 

	loanBirthDay = loanBirthDay1 & loanBirthDay2 & loanBirthDay3
	loanTel = loanTel1 & "-" & loanTel2 & "-" & loanTel3
    loanHP = loanHP1 & "-" & loanHP2 & "-" & loanHP3

	'���� ���
    'age = Year(Now()) - CInt(Left(loanBirthDay, 4))

	SQL = "insert into tb_Loan ( "
	SQL = SQL & "  RequestDay "
	SQL = SQL & "  ,RequestName "
	SQL = SQL & "  ,RequestAge "
	SQL = SQL & "  ,RequestTel "
	SQL = SQL & "  ,RequestHP "
	SQL = SQL & "  ,WishMoney "
	SQL = SQL & "  ,Contents "
	SQL = SQL & ") VALUES ( "
	SQL = SQL & "  getdate() "
	SQL = SQL & "  ,'" & loanName & "' "
	SQL = SQL & "  ,'" & loanBirthDay & "'  "
	SQL = SQL & "  ,'" & loanTel & "' "
	SQL = SQL & "  ,'" & loanHP & "' "
	SQL = SQL & "  ,'" & WishMoney & "'  "
	SQL = SQL & "  ,'" & contents & "' )"
	db.Execute SQL 

	'response.write SQL
	db.close
	set db=Nothing
%>
	<Script language=javascript>
		alert("���������� ����Ǿ����ϴ�. ������ �����帮�ڽ��ϴ�.");
		location.href = "loan.asp";
	</Script>
	