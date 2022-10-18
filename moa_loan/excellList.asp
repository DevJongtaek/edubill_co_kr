<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=order.xls"
%>

<!--#include virtual="/moa_loan/db/db.asp"-->

<%
	
	searchd = request("searchd")
	searche = request("searche")
	searchi = request("searchi")
	searchj = request("searchj")
	
	
	

	if searchd="" then
		searchd = "0"
	end if
	if searche="" then
		searche = "0"
	end if
	if searchi="" then
		searchi = "0"
	end if
	if searchj="" then
		searchj = "0"
	end if
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	

	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select a.seq, convert(varchar(10), a.RequestDay, 11) Request_Day ,a.RequestName ,a.RequestSangho  ,a.RequestTel  ,a.RequestHP  ,a.WishMoney,  a.LoanOrg  ,a.LoanProduct  ,a.LoanMoney  ,[InterestRate ]  ,convert(varchar(10), a.LoanDay, 11), a.StatusMemo,b.Name as BankName,d.Name as BranchName,a.RequestRegNo,a.RequestBIzNo  from tb_loan a "
        sql=sql +"left join StaticOptions b on a.LoanOrg = b.Value and b.Div='Bank' left join tb_Branch d on a.Loan_Branch = d.idx and a.Loan_area = d.AreaIdx" 
        sql = sql+" where replace(convert(varchar(10), RequestDay, 111), '/', '') <= '" & searche & "' and replace(convert(varchar(10), RequestDay, 111), '/', '') >= '" & searchd & "' "

	if session("Ausergubun")  = "3" then '관리자
		
		
	elseif session("Ausergubun")  = "2" then '지사
	
		sql = SQL+ "AND Loan_Area =  '"& session("Aarea") &"' AND Loan_Branch =  '"& session("Abranch") &"'"
	elseif session("Ausergubun")  = "1" then '금융기관
		
		 sql = SQL+ "AND LoanOrg =  '"& session("Abank") &"'"
	end if

	 If searchj = "1" Then
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and a.RequestName like '%" & searchk &  "%' "
	ElseIf searchj = "2" Then
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and a.RequestSangho like '%" & searchk &  "%' "
	ElseIf searchj = "3" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and a.LoanProduct like '%" & searchk &  "%' "
	ElseIf searchj = "4" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and d.Name like '%" & searchk &  "%' "
	ElseIf searchj = "5" Then 
	sqlFilter = sqlFilter & " and b.Name like '%" & searchk &  "%' "
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		ElseIf searchj = "6" Then 
		If searchk = "" Then 
			sqlFilter = sqlFilter & " and a.LoanDay is null "
		else
			sqlFilter = sqlFilter & " and a.LoanDay like '%" & searchk &  "%' "
		End If  
	End If 

	If searchi = "1" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and a.LoanDay is null "
	ElseIf searchi = "2" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and a.LoanDay is not null "
	End If 

	sql = sql & sqlFilter & " order by a.RequestDay desc"

	rslist.Open sql, db, 1
		
%>

<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<style type="text/css">
<!--
td.accountnum
{mso-number-format:\@}
-->
</STYLE>

<Script language=javascript>
	
	 
	      alert("수정 되었습니다");
	        window.opener.location.reload();
	    window.close();
	  
	     
	    
	     
	</Script>
	
	
</head>

<table border="1">
	<tr height=28 align=center>
		<td>번호</td>
		<td>신청일자</td>
		<td>대출자</td>
		<td>주민등록번호</td>
		
		<td>상호명</td>
		<td>사업자등록번호</td>
		<td>전화번호</td>
		<td>핸드폰번호</td>
		<td>희망금액(만원)</td>
		
		
	<!--	<td>금융기관</td>
		<td>대출상품</td>
		<td>대출금액(만원)</td>
		<td>금리(%)</td>
		<td>대출일</td>
		<td>진행상황</td>								-->
	</tr>

<%
i=1
do until rslist.EOF
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
	
		<td><%=rslist(1)%></td> <!--'신청일자-->
		<td><%=rslist(2)%></td> <!--'대출자-->
		<td><%=rslist(15)%></td> <!--''주민번호-->
		<td><%=rslist(3)%></td> <!--''상호명-->
		<td><%=rslist(16)%></td> <!--''사업자등록번호-->
		<td><%=rslist(4)%></td> <!--''전화번호-->
		<td><%=rslist(5)%></td> <!--''핸드폰번호-->
		<td><%=rslist(6)%></td> <!--''대출희망금액-->
		
		
		
	<!--	<td><%=rslist(13)%></td>
		<td><%=product%></td>
		<td><%=rslist(9)%></td>
		<td><%=rslist(10)%></td>
		<td><%=rslist(11)%></td>
		<td><%=rslist(12)%></td>-->
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
loop 
%>

</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>