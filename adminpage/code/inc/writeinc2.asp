<script language="JavaScript">
<!--
function checkval(val1,val2,val3){
	tmp = val2;
	if (tmp.length < 4) {
		alert("지사코드는 숫자 4글자 입니다!!") ;
		return false ;
	}
	window.open ('/adminpage/jdregok2.asp?val='+val2+'&gubun='+val3,'CheckID','width=0,height=0,top=30000,left=30000')
	return false ;
}
//-->
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script language="JavaScript">
    function DaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                   document.getElementById("m_addr2").value = extraAddr;
                
                } else {
                    document.getElementById("m_addr2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('m_post1').value = data.zonecode.substr(0, 2);
                document.getElementById('m_post2').value = data.zonecode.substr(2, 3);
                document.getElementById("m_addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("m_addr2").focus();
            }
        }).open();
    }
</script>
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 지사 등록 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="writeok.asp" name=form method=post>
<input type=hidden name=flag value="<%=flag%>">
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type="hidden" name="searcha" value="<%=searcha%>">
<input type="hidden" name="searchb" value="<%=searchb%>">
<input type="hidden" name="searchc" value="<%=searchc%>">
<input type="hidden" name="searchd" value="<%=searchd%>">
<input type="hidden" name="searche" value="<%=searche%>">
<input type="hidden" name="searchf" value="<%=searchf%>">
<input type="hidden" name="searchg" value="<%=searchg%>">
<input type="hidden" name="dflag">

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>지사(점)코드&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="tcode" maxlength="4" size=4 class="box_write" OnKeypress="onlyNumber();" value="<%=imsitcode%>" <%if idx <> "" then%>readonly<%end if%>>
<%if idx="" then%><input type=image src="/images/admin/member_01.gif" border=0 onClick="return checkval(form,form.tcode.value,2)" name="test1111"><%end if%> * 숫자 4자리</td>
	</tr>

<%
set rs2 = server.CreateObject("ADODB.Recordset")
SQL = " select dcenterflag from tb_company where idx = "& left(int(session("Ausercode")),5) &" "
rs2.Open sql, db, 1
if not rs2.eof then
	rsDcenterflag = rs2(0)
end if
rs2.close

if rsDcenterflag="y" then	'본사가 물류센터일 경우
	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select b.bidx,b.bname from tb_company a, tb_company_dcenter b where a.idx = b.idx and a.idx = "& int(session("Ausercode")) &" and a.dcenterflag='y' "
	SQL = sql & " order by b.bname asc"
	rs2.Open sql, db, 1
%>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>지사(점)명&nbsp;</td>
		<td width=80% bgcolor=white>
			<input type="text" name="comname" maxlength="30"  size=20 class="box_write" value="<%=imsicomname%>">
			<select name=choiceDcenter>
				<option value="0">지사로등록
				<%do until rs2.eof%>
					<%if rs2(1)<>"지정안함" then%>
						<option value="<%=rs2(0)%>" <%if rs2(0)=choiceDcenter then%>selected<%end if%>><%=rs2(1)%>
					<%end if%>
				<%rs2.movenext%>
				<%loop%>
				<%rs2.close%>
			</select>
		</td>
	</tr>
<%else%>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>지사(점)명&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="comname" maxlength="30"  size=20 class="box_write" value="<%=imsicomname%>"></td>
	</tr>
<%end if%>



	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>대표자&nbsp;</td>
		<td bgcolor=white><input type="text" name="name" maxlength="20"  size=10 class="box_write" value="<%=imsiname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>사업자등록번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" class="box_write" name="companynum1" maxlength="3" size=3 value="<%=imsicompanynum1%>" OnKeypress="onlyNumber();">
-
<input type="text" class="box_write" name="companynum2" maxlength="2" size=2 value="<%=imsicompanynum2%>" OnKeypress="onlyNumber();">
-
<input type="text" class="box_write" name="companynum3" maxlength="5" size=5 value="<%=imsicompanynum3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>우편번호&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:45;" name="m_post1" id="m_post1" maxlength=3 OnKeypress="onlyNumber();" value="<%=imsipost1%>">
			- 
			<input type="text" class="box_write" style="width:45;" name="m_post2" id="m_post2" maxlength=3 OnKeypress="onlyNumber();" value="<%=imsipost2%>"> 
			<!--<a href="#" onclick="javascript:AutoAddr('1')"><img src="/images/member_02.gif" hspace="5" align="absmiddle" border=0></a>-->
            <a href="#" onclick="javascript:DaumPostcode();"><img src="/images/member_02.gif" hspace="5" align="absmiddle" border=0></a>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>주소&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:300;" name="m_addr1" id="m_addr1" value="<%=imsiaddr%>"> 
                	<br> 
			<input type="text" class="box_write" style="width:300;" name="m_addr2" id="m_addr2" value="<%=imsiaddr2%>"> 
			나머지 주소 
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>업태&nbsp;</td>
		<td bgcolor=white><input type="text" name="uptae" maxlength="20" style="width:200;" class="box_write" value="<%=imsiuptae%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>업종&nbsp;</td>
		<td bgcolor=white><input type="text" name="upjong" maxlength="20" style="width:200;" class="box_write" value="<%=imsiupjong%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>전화번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="tel1" maxlength="3" size=3 class="box_write" value="<%=imsitel1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel2" maxlength="4" size=4 class="box_write" value="<%=imsitel2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel3" maxlength="4" size=4 class="box_write" value="<%=imsitel3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>팩스번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="fax1" maxlength="3" size=3 class="box_write" value="<%=imsifax1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax2" maxlength="4" size=4 class="box_write" value="<%=imsifax2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax3" maxlength="4" size=4 class="box_write" value="<%=imsifax3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
    <tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>e-메일주소&nbsp;</td>
		<td bgcolor=white>

            <input type="text" name="homepage" maxlength="100" style="width:400;" class="box_write" value="<%=imsihomepage%>">
		</td>
	</tr>
<!--
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>핸드폰번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="hp1" maxlength="3" size=3 class="box_write" value="<%=imsifax1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="hp2" maxlength="4" size=4 class="box_write" value="<%=imsifax2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="hp3" maxlength="4" size=4 class="box_write" value="<%=imsifax3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
-->
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>호차&nbsp;</td>
		<td bgcolor=white>
			<select name=dcarno>
				<option value="">호차선택
				<%do until rs.eof%>
					<option value="<%=rs(0)%>" <%if rs(0)=imsidcarno then%>selected<%end if%>><%=rs(1)%>호차
				<%rs.movenext%>
				<%loop%>
				<%rs.close%>
			</select>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>개설일자&nbsp;</td>
		<td bgcolor=white>
			<input type="text" name="startday" maxlength="8" size=8 class="box_write" value="<%=replace(imsistartday,"/","")%>" OnKeypress="onlyNumber();">
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>가상계좌&nbsp;</td>
		<td bgcolor=white>
			은행명 : <input type="text" name="virtual_acnt2_bank" value="<%=imsivirtual_acnt2_bank%>" size=10>은행
			&nbsp;&nbsp;
			계좌번호<input type="text" name="virtual_acnt2" value="<%=imsivirtual_acnt2%>" size=20>
		</td>
	</tr>
</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>

<%if session("Ausergubun")="2" then%>
	<%if session("Auserwrite")="y" then%>
		<%if idx="" then%>
			<input type="image" src="/images/admin/l_bu01.gif" border=0 onclick="return comwrite2();" name="hgghhg">
		<%else%>
			<input type="image" src="/images/admin/l_bu03.gif" border=0 onclick="return comwrite2();">
			<a href="#" onclick="javascript:comdel2();"><img src="/images/admin/l_bu04.gif" border=0></a>
		<%end if%>
	<%end if%>
<%end if%>

			<a href="#" onclick="javascript:history.back();"><img src="/images/admin/l_bu07.gif" border=0></a>
		</td>
	</tr>

</form>

</table>