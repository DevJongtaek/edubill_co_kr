
<!--#include virtual="/moa_loan/db/db.asp"-->

<%
    loangubun  = replace(request("searcha"),"'","''") '����
    loanBank  = replace(request("searchg"),"'","''")'���������
    loanArea  = replace(request("searchc"),"'","''") '����
    loanBranch  = replace(request("searchf"),"'","''") '�Ҽ�����
    loanuserid = replace(request("userid"),"'","''") '���̵�

	  loanuserpwd = replace(request("userpwd"),"'","''") '��й�ȣ
	  writeyn = replace(request("writeyn"),"'","''")'����
	  
	if writeyn = "on" then
	writeyn = 1
	else
	writeyn = 0
	end if
	  
'	loanwritedate = replace(request("loanRegNo2"),"'","''") '�������
if loangubun = 1then
	if loanBank = 1 then
	  filename = "daishin.png"
	
	elseif loanbank = 2 then
	  filename = "sejong.png"	
	elseif loanbank = 3 then
		filename = "hyundai.png"
 
	end if

 
end if
'response.write loangubun

	
	
	'If Len(loanBirthDay2) < 2 Then
	'loanBirthDay2 = "0" & loanBirthDay2
	'End If 

	'If Len(loanBirthDay3) < 2 Then
	'loanBirthDay3 = "0" & loanBirthDay3
	'End If 

	'loanBirthDay = loanBirthDay1 & loanBirthDay2 & loanBirthDay3

	'loanTel = loanTel1 & "-" & loanTel2 & "-" & loanTel3
   ' loanHP = loanHP1 & "-" & loanHP2 & "-" & loanHP3
   ' loanBizNo = loanBizNo1 & "-"& loanBizNo2 & "-" & loanBizNo3
   ' loanRegNo = loanRegNo1 & "-"& loanRegNo2 

	'���� ���
    'age = Year(Now()) - CInt(Left(loanBirthDay, 4))
if loangubun = 1 then '�������
	SQL = "insert into tb_LoanUser ( "
	SQL = SQL & " WriteDate"
	SQL = SQL & " , Gubun "
  SQL = SQL & " ,Bank "
  SQL = SQL & " ,Area "
	SQL = SQL & "  ,Branch "
  SQL = SQL & " ,userid "
	SQL = SQL & "  ,userpwd "
	SQL = SQL & "  ,filename "
	SQL = SQL & ") VALUES ( "
	SQL = SQL & "  getdate() "
  SQL = SQL & "  ,'" & loangubun & "' "
  SQL = SQL & "  ,'" & loanBank & "' "
	SQL = SQL & "  ,'" & loanArea & "' "
	SQL = SQL & "  ,'" & loanBranch & "'  "
	SQL = SQL & "  ,'" & loanuserid & "' "
	SQL = SQL & "  ,'" & loanuserpwd & "' "
	SQL = SQL & "  ,'" & filename & "')"
elseif loangubun = 3 then '������
SQL = "insert into tb_LoanUser ( "
	SQL = SQL & " WriteDate"
	SQL = SQL & " , Gubun "
  SQL = SQL & " ,Bank "
  SQL = SQL & " ,Area "
	SQL = SQL & "  ,Branch "
  SQL = SQL & " ,userid "
	SQL = SQL & "  ,userpwd "
  SQL = SQL & "  ,writeyn "
	SQL = SQL & ") VALUES ( "
	SQL = SQL & "  getdate() "
  SQL = SQL & "  ,'" & loangubun & "' "
  SQL = SQL & "  ,'" & loanBank & "' "
	SQL = SQL & "  ,'" & loanArea & "' "
	SQL = SQL & "  ,'" & loanBranch & "'  "
	SQL = SQL & "  ,'" & loanuserid & "' "
	SQL = SQL & "  ,'" & loanuserpwd & "' "
	SQL = SQL & "  ,'" & writeyn & "')"
else
SQL = "insert into tb_LoanUser ( "
	SQL = SQL & " WriteDate"
	SQL = SQL & " , Gubun "
  SQL = SQL & " ,Bank "
  SQL = SQL & " ,Area "
	SQL = SQL & "  ,Branch "
  SQL = SQL & " ,userid "
	SQL = SQL & "  ,userpwd "
	SQL = SQL & ") VALUES ( "
	SQL = SQL & "  getdate() "
  SQL = SQL & "  ,'" & loangubun & "' "
  SQL = SQL & "  ,'" & loanBank & "' "
	SQL = SQL & "  ,'" & loanArea & "' "
	SQL = SQL & "  ,'" & loanBranch & "'  "
	SQL = SQL & "  ,'" & loanuserid & "' "
	SQL = SQL & "  ,'" & loanuserpwd & "')"
end if
'response.write sql
	db.Execute SQL 

	
	db.close
	set db=Nothing
%>
	<Script language=javascript>
	    alert("���������� ����Ǿ����ϴ�");
	    window.opener.location.reload();
	    window.close();
	</Script>
	