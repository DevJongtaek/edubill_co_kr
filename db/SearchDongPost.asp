<%
	dong = request("dong")
	gubun = request("gubun")
	key=request("key")

	if gubun <> "" then
%>
		<!-- #include file="dbzip.asp"-->
<%
		select case gubun
			case "1"
				set rs = server.CreateObject("ADODB.Recordset")
				sql= "select SIDO, GUGUN, DONG, BUNJI, ZIPCODE from TblZipCode where dong like '"&dong&"%' order by DONG, BUNJI asc"
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
<title>동 주소 검색</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/dog.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
function checkValue() {
	if (form1.dong.value=="") {
		alert("도로 명을 입력하세요.") ;
		form1.dong.focus() ;
		return false ;
	}
	form1.submit() ;
	return false ;
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- Save for Web Slices (Untitled-2.psd) -->
<table id="Table_01" width="512" height="494" border="0" cellpadding="0" cellspacing="0">
<form action="SearchDongPost.asp" method=post name=form1>
<input type=hidden name=gubun value="1">
<input type=hidden name=key value=<%=key%>>
	<tr>
		<td colspan="5">
			<img src="images/SearchPost_01.gif" width="512" height="54" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/SearchPost_02.gif" width="19" height="26" alt=""></td>
		<td>
			<img src="images/SearchPost_03.gif" width="167" height="26" alt="" border=0></td>
		<td>
			<a href="/db/SearchRoadPost.asp?dong=<%=dong%>&gubun=<%=gubun%>&key=<%=key%>"><img src="images/SearchPost_04.gif" width="136" height="26" alt="" border=0></a></td>
		<td colspan="2">
			<img src="images/SearchPost_05.gif" width="190" height="26" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/SearchPost_06.gif" width="19" height="397" alt=""></td>
		<td colspan="3" align=center>
			<table border=0 width=450>
			<tr>
				<td align=center >동(읍/면/리)명+지번 : <input name="dong" type="text" size="10" maxlength="16" style="background-color:#ffffff;border:1 solid #999999; width:130px"> <input type=image src="/db/images/member_05.gif" width="46" height="21" border=0 onclick="javascript:return checkValue()"></td>
			</tr>
			<tr>
				<td>* 검색방법 : 도로명(~로,~길)+건물번호<br>
- 서울시 송파구 잠실로 51-33 예) '잠실로(도로명) 51-33(건물번호)'<br>
- 서울시 강동구 양재대로112길 57 예) '양재대로112길(도로명) 57(건물번호)'</td>
			</tr>
			<tr>
				<td><div style="widht:200;height:260;overflow-y:scroll;overflow:auto;">
					<table width=440>
					<tr bgcolor=#E1E4F0 align=center>
						<td width=20%>우편번호</td>
						<td>주소</td>
					</tr>
			<%
			If gubun <> "" Then 
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
								<td> &nbsp; <a href="SearchDongPost.asp?gubun=2&imsi_useraddr=<%=imsi_useraddr2%>&imsi_userpost1=<%=left(rs("Zipcode"),3)%>&imsi_userpost2=<%=right(rs("Zipcode"),3)%>&key=<%=key%>"><%=imsi_useraddr%></a></td>
							</tr>

				<%
					rs.MoveNext 
					loop 
					rs.close

				end If
				End if 
				%>
					</table></div></td>
			</tr>
			</table>
			</td>
		<td>
			<img src="images/SearchPost_08.gif" width="21" height="397" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="images/SearchPost_09.gif" width="512" height="16" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/spacer.gif" width="19" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="167" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="136" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="169" height="1" alt=""></td>
		<td>
			<img src="images/spacer.gif" width="21" height="1" alt=""></td>
	</tr>
</table>
<!-- End Save for Web Slices -->
</body>
</html>