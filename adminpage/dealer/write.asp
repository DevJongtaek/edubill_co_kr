<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	GotoPage = Request("GotoPage")
	idx = Request("idx")

	if idx <> "" then
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcode,dname,name,jumin1,jumin2,comnum1,comnum2,comnum3,post,addr,addr2,uptae,upjong,tel1,tel2,tel3, "
	SQL = SQL & " fax1,fax2,fax3,homepage,sudang,bank,banknum,bankname,wdate "
	SQL = sql & " from tb_dealer "
	SQL = sql & " where idx = "& idx &" "
	rs.Open sql, db, 1
	dcode = rs(0)
	dname = rs(1)
	name = rs(2)
	jumin1 = rs(3)
	jumin2 = rs(4)
	comnum1 = rs(5)
	comnum2 = rs(6)
	comnum3 = rs(7)
	post = rs(8)
	addr = rs(9)
	addr2 = rs(10)
	uptae = rs(11)
	upjong = rs(12)
	tel1 = rs(13)
	tel2 = rs(14)
	tel3 = rs(15)
	fax1 = rs(16)
	fax2 = rs(17)
	fax3 = rs(18)
	homepage = rs(19)
	sudang = rs(20)
	bank = rs(21)
	banknum = rs(22)
	bankname = rs(23)
	wdate = rs(24)
	rs.close
	end if
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 딜러등록 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="writeok.asp" name=form method=post onsubmit="return dwrite();">
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type="hidden" name="dflag">

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>딜러코드&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="dcode" maxlength="4" size=4 class="box_write" value="<%=dcode%>" <%if idx <> "" then%>readonly<%end if%>>
			<%if idx = "" then%><a href="#" onClick="return checkid2(form,form.dcode.value)"><img src="/images/admin/member_01.gif" border=0 hspace="5" align="absmiddle"></a><%end if%>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>딜러명&nbsp;</td>
		<td bgcolor=white><input type="text" class="box_write" name="dname" maxlength="10" size=15 value="<%=dname%>" <%if idx <> "" then%>readonly<%end if%>></td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>대표자&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="name" maxlength="10" size=15 class="box_write" value="<%=name%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>주민(법인)등록번호&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="text" name="jumin1" maxlength="6" size=6 class="box_write" value="<%=jumin1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="jumin2" maxlength="7" size=7 class="box_write" value="<%=jumin2%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>사업자등록번호&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="text" name="comnum1" maxlength="3" size=3 class="box_write" value="<%=comnum1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="comnum2" maxlength="2" size=2 class="box_write" value="<%=comnum2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="comnum3" maxlength="5" size=5 class="box_write" value="<%=comnum3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>우편번호&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:45;" name="m_post1" maxlength=3 OnKeypress="onlyNumber();" readonly value="<%=left(post,3)%>">
			- 
			<input type="text" class="box_write" style="width:45;" name="m_post2" maxlength=3 OnKeypress="onlyNumber();" readonly value="<%=right(post,3)%>"> 
			<a href="#" onclick="javascript:AutoAddr('1')"><img src="/images/member_02.gif" hspace="5" align="absmiddle" border=0></a>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>주소&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:300;" name="m_addr1" value="<%=addr%>"> 
                	<br> 
			<input type="text" class="box_write" style="width:300;" name="m_addr2" value="<%=addr2%>"> 
			나머지 주소 
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>업태&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="uptae" maxlength="50" size=20 class="box_write" value="<%=uptae%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>업종&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="upjong" maxlength="50" size=20 class="box_write" value="<%=upjong%>"></td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>전화번호&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="text" name="tel1" maxlength="3" size=3 class="box_write" value="<%=tel1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel2" maxlength="4" size=4 class="box_write" value="<%=tel2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel3" maxlength="4" size=4 class="box_write" value="<%=tel3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>팩스번호&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="text" name="fax1" maxlength="3" size=3 class="box_write" value="<%=fax1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax2" maxlength="4" size=4 class="box_write" value="<%=fax2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax3" maxlength="4" size=4 class="box_write" value="<%=fax3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>홈페이지&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="homepage" maxlength="50" size=40 class="box_write" value="<%=homepage%>"></td>
	</tr>
</table>

<BR>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 환경설정 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>영업수당&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="sudang" maxlength="4" size=4 class="box_write" value="<%=sudang%>">%</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>은행명&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="bank" maxlength="20" size=20 class="box_write" value="<%=bank%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>계좌번호&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="banknum" maxlength="30" size=30 class="box_write" value="<%=banknum%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>예금주&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="bankname" maxlength="10" size=15 class="box_write" value="<%=bankname%>"></td>
	</tr>
</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>

	<%if session("Auserwrite")="y" then%>
		<%if idx="" then%>
			<input type="image" src="/images/admin/l_bu01.gif" border=0>
		<%else%>
			<input type="image" src="/images/admin/l_bu03.gif" border=0>
			<a href="#" onclick="javascript:ddel(this.form);"><img src="/images/admin/l_bu04.gif" border=0></a>
		<%end if%>
	<%end if%>
			<a href="#" onclick="javascript:history.back();"><img src="/images/admin/l_bu07.gif" border=0></a>
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