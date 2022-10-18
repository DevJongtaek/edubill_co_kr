
<!--#include virtual="/moa_loan/Inc_Files/sessionend.asp"-->
<!--#include virtual="/moa_loan/db/db.asp"-->
<!--#include virtual="/moa_loan/Inc_Files/top.asp"-->

<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	
    <%
	gongi = request("gongi")
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	' 검색 조건 추가 
	searchi = request("searchi")
	searchj = request("searchj")
	searchk = request("searchk")

	if searchg="" then
		searchg = "0"
	end if
	if searchc="" then
		searchc = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if

	if searchd="" then
		searchd = replace(left(now()-7,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if
	'''''''''''''''''''''''''''
	fclass1 = Request("fclass1")
	sclass2 = Request("sclass2")
	tclass3 = Request("tclass3")
	imsifclass1 = right(Request("fclass1"),5)
	imsisclass2 = right(Request("sclass2"),5)
	imsitclass3 = right(Request("tclass3"),5)

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sqlFilter = ""
	sqlFileter2 = ""
        if session("Ausergubun")  = "3" then '관리자
	set rslist = server.CreateObject("ADODB.Recordset")
	'sql = " select seq, convert(varchar(10), RequestDay, 11) Request_Day ,RequestSangho  , case when RTRIM(RequestAge) <> '' then year(getdate()) - year(RequestAge) else '00' end RequestAge,RequestTel  ,RequestHP  ,WishMoney,  LoanOrg  ,LoanProduct  ,LoanMoney  ,[InterestRate ]  ,convert(varchar(10), LoanDay, 11), StatusMemo  from tb_loan where replace(convert(varchar(10), RequestDay, 111), '/', '') <= '" & searche & "' and replace(convert(varchar(10), RequestDay, 111), '/', '') >= '" & searchd & "' "
        sql = " select a.seq, convert(varchar(10), a.RequestDay,111) Request_Day ,a.RequestName ,a.RequestSangho  ,a.RequestTel  ,a.RequestHP  ,a.WishMoney,  a.LoanOrg  ,a.LoanProduct  ,REPLACE(CONVERT(VARCHAR(50), CAST((a.LoanMoney)as money),1) , '.00', '')  ,[InterestRate ]  ,convert(varchar(10), a.LoanDay, 111), a.StatusMemo,b.Name as BankName,d.Name as BranchName,c.Name as AreaName,a.RequestProposer,REPLACE(CONVERT(VARCHAR(50), CAST((convert(decimal,a.LoanMoney*10000) * 0.07)as money),1) , '.00', ''),REPLACE(CONVERT(VARCHAR(50), CAST(((convert(decimal,a.LoanMoney*10000) * 0.07)*0.6)as money),1)  , '.00', '') from tb_loan a "
        sql=sql +" left join StaticOptions b on a.LoanOrg = b.Value and b.Div='Bank' left join tb_Branch d on a.Loan_Branch = d.idx and a.Loan_area = d.AreaIdx " 
        sql = sql +" left join tb_Area c on a.Loan_area = c.idx" 
        sql = sql+" where replace(convert(varchar(10), RequestDay, 111), '/', '') <= '" & searche & "' and replace(convert(varchar(10), RequestDay, 111), '/', '') >= '" & searchd & "' "
        
 elseif session("Ausergubun")  = "2" then '지사
	set rslist = server.CreateObject("ADODB.Recordset")
	'sql = " select seq, convert(varchar(10), RequestDay, 11) Request_Day ,RequestSangho  , case when RTRIM(RequestAge) <> '' then year(getdate()) - year(RequestAge) else '00' end RequestAge,RequestTel  ,RequestHP  ,WishMoney,  LoanOrg  ,LoanProduct  ,LoanMoney  ,[InterestRate ]  ,convert(varchar(10), LoanDay, 11), StatusMemo  from tb_loan where replace(convert(varchar(10), RequestDay, 111), '/', '') <= '" & searche & "' and replace(convert(varchar(10), RequestDay, 111), '/', '') >= '" & searchd & "' "
         sql = " select a.seq, convert(varchar(10), a.RequestDay, 111) Request_Day ,a.RequestName ,a.RequestSangho  ,a.RequestTel  ,a.RequestHP  ,a.WishMoney,  a.LoanOrg  ,a.LoanProduct  ,REPLACE(CONVERT(VARCHAR(50), CAST((a.LoanMoney)as money),1) , '.00', '')  ,[InterestRate ]  ,convert(varchar(10), a.LoanDay, 111), a.StatusMemo,b.Name as BankName,d.Name as BranchName,c.Name as AreaName,a.RequestProposer,REPLACE(CONVERT(VARCHAR(50), CAST((convert(decimal,a.LoanMoney*10000) * 0.07)as money),1) , '.00', ''),REPLACE(CONVERT(VARCHAR(50), CAST(((convert(decimal,a.LoanMoney*10000) * 0.07)*0.6)as money),1)  , '.00', '') from tb_loan a "
        sql=sql +" left join StaticOptions b on a.LoanOrg = b.Value and b.Div='Bank' left join tb_Branch d on a.Loan_Branch = d.idx and a.Loan_area = d.AreaIdx " 
        sql = sql +" left join tb_Area c on a.Loan_area = c.idx" 
        sql = sql+" where replace(convert(varchar(10), RequestDay, 111), '/', '') <= '" & searche & "' and replace(convert(varchar(10), RequestDay, 111), '/', '') >= '" & searchd & "' "
        sql = SQL+ "AND Loan_Area =  '"& session("Aarea") &"' AND Loan_Branch =  '"& session("Abranch") &"'"
     elseif session("Ausergubun")  = "1" then '금융기관
	set rslist = server.CreateObject("ADODB.Recordset")
	'sql = " select seq, convert(varchar(10), RequestDay, 11) Request_Day ,RequestSangho  , case when RTRIM(RequestAge) <> '' then year(getdate()) - year(RequestAge) else '00' end RequestAge,RequestTel  ,RequestHP  ,WishMoney,  LoanOrg  ,LoanProduct  ,LoanMoney  ,[InterestRate ]  ,convert(varchar(10), LoanDay, 11), StatusMemo  from tb_loan where replace(convert(varchar(10), RequestDay, 111), '/', '') <= '" & searche & "' and replace(convert(varchar(10), RequestDay, 111), '/', '') >= '" & searchd & "' "
        sql = " select a.seq, convert(varchar(10), a.RequestDay, 111) Request_Day ,a.RequestName ,a.RequestSangho  ,a.RequestTel  ,a.RequestHP  ,a.WishMoney,  a.LoanOrg  ,a.LoanProduct  ,REPLACE(CONVERT(VARCHAR(50), CAST((a.LoanMoney)as money),1) , '.00', '')  ,[InterestRate ]  ,convert(varchar(10), a.LoanDay, 111), a.StatusMemo,b.Name as BankName,d.Name as BranchName,c.Name as AreaName,a.RequestProposer,REPLACE(CONVERT(VARCHAR(50), CAST((convert(decimal,a.LoanMoney*10000) * 0.07)as money),1) , '.00', ''),REPLACE(CONVERT(VARCHAR(50), CAST(((convert(decimal,a.LoanMoney*10000) * 0.07)*0.6)as money),1)  , '.00', '') from tb_loan a "
        sql=sql +" left join StaticOptions b on a.LoanOrg = b.Value and b.Div='Bank' left join tb_Branch d on a.Loan_Branch = d.idx and a.Loan_area = d.AreaIdx " 
        sql = sql +" left join tb_Area c on a.Loan_area = c.idx" 
        sql = sql+" where replace(convert(varchar(10), RequestDay, 111), '/', '') <= '" & searche & "' and replace(convert(varchar(10), RequestDay, 111), '/', '') >= '" & searchd & "' "
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
	sqlFilter = sqlFilter & " and a.RequestProposer like '%" & searchk &  "%' "
		
		ElseIf searchj = "7" Then 
		If searchk = "" Then 
			sqlFilter = sqlFilter & " and a.LoanDay is null "
		else
			sqlFilter = sqlFilter & " and a.LoanDay like '%" & searchk &  "%' "
		End If  
	End If 

	
		sqlFilter = sqlFilter & " and a.LoanDay is not null "
	

	sql = sql & sqlFilter & " order by a.RequestDay desc"
	
	'response.write sql
	'response.end
	rslist.PageSize=40
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if
	
	
	set rslist2 = server.CreateObject("ADODB.Recordset")
  sql2 = " select REPLACE(CONVERT(VARCHAR(50), CAST((sum(a.loanmoney))as money),1) , '.00', '')  ,REPLACE(CONVERT(VARCHAR(50), CAST((sum(convert(decimal,a.LoanMoney*10000) * 0.07))as money),1) , '.00', ''),REPLACE(CONVERT(VARCHAR(50), CAST(((sum(convert(decimal,a.LoanMoney*10000) * 0.07)*0.6))as money),1) , '.00', '') from tb_loan a  "
    sql2 = sql2 + " left join StaticOptions b on a.LoanOrg = b.Value and b.Div='Bank' left join tb_Branch d on a.Loan_Branch = d.idx and a.Loan_area = d.AreaIdx "
  sql2 = sql2 +" where replace(convert(varchar(10), RequestDay, 111), '/', '') <= '" & searche & "' and replace(convert(varchar(10), RequestDay, 111), '/', '') >= '" & searchd & "' "

 if session("Ausergubun")  = "2" then '지사
  
   sql2 = SQL2 + "AND a.Loan_Area =  '"& session("Aarea") &"' AND a.Loan_Branch =  '"& session("Abranch") &"'"
   
    elseif session("Ausergubun")  = "1" then '금융기관
    sql2 = SQL2 + "AND a.LoanOrg =  '"& session("Abank") &"'"
    
   end if
  If searchj = "1" Then
		
		sqlFilter2 = sqlFilter2 & " and a.RequestName like '%" & searchk &  "%' "
	ElseIf searchj = "2" Then
		
		sqlFilter2 = sqlFilter2 & " and a.RequestSangho like '%" & searchk &  "%' "
	ElseIf searchj = "3" Then 
		
		sqlFilter2 = sqlFilter2 & " and a.LoanProduct like '%" & searchk &  "%' "
	ElseIf searchj = "4" Then 
		
		sqlFilter2 = sqlFilter2 & " and d.Name like '%" & searchk &  "%' "
	ElseIf searchj = "5" Then 
	sqlFilter2 = sqlFilter2 & " and b.Name like '%" & searchk &  "%' "
		'
		ElseIf searchj = "6" Then 
	sqlFilter2 = sqlFilter2 & " and a.RequestProposer like '%" & searchk &  "%' "
		
		ElseIf searchj = "7" Then 
		If searchk = "" Then 
			sqlFilter2 = sqlFilter2 & " and a.LoanDay is null "
		else
			sqlFilter2 = sqlFilter2 & " and a.LoanDay like '%" & searchk &  "%' "
		End If  
	End If 
	sqlFilter2 = sqlFilter2 & " and a.LoanDay is not null "
	sql2 = sql2 & sqlFilter2 
	'rslist2.PageSize=20
	
	'response.write sql2
	rslist2.Open sql2, db, 1
 
	
%>

<script language="JavaScript">
<!--
    function onlyNumber() {
        if ((event.keyCode < 48) || (event.keyCode > 57))
            event.returnValue = false;
    }
    //-->
</script>
</HEAD>
<BODY>
		
	<!-- 콘텐츠 시작 -->
		<div style='width:100%;padding:30px 0 0 0;'>
			<table width='1000' border='0' cellspacing='0' cellpadding='0' align='center'>
				<tr>
					<td><img src='images/pg_bnn1.gif' style='width:1000px;height:180px;'></td>
				</tr>
				<tr>
					<td style='padding:30px 0 15px'><img src='images/pgtit2.gif'></td>
				</tr>
				<tr>
					<td style='padding:10px;border:1px solid #cccccc;'>
								<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>



<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="accounts.asp" method="POST" name=form>
	<tr>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>검색조건</b></td>
		<td nowrap width="90%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="오늘" value="오늘" class="box_work" onclick="javascript: serchtodaycheck(document.form.searchd, document.form.searche);"> 예)20110501 
          
			<select name="searchj" size="1" class="box_work">
       			<option value="0" <%if searchj="0" then%>selected<%end if%>>전체</option>
       			<option value="1" <%if searchj="1" then%>selected<%end if%>>대출자</option>
                <option value="2" <%if searchj="2" then%>selected<%end if%>>상호</option>
       <!--			<option value="3" <%if searchj="3" then%>selected<%end if%>>대출상품</option>-->
       			<option value="6" <%if searchj="6" then%>selected<%end if%>>추천인</option>
       			<% if session("Ausergubun")  = "3" then %>
       			<option value="4" <%if searchj="4" then%>selected<%end if%>>소속지사</option>

       			<option value="5" <%if searchj="5" then%>selected<%end if%>>금융기관</option>
       			<%end if%>
       		</select>
			<input type="Text" name="searchk" size="8" maxlength="15" value="<%=searchk%>" style="width:150">
	        <input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        <input type="button" name="초기화" value="초기화" class="box_work"' onclick="javascript:frmzerocheck(this.form,'accounts.asp');">
	       
		</td>
	</tr>

</form>

</table>

<table border=0 cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=60%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.
         
<!--<img src="/images/admin/excel.gif" border=0>
<a href="excell.asp?searcha=<%=searcha%>&searchh=<%=searchh%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a>-->

		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F6F6F6 align=center>
		<td width=7%>번호</td>
		<td width=6%>대출자</td>
		<td width=11%>상호명</td>
		<td width=5%>지역</td>
		<td width=12%>소속지사</td>
		<td width=6%>추천인</td>
		<td width=10%>금융기관</td>
		<!--<td width=9%>대출상품</td>-->

		<td width=7%>대출금액<br>(만원)</td>
		<td width=6%>금리<BR>(%)</td>
		<td width=9%>대출일</td>
				<td width=10%>수수료<br>(원)</td>
		<td width=10%>지급수수료<br>(원)</td>
	</tr>
<%
i=1
j=((gotopage-1)*39)+gotopage
do until rslist.EOF or rslist.PageSize<i
	If Len(rslist(8)) > 6 Then 
	   product = left(rslist(8), 6) & "..." 
	Else
		product = rslist(8)
	End If 

	If Len(rslist(12)) > 6 Then 
	   StatusMemo = left(rslist(12), 6) & "..." 
	Else
		StatusMemo = rslist(12)
	End If 
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<!--<td><a href="#" onclick="window.open('loancase.asp?seq=<%=rslist(0)%>','','top=100,left=100,width=385,height=650'); return false;"><%=rslist(2)%>&nbsp;</a></td>-->
		<td><%=rslist(2)%>&nbsp;</td>
		<td align="left">&nbsp;<%=rslist(3)%></td>
		<td><%=rslist(15)%></td>
		
		
		<td align=left>&nbsp;<%=rslist(14)%>&nbsp;</td>
		<td><%=rslist(16)%>&nbsp;</td>
		<td><%=rslist(13)%>&nbsp;</td>
	<!--	<td align="left">&nbsp;<%=product%></td>-->
		<td align="right"><%=rslist(9)%>&nbsp;</td>
		<td><%=rslist(10)%>&nbsp;</td>
		<td><%=rslist(11)%>&nbsp;</td>
		<td align="right"><%=rslist(17)%>&nbsp;</td>
		<td align="right"><%=rslist(18)%>&nbsp;</td>
	</tr>
	
	
</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
%>

</form>

</table>
<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
<tr height=28 bgcolor=#FFFFFF align=center>
	<td width=7%>계</td>
		<td width=6%>&nbsp;</td>
		<td width=11%>&nbsp;</td>
		<td width=5%>&nbsp;</td>
		<td width=12%>&nbsp;</td>
		<td width=6%>&nbsp;</td>
		<td width=10%>&nbsp;</td>
	

		<td width=7% align="right"><%=rslist2(0)%>&nbsp;</td>
		<td width=6%>&nbsp;</td>
		<td width=9%>&nbsp;</td>
	  <td width=10% align="right"><%=rslist2(1)%>&nbsp;</td>
		<td width=10% align="right"><%=rslist2(2)%>&nbsp;</td>
	</tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="list.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">첫페이지</a>&nbsp;
				<a href="list.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="list.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="list.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">다음 10개</a>
				&nbsp;<a href="list.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">마지막</a>
		<% 	End If %>

		</td>
	</tr>
</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<%
	rslist.close
	db.close
	set rs=nothing
	set rslist=nothing
	set db=nothing
%>		
					</td>
				</tr>
			</table>
		</div>
		<!-- 콘텐츠 끝 -->
		<!-- 카피라이트 시작 -->
		<div style='padding:30px 0 0 0;'><img src='images/footer_line.gif' style='width:100%;height:6px;'></div>
		<div style='padding:20px 0 0 0;'>
			<table width='1000' border='0' cellspacing='0' cellpadding='0' align='center'>
				<tr>
					<td style='padding:0 25px 0 40px;'><img src='images/footer_logo.gif'></td>
					<td style=''><img src='images/copytext.gif'></td>
				</tr>
			</table>
		</div>
		<!-- 카피라이트 끝 -->
</BODY>
</HTML>
