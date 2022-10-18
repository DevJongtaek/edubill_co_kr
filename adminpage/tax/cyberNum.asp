<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<%
	'--------------------------------------------------------------------------------------------------------------------
	'# 날짜관련 함수
	'# FunYMDHMS(dflag)	년월일시분초 가져오는 함수
	'#    			4:yyyy    6:yyyymm    8:yyyymmdd    10:yyyymmddhh    12:yyyymmddhhmm    14:yyyymmddhhmmss
	'# DateFormatReplace	20090605123541 -->> 2009-06-05 12:35:41
	'#    			psDate:데이타	psDateflag:날짜구분값	psDategubun:1=날짜전체 2=시간만
	'# SelectDateChoice	년월일 콤보박스
	'#    			yearDa:년도값    monthDa:월값    dayDa:일값    yvalD:년도이름    mvalD:월이름    dvalD:일이름
	'# alertURL	 이동할 주소
	'--------------------------------------------------------------------------------------------------------------------
	Function DateFormatReplace(psDate,psDateflag,psDategubun)
		if psDateflag="" then
			psDateflag = "-"
		end if
		if psDategubun="" then
			psDategubun = "1"
		end if

		if psDategubun="1" then
	        	if IsNull(psDate) OR Len(psDate)=0 then 
        	        	DateFormatReplace="" 
        		elseif Len(psDate)=6 then 
      	          		DateFormatReplace = Left(psDate,4) & psDateflag & Right(psDate,2) 
        		elseif Len(psDate)=8 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & Right(psDate,2) 
  			elseif Len(psDate)=12 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & mid(psDate,7,2) & " " & mid(psDate,9,2) & ":" & right(psDate,2) 
  			elseif Len(psDate)=14 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & mid(psDate,7,2) & " " & mid(psDate,9,2) & ":" & mid(psDate,11,2)  & ":" & mid(psDate,13,2)
			else 
	                	DateFormatReplace = psDate 
        		end if 
		else
	        	if IsNull(psDate) OR Len(psDate)=0 then 
        	        	DateFormatReplace="" 
        		elseif Len(psDate)=4 then 
                		DateFormatReplace = mid(psDate,1,2) & ":" & mid(psDate,3,2)
        		elseif Len(psDate)=6 then 
                		DateFormatReplace = mid(psDate,1,2) & ":" & mid(psDate,3,2) & ":" & mid(psDate,5,2)
			else 
	                	DateFormatReplace = psDate 
        		end if 
		end if
	End Function 
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select cporg_cd from tb_company where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	btcode = rs(0)
	rs.close
	if len(session("Ausercode"))=15 then
		set rs = server.CreateObject("ADODB.Recordset")
		sql = " select tcode from tb_company where idx = "& right(session("Ausercode"),5) &" "
		rs.Open sql, db, 1
		ctcode = rs(0)
		rs.close
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select * from tb_virtual_acnt "
	SQL = sql & " where cporg_cd = '"& btcode &"' and dep_st = '1' "

	if session("Ausergubun")="4" and ctcode<>"" then	'체인점
		SQL = sql & " and chancode = '"& ctcode &"' "
	end if

	if searchd<>"" then
		SQL = sql & " and tr_il >= '"& searchd &"' "
	end if
	if searche<>"" then
		SQL = sql & " and tr_il <= '"& searche &"' "
	end if
	if searcha<>"" and searchb<>"" then
		SQL = sql & " and "& searcha &" like '%"& searchb &"%' "
	end if

	if searchc="1" then
		SQL = sql & " and (ye_money-mi_money) >= 0 "
	elseif searchc="2" then
		SQL = sql & " and (ye_money-mi_money) < 0 "
	end if

	SQL = sql & " order by tr_il desc, tr_si desc, channame asc "
	
	'response.write sql
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
		<td><font color=blue size=3><B>[ 가상계좌 입금내역 ]</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>※.허용(체인점주문 됨.)  : '입금후미수' < '여신금' 경우, 차단(체인점주문 안 됨.) : '입금후미수' > '여신금' 경우</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="cyberNum.asp" method="POST" name=form>
	<tr>
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>입금일자<BR> &nbsp;<B>입금정보 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="오늘" value="오늘" class="box_work"' onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);"> 예)20040928 ~ 20041004
			<BR>
			<select name="searchc" size="1" class="box_work">
	          		<option value=""  <%if searchc=""  then%>selected<%end if%>>전체
	          		<option value="1" <%if searchc="1" then%>selected<%end if%>>주문허용
	          		<option value="2" <%if searchc="2" then%>selected<%end if%>>주문차단
        		</select>
			<select name="searcha" size="1" class="box_work">
	          		<option value="" <%if searcha="" then%>selected<%end if%>>전체
	          		<option value="channame" <%if searcha="channame" then%>selected<%end if%>>체인점명
	          		<option value="cust_nm"  <%if searcha="cust_nm" then%>selected<%end if%>>입금자
	          		<option value="dep_amt"  <%if searcha="dep_amt" then%>selected<%end if%>>입금액
	          		<option value="va_no"    <%if searcha="va_no" then%>selected<%end if%>>가상계좌번호
        		</select>
			<input type="Text" name="searchb" size="20" maxlength="20" class="box_work" value="<%=searchb%>">
	        	<input type="button" name="검 색" value="검 색 "  class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="초기화" value="초기화" class="box_work"' onclick="javascript:frmzerocheck(this.form,'cyberNum.asp');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right valign="bottom">*양식1:&nbsp;
		<a href="cexcell.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchh=<%=searchh%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a>
		*양식2:&nbsp;<a href="cexcell2.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchh=<%=searchh%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a>
		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=14%>가상계좌번호</td>
		<td width=14%>입금자</td>
		<td width=18%>입금일시</td>
		<td width=15%>체인점명</td>
		<td width=8%>입금액</td>
		<td width=10%>여신금</td>
		<td width=10%>입금후미수</td>
		<td width=6%>주문</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
	imsidt = rslist("tr_il")&rslist("tr_si")
	imsidt = DateFormatReplace(imsidt,"/","1")

	dep_amt  = rslist("dep_amt")
	ye_money = rslist("ye_money")
	mi_money = rslist("mi_money")
	if dep_amt  <> "" then dep_amt  = formatnumber(dep_amt,0)
	if ye_money <> "" then ye_money = formatnumber(ye_money,0)
	if mi_money <> "" then mi_money = formatnumber(mi_money,0)

	if rslist("ye_money")-rslist("mi_money") >= 0 then
		imsitmsg = "<font color=blue> 허용"
	else
		imsitmsg = "<font color=red> 차단"
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("va_no")%></td>
		<td><%=rslist("cust_nm")%></td>
		<td><%=imsidt%></td>
		<td align=left>&nbsp;<%=rslist("channame")%></td>
		<td align=right><%=dep_amt%>&nbsp;</td>
		<td align=right><%=ye_money%>&nbsp;</td>
		<td align=right><%=mi_money%>&nbsp;</td>
		<td align=center><%=imsitmsg%>&nbsp;</td>
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
				<a href="cyberNum.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">첫페이지</a>&nbsp;
				<a href="cyberNum.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="cyberNum.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="cyberNum.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">다음 10개</a>
				&nbsp;<a href="cyberNum.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">마지막</a>
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