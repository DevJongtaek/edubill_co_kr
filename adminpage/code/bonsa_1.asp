<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	    idx = right(session("Ausercode"),5)
		myIp = Request.ServerVariables("Remote_addr") 

		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,tcode,flag,idxsub,idxsubname,comname,name,post,addr,addr2,companynum1,companynum2,companynum3 "
		SQL = sql & " ,uptae,upjong,tel1,tel2,tel3,fax1,fax2,fax3,hp1,hp2,hp3,dcarno,startday,bidxsub,tcode,vatflag,taxtitle "
		SQL = sql & " ,juminno1,juminno2,homepage,usegubun,usemoney,orderreg,soundfile,sclose,dcode,fileflag,timecheck1,timecheck2,isnull(com_notice,''),chk_gongi1,chk_gongi2,noticeflag,myflag,myflagauth,server_name "
		SQL = sql & " from tb_company A "
		SQL = sql & " left join tb_adminuser B "
		SQL = sql & " on convert(varchar(20), B.usercode) = convert(varchar(20), A.idx) "
		SQL = sql & " where idx = "& idx
'response.write sql
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
		imsivatflag = rslist(28)
		imsitaxtitle = rslist(29)
		imsijuminno1 = rslist(30)
		imsijuminno2 = rslist(31)
		imsihomepage = rslist(32)
		imsiusegubun = rslist(33)
		imsiusemoney = rslist(34)
		imsiorderreg = rslist(35)
		imsisoundfile = rslist(36)
		imsisclose = rslist(37)
		imsidcode = rslist(38)
		imsifileflag = rslist(39)
		imsitimecheck1 = rslist(40)
		imsitimecheck2 = rslist(41)
		imsicom_notice = rslist(42)
		imsichk_gongi1 = rslist(43)
		imsichk_gongi2 = rslist(44)
		imsinoticeflag = rslist(45)
		imsimyflag = rslist(46)
		imsimyflagauth = rslist(47)
		imsimyip = rslist(48)
		rslist.close


	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select dname "
	SQL = sql & " from tb_dealer where dcode = '"& imsidcode &"' "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsidname = rs2(0)
	end if
	rs2.close

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select userpwd "
	SQL = sql & " from tb_adminuser where flag='2' and usercode = '"& session("Ausercode") &"' "
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
		<td><font color=blue size=3><B>[ �������� ���� ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="bonsaok.asp" name=form method=post onsubmit="return comwrite11111();">
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
		<td colspan=2>&nbsp;<font color=red><B>[ �Ϲݻ��� ]</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>ȸ�����ڵ�&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="tcode" maxlength="20" style="width:200;" class="box_write" value="<%=imsitcode%>" <%if idx <> "" then%>readonly<%end if%>></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>ȸ���&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="comname" maxlength="20" style="width:200;" class="box_write" value="<%=imsicomname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>��ǥ��&nbsp;</td>
		<td bgcolor=white><input type="text" name="name" maxlength="20" style="width:100;" class="box_write" value="<%=imsiname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�ֹ�(����)��Ϲ�ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="juminno1" maxlength="6" size=6 class="box_write" value="<%=imsijuminno1%>">
-
<input type="text" name="juminno2" maxlength="7" size=6 class="box_write" value="<%=imsijuminno2%>">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>����ڵ�Ϲ�ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" class="box_write" name="companynum1" maxlength="3" size=3 value="<%=imsicompanynum1%>" OnKeypress="onlyNumber();">
-
<input type="text" class="box_write" name="companynum2" maxlength="2" size=2 value="<%=imsicompanynum2%>" OnKeypress="onlyNumber();">
-
<input type="text" class="box_write" name="companynum3" maxlength="5" size=5 value="<%=imsicompanynum3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�����ȣ&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:45;" name="m_post1" maxlength=3 OnKeypress="onlyNumber();" readonly value="<%=imsipost1%>">
			- 
			<input type="text" class="box_write" style="width:45;" name="m_post2" maxlength=3 OnKeypress="onlyNumber();" readonly value="<%=imsipost2%>"> 
			<a href="#" onclick="javascript:AutoAddr('1')"><img src="/images/member_02.gif" hspace="5" align="absmiddle" border=0></a>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�ּ�&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:300;" name="m_addr1" value="<%=imsiaddr%>"> 
                	<br> 
			<input type="text" class="box_write" style="width:300;" name="m_addr2" value="<%=imsiaddr2%>"> 
			������ �ּ� 
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>����&nbsp;</td>
		<td bgcolor=white><input type="text" name="uptae" maxlength="20" style="width:200;" class="box_write" value="<%=imsiuptae%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>����&nbsp;</td>
		<td bgcolor=white><input type="text" name="upjong" maxlength="20" style="width:200;" class="box_write" value="<%=imsiupjong%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>��ȭ��ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="tel1" maxlength="3" size=3 class="box_write" value="<%=imsitel1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel2" maxlength="4" size=4 class="box_write" value="<%=imsitel2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel3" maxlength="4" size=4 class="box_write" value="<%=imsitel3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�ѽ���ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="fax1" maxlength="3" size=3 class="box_write" value="<%=imsifax1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax2" maxlength="4" size=4 class="box_write" value="<%=imsifax2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax3" maxlength="4" size=4 class="box_write" value="<%=imsifax3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>Ȩ������&nbsp;</td>
		<td bgcolor=white><input type="text" name="homepage" maxlength="100" style="width:400;" class="box_write" value="<%=imsihomepage%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ֹ��ڵ�Ȯ��&nbsp;</td>
		<td bgcolor=white><input type="checkbox" name="orderreg" value="y" <%if imsiorderreg="y" then%>checked<%end if%> disabled>Yes</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�α��κ�й�ȣ&nbsp;</td>
		<td bgcolor=white><input type="text" name="userpwd" maxlength="4" OnKeypress="onlyNumber();" style="width:50;" class="box_write" value="<%=imsiuserpwd%>">(����4�ڸ� �Է�)</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>���� IP</td>
		<td bgcolor=white><input type="text" name="userip" maxlength="4" value="<%=imsimyip%>"><br>����IP:<%=myIp%> (���� IP�� ����PC���� Ȯ���ϼž� �մϴ�.)</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td colspan=2>&nbsp;<font color=red><B>[ ȯ�漳�� ]</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�ֹ����ܽð�&nbsp;</td>
		<td bgcolor=white>
			<input type="text" name="timecheck1_1" value="<%=left(imsitimecheck1,2)%>" OnKeypress="onlyNumber();" size=2 maxlength=2>
			:
			<input type="text" name="timecheck1_2" value="<%=right(imsitimecheck1,2)%>" OnKeypress="onlyNumber();" size=2 maxlength=2>
			~
			<input type="text" name="timecheck2_1" value="<%=left(imsitimecheck2,2)%>" OnKeypress="onlyNumber();" size=2 maxlength=2>
			:
			<input type="text" name="timecheck2_2" value="<%=right(imsitimecheck2,2)%>" OnKeypress="onlyNumber();" size=2 maxlength=2>
<font color=red>(��-2�ڸ� : ��-2�ڸ�, ���� �� �ð��뿡�� �ֹ��� ���� �ʽ��ϴ�.!!)
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�ΰ���&nbsp;</td>
		<td bgcolor=white>
<input type="radio" name="vatflag" value="y" <%if imsivatflag="y" then%>checked<%end if%>>����
<input type="radio" name="vatflag" value="n" <%if imsivatflag="n" then%>checked<%end if%>>����
<input type="radio" name="vatflag" value="a" <%if imsivatflag="a" or imsivatflag="" then%>checked<%end if%>>�����
<font color=red>('�����'�� VAT�� '0'������ �� ���)</font>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>���ݰ�꼭 �׸�&nbsp;</td>
		<td bgcolor=white><input type="text" name="taxtitle" class="box_write" value="<%=imsitaxtitle%>" size=20></td>
	</tr>
	<%if imsimyflagauth="y" then%>
		<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�̼��� üũ&nbsp;</td>
		<td bgcolor=white>			
			<input type="radio" name="myflag" value="n" <%if imsimyflag="n" or imsimaechulflag="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="myflag" value="y" <%if imsimyflag="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>
	<%end if%>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�̿�ᳳ����&nbsp;</td>
		<td bgcolor=white>
			<%if imsiusegubun="1" then%>ȸ����<%else%>ü����<%end if%>
			<input type=hidden name=usegubun value="<%=imsiusegubun%>">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�̿�� �ݾ�&nbsp;</td>
		<td bgcolor=white><%=imsiusemoney%><input type="hidden" name="usemoney" value="<%=imsiusemoney%>"></td>
	</tr>


	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�����&nbsp;</td>
		<td bgcolor=white><%=imsidname%></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>ȭ�ϻ�������&nbsp;</td>
		<td bgcolor=white>
			<%
			if imsifileflag="0" then
				response.write "������"
			elseif imsifileflag="1" then
				response.write "Text 1"
			elseif imsifileflag="2" then
				response.write "Text 2"
			elseif imsifileflag="3" then
				response.write "Text 3"
			elseif imsifileflag="4" then
				response.write "Excel 1"
			elseif imsifileflag="5" then
				response.write "Excel 2"
			elseif imsifileflag="6" then
				response.write "Excel 3"
			end if
			%>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��뿩��&nbsp;</td>
		<td bgcolor=white><%if imsihclose="y" or imsihclose="" then%>�����<%else%>�������<%end if%></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�������&nbsp;</td>
		<td bgcolor=white><%=left(imsistartday,4)%>/<%=mid(imsistartday,5,2)%>/<%=right(imsistartday,2)%></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>&nbsp;ü������������<BR><font color=red>(2000�� �̳�)</td>
		<td bgcolor=white>
			<input type=radio name=noticeflag value='1' <%if imsinoticeflag="1" then%>checked<%end if%>>ü����
			<input type=radio name=noticeflag value='2' <%if imsinoticeflag="2" then%>checked<%end if%>>����
			<input type=radio name=noticeflag value='a' <%if imsinoticeflag="a" then%>checked<%end if%>>ü����+����
			<BR>
			<textarea align="left" name="com_notice" cols="80" rows="5" style="border:1 solid #C7C7C7;back-color :black;" onkeyup='check_maxLen(form.com_notice, "ü������������", 2000)'><%=imsicom_notice%></textarea>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>���1 �޽���<BR><font color=red>(500�� �̳�)&nbsp;</td>
		<td bgcolor=white><textarea name="chk_gongi1" cols="80" rows="5" style="border:1 solid #C7C7C7;back-color :black;" onkeyup='check_maxLen(form.chk_gongi1, "���1 �޽���", 500)'><%=imsichk_gongi1%></textarea></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>���2 �޽���<BR><font color=red>(500�� �̳�)&nbsp;</td>
		<td bgcolor=white><textarea name="chk_gongi2" cols="80" rows="5" style="border:1 solid #C7C7C7;back-color :black;" onkeyup='check_maxLen(form.chk_gongi2, "���2 �޽���", 500)'><%=imsichk_gongi2%></textarea></td>
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