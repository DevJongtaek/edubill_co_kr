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

	if session("Ausergubun")  = "3" then '������
		
		
	elseif session("Ausergubun")  = "2" then '����
	
		sql = SQL+ "AND Loan_Area =  '"& session("Aarea") &"' AND Loan_Branch =  '"& session("Abranch") &"'"
	elseif session("Ausergubun")  = "1" then '�������
		
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
	
	 
	      alert("���� �Ǿ����ϴ�");
	        window.opener.location.reload();
	    window.close();
	  
	     
	    
	     
	</Script>
	
	
</head>

<table border="1">
	<tr height=28 align=center>
		<td>��ȣ</td>
		<td>��û����</td>
		<td>������</td>
		<td>�ֹε�Ϲ�ȣ</td>
		
		<td>��ȣ��</td>
		<td>����ڵ�Ϲ�ȣ</td>
		<td>��ȭ��ȣ</td>
		<td>�ڵ�����ȣ</td>
		<td>����ݾ�(����)</td>
		
		
	<!--	<td>�������</td>
		<td>�����ǰ</td>
		<td>����ݾ�(����)</td>
		<td>�ݸ�(%)</td>
		<td>������</td>
		<td>�����Ȳ</td>								-->
	</tr>

<%
i=1
do until rslist.EOF
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
	
		<td><%=rslist(1)%></td> <!--'��û����-->
		<td><%=rslist(2)%></td> <!--'������-->
		<td><%=rslist(15)%></td> <!--''�ֹι�ȣ-->
		<td><%=rslist(3)%></td> <!--''��ȣ��-->
		<td><%=rslist(16)%></td> <!--''����ڵ�Ϲ�ȣ-->
		<td><%=rslist(4)%></td> <!--''��ȭ��ȣ-->
		<td><%=rslist(5)%></td> <!--''�ڵ�����ȣ-->
		<td><%=rslist(6)%></td> <!--''��������ݾ�-->
		
		
		
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