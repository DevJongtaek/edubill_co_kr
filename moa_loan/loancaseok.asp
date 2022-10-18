<!--#include virtual="/moa_loan/db/db.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	seq = replace(request("Seq"),"'","''")
	LoanOrg = replace(request("searchg"),"'","''")
	'LoanOrg = replace(request("searchg")," ","")
	LoanProduct = replace(request("LoanProduct"),"'","''")
	LoanMoney = replace(request("LoanMoney"),"'","''")
	InterestRate = replace(request("InterestRate"),"'","''")
	LoanDay = replace(replace(request("LoanDay"),"'","''"),"/","")
	StatusMemo = replace(request("StatusMemo"),"'","''")

	If LoanDay <> "" Then
	LoanDay = Left(LoanDay, 4) & "-" & Mid(LoanDay, 5, 2) & "-" & Mid(LoanDay, 7, 2) & " " & FormatDateTime(Time, 4) & ":00"
	End If 


if session("AuserGubunName") = "관리자"  then
	SQL = "update tb_Loan set "
	IF ISNULL(LoanOrg)  or LoanOrg = "" then
	ELSE
	SQL = SQL & " LoanOrg =  '" & LoanOrg & "' , "
	END IF
	
	SQL = SQL & " LoanProduct = '" & LoanProduct & "' "
	If LoanMoney = "" Then 
		SQL = SQL & "  ,LoanMoney = null "
	Else 
		SQL = SQL & "  ,LoanMoney = '" & LoanMoney & "' "
	End If 
	If InterestRate = "" then 
		SQL = SQL & "  ,InterestRate = null "
	else
		SQL = SQL & "  ,InterestRate = '" & InterestRate & "' "
	End If 
	If LoanDay = "" Then 
		SQL = SQL & "  ,LoanDay = null "
	Else
		SQL = SQL & "  ,LoanDay = '" & LoanDay & "' "
	End If 
	SQL = SQL & "  ,StatusMemo = '" & StatusMemo & "' "
	SQL = SQL & "  where seq = '" & seq & "' "
	
	else
	SQL = "update tb_Loan set "
	'SQL = SQL & "   LoanOrg =  '" & LoanOrg & "' "
	SQL = SQL & "  LoanProduct = '" & LoanProduct & "' "
	If LoanMoney = "" Then 
		SQL = SQL & "  ,LoanMoney = null "
	Else 
		SQL = SQL & "  ,LoanMoney = '" & LoanMoney & "' "
	End If 
	If InterestRate = "" then 
		SQL = SQL & "  ,InterestRate = null "
	else
		SQL = SQL & "  ,InterestRate = '" & InterestRate & "' "
	End If 
	If LoanDay = "" Then 
		SQL = SQL & "  ,LoanDay = null "
	Else
		SQL = SQL & "  ,LoanDay = '" & LoanDay & "' "
	End If 
	SQL = SQL & "  ,StatusMemo = '" & StatusMemo & "' "
	SQL = SQL & "  where seq = '" & seq & "' "
	

end if
'response.write SQL
	db.Execute SQL 

	
	db.close
	set db=Nothing
%>
<Script language=javascript>
	    alert("성공적으로 저장되었습니다");
	    window.opener.location.reload();
	    window.close();
	</Script>
	