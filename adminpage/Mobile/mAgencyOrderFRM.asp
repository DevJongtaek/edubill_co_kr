<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/mtop2.asp"-->
<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	gongi = request("gongi")
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select brandflag,brandbox,isnull(com_notice,''),isnull(chk_gongi1,''),isnull(chk_gongi2,''),tcode,proflag2,noticeflag,proflag2Pgubun,productorderweek "
	SQL = SQL & " from tb_company "
	SQL = SQL & " where idx = '"& left(session("AAusercode"),5) &"' "
	rs.Open sql, db, 1
	imsibrandflag  = rs(0)
	imsibrandbox   = rs(1)
	imsicom_notice = rs(2)
	imsicom_notice = Replace(imsicom_notice,chr(13),"<br>")
	imsichk_gongi1 = Replace(rs(3),chr(13),"<br>")
	imsichk_gongi2 = Replace(rs(4),chr(13),"<br>")
	imsitcode = rs(5)
	proflag2 = rs(6)
	noticeflag = rs(7)	'1:체인점2:지사a:전체
	proflag2Pgubun = rs(8)
	productorderweek = rs(9)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select cbrandchoice,isnull(ch_gongi,''),orderflag, order_checkStime, order_checkEtime "
	SQL = SQL & " from tb_company "
	SQL = SQL & " where idx = '"& right(session("AAusercode"),5) &"' "
	rs.Open sql, db, 1
	imsicbrandchoice = replace(rs(0)," ","")
	imsich_gongi = Replace(rs(1),chr(13),"<br>")
	flagorderflag = rs(2)
	rs_order_checkStime = rs(3)
	rs_order_checkEtime = rs(4)
	rs.close

	if imsicbrandchoice<>"" and imsicbrandchoice<>"00000" then
		arrayBrand = split(imsicbrandchoice,",")
		arrayBrandInt = ubound(arrayBrand)
	end if

	imsigtitle = "개별 공지사항"
	if flagorderflag="4" then
		imsich_gongi = imsichk_gongi1
		imsigtitle = "경고1 메세지"
		if imsich_gongi="" then
			imsich_gongi = "경고 #1 메세지가 없습니다."
		end if
	elseif flagorderflag="5" then
		imsich_gongi = imsichk_gongi2
		imsigtitle = "경고2 메세지"
		if imsich_gongi="" then
			imsich_gongi = "경고 #2 메세지가 없습니다."
		end if
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sidx,sname "
	SQL = sql & " from tb_product_submenu "
	SQL = sql & " where idx = '"& left(session("AAusercode"),5) &"' order by sidx asc"
	rs.Open sql, db, 1
	if not rs.eof then
		proFlagArray = rs.GetRows
		proFlagArrayInt = ubound(proFlagArray,2)
	else
		proFlagArray    = ""
		proFlagArrayInt = ""
	end if
	rs.close

	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	if searcha = "" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select top 1 sname from tb_product_submenu where idx = '"& left(session("AAusercode"),5) &"' order by sidx asc"
		rs.Open sql, db, 1
		if not rs.eof then
			searcha = rs(0)
		end if
		rs.close
	end if
	if searchb = "" then
		searchb = "pcode"
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from v_product "
	SQL = sql & " where usercode = '"& left(session("AAusercode"),5) &"' "
	SQL = sql & " and usercode = '"& left(session("AAusercode"),5) &"' "

		if arrayBrandInt<>"" and imsicbrandchoice<>"00000" then
			SQL = sql & " and ( cbrandchoice = '' or cbrandchoice = '00000' "
			for i=0 to arrayBrandInt
				SQL = sql & " or cbrandchoice like '%"& arrayBrand(i) &"%' "
			next
			SQL = sql & " ) "
		end if

	if searchc<>"" and searchd<>"" then
		SQL = sql & " and "& searchc &" like '%"& searchd &"%' "
	else


		if searcha <> "0" then
			SQL = sql & " and sname = '"& searcha &"' "
		end if
	end if

	SQL = sql & " order by "& searchb &" asc"
	rs.Open sql, db, 1

	imsirscnt = rs.recordcount

	'요일 
	strNowWeek = WeekDay(Date())
	Select Case (strNowWeek)
    Case 1
       	today = "일요일"
    Case 2
        today = "월요일"
    Case 3
        today = "화요일"
    Case 4
        today = "수요일"
    Case 5
        today = "목요일"
    Case 6
        today = "금요일"
    Case 7
        today = "토요일"
	End Select

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Function Funloginok(fundata,funtime1,funtime2)
		ho = cstr(hour(time))
		if len(ho) = 1 then
			ho2 = "0"&ho
		else
			ho2 = ho
		end if
		mi = cstr(minute(time))
		if len(mi) = 1 then
			mi2 = "0"&mi
		else
			mi2 = mi
		end if
		now_time   = int("1"&ho2&mi2)		'현재시간
		timecheck1 = int("1"&funtime1)		'설정시간1
		timecheck2 = int("1"&funtime2)		'설정시간2
		today_week = int(WeekDay(Now()))	'오늘요일
		fundata    = int(fundata)
		if fundata=1 then
			if today_week=7 or today_week=1 Then
				if today_week = 7 Then
					if now_time >= timecheck1 Then
						loginokynflag = "y"
					Else
						loginokynflag = "n"
					end if
				else
					if now_time <= timecheck2 Then
						loginokynflag = "y"
					Else
						loginokynflag = "n"
					end if
				end if
			Else
				loginokynflag = "n"
			end if
		else
			if today_week=fundata-1 then
				if now_time >= timecheck1 Then
					loginokynflag = "y"
				Else
					loginokynflag = "n"
				end if
			elseif today_week=fundata then
				if now_time <= timecheck2 Then
					loginokynflag = "y"
				Else
					loginokynflag = "n"
				end if
			Else
				loginokynflag = "n"
			end if
		end if

		Funloginok = loginokynflag

	End Function
%>
<script language="javascript">
function radiochbsubmit() {
	form2.action="mAgencyOrderFRM.asp";
	form2.submit() ;
	return false ;
}

function cartchbok() {
<%if imsirscnt > 1 then%>
	var imsicnt = 0;
	for(var i=0; i<document.form.pcnt.length;i++) 	//체크박스 갯수
	{
		if(document.form.pcnt[i].value != ""){
			imsicnt = 1
		}
	}
	if (imsicnt<1) {
		alert("주문수량을 입력해 주세요.") ;
		return false ;
	}
<%else%>
	if (document.form.pcnt.value=="") {
		alert("주문수량을 입력해 주세요.") ;
		return false ;
	}
<%end if%>
	document.all("btnsubmit").style.display="none";
	form.submit() ;
	return false ;
}

function pop_win(){
	popWindow.style.display="none";
}
function pop_win2(){
	popWindow2.style.display="none";
}

function bwrite() {
	document.all("btn1").disabled = true;
	form2.submit() ;
}

function searchchb(form) {
	if (form.searchc.value=="") {
		alert("검색조건을 선택해 주세요.") ;
		return false ;
	}
	if (form.searchd.value=="") {
		alert("검색어를 입력해 주세요.") ;
		return false ;
	}
	form.submit() ;
	return false ;
}

function searchchange()
{
	form.searchc.value = afrm.searchc.options[afrm.searchc.selectedIndex].value;
	afrm.searchd.focus();
}

</script>
<table width="310" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td>
		<hr>
		<table width="300" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
			<tr>
				<td align=center >
<table width="310" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="20">
		<td>
			<%if proFlagArrayInt<>"" then%>
				<%for i=0 to proFlagArrayInt%>
					<a href="mAgencyOrderFRM.asp?popnot=1&searcha=<%=proFlagArray(1,i)%>&searchb=<%=searchb%>"><font size=2><%if proFlagArray(1,i)=searcha then%><B><%else%><font color=blue><%end if%><%=proFlagArray(1,i)%><%if proFlagArray(1,i)=searcha then%></B><%end if%></a><%if i<proFlagArrayInt then%>&nbsp;|&nbsp;<%end if%>
				<%next%>
				&nbsp;|&nbsp;<a href="mAgencyOrderFRM.asp?popnot=1&searcha=0&searchb=<%=searchb%>"><font size=2><%if searcha="0" then%><B><%else%><font color=blue><%end if%>전체보기</a>
			<%end if%>
		</td>
	</tr>
</table>

<table width="310" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">

<form name=form2 method=post>
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=popnot  value="1">

	<tr height="27">
		<td width=30%><font size=3><B>[ <%if searcha="0" then%>전체보기<%else%><%=searcha%><%end if%> ]</td>
		<td align=right>			<input type=button value="장바구니보기"  onclick="javascript:location.href='mAgencyOrderCartFRM.asp?btnsee=y';"></td>
	</tr>
	<tr>
		<td width=70% align=right colspan=2>
			정렬순서 : 
			<input type=radio name="searchb" value="pcode" onclick="radiochbsubmit()" <%if searchb="pcode" or searchb="" then%>checked<%end if%>>상품코드
			<input type=radio name="searchb" value="pname" onclick="radiochbsubmit()" <%if searchb="pname" then%>checked<%end if%>>상품명
			<!--<input type=radio name="searchb" value="sname" onclick="radiochbsubmit()" <%if searchb="sname" then%>checked<%end if%>>서브메뉴-->

		</td>
	</tr>
</form>
</table>

<table cellspacing=0 cellpadding=0 width="310" border=0>
<form action="mAgencyOrderCartOk.asp" name=form method=post>
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=searchd value="<%=searchd%>">
	<tr>
		<td align=center>

		<table cellspacing=1 cellpadding=1 width="310" border=0 bgcolor=#BDCBE7>
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width=7%><B>번호</td>
				<td width=7%><B>코드</td>
				<%if proflag2="1" then%>
					<td width=26%><B>상품명</td>
				<%else%>
					<td width=26%><B>상품명</td>
				<%end if%>
				<td width=10% align=center><B>수량</td>
				<!--<td width=18%><B>규격</td>-->
				<td width=10%><B>단가</td>
				<!-- <td width=12%><B>서브매뉴</td> -->
				<%if proflag2="1" then%>
					<%if proflag2Pgubun="1" then%>
						<!-- <td width=5%><B>사진</td>
						<td width=8%><B>비고</td> -->
					<%else%>
						<!-- <td width=13%><B>사진</td> -->
					<%end if%>
				<%end if%>

			</tr>

			<%
			irow=1
			do until rs.eof
			ordercheck = "n"
			rs_order_weekchoice = rs("Order_WeekChoice")
			if ProductOrderWeek = "y" then	'요일주문
				rs_order_weekchoice1 = ""
				rs_order_weekchoice2 = ""
				rs_order_weekchoice3 = ""
				rs_order_weekchoice4 = ""
				rs_order_weekchoice5 = ""
				rs_order_weekchoice6 = ""
				rs_order_weekchoice7 = ""
				for i=1 to len(rs_order_weekchoice)
					if i=1 then
						rs_order_weekchoice1 = mid(rs_order_weekchoice,1,1)
					elseif i=2 then
						rs_order_weekchoice2 = mid(rs_order_weekchoice,2,1)
					elseif i=3 then
						rs_order_weekchoice3 = mid(rs_order_weekchoice,3,1)
					elseif i=4 then
						rs_order_weekchoice4 = mid(rs_order_weekchoice,4,1)
					elseif i=5 then
						rs_order_weekchoice5 = mid(rs_order_weekchoice,5,1)
					elseif i=6 then
						rs_order_weekchoice6 = mid(rs_order_weekchoice,6,1)
					elseif i=7 then
						rs_order_weekchoice7 = mid(rs_order_weekchoice,7,1)
					end if
				Next
				
				if rs_order_weekchoice1<>"" then
					imsiloginok1 = Funloginok(rs_order_weekchoice1,rs_order_checkStime,rs_order_checkEtime)
				else
					imsiloginok1 = "n"
				end if
				if rs_order_weekchoice2<>"" then
					imsiloginok2 = Funloginok(rs_order_weekchoice2,rs_order_checkStime,rs_order_checkEtime)
				else
					imsiloginok2 = "n"
				end If
				if rs_order_weekchoice3<>"" then
					imsiloginok3 = Funloginok(rs_order_weekchoice3,rs_order_checkStime,rs_order_checkEtime)
				else
					imsiloginok3 = "n"
				end if
				if rs_order_weekchoice4<>"" then
					imsiloginok4 = Funloginok(rs_order_weekchoice4,rs_order_checkStime,rs_order_checkEtime)
				else
					imsiloginok4 = "n"
				end if
				if rs_order_weekchoice5<>"" then
					imsiloginok5 = Funloginok(rs_order_weekchoice5,rs_order_checkStime,rs_order_checkEtime)
				else
					imsiloginok5 = "n"
				end if
				if rs_order_weekchoice6<>"" then
					imsiloginok6 = Funloginok(rs_order_weekchoice6,rs_order_checkStime,rs_order_checkEtime)
				else
					imsiloginok6 = "n"
				end if
				if rs_order_weekchoice7<>"" then
					imsiloginok7 = Funloginok(rs_order_weekchoice7,rs_order_checkStime,rs_order_checkEtime)
				else
					imsiloginok7 = "n"
				end If
			
				'response.write "imsiloginok1"&imsiloginok1&"<BR>imsiloginok2"&imsiloginok2&"<BR>imsiloginok3"&imsiloginok3&"<BR>imsiloginok4"&imsiloginok4&"<BR>imsiloginok5"&imsiloginok5&"<BR>imsiloginok6"&imsiloginok6&"<BR>imsiloginok7"&imsiloginok7
		
				if imsiloginok1="n" and imsiloginok2="n" and imsiloginok3="n" and imsiloginok4="n" and imsiloginok5="n" and imsiloginok6="n" and imsiloginok7="n" then
					ordercheck = "y"
				End If 
			End If 

				'response.write "<script language=JavaScript>"
				'response.write "alert(" & ordercheck & ");"
				'response.write "</script>"
				imsinum = irow mod 2
				if imsinum=1 then
					imsibgcolor="bgcolor='white'"
				else
					imsibgcolor="bgcolor='#FCE7D6'"
				end if

				bigo = rs("bigo")
				if len(bigo)>4 then
					bigo = left(bigo,4)
				end if
				imsipname = rs("pname")
				pname = ""
				If Len(imsipname) > 12 Then 
					For i = 1 To Len(imsipname)
						If (i mod 12) = 0 And i > 0 Then 
							pname = pname & Mid(imsipname, i, 1) & "<br>&nbsp;"
						Else 
							pname = pname & Mid(imsipname, i, 1)
						End If 
					Next 
				Else
					pname = imsipname
				End If 
			%>

				<input type=hidden name=pcode value="<%=rs("pcode")%>">

				<tr height=25 <%=imsibgcolor%> align=center>
					<td><%=irow%></td>
					<td><%=rs("pcode")%></td>
					<td align=left>&nbsp;<B><%=pname%></td>
					<td>
						<% If ordercheck = "y" Then %>
							<input type=hidden name=pcnt>
							<input type=text size=4 STYLE="background-color: silver" disabled>
						<%else%>
						<%if rs("proout")="y" then%>
							<input type=text name=pcnt size=4 style="ime-mode:disabled;" OnKeypress="onlyNumber();" maxlength=4 tabindex=<%=i%>>
						<%else%>
							<input type=hidden name=pcnt>
							<font color=red>품절
						<%end if%>
						<% End If %>		
					</td>
					<!-- <td align=left>&nbsp;<%=rs("ptitle")%></td> -->
					<td align=right><%=formatnumber(rs("pprice"),0)%>&nbsp;</td>
					<!-- <td align=left>&nbsp;<%=rs("sname")%></td> -->
					<%if proflag2="1" then%>
						<%if proflag2Pgubun="1" then%>
							<!-- <td><%if rs("proimage")<>"" then%><a href="#" onclick="bwinopenXY('zoom.asp?tcode=<%=imsitcode%>&filename=<%=rs("proimage")%>', 'photoBig', '100', '100')"><img src="icon.gif" border=0><%end if%></td>
							<td><%=rs("bigo")%></td> -->
						<%else%>
							<!-- <td><%if rs("proimage")<>"" then%><a href="#" onclick="bwinopenXY('zoom.asp?tcode=<%=imsitcode%>&filename=<%=rs("proimage")%>', 'photoBig', '100', '100')"><img src="/fileupdown/pr_image/<%=imsitcode%>/<%=rs("proimage")%>" width=80 height=80 border=0><%end if%></td> -->
						<%end if%>
					<%end if%>

				</tr>

			<%
			rs.movenext
			irow=irow+1
			loop
			rs.close
			%>

		</table>
		</td>
	</tr>
<BR>
<tr>
<td>
<table align=center width=300>
	<tr>  
		<td height=30 align=center>
			<input type="image" name="btnsubmit" src="../images/mobile/cart.gif" width=96 height=28 border=0  onclick="return cartchbok();">&nbsp;&nbsp;
			<a href="mAgencyOrderFRM.asp?searcha=<%=searcha%>&searchb=<%=searchb%>"><img src="../images/mobile/cartcancel.gif"  width=96 height=28 border=0></a>
		</td>
	</tr>

</form>

</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR><BR>

<%if request("popnot")="" then%>
<%if gongi="1" and imsicom_notice<>"" and (noticeflag="1" or noticeflag="a") then%>
<!--------레이어 팝업---------->
<div id="popup1" style="position:absolute; left:0px; top:270px; z-index:0; display:;" onSelectStart="return false" isInfoWin="true">
<table width="300" height=100 cellpadding="0" cellspacing="0" border="0" bgcolor=white>
	<tr>
		<td height=25 bgcolor=#2A75B6 width=70%>&nbsp; <font color=white><b>* 전체 공지사항</td>
		<td height=25 bgcolor=#2A75B6 width=30% align=right>&nbsp; </td>
	</tr>
	<tr>
		<td valign=top bgcolor=#F4FB9F align=center colspan=2>

		<table width="97%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td><font color=black><B><%=imsicom_notice%></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td colspan=2 height=20 bgcolor=#2A75B6 align=right><input type="checkbox" name="popcheck1"><font color=white>24시간동안 안보기</font><a href="javascript:closeWin1();"><font color=white><B>[ 창 닫 기 ]</a></td>
	</tr>
</table>
</div>
<!--//팝업-->
<%end if%>

<%if imsich_gongi<>"" then%>
<!--------레이어 팝업---------->
<div id="popup2" style="position:absolute; left:0px; top:400px; z-index:0;display:;" onSelectStart="return false" isInfoWin="true">
<table width="300" height=100 cellpadding="0" cellspacing="0" border="0" bgcolor=white>
	<tr>
		<td height=25 bgcolor=#2A75B6 width=70%>&nbsp; <font color=white><b>* <%=imsigtitle%></td>
		<td height=25 bgcolor=#2A75B6 width=30% align=right>&nbsp; </td>
	</tr>
	<tr>
		<td valign=top bgcolor=#F4FB9F align=center colspan=2>

		<table width="97%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td><font color=black><B><%=imsich_gongi%></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td colspan=2 height=20 bgcolor=#2A75B6 align=right><input type="checkbox" name="popcheck2"><font color=white>24시간동안 안보기</font><a href="javascript:closeWin2();"><font color=white><B>[ 창 닫 기 ]</a></td>
	</tr>
</table>
</div>
<!--//팝업-->
<%end if%>
<%end if%>

<%'gongi=""%>
<script type="text/javascript">

 cookiedata = document.cookie; 

 if ( cookiedata.indexOf("maindiv1=done") < 0 ){ 
  document.all['popup1'].style.display = "";
 } else {
  document.all['popup1'].style.display = "none";
 }

  if ( cookiedata.indexOf("maindiv2=done") < 0 ){ 
  document.all['popup2'].style.display = "";
 } else {
  document.all['popup2'].style.display = "none";
 }


 function startTime() {
  var time = new Date();
  hours = time.getHours();
  mins = time.getMinutes();
  secs = time.getSeconds();
  closeTime = hours*3600+mins*60+secs;
  Timer();
 }

 function Timer() {
  var time = new Date();
  hours = time.getHours();
  mins = time.getMinutes();
  secs = time.getSeconds();
  curTime = hours*3600+mins*60+secs
  closeTime += 60;
 
  if (curTime >= closeTime) {
   document.all['popup1'].style.display = "none";
  } else {
   window.setTimeout("Timer()",1000);
  }
 if (curTime >= closeTime) {
   document.all['popup2'].style.display = "none";
  } else {
   window.setTimeout("Timer()",1000);
  }
 }

 function setCookie( name, value, expiredays ) { 
  var todayDate = new Date(); 
  todayDate.setDate( todayDate.getDate() + expiredays ); 
  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
 } 

 function closeWin1() { 
  if ( document.all.popcheck1.checked ) { 
   setCookie( "maindiv1", "done" , 1 ); 
  }
 
  document.all['popup1'].style.display = "none";
 }
  function closeWin2() { 
  if ( document.all.popcheck2.checked ) { 
   setCookie( "maindiv2", "done" , 1 ); 
  }

  document.all['popup2'].style.display = "none";
  }
</script>
<!--#include virtual="/adminpage/incfile/mbottom2.asp"-->