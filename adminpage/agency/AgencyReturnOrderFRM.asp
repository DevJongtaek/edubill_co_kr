<!--#include virtual="/adminpage/incfile/top2.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	Response.Expires = 0   
	Response.AddHeader "Pragma","no-cache"   
	Response.AddHeader "Cache-Control","no-cache,must-revalidate" 
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

   ' neworder = request("OrderGubun")

   
	gongi = request("gongi")

   '  response.Write neworder
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select brandflag,brandbox,isnull(com_notice,''),isnull(chk_gongi1,''),isnull(chk_gongi2,''),tcode,proflag2,noticeflag,proflag2Pgubun,productorderweek,chk_gongi3 "
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
	noticeflag = rs(7)	'1:ü����2:����a:��ü
	proflag2Pgubun = rs(8)
	productorderweek = rs(9)

   chk_gongi3 = rs(10)
   
   '  response.write SQL
	rs.close
    

    set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select bidx,bname "
	SQL = sql & " from tb_company_Retrurn "
	SQL = sql & " where idx = '"& left(session("AAusercode"),5) &"' order by bname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		imsiRetrurnboxarry = rs.GetRows
		imsiRetrurnboxarry_int = ubound(imsiRetrurnboxarry,2)
	else
		imsiRetrurnboxarry = ""
		imsiRetrurnboxarry_int = ""
	
   
	rs.close
    end if



	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select cbrandchoice,isnull(ch_gongi,''),orderflag, order_checkStime, order_checkEtime "
	SQL = SQL & " from tb_company "
	SQL = SQL & " where idx = '"& right(session("AAusercode"),5) &"' "
	rs.Open sql, db, 1
	if not rs.eof then
	imsicbrandchoice = replace(rs(0)," ","")
	imsich_gongi = Replace(rs(1),chr(13),"<br>")
	flagorderflag = rs(2)
	rs_order_checkStime = rs(3)
	rs_order_checkEtime = rs(4)
  
	rs.close
	End If 

	if imsicbrandchoice<>"" and imsicbrandchoice<>"00000" then
		arrayBrand = split(imsicbrandchoice,",")
		arrayBrandInt = ubound(arrayBrand)
	end if

	imsigtitle = "���� ��������"
	if flagorderflag="4" then
		imsich_gongi = imsichk_gongi1
		imsigtitle = "���1 �޼���"
		if imsich_gongi="" then
			imsich_gongi = "��� #1 �޼����� �����ϴ�."
		end if
	elseif flagorderflag="5" then
		imsich_gongi = imsichk_gongi2
		imsigtitle = "���2 �޼���"
		if imsich_gongi="" then
			imsich_gongi = "��� #2 �޼����� �����ϴ�."
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

	'response.write "A" & searcha & "<br>"
	'response.write "B" & searchb & "<br>"
	'response.write "C" & searchc & "<br>"
	'response.write "D" & searchd & "<br>"

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
    'SQL = sql & " and ReturnYn = 'y' "

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

	'���� 
	strNowWeek = WeekDay(Date())
	Select Case (strNowWeek)
    Case 1
       	today = "�Ͽ���"
    Case 2
        today = "������"
    Case 3
        today = "ȭ����"
    Case 4
        today = "������"
    Case 5
        today = "�����"
    Case 6
        today = "�ݿ���"
    Case 7
        today = "�����"
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
		now_time   = int("1"&ho2&mi2)		'����ð�
		timecheck1 = int("1"&funtime1)		'�����ð�1
		timecheck2 = int("1"&funtime2)		'�����ð�2
		today_week = int(WeekDay(Now()))	'���ÿ���
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
function chaintel()
{
  alert("<%=session("AAcomname2")%> ��ȭ��ȣ �ȳ� �Դϴ�.\n\n��ü�κ���:<%=session("AAtel")%> \n�߹�������:<%=session("AAfax")%>\n\n �ع����� ���õ� �ֹ�/���/��ǰ ���� �� ��ȭ��ȣ�� ���� �ٶ��ϴ�.\n\n��, ���α׷� ��� �ÿ��� �Ʒ��� ���� �ٶ��ϴ�.\n�ڿ���� �� ���� : 02-853-5111");
}
function radiochbsubmit() {
    form2.action="AgencyReturnOrderFRM.asp";
	form2.submit() ;
	return false ;
}

function cartchbok(chkvalue) {
<%if imsirscnt > 1 then%>
	var imsicnt = 0;
	for(var i=0; i<document.form.pcnt.length;i++) 	//üũ�ڽ� ����
	{
		if(document.form.pcnt[i].value != ""){
			imsicnt = 1
		}
	}
	if (imsicnt<1) {
		alert("�ֹ������� �Է��� �ּ���.") ;
		return false ;
	}
<%else%>
	if (document.form.pcnt.value=="") {
		alert("�ֹ������� �Է��� �ּ���.") ;
		return false ;
	}
<%end if%>
	form.searche.value = chkvalue;
	document.all("btn1").style.display="none";
	document.all("btn2").style.display="none";
	form.submit() ;
	return false ;
}

function pop_win(){
	popWindow.style.display="none";
}
function pop_win2(){
	popWindow2.style.display="none";
}

function searchchb(form) {
	if (form.searchc.value=="") {
		alert("�˻������� ������ �ּ���.") ;
		return false ;
	}
	if (form.searchd.value=="") {
		alert("�˻�� �Է��� �ּ���.") ;
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

<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="center" valign=top>
  	<tr height="20"><td> <font color=blue><B>[ ��ǰ�ϱ� ]</td><td align="center" width="90%">&nbsp;<font color="Black"><b><%=chk_gongi3%></font></b></td></tr> 
	<tr height="20">
		<td colspan="2"><font color=red>��.�ֹ���� : ��޴����â� ���ֹ������Է¢� ����ٱ��ϴ�⢺ ����ٱ��Ϻ��⢺ ����(����)�� ���ֹ��ϱ⢺ ��Ϸ�޽���(��)</td>
	</tr>
</table>


<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form name=afrm method=post action=AgencyReturnOrderFRM.asp>
<input type=hidden name=searcha value="<%=searcha%>">
	<tr>
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>��ǰ�˻�</td>
		<td nowrap width="64%" bgcolor="#FFFFFF" height="25">
			<select name="searchc" onchange="return searchchange();">
				<option value="">�˻�����
				<option value="pname" <%if searchc="pname" then%>selected<%end if%>>��ǰ��
				<option value="pcode" <%if searchc="pcode" then%>selected<%end if%>>��ǰ�ڵ�
			</select> <input type=text name=searchd value="<%=searchd%>"> <input type=button value="�˻�" onclick="return searchchb(this.form);">
		</td>
		<td width=30%><input type=button style="background-color:yellow; color:blue; font-weight: bolder" value="��ü�κ��� ��ȭ��ȣ��"  onclick="chaintel();"></td>
	</tr>
</form>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="20">
		<td>
			<%if proFlagArrayInt<>"" then%>
				<%for i=0 to proFlagArrayInt%>
					<a href="AgencyReturnOrderFRM.asp?popnot=1&searcha=<%=proFlagArray(1,i)%>&searchb=<%=searchb%>"><font size=2><%if proFlagArray(1,i)=searcha then%><B><%else%><font color=blue><%end if%><%=proFlagArray(1,i)%><%if proFlagArray(1,i)=searcha then%></B><%end if%></a><%if i<proFlagArrayInt then%>&nbsp;|&nbsp;<%end if%>
				<%next%>
				&nbsp;|&nbsp;<a href="AgencyReturnOrderFRM.asp?popnot=1&searcha=0&searchb=<%=searchb%>"><font size=2><%if searcha="0" then%><B><%else%><font color=red><%end if%><b>��ü����</b></a>
			<%end if%>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">

<form name=form2 method=post>
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=popnot  value="1">

	<tr height="27">
		<td width=30%><font size=3><B>[ <%if searcha="0" then%>��ü����<%else%><%=searcha%><%end if%> ]</td>
		<td width=70% align=right>
			���ļ��� : 
			<input type=radio name="searchb" value="pcode" onclick="radiochbsubmit()" <%if searchb="pcode" or searchb="" then%>checked<%end if%>>��ǰ�ڵ�
			<input type=radio name="searchb" value="pname" onclick="radiochbsubmit()" <%if searchb="pname" then%>checked<%end if%>>��ǰ��
			<input type=radio name="searchb" value="sname" onclick="radiochbsubmit()" <%if searchb="sname" then%>checked<%end if%>>����޴�
			<input type=button value="��ٱ��Ϻ���"  onclick="javascript:location.href='AgencyReturnOrderCartFRM.asp?btnsee=y';">
		</td>
	</tr>
</form>
</table>

<table cellspacing=0 cellpadding=0 width="100%" border=0>
<form action="AgencyReturnOrderCartOk.asp" name=form method=post>
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=searchd value="<%=searchd%>">
<input type=hidden name=searche value="">
	<tr>
		<td align=center>

		<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width=5%><B>��ȣ</td>
				<td width=6%><B>�ڵ�</td>
				<%if proflag2="1" then%>
					<td width=18%><B>��ǰ��</td>
				<%else%>
					<td width=23%><B>��ǰ��</td>
				<%end if%>
				<td width=9%><B>�ֹ�����</td>
                <td width="10%"><b>��ǰ����</b></td>
				<td width=13%><B>�԰�</td>
				<td width=9%><B>�ܰ�</td>
				<td width=12%><B>����Ŵ�</td>
				<%if proflag2="1" then%>
					<%if proflag2Pgubun="1" then%>
						<td width=5%><B>����</td>
						<td width=8%><B>���</td>
					<%else%>
						<td width=13%><B>����</td>
					<%end if%>
				<%end if%>

			</tr>

			<%
			irow=1
			do until rs.eof
			

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

			%>

				<input type=hidden name=pcode value="<%=rs("pcode")%>">

				<tr height=25 <%=imsibgcolor%> align=center>
					<td><%=irow%></td>
					<td><%=rs("pcode")%></td>
					<td align=left>&nbsp;<B><%=rs("pname")%></td>
					<td>
						<!--<% If ordercheck = "y" Then %>
							<input type=hidden name=pcnt>
							<input type=text size=4 STYLE="background-color: silver" disabled>
						<%else%>-->
						<%if rs("ReturnYn")="y" then%>
							<input type=text name=pcnt size=4 style="ime-mode:disabled;" OnKeypress="onlyNumber();" onkeydown="return down(event)" onkeyup="up(this)" oncontextmenu="return false"  maxlength=4 tabindex=<%=i%>>
						<%else%>
							<input type=hidden name=pcnt>
							<font color=red>��ǰ�Ұ�
						<%end if%>
						<!--<% End If %>		-->
					</td>
                    <!-- ��ǰ���� -->
                     <td>
                         <%if rs("ReturnYn")="y" then%>
                            <select name=creturnchoice  >
				
				<%if imsiRetrurnboxarry_int<>"" then%>
				<%for i=0 to imsiRetrurnboxarry_int%>
					<option value="<%=imsiRetrurnboxarry(0,i)%>"><%=imsiRetrurnboxarry(1,i)%>
				<%next%>
				<%end if%>
			</select>
                         <%else %>
                        <input type=hidden name=creturnchoice>
                         <select name=creturnchoice disabled>
				
				<%if imsiRetrurnboxarry_int<>"" then%>
				<%for i=0 to imsiRetrurnboxarry_int%>
					<option value="<%=imsiRetrurnboxarry(0,i)%>"><%=imsiRetrurnboxarry(1,i)%>
				<%next%>
				<%end if%>
			</select>
                        <%end if%>

                     </td>
					<td align=left>&nbsp;<%=rs("ptitle")%></td>
                   
					<td align=right><%=formatnumber(rs("pprice"),0)%>&nbsp;</td>
					<td align=left>&nbsp;<%=rs("sname")%></td>
					<%if proflag2="1" then%>
						<%if proflag2Pgubun="1" then%>
							<td><%if rs("proimage")<>"" then%><a href="#" onclick="bwinopenXY('zoom.asp?tcode=<%=imsitcode%>&filename=<%=rs("proimage")%>', 'photoBig', '100', '100')"><img src="icon.gif" border=0><%end if%></td>
							<td><%=rs("bigo")%></td>
						<%else%>
							<td><%if rs("proimage")<>"" then%><a href="#" onclick="bwinopenXY('zoom.asp?tcode=<%=imsitcode%>&filename=<%=rs("proimage")%>', 'photoBig', '100', '100')"><img src="/fileupdown/pr_image/<%=imsitcode%>/<%=rs("proimage")%>" width=80 height=80 border=0><%end if%></td>
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
		</table>

		</td>
	</tr>


<BR>
<tr>
<td>
<table align=center width=770>
	<tr> 
		<td height=30 align=center>
			<input type="image" src="cartokcontinue.gif" border=0 name="btn1" onclick="return cartchbok('1');">
			<input type="image" src="cartokview.gif" border=0 name="btn2" onclick="return cartchbok('');">
			<a href="AgencyReturnOrderFRM.asp?searcha=<%=searcha%>&searchb=<%=searchb%>><img src="/images/admin/l_bu02.gif" border=0></a>
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
<!--------���̾� �˾�---------->
<div id="popup1" style="position:absolute; left:<%if imsich_gongi<>"" then%>30<%else%>80<%end if%>px; top:370px; z-index:0; display:;" onSelectStart="return false" isInfoWin="true">
<table width="350" height=100 cellpadding="0" cellspacing="0" border="0" bgcolor=white>
	<tr>
		<td height=25 bgcolor=#2A75B6 width=70%>&nbsp; <font color=white><b>* ��ü ��������</td>
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
		<td colspan=2 height=20 bgcolor=#2A75B6 align=right><input type="checkbox" name="popcheck1" <%If left(session("AAusercode"),5) = "19209" or left(session("AAusercode"),5) = "96338" Then  %> style="visibility:hidden" > <%Else %> ><font color=white>24�ð����� �Ⱥ���</font><%End If %><a href="javascript:closeWin1();"><font color=white><B>[ â �� �� ]</a></td>
	</tr>
</table>
</div>
<!--//�˾�-->
<%end if%>

<%if imsich_gongi<>"" then%>
<!--------���̾� �˾�---------->
<div id="popup2" style="position:absolute; left:390px; top:370px; z-index:0;display:none;" onSelectStart="return false" isInfoWin="true">
<table width="350" height=100 cellpadding="0" cellspacing="0" border="0" bgcolor=white>
	<tr>
		<td height=25 bgcolor=<%If InStr(imsigtitle, "���") Then %>#ff3366<%else%>#2A75B6<%End If%> width=70%>&nbsp; <font color=white><b>* <%=imsigtitle%></td>
		<td height=25 bgcolor=<%If InStr(imsigtitle, "���") Then %>#ff3366<%else%>#2A75B6<%End If%> width=30% align=right>&nbsp; </td>
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
		<td colspan=2 height=20 bgcolor=<%If InStr(imsigtitle, "���") Then %>#ff3366<%else%>#2A75B6<%End If%> align=right><input type="checkbox" name="popcheck2" <%If left(session("AAusercode"),5) = "19209" or left(session("AAusercode"),5) = "96338" Then  %> style="visibility:hidden" > <%Else %> ><font color=white>24�ð����� �Ⱥ���</font><%End If %><a href="javascript:closeWin2();"><font color=white><B>[ â �� �� ]</a></td>
	</tr>
</table>
</div>
<!--//�˾�-->
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

<!--#include virtual="/adminpage/incfile/bottom2.asp"-->