<%
	imsi_userjuso = request("imsi_userjuso")
	gubun = request("gubun")
	key=request("key")

	if gubun <> "" then
%>
		<!-- #include file="dbzip.asp"-->
<%
		select case gubun
			case "1"
				set rs = server.CreateObject("ADODB.Recordset")
				sql= "select SIDO, GUGUN, DONG, BUNJI, ZIPCODE from TblZipCode where dong like '"&imsi_userjuso&"%' order by DONG, BUNJI asc"
				rs.Open sql, Db, 1
			case "2"
				imsi_useraddr = request("imsi_useraddr")
				imsi_userpost1 = request("imsi_userpost1")
				imsi_userpost2 = request("imsi_userpost2")
%>
				<script language="javascript">
					var imsi_useraddr = "<%=imsi_useraddr%>";
					var imsi_userpost1 = "<%=imsi_userpost1%>";
					var imsi_userpost2 = "<%=imsi_userpost2%>";

					<%select case key%>
						<%case "1"%>
							opener.form.m_addr1.value=imsi_useraddr;
							opener.form.m_post1.value=imsi_userpost1;
							opener.form.m_post2.value=imsi_userpost2;
							opener.form.m_addr2.value="";
							opener.form.m_addr2.focus();
							parent.window.close();
						<%case "3"%>
							opener.form_o.m_addr1.value=imsi_useraddr;
							opener.form_o.m_post1.value=imsi_userpost1;
							opener.form_o.m_post2.value=imsi_userpost2;
							opener.form_o.m_addr2.focus();
							parent.window.close();
						<%case "333"%>
							opener.form.o_addr1.value=imsi_useraddr;
							opener.form.o_post1.value=imsi_userpost1;
							opener.form.o_post2.value=imsi_userpost2;
							opener.form.o_addr2.focus();
							parent.window.close();
						<%case "4"%>
							opener.form_o.r_juso.value=imsi_useraddr;
							opener.form_o.r_post1.value=imsi_userpost1;
							opener.form_o.r_post2.value=imsi_userpost2;
							opener.form_o.r_juso2.focus();
							parent.window.close();
						<%case "5"%>
							opener.form.m_addr1.value=imsi_useraddr;
							opener.form.m_post1.value=imsi_userpost1;
							opener.form.m_post2.value=imsi_userpost2;
							opener.form.m_addr1.focus();
							parent.window.close();
						<%case "6"%>
							opener.form.o_addr1.value=imsi_useraddr;
							opener.form.o_post1.value=imsi_userpost1;
							opener.form.o_post2.value=imsi_userpost2;
							opener.form.o_addr2.focus();
							parent.window.close();
						<%case "222"%>
							opener.form.d_addr1.value=imsi_useraddr;
							opener.form.d_post1.value=imsi_userpost1;
							opener.form.d_post2.value=imsi_userpost2;
							opener.form.d_addr2.focus();
							parent.window.close();
						<%case ""%>
							opener.form.m_addr1.value=imsi_useraddr;
							opener.form.m_post1.value=imsi_userpost1;
							opener.form.m_post2.value=imsi_userpost2;
							opener.form.m_addr2.value="";
							opener.form.m_addr2.focus();
							parent.window.close();
					<%end select%>
				</script>

<%
		end select
	end if
%>

<html>
<head>
<title>::: 우편번호 찾기 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/dog.css" rel="stylesheet" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="320" height="100%" border=0 cellpadding="0" cellspacing="0">

<script language="JavaScript">
<!--
function checkValue() {
	if (form1.imsi_userjuso.value=="") {
		alert("현재 거주하고 계시는 읍/면/동 명을 입력하세요.") ;
		form1.imsi_userjuso.focus() ;
		return false ;
	}
	form1.submit() ;
	return false ;
}
//-->
</script>

<form action="PostChoice.asp" method=post name=form1>
<input type=hidden name=gubun value="1">
<input type=hidden name=key value=<%=key%>>

	<tr> 
		<td height="50" valign="top"><img src="/db/images/member_14.gif" width="320" height="50"></td>
	</tr>
	<tr> 
		<td valign="top" align="center" height=1>

		<br>
		찾고자하시는 지역의 동이나 읍/면의 이름을 공백없이
		<br>
        	입력하신 후, 검색버튼을 클릭하십시오.<BR>&nbsp;

		<table width="320" height="21" border="0" cellpadding="0" cellspacing="0">
			<tr> 
            			<td width="125" align="center">
					<img src="/db/images/icon_2.gif"> 읍/면/동의 이름</td>
				<td width="135">
					<input name="imsi_userjuso" type="text" size="10" maxlength="16" style="background-color:#ffffff;border:1 solid #999999; width:130px"> 
				</td>
				<td width="60"><input type=image src="/db/images/member_05.gif" width="46" height="21" border=0 onclick="javascript:return checkValue()"></td>
			</tr>
		</table>

	<%if gubun = "" then%>
		&nbsp;<br>
		ex) 주소가 '서울시특별시 강남구 역삼동..' 인경우 
		<br>
		역삼동 만 입력하시면 됩니다.
	<%end if%>

		</td>
	</tr>

</form>


<%if gubun = "1" then%>

	<tr> 
		<td valign="top">

		<table width="320" border="0" cellpadding="1" cellspacing="1" valign="top">
			<tr bgcolor=#E1E4F0 height=23 align=center>
				<td width=17%>우편번호</td>
				<td width=83%>주 &nbsp;&nbsp;&nbsp; 소</td>
			</tr>

<%
if rs.eof then
%>

			<tr height=19 valign=top>
				<td colspan=2 align=center><B>찾으시는 주소가 없습니다. 다시검색해 주십시요.</td>
			</tr>

<%
else
	do until rs.EOF
		if isnull(rs("BUNJI")) then
			imsi_s4 = rs("BUNJI")
		else
			imsi_s4 = rs("BUNJI")
			imsi_s4 = replace(imsi_s4,"(","")
			imsi_s4 = replace(imsi_s4,")","")
		end if

		imsi_useraddr = rs("SIDO")&" "&rs("GUGUN")&" "&rs("DONG")&" "&imsi_s4&" "
		imsi_useraddr2 = rs("SIDO")&" "&rs("GUGUN")&" "&rs("DONG")
%>

			<tr bgcolor=#F8F9FC height=19 valign=top>
				<td align=center><%=left(rs("Zipcode"),3)%>-<%=right(rs("Zipcode"),3)%></td>
				<td> &nbsp; <a href="PostChoice.asp?gubun=2&imsi_useraddr=<%=imsi_useraddr2%>&imsi_userpost1=<%=left(rs("Zipcode"),3)%>&imsi_userpost2=<%=right(rs("Zipcode"),3)%>&key=<%=key%>"><%=imsi_useraddr%></a></td>
			</tr>

<%
	rs.MoveNext 
	loop 
	rs.close

end if
%>

			<tr>
				<td></td>
			</tr>
		</table>

		</td>
	</tr>

<%end if%>


	<tr> 
		<td bgcolor="#DEDEDE" align="center" height=1> 

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> 
				<td align="center">
					<a href="javascript:window.close();"><img src="/db/images/member_06.gif" width="57" height="24" border="0"></a>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>
