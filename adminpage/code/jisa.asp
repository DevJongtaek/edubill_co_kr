<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	idx = mid(session("Ausercode"),6,5)

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,tcode,flag,idxsub,idxsubname,comname,name,post,addr,addr2,companynum1,companynum2,companynum3 "
	SQL = sql & " ,uptae,upjong,tel1,tel2,tel3,fax1,fax2,fax3,hp1,hp2,hp3,dcarno,startday,bidxsub,tcode "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& idx
	rslist.Open sql, db, 1

	imsitcode = rslist(1)
	imsiflag = rslist(2)
	imsiidxsub = rslist(3)
	imsiidxsubname = rslist(4)
	imsicomname = rslist(5)
	imsiname = rslist(6)
	imsipost = rslist(7)
	imsipost1 = left(imsipost,3)
	imsipost2 = right(imsipost,3)
	imsiaddr = rslist(8)
	imsiaddr2 = rslist(9)
	imsicompanynum1 = rslist(10)
	imsicompanynum2 = rslist(11)
	imsicompanynum3 = rslist(12)
	imsiuptae = rslist(13)
	imsiupjong = rslist(14)
	imsitel1 = rslist(15)
	imsitel2 = rslist(16)
	imsitel3 = rslist(17)
	imsifax1 = rslist(18)
	imsifax2 = rslist(19)
	imsifax3 = rslist(20)
	imsihp1 = rslist(21)
	imsihp2 = rslist(22)
	imsihp3 = rslist(23)
	imsidcarno = rslist(24)
	imsistartday = rslist(25)
	imsibidxsub = rslist(26)
	imsitcode = rslist(27)
	rslist.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " order by dcarno asc"
	rs.Open sql, db, 1

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select userpwd "
	SQL = sql & " from tb_adminuser where flag='3' and usercode = '"& session("Ausercode") &"' "
	rs2.Open sql, db, 1
	imsiuserpwd = rs2(0)
	rs2.close
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 지사정보 수정 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="jisaok.asp" name=form method=post onsubmit="return comwrite222(this.form);">
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
		<td width=80% bgcolor=white><input type="text" name="tcode" maxlength="20" size=10 class="box_write" value="<%=imsitcode%>" readonly></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>지사(점)명&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="comname" maxlength="20"  size=15 class="box_write" value="<%=imsicomname%>" readonly></td>
	</tr>
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
			<input type="text" class="box_write" style="width:45;" name="m_post1" id="m_post1" maxlength=3 OnKeypress="onlyNumber();" readonly value="<%=imsipost1%>">
			- 
			<input type="text" class="box_write" style="width:45;" name="m_post2" id="m_post2" maxlength=3 OnKeypress="onlyNumber();" readonly value="<%=imsipost2%>"> 
			<a href="#" onclick="javascript:AutoAddr('1')"><img src="/images/member_02.gif" hspace="5" align="absmiddle" border=0></a>
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
		<td align=right><font color=red>*</font><B>전화번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="tel1" maxlength="3" size=3 class="box_write" value="<%=imsitel1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel2" maxlength="4" size=4 class="box_write" value="<%=imsitel2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel3" maxlength="4" size=4 class="box_write" value="<%=imsitel3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>팩스번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="fax1" maxlength="3" size=3 class="box_write" value="<%=imsifax1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax2" maxlength="4" size=4 class="box_write" value="<%=imsifax2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax3" maxlength="4" size=4 class="box_write" value="<%=imsifax3%>" OnKeypress="onlyNumber();">
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
		<td align=right><font color=red>*</font><B>로그인비밀번호&nbsp;</td>
		<td bgcolor=white><input type="text" name="userpwd" maxlength="10" style="width:100;" class="box_write" value="<%=imsiuserpwd%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>개설일자&nbsp;</td>
		<td bgcolor=white><%=imsistartday%></td>
	</tr>
</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>
		<%if session("Auserwrite")="y" then%>
			<input type="image" src="/images/admin/l_bu03.gif" border=0>
		<%end if%>
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

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->