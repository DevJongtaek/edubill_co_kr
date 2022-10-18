
<!--#include virtual="/moa_loan/Inc_Files/sessionend.asp"-->


<!--#include virtual="/moa_loan/db/db.asp"-->
<!--#include virtual="/moa_loan/Inc_Files/top.asp"-->
<%
	if session("Ausergubun")  = "2" or session("Ausergubun")="1" then
		response.write "<Script language=javascript>"
		response.write "	alert(""이용권한이 없습니다."");"
		response.write "	history.go(-1);"
		response.write "</Script>"
		response.end
	end if
%>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<HTML>

	<head>
	
        <%
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

            sqlFilter = ""
		set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select  a.idx, a.Gubun,b.Name as GubunName, a.Bank,c.Name as BankName , a.Area, a.Branch, a.userid, a.userpwd, a.filename,convert(varchar(10),a.WriteDate,111) as WriteDate, d.Name as AreaName, e.Name as BranchName,writeyn "
	SQL = sql & " from tb_LoanUser a left join StaticOptions b  on a.Gubun = b.value and b.Div = 'Gubun'"
    SQL = sql & " left join StaticOptions c on a.Bank = c.value and c.Div='Bank' "
   
    SQL = sql & " left join tb_area d on a.Area = d.Idx "
    SQL = sql & " left join tb_Branch e on a.Area = e.AreaIdx and a.Branch = e.idx"
    SQL = sql& " where a.idx like '%%'"
'response.Write SQL
	  If searchj = "1" Then
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and c.Name like '%" & searchk &  "%' "
	ElseIf searchj = "2" Then
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and d.Name like '%" & searchk &  "%' "
	ElseIf searchj = "3" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
	    sqlFilter = sqlFilter & " and e.Name like '%" & searchk &  "%' "
	ElseIf searchj = "4" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
	    sqlFilter = sqlFilter & " and a.userid like '%" & searchk &  "%' and a.gubun='3' "
	
	End If 





	SQL = sql & sqlFilter & " order by a.WriteDate desc"
	rslist.PageSize=40
	rslist.Open sql, db, 1
'response.Write Sql
	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if

	
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
		<!-- 상단메뉴 -->
	
		<!-- 상단메뉴 끝 -->
		<div style='width:100%;padding:30px 0 0 0;'>
			<table width='1000' border='0' cellspacing='0' cellpadding='0' align='center'>
				<tr>
					<td><img src='images/pg_bnn1.gif' style='width:1000px;height:180px;'></td>
				</tr>
				<tr>
					<td style='padding:30px 0 15px'><img src='images/pgtit3.gif'></td>
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

<form action="LoginId.asp" method="POST" name=form>
	<tr>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>검색조건</b></td>
		<td nowrap width="90%" bgcolor="#FFFFFF" height="25">
		<!--	<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="오늘" value="오늘" class="box_work" onclick="javascript: serchtodaycheck(document.form.searchd, document.form.searche);"> 예)20110501 -->
          	<select name="searchj" class="f">
            	<option value="0" <%if searchj="0" then%>selected<%end if%>>전체</option>
            	 <option value="4" <%if searchj="4" then%>selected<%end if%>>관리자</option>
            	<option value="1" <%if searchj="1" then%>selected<%end if%>>금융기관</option>
				<option value="2" <%if searchj="2" then%>selected<%end if%>>지역</option>
                  <option value="3" <%if searchj="3" then%>selected<%end if%>>소속지사</option>
           	</select>
			<!--<select name="searchj" size="1" class="box_work">
       			<option value="0" <%if searchj="0" then%>selected<%end if%>>전체</option>
       			<option value="1" <%if searchj="1" then%>selected<%end if%>>성명</option>
                <option value="2" <%if searchj="2" then%>selected<%end if%>>상호</option>
       			<option value="3" <%if searchj="3" then%>selected<%end if%>>전화번호</option>
       			<option value="4" <%if searchj="4" then%>selected<%end if%>>핸드폰번호</option>

<!--       			<option value="4" <%if searchj="4" then%>selected<%end if%>>대출일</option>-->
       	<!--	</select>-->
			<input type="Text" name="searchk" size="8" maxlength="15" value="<%=searchk%>" style="width:150">
	        <input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        <input type="button" name="초기화" value="초기화" class="box_work"' onclick="javascript:frmzerocheck(this.form,'LoginId.asp');">
	        <input type="button" name="추가" value="추가 " class="box_work" onclick="javascript:bwinopenXY('popup/IdAdd.asp', 'domain', 380,300)" >
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right>&nbsp;</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F6F6F6 align=center>
		<td width=5%>번호</td>
		<td width=10%>구분</td>
		<td width=17%>금융기관명</td>
		<td width=15%>지역</td>
		<td width=15%>소속지사</td>
		<td width=10%>아이디</td>
		<td width=10%>비밀번호</td>
		<td width=10%>등록일자</td>
		<td width=8%>권한</td>
	</tr>

<script language="JavaScript">
<!--
    function frmget(mid, mpwd) {
        form.mid.value = mid;
        form.mpwd.value = mpwd;
        form.action = "/adminpage/loginok.asp";
        //form.target="_blank";
        form.submit();
    }
    //-->
</script>

<!--<form name=form method=post>
<input type=hidden name=mid>
<input type=hidden name=mpwd>-->

<%
i=1
j=((gotopage-1)*39)+gotopage
do until rslist.EOF or rslist.PageSize<i

	


%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j %></td>
		<td><%=rslist("gubunname")%></td>
		<td align=left>&nbsp;<%=rslist("bankname")%></td>
		<td><%=rslist("AreaName")%></td>
		<td align=left>&nbsp;<%=rslist("branchName")%></td>
		<td align="left">&nbsp;<a href="#" onclick="window.open('Popup/IdUpdate.asp?seq=<%=rslist(0)%>','LoginIdUp','top=100,left=100,width=380,height=300'); return false;"><font color="blue" style="font-weight: bold"><%=rslist("userid")%>&nbsp;</font></a></td>
		<td><%=rslist("userpwd")%></td>
		<td><%=rslist("WriteDate")%></td>
		
		<%if rslist("gubunname") = "관리자" then%>
    		<%if rslist("writeyn") = 1 then%>
    		<td><input type=checkbox checked disabled=true></td>
    		<%elseif rslist("writeyn") = 0 then%>
    		<td><input type=checkbox disabled=true></td>		
    		<%end if%>
    <%else%>
    		<td> </td>		
    <%end if%>        
		
		
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

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="LoginId.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">첫페이지</a>&nbsp;
				<a href="LoginId.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="LoginId.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="LoginId.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">다음 10개</a>
				&nbsp;<a href="LoginId.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">마지막</a>
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
	db.close
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

