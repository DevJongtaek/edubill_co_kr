<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	searcha = request("searcha")
	searchb = request("searchb")
	GotoPage = Request("GotoPage")
	idx = Request("idx")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if idx <> "" then
		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,dcarno,dcarname,tel1,tel2,tel3,carno,carkind,caryflag,dcenteridx "
		SQL = sql & " from tb_car "
		SQL = sql & " where idx = "& idx
		rslist.Open sql, db, 1
		imsidcarno = rslist(1)
		imsidcarname = rslist(2)
		imsitel1 = rslist(3)
		imsitel2 = rslist(4)
		imsitel3 = rslist(5)
		imsicarno = rslist(6)
		imsicarkind = rslist(7)
		imsicaryflag = rslist(8)
		dcenteridx = rslist(9)
		if isnull(dcenteridx) then dcenteridx=""
		rslist.close
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select choiceDcenter from tb_company where flag='2' and bidxsub = "& int(session("Ausercode")) &" and choiceDcenter<>0 group by choiceDcenter "
	rs2.Open sql, db, 1
	if not rs2.eof then
		i=1
		do until rs2.eof
			if i=1 then
				choiceDcenter = rs2(0)
			else
				choiceDcenter = choiceDcenter & "," & rs2(0)
			end if
		rs2.movenext
		i=i+1
		loop
	end if
	rs2.close
	if choiceDcenter<>"" then
		set rs2 = server.CreateObject("ADODB.Recordset")
'		SQL = " select b.bidx,b.bname from tb_company a, tb_company_dcenter b where a.idx = b.idx and a.idx = "& int(session("Ausercode")) &" and a.dcenterflag='y' "
		SQL = " select NULL as bidx,NULL as bname union select b.bidx,b.bname from tb_company a, tb_company_dcenter b where a.idx = b.idx and a.idx = "& int(session("Ausercode")) &" and a.dcenterflag='y' "
		SQL = sql & " and b.bidx in ( "& choiceDcenter &" ) "
		SQL = sql & " order by bname asc"
		'response.write sql
		rs2.Open sql, db, 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 호차등록 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<form action="cwriteok.asp" name=form method=post onsubmit="return carwrite();">
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type="hidden" name="searcha" value="<%=searcha%>">
<input type="hidden" name="searchb" value="<%=searchb%>">
<input type="hidden" name="dflag">

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>호차&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="dcarno" maxlength="4" style="ime-mode:disabled;" size=4 class="box_write" value="<%=imsidcarno%>" <%if idx <> "" then%>readonly<%end if%>>호차 (영숫자만 입력)</td>
	</tr>

<%if choiceDcenter<>"" then%>
<%if not rs2.eof then%>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>물류센터명&nbsp;</td>
		<td width=80% bgcolor=white>
			<select name=dcenteridx>
				<%do until rs2.eof%>
					<option value="<%=rs2(0)%>" <%if rs2(0)=dcenteridx then%>selected<%end if%>><%=rs2(1)%>
				<%rs2.movenext%>
				<%loop%>
				<%rs2.close%>
			</select>
		</td>
	</tr>
<%end if%>
<%end if%>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>기사명&nbsp;</td>
		<td bgcolor=white><input type="text" name="dcarname" maxlength="10" size=10 class="box_write" value="<%=imsidcarname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>핸드폰번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="tel1" maxlength="3" size=3 class="box_write" value="<%=imsitel1%>" style="ime-mode:disabled;" OnKeypress="onlyNumber();">
-
<input type="text" name="tel2" maxlength="4" size=4 class="box_write" value="<%=imsitel2%>" style="ime-mode:disabled;" OnKeypress="onlyNumber();">
-
<input type="text" name="tel3" maxlength="4" size=4 class="box_write" value="<%=imsitel3%>" style="ime-mode:disabled;" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>차량번호&nbsp;</td>
		<td bgcolor=white><input type="text" name="carno" maxlength="20" size=20 class="box_write" value="<%=imsicarno%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>차종&nbsp;</td>
		<td bgcolor=white><input type="text" name="carkind" maxlength="20" size=20 class="box_write" value="<%=imsicarkind%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>연식&nbsp;</td>
		<td bgcolor=white><input type="text" name="caryflag" maxlength="4" size=4 style="ime-mode:disabled;" class="box_write" OnKeypress="onlyNumber();" value="<%=imsicaryflag%>">년식 (숫자만 입력)</td>
	</tr>
</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>

<%if session("Ausergubun")="2" then%>
	<%if session("Auserwrite")="y" then%>
		<%if idx="" then%>
			<input type="image" src="/images/admin/l_bu01.gif" border=0>
		<%else%>
			<input type="image" src="/images/admin/l_bu03.gif" border=0>
			<a href="#" onclick="javascript:cardel(this.form);"><img src="/images/admin/l_bu04.gif" border=0></a>
		<%end if%>
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

<%
	db.close
	set db=nothing
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>
<BR><BR>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->