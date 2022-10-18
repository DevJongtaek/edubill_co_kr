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
	'if searchf="" then
	'	searchf = "0"
	'end if

	if searchd="" then
		searchd = replace(left(now()-90,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	btcode = "01806010"
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select a.*, b.comname,b.tcode,b.flag as comflag, b.idx as comidx "
	sql = sql & " from  "
	sql = sql & " 	( "
	sql = sql & " 	select * from tb_virtual_acnt "
	SQL = sql & " 	where cporg_cd = '"& btcode &"' and dep_st = '1' "
			if searchd<>"" then SQL = sql & " and tr_il >= '"& searchd &"' "
			if searche<>"" then SQL = sql & " and tr_il <= '"& searche &"' "
			if searcha<>"" and searchb<>"" and left(searcha,2)<>"b." then SQL = sql & " and "& searcha &" like '%"& searchb &"%' "
			if searchc="1" then
				SQL = sql & " and (ye_money-mi_money) >= 0 "
			elseif searchc="2" then
				SQL = sql & " and (ye_money-mi_money) < 0 "
			end if
			if searchf<>"" then SQL = sql & " and taxReg = '"& searchf &"' "
	sql = sql & " 	) a "
	sql = sql & " left outer join  "
	sql = sql & " 	( "
	sql = sql & " 	select comname,virtual_acnt2,tcode,flag,idx from tb_company where flag='1' or flag='2' "
	sql = sql & " 	) b "
	sql = sql & " on a.va_no = b.virtual_acnt2 "
		if (searcha="b.comname" or searcha="b.tcode") and searchb<>"" then SQL = sql & " where "& searcha &" like '%"& searchb &"%' "
	SQL = sql & " order by a.tr_il desc, a.tr_si desc, b.comname asc "
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

//금지 단어 검색 시작
function nottxtfield(word) {
var NotWord = ",";
var SP = NotWord.split('|');
	for(var i=0; i<SP.length; i++)
	{
        	var NotStr = word.indexOf(SP[i], 0);
        	if( NotStr >= 0 )
        	{
                	alert(SP[i]+' 콤마는 절대 사용 하지 마세요.');
			//word = "";
                	return;
        	}
	}
}
//금지단어 검색 끝

function allsavechb(){
	form1.action = "cyberNumSave.asp";
	form1.submit();
	return false ;
}

function allsavechb2(){
	form1.target = "ifrm";
	form1.method = "post";
	form1.action = "cyberNumSaveIframe.asp";
	form1.submit();
	return false ;
}

function allsavechb3(){
	form1.target = "ifrm";
	form1.method = "post";
	form1.action = "cyberNumSaveIframeCancle.asp";
	form1.submit();
	return false ;
}

function checkValue(form) {
	if ((form.searchd.value=="")||(form.searche.value=="")) {
		alert("입금일자를 입력하여 주시기바랍니다.") ;
		form.searchd.focus() ;
		return false ;
	}
	form.submit() ;
}

function isent(form) {
	if (event.kdyCode == 13) {
		checkValue(form);
	}
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
	          		<option value=""  <%if searchc=""  then%>selected<%end if%>>주문전체
	          		<option value="1" <%if searchc="1" then%>selected<%end if%>>주문허용
	          		<option value="2" <%if searchc="2" then%>selected<%end if%>>주문차단
        		</select>
			<select name="searchf" size="1" class="box_work">
	          		<option value=""  <%if searchf=""  then%>selected<%end if%>>입금전체
	          		<option value="y" <%if searchf="y" then%>selected<%end if%>>입금확인
	          		<option value="n" <%if searchf="n" then%>selected<%end if%>>입금미확인
	          		<option value="i" <%if searchf="i" then%>selected<%end if%>>입금액오류
        		</select>
			<select name="searcha" size="1" class="box_work">
	          		<option value="" <%if searcha="" then%>selected<%end if%>>전체
	          		<option value="b.comname"  <%if searcha="b.comname" then%>selected<%end if%>>회원사명
	          		<option value="cust_nm"  <%if searcha="cust_nm" then%>selected<%end if%>>입금자
	          		<option value="b.tcode"  <%if searcha="b.tcode" then%>selected<%end if%>>회원사코드
	          		<option value="va_no"    <%if searcha="va_no" then%>selected<%end if%>>가상계좌번호
        		</select>
			<input type="Text" name="searchb" size="20" maxlength="20" class="box_work" value="<%=searchb%>" onkeypress="if(event.keyCode==13){checkValue(this.form);}">
	        	<input type="button" name="검 색"  value="검 색 "  class="box_work" onclick="return checkValue(this.form)">
	        	<input type="button" name="초기화" value="초기화" class="box_work"  onclick="javascript:frmzerocheck(this.form,'cyberNum.asp');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form name=form1 method=post>
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=searchd value="<%=searchd%>">
<input type=hidden name=searche value="<%=searche%>">
<input type=hidden name=searchf value="<%=searchf%>">
<input type=hidden name=searchg value="<%=searchg%>">
<input type=hidden name=gotopage value="<%=gotopage%>">

	<tr height=30 valign=bottom>
		<td width=60%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=40% align=right>
			<input type=button value="입금취소" onclick="return allsavechb3()">
			<input type=button value="입금확인" onclick="return allsavechb2()">
			<input type=button value="전체저장" onclick="return allsavechb()">
			<a href="cexcell.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchf=<%=searchf%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>"><img src="/images/admin/excel.gif" border=0></a>
		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=13%>가상계좌번호</td>
		<td width=6%>코드</td>
		<td width=15%>입금자</td>
		<td width=10%>입금일</td>
		<td width=24%>회원사명</td>
		<td width=9%>입금액</td>
		<td width=5%>확인</td>
		<td width=13%>비고</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
	imsidt = rslist("tr_il")
	imsidt = DateFormatReplace(imsidt,"/","1")

	taxReg   = rslist("taxReg")
	dep_amt  = rslist("dep_amt")
	ye_money = rslist("ye_money")
	mi_money = rslist("mi_money")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	dep_amt2 = dep_amt
	if dep_amt2="" then dep_amt2=0
	if taxReg="" or taxReg="n" or taxReg="i" then 
		response.write "<input type=hidden name=fidx    value='"& rslist("idx") &"'>"
		response.write "<input type=hidden name=ftcode  value='"& rslist("tcode") &"'>"
		response.write "<input type=hidden name=tr_il   value='"& rslist("tr_il") &"'>"
		response.write "<input type=hidden name=dep_amt value='"& dep_amt2 &"'>"
		response.write "<input type=hidden name=comflag value='"& rslist("comflag") &"'>"
		response.write "<input type=hidden name=comidx  value='"& rslist("comidx") &"'>"
	else
		response.write "<input type=hidden name=ffidx    value='"& rslist("idx") &"'>"
		response.write "<input type=hidden name=fftcode  value='"& rslist("tcode") &"'>"
		response.write "<input type=hidden name=ftr_il   value='"& rslist("tr_il") &"'>"
		response.write "<input type=hidden name=fdep_amt value='"& dep_amt2 &"'>"
		response.write "<input type=hidden name=fcomflag value='"& rslist("comflag") &"'>"
		response.write "<input type=hidden name=fcomidx  value='"& rslist("comidx") &"'>"
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if dep_amt  <> "" then dep_amt  = formatnumber(dep_amt,0)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select top 10 Aym,seq from tAccountM where tcode = '"& rslist("tcode") &"' and flag='1' and idate = '' "
	SQL = sql & " order by Aym desc "
	rs.Open sql, db, 1
	if not rs.eof then
		arr_val     = rs.GetRows
		arr_val_int = ubound(arr_val,2)
	else
		arr_val     = ""
		arr_val_int = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<input type=hidden name=idx value="<%=rslist("idx")%>">


	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("va_no")%></td>
		<td><%=rslist("tcode")%></td>
		<td align=left><%=rslist("cust_nm")%></td>
		<td><%=imsidt%></td>
		<td align=left>&nbsp;<%=rslist("comname")%></td>
		<td align=right><%=dep_amt%>&nbsp;</td>
		<td>
			<%if taxReg<>"y" then%>
				<%if arr_val_int="" then%>
					<input type=checkbox name=taxReg value="<%=rslist("idx")%>" <%if taxReg="y" then response.write "checked"%>>
				<%end if%>
			<%else%>
				<font color=red><B>V
			<%end if%>
		</td>
		<!--<td><input type=text name=bigo value="<%=rslist("bigo")%>" style="width:100%" onkeyup="nottxtfield(form1.bigo[<%=i-1%>].value);"></td>-->
		<td>
			<%if taxReg="y" then%>
				<font color=black><%=rslist("bigo")%>
				<input type=checkbox name=cancleIdx value="<%=rslist("idx")%>">
			<%else%>
				<%if arr_val_int<>"" then%>
					<select name=seq>
						<option value="">미확인
						<%for k=0 to arr_val_int%>
							<option value="<%=arr_val(1,k)%>&<%=rslist("idx")%>&<%=rslist("tr_il")%>&<%=rslist("dep_amt")%>"><%=mid(arr_val(0,k),1,4)%> / <%=mid(arr_val(0,k),5,2)%>
						<%next%>
						<option value="0&<%=rslist("idx")%>&<%=rslist("tr_il")%>&<%=rslist("dep_amt")%>">미적용
					</select>
				<%end if%>
			<%end if%>
		</td>
	</tr>

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

<iframe name=ifrm frameborder=0 border=0 width=0 height=0></iframe>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->