<!--#include virtual="/adminpage/incfile/top2.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")

	if searchg="" then
		searchg = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if

	if searchd="" then
		searchd = replace(left(now()-31,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select userpwd, server_name "
	SQL = sql & " , pc_name,server_inname "
	SQL = sql & " from tb_adminuser where flag='2' and usercode = "& left(session("AAusercode"),5) &" "

   ' response.Write  SQL


	rs.Open sql, db, 1
	imsiuserpwd = rs("userpwd")
	imsiserver_name = rs("server_name")
	imsipc_name = rs("pc_name")
	imsiserver_inname = rs("server_inname")
	rs.close

    set rs = server.CreateObject("ADODB.Recordset")
   SQL = "SELECT fileregcode from tb_company where tcode = '"& session("AAtcode") &"' AND bidxsub = '"&left(session("AAusercode"),5) &"'"

  '   response.Write sql


    rs.Open sql, db, 1
	imsifileregcode = rs("fileregcode")
	
	rs.close

   

   
    	    Set db1 = Server.CreateObject("ADODB.Connection")
	if left(session("AAusercode"),5) = "19209" then
    	  imsiuid = "gn"
            imsipwd = "qsefofgnfood"
           else
             imsiuid = "sa"
            imsipwd = "qsefofedubill"
    end if

     db1.Open  "provider=sqloledb;server="&imsiserver_name&";database=CM;uid="&imsiuid&";pwd="&imsipwd&";"	'db를 연다
   
      QSql = "if EXISTS( select * from sys.SYSOBJECTS where name  like 'T_Slip')"
           Qsql = qsql + "begin drop table T_Slip end "
    
		       
		        db1.Execute(QSql)

   if left(session("AAusercode"),5) = "19209" then
     QSql2 = "select RANK() OVER(order by AccDate, In_Idx) as No, CODE AS CODE, Name AS NAME, AccDate, Amt, Div, In_Idx into T_Slip from ( select clientcode as Code, ISNULL(C.NAME, '') as Name, request_day as AccDate, case when flag = '21' then ordermoney * -1 else ordermoney end as Amt, wdate as AccTime, case when flag = '21' then '반품' else '매출' end as Div, idx as In_Idx from tblorder O LEFT JOIN TBLCLIENT C ON O.clientcode = C.CODE where flag in ('10', '11', '21') and Request_Day <> '' AND clientcode = '"& imsifileregcode &"' union all select client_code, ISNULL(C.NAME, '') NAME, trade_date, input_amt * -1, trade_date + ' ' + trade_time , case when a.Name = '가수금' then '이월' else '수금' end, idx as In_Idx from tblvirtualaccount v join TblAccountCode a on v.AccountCode = a.Code LEFT JOIN TBLCLIENT C ON V.CLIENT_CODE = C.CODE where div = '00' and SlipDate <> '' AND client_code = '"& imsifileregcode &"') A "
          else
      QSql2 = "select RANK() OVER(order by AccDate, In_Idx) as No, CODE AS CODE, Name AS NAME, AccDate, Amt, Div, In_Idx into T_Slip from ( select clientcode as Code, ISNULL(C.NAME, '') as Name, request_day as AccDate, case when flag = '21' then ordermoney * -1 else ordermoney end as Amt, wdate as AccTime, case when flag = '21' then '반품' else '매출' end as Div, idx as In_Idx from tblorder O LEFT JOIN TBLCLIENT C ON O.clientcode = C.CODE where flag in ('10', '11', '21') and Request_Day <> '' AND clientcode = '"& session("AAtcode") &"' union all select client_code, ISNULL(C.NAME, '') NAME, trade_date, input_amt * -1, trade_date + ' ' + trade_time , case when a.Name = '가수금' then '이월' else '수금' end, idx as In_Idx from tblvirtualaccount v join TblAccountCode a on v.AccountCode = a.Code LEFT JOIN TBLCLIENT C ON V.CLIENT_CODE = C.CODE where div = '00' and SlipDate <> '' AND client_code = '"& session("AAtcode") &"') A "
    end if

    
		       
		        db1.Execute(QSql2)
            
             set rslist = server.CreateObject("ADODB.Recordset")
        
    



   
          SQL3 = sql3 & "     SELECT	A.[NO] AS NO, A.ACCDATE AS DATE, "
		   SQL3 = sql3 & "             SUM(B.AMT) - A.AMT AS PRE_MISU,"
		   SQL3 = sql3 & "             CASE WHEN A.DIV = '매출' OR A.DIV = '반품' THEN A.AMT ELSE 0 END AS MAE,"
		   SQL3 = sql3 & "             CASE WHEN A.DIV = '이월' OR A.DIV = '수금' THEN A.AMT * -1 ELSE 0 END AS SUGUM,"
		   sql3 = sql3 & "             SUM(B.AMT) AS MISU,"
		   sql3 = sql3 & "             A.Div AS DIV,"
		   sql3 = sql3 & "             A.IN_IDX AS IDX, A.CODE, A.NAME"
           sql3 = sql3 & "     FROM T_Slip A JOIN T_Slip B ON A.No >= B.No"
          SQL3 = sql3 & "     WHERE REPLACE(A.ACCDATE,'/','') >= '"& searchd &"' AND REPLACE(A.ACCDATE,'/','') <= '"& searche &"'"
           sql3 = sql3 & "     GROUP BY A.[NO], A.ACCDATE, A.DIV, A.AMT, A.IN_IDX, A.CODE, A.NAME"
           sql3 = sql3 & "     ORDER BY A.[NO] desc "
' SQL = " select No, CODE, NAME, AccDate, Amt, Div, In_Idx from  T_Slip "
           'response.Write session("AAfilename")

    '  response.Write sql3
        rslist.PageSize=20
       rslist.Open sql3, db1, 1
        
     if not rslist.bof then
  
		rslist.AbsolutePage=int(gotopage)

     
	end if
	   
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="98%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td width=40%><font color=blue size=3><B>[ 입금내역조회 ]</td>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="cyberNum3.asp" method="POST" name=form>
	<tr>
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>정보검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="오늘" value="오늘" class="box_work"' onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);"> 예)20040928 ~ 20041004
			
	        	<input type="button" name="검 색" value="검 색 "  class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="초기화" value="초기화" class="box_work"' onclick="javascript:frmzerocheck(this.form,'cyberNum3.asp');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="5"></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=20%>거래일자</td>
		<td width=15%>직전미수금</td>
		<td width=15%>판매금액</td>
		<td width=15%>결제금액</td>
		<td width=15%>미수잔액</td>
		<!--<td width=10%>입금후미수</td>
		<td width=12%>가상계좌번호</td>-->
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
    
do until rslist.EOF or rslist.PageSize<i

  
	No = rslist("No")
	sDate =  rslist("Date")
	PRE_MISU = rslist("PRE_MISU")
	MAE = rslist("MAE")
	SUGUM = rslist("SUGUM")
	MISU = rslist("MISU")
   

%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td>
            <%=j%>

		</td>
		
		<td><%=sDate%></td>
		<td align=right><%=formatnumber(PRE_MISU,0)%>&nbsp;</td>
		<td align=right><%=formatnumber(MAE,0)%>&nbsp;</td>
		<td align=right><%=formatnumber(SUGUM,0)%>&nbsp;</td>
		<td align=right><%=formatnumber(MISU,0)%>&nbsp;</td>
		
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
%>

</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="cyberNum3.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">첫페이지</a>&nbsp;
				<a href="cyberNum3.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="cyberNum3.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
                 
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="cyberNum3.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">다음 10개</a>
				&nbsp;<a href="cyberNum3.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">마지막</a>
		<% 	End If 
            %>
          
		</td>
	</tr>
</table>







				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR>

<!--#include virtual="/adminpage/incfile/bottom2.asp"-->