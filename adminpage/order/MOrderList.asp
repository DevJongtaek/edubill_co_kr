<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	'주문 시간
	searchi = request("searchi")
	searchj = request("searchj")

  


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
		searchd = replace(left(now()-1,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end If

  
   if searchh <> "" then
	searchhArr = split(searchh,",")
  
   
    for i=0 to ubound(searchhArr)
			imsival = trim(searchhArr(i))
			if i=0 then
    	    inCnt = "'"& imsival &"'"
            else 
			inCnt =  inCnt &","& "'"& imsival &"'"
			end if
		next

    else

     
    inCnt = "'y','4','5','1','6','2','3'"
   
	end if
   
    
 
		
	
    



	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end If
	
	 
	
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select SearchOrderTime, SearchStartTime, SearchEndTime "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		SearchOrderTime = rs(0)    '시간사용
		SearchStartTime = rs(1)	   '시작시간
		SearchEndTime = rs(2)      '종료시간
	else
		SearchOrderTime = "n"
		SearchStartTime = ""
		SearchEndTime = ""
	end if
	rs.close
	
   
	

   
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag,smsflag,tcode,smsflagType "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
    rs_myflag = rs(0)	'미수체크여부
	smsflag = rs(1)
	smsttcode1 = rs(2)
	smsflagType = rs(3)
    
	rs.close

	
		
	'주문시간
	If searchi = "" Then 
		If  SearchStartTime = "" Then 
			searchi = "000000"
		Else 
			If Len(SearchStartTime) = 4 Then 
				searchi = SearchStartTime & "00"
			Else
				searchi = "000000"
			End If 
		End If 
	End If 

	If searchj = "" Then 
		If SearchEndTime = ""Then 
			searchj = "235959"
		Else 
			If Len(SearchEndTime) = 4 Then 
				searchj = SearchEndTime & "59"
			Else
				searchj = "235959"
			End If 
		End If
	End If 
	
	startdate = searchd + searchi
	enddate = searche + searchj


  
  


	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tb_company "
	SQL = sql & " where bidxsub = '"& left(session("Ausercode"),5) &"' "
   
	if session("Ausergubun")="3" then
		SQL = sql & " and idxsub = '"& mid(session("Ausercode"),6,5) &"' "
	end if
	SQL = sql & " and flag = '3' "
	SQL = sql & " and orderflag  in ("&inCnt&")"
	SQL = sql & " and idx not in ( "
	SQL = sql & " 	select distinct substring(usercode,11,5) "
	SQL = sql & " 	from tb_order where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
     SQL = sql & " AND ISNULL(Rgubun,0) != 1 "
	If searchordertime = "n" Or searchordertime ="" Then 
		SQL = sql & " 	and orderday >= '"& searchd &"' and orderday <= '"& searche &"' "
	Else 
		SQL = sql & "  and (convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
		SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) )  "
	End If 
  
	SQL = sql & " 	) "
	SQL = sql & " order by orderflag desc "
	
  ' response.write sql
 
	

	'response.write sql
	rslist.PageSize=20

	rslist.Open sql, db, 1



       if not rslist.eof then
		hcararray = rslist.GetRows
		hcararrayint = ubound(hcararray,2)
	else
		hcararray = ""
		hcararrayint = ""
	end if


	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
      
	end if

   
   
%>

<script language="JavaScript">
<!--
function onlyNumber(){
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}
function posorderwin(){
	window.open ('posDatatorder.asp','dssdsd','width=300,height=180,left=100,top=100');
	return false ;
}
//-->
</script>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 미주문 체인점 ]</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>※.'주문내역'의 주문 건 중, 지정한 기간 동안에 주문한 건이 한 건도 없는 체인점 리스트</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="MOrderList.asp" method="POST" name=form>
	<tr>
		<td nowrap width="20%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>미 주문정보 검색</td>
		<td nowrap width="80%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<%If searchordertime = "y" Then %><input type="Text" name="searchi" size="6" maxlength="6" class="box_work" value="<%=searchi%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;"><%End If %>
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<%If searchordertime = "y" Then %><input type="Text" name="searchj" size="6" maxlength="6" class="box_work" value="<%=searchj%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;"><%End If %>
			<input type="button" name="오늘" value="오늘" class="box_work"' onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);"> 예)20040928 ~ 20041004
			<BR>
			
			
			<select name="searchh" size="3" class="box_work" multiple>
	          			<option value="" <%if searchh="" then%>selected<%end if%>>주문상태전체
        	  			<option value="y" <%if searchh="y" then%>selected<%end if%>>주문중
        	  			<option value="4" <%if searchh="4" then%>selected<%end if%>>경고1(주문)
        	  			<option value="5" <%if searchh="5" then%>selected<%end if%>>경고2(주문)
        	  		<%	If left(session("Ausercode"),5) = "19209"  or left(session("Ausercode"),5) = "96338" Then %>
		<!--<option value="1" <%if searchh="1" then%>selected<%end if%>>미수금1(정지)
        	  			<option value="6" <%if searchh="6" then%>selected<%end if%>>미수금2(정지)-->
                              <option value="1" <%if searchh="1" then%>selected<%end if%>>주문차단(정지)
        	  			<option value="6" <%if searchh="6" then%>selected<%end if%>>시즈닝차단(정지)
	 <% else %>
		<option value="1" <%if searchh="1" then%>selected<%end if%>>미수금(정지)
        	  		
	<%	end if %>
        	  			
	        	  		<option value="2" <%if searchh="2" then%>selected<%end if%>>폐업(정지)
        	  			<option value="3" <%if searchh="3" then%>selected<%end if%>>휴업(정지)
        		</select>
        		
	        	<input type="button" name="검 색" value="검 색 " class="box_work"  onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="초기화" value="초기화" class="box_work" onclick="javascript:frmzerocheck(this.form,'MOrderList.asp');">
	      
            <%if smsflag= "y" then%>	
            <%if rslist.recordcount =0 then%>

            <%else %>
            <input type="button" name="문자전송" value="문자전송" class="box_work"  onclick="javascript: bwinopenXY('Msms.asp?sms=<%=rslist.recordcount%>&tcode=<%if hcararrayint<>"" then%>	<%for i=0 to hcararrayint%> <%=hcararray(1,i)%>, <%next%><%end if%>', 'domain', 500, 400)">
            <%end if %>
            <%end if%>
          
          	
	        
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right><a href="MOrderListExcel.asp?searcha=<%=searcha%>&searchh=<%=searchh%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=10%>코드</td>
		<td width=15%>체인점명</td>
		<td width=15%>브랜드</td>
		<td width=11%>지사명</td>
		<td width=12%>전화번호</td>
		<td width=12%>핸드폰</td>
		<td width=8%>호차</td>
		<td width=12%>주문상태</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
   
	
	
	tel = rslist("tel1")&"-"&rslist("tel2")&"-"&rslist("tel3")
	hp  = rslist("hp1")&"-"&rslist("hp2")&"-"&rslist("hp3")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and idx = "& rslist("dcarno") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsidcarname = rs(0)
	ELSE
		imsidcarname = ""
	end if
	rs.close

	if rslist("cbrandchoice")<>"" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bname from tb_company_brand "
		SQL = sql & " where bidx = "& rslist("cbrandchoice") &" "
		rs.Open sql, db, 1
		if not rs.eof then
			imsibname = rs(0)
		end if
		rs.close
	else
		imsibname = ""
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select distinct comname from tb_company where idx = "& rslist("idxsub") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsicomname = rs(0)
	end if
	rs.close
	
	orderflag = rslist("orderflag")
	
	If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then 
		'misugum = "미수금1"
        misugum = "주문차단"
	Else
		misugum = "미수금"
	End if 
	
	if orderflag="y" then
		imsiorderflag = "주문중"
	elseif orderflag="1" then
		imsiorderflag = "<font color='red'>" & misugum & "(정지)"
	elseif orderflag="2" then
		imsiorderflag = "<font color='red'>폐업(정지)"
	elseif orderflag="3" then
		imsiorderflag = "<font color='red'>휴업(정지)"
	elseif orderflag="4" then
		imsiorderflag = "<font color='blue'>경고1(주문)"
	elseif orderflag="5" then
		imsiorderflag = "<font color='blue'>경고2(주문)"
	elseif orderflag="6" then
		'imsiorderflag = "<font color='red'>미수금2(정지)"
        imsiorderflag = "<font color='red'>시즈닝차단(정지)"
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("tcode")%></td>
		<td align="left">&nbsp;<%=rslist("comname")%></td>

		<td><%=imsibname%></td>
		<td><%=imsicomname%></td>
		<td><%=tel%></td>
		<td><%=hp%></td>
		<td><%=imsidcarname%></td>
		<td align="left">&nbsp;
				
					<%=imsiorderflag%>
				
		</td>
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
				<a href="MOrderList.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">첫페이지</a>&nbsp;
				<a href="MOrderList.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="MOrderList.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="MOrderList.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">다음 10개</a>
				&nbsp;<a href="MOrderList.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">마지막</a>
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

<!--#include virtual="/adminpage/incfile/bottom.asp"-->