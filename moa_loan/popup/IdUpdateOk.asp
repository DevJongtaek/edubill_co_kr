
<!--#include virtual="/moa_loan/db/db.asp"-->

<%
    seq = replace(request("Seq"),"'","''")
    loangubun  = replace(request("searcha"),"'","''") '����
    loanBank  = replace(request("searchg"),"'","''")'���������
    loanArea  = replace(request("searchc"),"'","''") '����
    loanBranch  = replace(request("searchf"),"'","''") '�Ҽ�����
    loanuserid = replace(request("userid"),"'","''") '���̵�

	  loanuserpwd = replace(request("userpwd"),"'","''") '��й�ȣ
	  writeyn = replace(request("writeyn"),"'","''") '����
	  
	  if writeyn = "on" then
  	writeyn = 1
  	else
  	writeyn = 0
  	end if
  	
'	loanwritedate = replace(request("loanRegNo2"),"'","''") '�������

    dflag = request("dflag")
    
    if dflag = "1" then

          SQL = "delete tb_LoanUser "
					SQL = SQL & " where idx = '"& seq &"' "
				

  	else
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

	SQL = "Update tb_LoanUser "
	SQL = SQL & "set userpwd = '"& loanuserpwd & "' "
	SQL = SQL & ", writeyn = '"& writeyn &"'"
	SQL = SQL & " WHERE idx = '"& seq &"'"


'response.write SQL
	

  end if
  
  'response.write dflag
  	db.Execute sql
	db.close
	set db=Nothing
%>
	<Script language=javascript>
	
	 
	      alert("���� �Ǿ����ϴ�");
	        window.opener.location.reload();
	    window.close();
	  
	     
	    
	     
	</Script>
	