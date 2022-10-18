<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include virtual="/moa_loan/db/db.asp"-->
<%
    loanSangho  = replace(request("loanSangho"),"'","''") '상호명
    loanBizNo1  = replace(request("loanBizNo1"),"'","''") '사업자등록번호
    loanBizNo2  = replace(request("loanBizNo2"),"'","''")
    loanBizNo3  = replace(request("loanBizNo3"),"'","''")
    loanName = replace(request("loanName"),"'","''") '대표자

	loanRegNo1 = replace(request("loanRegNo1"),"'","''") '주민등록번호
	loanRegNo2 = replace(request("loanRegNo2"),"'","''")
	


	loanTel1 = replace(request("loanTel1"),"'","''") ' 전화번호
	loanTel2 = replace(request("loanTel2"),"'","''")
	loanTel3 = replace(request("loanTel3"),"'","''")

	loanHP1 = replace(request("loanHP1"),"'","''") '핸드폰번호
	loanHP2 = replace(request("loanHP2"),"'","''")
	loanHP3 = replace(request("loanHP3"),"'","''")

	WishMoney = replace(request("WishMoney"),"'","''") '희망대출금액
    loanProposer = replace(request("loanProposer"),"'","''")'추천인
    
    loanArea =  replace(request("searchc"),"'","''")'지역
    loanBranch =  replace(request("searchf"),"'","''")'소속지사

	contents = replace(request("contents"),"'","''") '남기고싶은말
	
	'If Len(loanBirthDay2) < 2 Then
	'loanBirthDay2 = "0" & loanBirthDay2
	'End If 

	'If Len(loanBirthDay3) < 2 Then
	'loanBirthDay3 = "0" & loanBirthDay3
	'End If 

	'loanBirthDay = loanBirthDay1 & loanBirthDay2 & loanBirthDay3

	loanTel = loanTel1 & "-" & loanTel2 & "-" & loanTel3
    loanHP = loanHP1 & "-" & loanHP2 & "-" & loanHP3
    loanBizNo = loanBizNo1 & "-"& loanBizNo2 & "-" & loanBizNo3
    loanRegNo = loanRegNo1 & "-"& loanRegNo2 

	'나이 계산
    'age = Year(Now()) - CInt(Left(loanBirthDay, 4))

	SQL = "insert into tb_Loan ( "
	SQL = SQL & "  RequestDay "
    SQL = SQL & " ,RequestSangho "
    SQL = SQL & " ,RequestBizNo "
	SQL = SQL & "  ,RequestName "
    SQL = SQL & " ,RequestRegNo "
	'SQL = SQL & "  ,RequestAge "
	SQL = SQL & "  ,RequestTel "
	SQL = SQL & "  ,RequestHP "
	SQL = SQL & "  ,WishMoney "
    SQL = SQL & " ,RequestProposer "
    SQL = SQL & " ,Loan_Area "
    SQL = SQL & " ,Loan_Branch "
	SQL = SQL & "  ,Contents "
	SQL = SQL & ") VALUES ( "
	SQL = SQL & "  getdate() "
    SQL = SQL & "  ,'" & loanSangho & "' "
    SQL = SQL & "  ,'" & loanBizNo & "' "
	SQL = SQL & "  ,'" & loanName & "' "
	SQL = SQL & "  ,'" & loanRegNo & "'  "
	SQL = SQL & "  ,'" & loanTel & "' "
	SQL = SQL & "  ,'" & loanHP & "' "
	SQL = SQL & "  ,'" & WishMoney & "'  "
    SQL = SQL & "  ,'" & loanProposer & "'  "
     SQL = SQL & "  ,'" & LoanArea & "'  "
     SQL = SQL & "  ,'" & LoanBranch & "'  "
	SQL = SQL & "  ,'" & contents & "' )"


	db.Execute SQL 

	'response.write SQL
	db.close
	set db=Nothing
%>
	<Script language=javascript>
	    alert("성공적으로 저장되었습니다. 상담원이 연락드리겠습니다.");
	    location.href = "loan.asp";
	</Script>
	