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
				sido = request("sido")
				sigungu = request("sigungu")
				If sido <> "" Then 
					set rs = server.CreateObject("ADODB.Recordset")
					SQL = " select City from TblCityInfo "
					SQL = SQL & " where sido = '" & sido & "'"
					SQL = SQL & " group by City "
					SQL = SQL & " order by City "
					rs.Open SQL, Db, 1
				End If 

				If Trim(dong) <> "" And Trim(sido) <> "" And Trim(sigungu) <> "" Then 
					set rsaddr = server.CreateObject("ADODB.Recordset")
					'SQL = " select  p.postcode, "
					'SQL = SQL & " p.SIDO + ' ' + p.City + ' ' + p.RoadName + ' ' + p.BuildingFirstNo + ' ' + case p.BuildingSecNo when 0 then '' else '-' + p.BuildingSecNo end address "
					'SQL = SQL & " from TblPostInfo p"
					'SQL = SQL & " join TblCityInfo c"
					'SQL = SQL & " on p.RoadCode = c.RoadCode"
					'SQL = SQL & " where c.SIDO = '" & sido & "' "
					'SQL = SQL & " and c.City = '" & sigungu & "' "
					'SQL = SQL & " and c.RoadName = '" & dong & "' "
					'SQL = SQL & " order by p.BuildingFirstNo"
					
					SQL = "select  postcode, "
                    SQL = SQL & " SIDO + ' ' + City + ' ' + RoadName + ' ' + BuildingFirstNo + ' ' + case BuildingSecNo when 0 then '' else '-' + BuildingSecNo end address "
					SQL = SQL & " from TblPostInfo "
					SQL = SQL & " where RoadCode = (select RoadCode from TblCityInfo where SIDO = '" & sido & "' and City = '" & sigungu & "' and RoadName = '" & dong & "')"
					rsaddr.Open SQL, Db, 1
					'response.write sql
					
				End If 
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
<title>도로명 주소 검색</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/dog.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
function Sido(value){
	switch (value)
	{
		case "서울특별시":
		case "부산광역시":
		case "대구광역시":
		case "인천광역시":
		case "광주광역시":
		case "대전광역시":
		case "울산광역시":
		case "경기도":
		case "강원도":
		case "충청남도":
		case "충청북도":
		case "전라남도":
		case "전라북도":
		case "경상남도":
		case "경상북도":
		case "제주특별자치도":
		case "세종특별자치시":
			myForm.submit();
			break;
		case "":
		alert('aaa');
		var obj=document.myForm.sigungu;
		for (i = obj.options.length -1 ; i > 0 ; i--)
		{
			obj.remove(i);
		}	
			break;
		default:
			break;
	}
}
function checkValue() {
	if (myForm.dong.value=="") {
		alert("읍/면/동 명을 입력하세요.") ;
		myForm.dong.focus() ;
		return false ;
	}
	myForm.submit() ;
	return false ;
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- Save for Web Slices (Untitled-2.psd) -->
<table id="Table_01" width="512" height="494" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5">
			<img src="images/SearchPost_01.gif" width="512" height="54" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/SearchPost_02.gif" width="19" height="26" alt=""></td>
		<td>
			<a href="/db/SearchDongPost.asp?dong=<%=dong%>&gubun=<%=gubun%>&key=<%=key%>"><img src="images/SearchPost_03_1.gif" width="167" height="26" alt="" border=0></a></td>
		<td>
			<img src="images/SearchPost_04_1.gif" width="136" height="26" alt=""></td>
		<td colspan="2">
			<img src="images/SearchPost_05.gif" width="190" height="26" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/SearchPost_06.gif" width="19" height="397" alt=""></td>
		<td colspan="3" align=center>
			<table border=0 width=450>
			<form name=myForm action="SearchRoadPost.asp">
			<input type=hidden name=gubun value="1">
			<input type=hidden name=key value=<%=key%>>
			<tr>
				<td align=center>
				시도 <select name=sido  onchange="Sido(this.options[this.selectedIndex].value)">
				<option value=""<%If sido="" Then %>selected<%End If%>><  선  택  >
				<option value="서울특별시"<%If sido="서울특별시" Then %>selected<%End If%>>서울
				<option value="부산광역시"<%If sido="부산광역시" Then %>selected<%End If%>>부산
				<option value="대구광역시"<%If sido="대구광역시" Then %>selected<%End If%>>대구
				<option value="인천광역시"<%If sido="인천광역시" Then %>selected<%End If%>>인천
				<option value="광주광역시"<%If sido="광주광역시" Then %>selected<%End If%>>광주
				<option value="대전광역시"<%If sido="대전광역시" Then %>selected<%End If%>>대전
				<option value="울산광역시"<%If sido="울산광역시" Then %>selected<%End If%>>울산
				<option value="경기도"<%If sido="경기도" Then %>selected<%End If%>>경기
				<option value="강원도"<%If sido="강원도" Then %>selected<%End If%>>강원
				<option value="충청남도"<%If sido="충청남도" Then %>selected<%End If%>>충남
				<option value="충청북도"<%If sido="충청북도" Then %>selected<%End If%>>충북
				<option value="전라남도"<%If sido="전라남도" Then %>selected<%End If%>>전남
				<option value="전라북도"<%If sido="전라북도" Then %>selected<%End If%>>전북
				<option value="경상남도"<%If sido="경상남도" Then %>selected<%End If%>>경남
				<option value="경상북도"<%If sido="경상북도" Then %>selected<%End If%>>경북
				<option value="제주특별자치도"<%If sido="제주특별자치도" Then %>selected<%End If%>>제주
				<option value="세종특별자치시"<%If sido="세종특별자치시" Then %>selected<%End If%>>세종
				</select>
				시군구
				<select name=sigungu>
					<option value=""><  선  택  >
					<% If sido <> "" Then 
					Do Until rs.eof %>
					<option value="<%=rs(0)%>" <%If rs(0) = sigungu Then %>selected <%End If %>><%=rs(0)%>
					<% rs.movenext
					Loop
					End If %>
				</select>
				<input name="dong" type="text" size="10" maxlength="16" style="background-color:#ffffff;border:1 solid #999999; width:130px"> <input type=image src="/db/images/member_05.gif" width="46" height="21" border=0 onclick="javascript:return checkValue()"></td>
			</tr>
			<tr>
				<td>* 검색방법 : 도로명(~로,~길)<br>
- 서울시 송파구 잠실로 51-33 예) '잠실로(도로명)'<br>
- 서울시 강동구 양재대로112길 57 예) '양재대로112길(도로명)'</td>
			</tr>
			<tr>
				<td><div style="widht:200;height:260;overflow-y:scroll;overflow:auto;">
				<table width=440>
					<tr bgcolor=#E1E4F0 align=center>
						<td width=20%>우편번호</td>
						<td>주소</td>
					</tr>
				<%If Trim(dong) <> "" And Trim(sido) <> "" And Trim(sigungu) <> "" Then 
				Do Until rsaddr.eof 

					imsi_useraddr = rsaddr("Address")
					%>
						<tr bgcolor=#F8F9FC height=19 valign=top>
							
							<td align=center><%=left(rsaddr("PostCode"),3)%>-<%=right(rsaddr("PostCode"),3)%></td>
							<td> &nbsp; <a href="SearchRoadPost.asp?gubun=2&imsi_useraddr=<%=imsi_useraddr%>&imsi_userpost1=<%=left(rsaddr("PostCode"),3)%>&imsi_userpost2=<%=right(rsaddr("PostCode"),3)%>&key=<%=key%>"><%=imsi_useraddr%></a></td>
							</tr>

					<%
					rsaddr.MoveNext 
					loop 
					rsaddr.close
					End If 
					%>
					</table></div></td>
			</tr>
			</form>
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